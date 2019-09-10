Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8162FC49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59667208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59667208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7elK-0007yy-AB
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i7eia-0006M6-OA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i7eiY-0004vr-31
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:53:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45536)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i7eiX-0004vD-R4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:53:54 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 944BEC056808
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 11:53:52 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id f18so8932720wro.19
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 04:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=1BN0LdRXtiNRZ8TGCJ9lprfFa5Qk53t9WZQ8HxpXauo=;
 b=cbLXpxPZE53uFr8n/Ocl5y6tvQJ4V4pfYu/4iaEByqqaKoeDXVBxG81uFEGIZfQDer
 J1BX9QsvimvWV3QIqfDpyII/DSO98gZwLlmhLOtMwJasK6Fl2My4GBL71jTrXlqBu2t6
 XMZHXts85YtrG7ArM0Rb9UTGpChrCYodIiU+6AECPoCmru6zm6bsakuz+aBRj6fSoscV
 YXPchd0FmlVJKtUNS8YNWsqHIkzLPyDM6VqABfgM2UkMjif0Hdk9Ktrblu6z8VBawg9J
 cjG1tnET86za+66deEnIt2YWy7fvuDRksmjHPQ70KCIqdoGuFlUixfJ/UELqBWlr2lPg
 F+tg==
X-Gm-Message-State: APjAAAUhjqB/WBKI7slNw9UcmHl8vuNIDTzc8NI7x7foDYZ3sW1WJOnm
 xD1EP6zhruWhR+rB+gGkaB4HTd3A/jyTEWb1LgqmNLN6qO0J2OgHQfpLwdAfwc2qma62LB4b6SP
 M5raHwV6FBDHoQYg=
X-Received: by 2002:a05:6000:12c9:: with SMTP id
 l9mr25749901wrx.163.1568116431383; 
 Tue, 10 Sep 2019 04:53:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzV641KgbEcsJ0/ocXWaifIoo4SxF0l6WsCFSWGUPpQ9PDtO+HHJ8VANyfSA/pydDgDTHbK3w==
X-Received: by 2002:a05:6000:12c9:: with SMTP id
 l9mr25749877wrx.163.1568116431211; 
 Tue, 10 Sep 2019 04:53:51 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id g15sm2569741wmk.17.2019.09.10.04.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 04:53:50 -0700 (PDT)
References: <20190910110725.141014-1-slp@redhat.com>
 <ff88a19b-ce70-4d31-4495-82ef0bcbbbd6@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Max Reitz <mreitz@redhat.com>
In-reply-to: <ff88a19b-ce70-4d31-4495-82ef0bcbbbd6@redhat.com>
Date: Tue, 10 Sep 2019 13:53:48 +0200
Message-ID: <87k1agv037.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] blockjob: update nodes head while removing
 all bdrv
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Max Reitz <mreitz@redhat.com> writes:

> On 10.09.19 13:07, Sergio Lopez wrote:
>> block_job_remove_all_bdrv() iterates through job->nodes, calling
>> bdrv_root_unref_child() for each entry. The call to the latter may
>> reach child_job_[can_]set_aio_ctx(), which will also attempt to
>> traverse job->nodes, potentially finding entries that where freed
>> on previous iterations.
>>=20
>> To avoid this situation, update job->nodes head on each iteration to
>> ensure that already freed entries are no longer linked to the list.
>>=20
>> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1746631
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  blockjob.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/blockjob.c b/blockjob.c
>> index 6e32d1a0c0..7b1551d981 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -192,6 +192,12 @@ void block_job_remove_all_bdrv(BlockJob *job)
>>          BdrvChild *c =3D l->data;
>>          bdrv_op_unblock_all(c->bs, job->blocker);
>>          bdrv_root_unref_child(c);
>> +        /*
>> +         * The call above may reach child_job_[can_]set_aio_ctx(), whic=
h will
>> +         * also traverse job->nodes, so update the head here to make su=
re it
>> +         * doesn't attempt to process an already freed BdrvChild.
>> +         */
>> +        job->nodes =3D l->next;
>>      }
>>      g_slist_free(job->nodes);
>
> But this will leak the whole list.

Ouch. This is what happens when you rush up things. I'll send a v2 ASAP.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl13jswACgkQ9GknjS8M
AjXzNg/+MGsEFhPjpBR9fMUGnwMbkJd80oxj5bCby08+Sz61shlIZlmRs+PU9fVv
rKFg8J5RiPgLZmEIQYUFF6GD6GA+IG/RfHPABhqNrGEFk1HEsBDcEvvbPoGSIVwI
TO10Ub9ghEZsT2wjwyXbnIj5zSIhuv2C34QLbT07x503QzzgzYKmsyLy6ICaVTBU
vD/EvQadF3M6KeWfM052vvHcAlrDYlbUPdNKJsaXg9/rSRQXehKHIIiYKR3DXwLb
gIAMuJnoRpPkllhM0Afju5ZuugFq/8vSJnWnbCbRrX3tkUxIO6Eq4nfzmAzkh/b3
Q/1IIqMLddS/E9iFf3Q5zJtKSz8UzqcBTNszEPY8VLDIu+QDzb7HBLVvi/PuBinZ
wLW/f5yR93uWUfuFilmv7NOSMRHYbCqp4cAppcwbwQ7hkZzDQpkr2AjtTaqwO/rz
WQE2ynQPFnkvzhMrtmY1BIqDjI6uGcaXypuS+Tr/AjRb7WOFJrx00mbLeez6flQ7
BdeEq92YOuDEbNNdhw2edm6Nxf+xjYrd7lida70oBzBFcqKoK7ztxTI3ZVfzyBYr
3udbUE2jXZR8sa2fTtTXZIObqJ9sWnYqQSIA01TDEO9rttuftjz8k1RAMOeyTzeJ
D9424xdjeW3TPQLU8AV4gfimSCQbPceK6jFiwSw/T31uHGL6evA=
=B1Ve
-----END PGP SIGNATURE-----
--=-=-=--

