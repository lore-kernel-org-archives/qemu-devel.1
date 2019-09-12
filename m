Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FB6C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F5520830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F5520830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8M7E-0001GO-DP
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i8M6N-0000mT-W9
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i8M6I-0005L6-TA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:13:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i8M6I-0005Kp-Lt
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:13:18 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D4B82A09A3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 10:13:17 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a4so10451229wrg.8
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 03:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=9hDwRXNDweqpUsoD5RFatxCkqPnudeJq2oeI8nt5R4s=;
 b=IWO0Y11m1Ekn7NWdbgi0v06Iw5/pq/TTV4JEvQCkMiBgDHoZ2iQzXTG7BHIW1zwbe3
 bg1IPf3piddmaYXOnOU5HP05I7urWGENvQZp1TYmw6YZXyp8gVCpsDqdex0hfQdl+51I
 0qPKFn6YzQjOfRAVG7bvU6aJJs+j5PKhyEt0OJCrpvlD0Ng03XTB8cQVKaW36v25lTd0
 AZ34y84AuGBHGJFzMZi9MKYWGDC6gL2y1BP4xg8atgKxKZkQCfjzzkZUOw5Q8g+TPyFS
 0mO6A+N44r9mrLOJuANDURKPdK8oRSSJNhVEzv4cAKX8uY91F8CiojxRMSbU0ZSsRnJw
 yC4w==
X-Gm-Message-State: APjAAAW0pXO/UBHIKjYACXtz370CDGSyG0O0SPLFbNcPLmpN5ZkNvejA
 uz6pgzlEkpnq5wXr7pFR3PZrasuq7eOguDNREmfcV/qgxonUmKbBd3Z3aiZKn8Zk/UsioGrE0vt
 dFJctbQh4cMdPTNo=
X-Received: by 2002:a5d:5381:: with SMTP id d1mr136307wrv.315.1568283196216;
 Thu, 12 Sep 2019 03:13:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqycQco6vgc6Gmf36RRTXnqrHaHUJr2WmhRHSAeHdw9SC+xVietDTg4A11AuvvytAjQOjfuCTQ==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr136296wrv.315.1568283196016;
 Thu, 12 Sep 2019 03:13:16 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id q19sm34063753wra.89.2019.09.12.03.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 03:13:14 -0700 (PDT)
References: <20190911161521.59261-1-slp@redhat.com>
 <20190912082322.GD5383@linux.fritz.box>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
In-reply-to: <20190912082322.GD5383@linux.fritz.box>
Date: Thu, 12 Sep 2019 12:13:04 +0200
Message-ID: <87zhj9x1ov.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nbd/server: attach client channel to the
 export's AioContext
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Kevin Wolf <kwolf@redhat.com> writes:

> Am 11.09.2019 um 18:15 hat Sergio Lopez geschrieben:
>> On creation, the export's AioContext is set to the same one as the
>> BlockBackend, while the AioContext in the client QIOChannel is left
>> untouched.
>>=20
>> As a result, when using data-plane, nbd_client_receive_next_request()
>> schedules coroutines in the IOThread AioContext, while the client's
>> QIOChannel is serviced from the main_loop, potentially triggering the
>> assertion at qio_channel_restart_[read|write].
>>=20
>> To fix this, as soon we have the export corresponding to the client,
>> we call qio_channel_attach_aio_context() to attach the QIOChannel
>> context to the export's AioContext. This matches with the logic in
>> blk_aio_attached().
>>=20
>> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1748253
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>
> Oh, looks like I only fixed switching the AioContext after the fact, but
> not starting the NBD server for a node that is already in a different
> AioContext... :-/
>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 10faedcfc5..51322e2343 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -471,6 +471,7 @@ static int nbd_negotiate_handle_export_name(NBDClien=
t *client,
>>      QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
>>      nbd_export_get(client->exp);
>>      nbd_check_meta_export(client);
>> +    qio_channel_attach_aio_context(client->ioc, client->exp->ctx);
>>=20=20
>>      return 0;
>>  }
>> @@ -673,6 +674,7 @@ static int nbd_negotiate_handle_info(NBDClient *clie=
nt, uint16_t myflags,
>>          QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
>>          nbd_export_get(client->exp);
>>          nbd_check_meta_export(client);
>> +        qio_channel_attach_aio_context(client->ioc, exp->ctx);
>>          rc =3D 1;
>>      }
>>      return rc;
>
> I think I would rather do this once at the end of nbd_negotiate()
> instead of duplicating it across the different way to open an export.
> During the negotiation phase, we don't start requests yet, so doing
> everything from the main thread should be fine.

OK.

> Actually, not doing everything from the main thread sounds nasty because
> I think the next QIOChannel callback could then already be executed in
> the iothread while this one hasn't completed yet. Or do we have any
> locking in place for the negotiation?

This is the first time I look at NBD code, but IIUC all the negotiation
is done with synchronous nbd_[read|write]() calls, so even if the
coroutine yields due to EWOULDBLOCK, nothing else should be making
progress.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl16GjAACgkQ9GknjS8M
AjVL1xAAuD5QtY69+89yn7TT/MRwkup44frvki3AMVRRQFZbb5nXfK02K3n+LVzT
xgss5A/VBPNn6j8lfy7SVd9EmM/e9tLQFJDrcgAUu4C+D9rwkYhRog/9frEMh4J+
uud63DcMIPfBtiY2e+2Kj9FuopwgojIpLzekcfx++0MU3D+mPtgxW0CFkc6anS+x
ni6x3DHWaJLrm4pwLAE5RYs0btuvF2TRIV2kX1hmZvymjh5JfxHSDlyC1bVAKb/4
Tqg8yETAtY6ZJiZsKUwGSXOSkF9uirM+vvWpaAPtQHbw6VQC326RYxm8Fotz2qQP
lrxWG60e1/QbpFX0TDsvaGPGnvDfZb5RvswdUNP0jhnD7vtNLrwRSq6apsXrq7Bp
+VB0OkOmuQWWatnhR7xM6EqoeNKvh6FTkZYBHTd24QocbHPdM+gNnkAQSV3m0H1T
a5Ry8TdaWJtNl1S5te4FFdhZWirWSkP0a241hddxFaqIW6sJD9hHjELX6O/BWH6P
p1R8xaNdIkXFm6j/p4v9j2ekH4YZba5OLMI++GI9zd+Pt0wNI1toDm3IM2rR6HX6
+rOLGM8bdxMFd+HLeEk9/FxoQT+XV9ePbM9Z4QhQDSsn/8UmOEZ2Qe2u2eqnQzqz
USI7lDAVzGC75aGrHMrKjxDYb7jPdllpGofRN+8kxlSYhTjl61g=
=LjBN
-----END PGP SIGNATURE-----
--=-=-=--

