Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B14C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C74120830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C74120830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ieV-0001xV-Rv
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 06:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i8ica-0000wG-U4
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i8icY-0000XA-Kk
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:16:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i8icU-0000UH-Nw
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:16:04 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42F08C056808
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 10:16:01 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n2so13586370wru.9
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 03:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=/qb3WYaHzkrD92YkP9hR3MNkfFcJC/4Ln6SkLurg/EY=;
 b=hmO/+2uVKPMnfph3BDueWj9E1RAOwFgclOM+j+5aR2SLPfgBACrXvZLr72bbLA1bTO
 Q7IkiKAs7pSAfH2ErWCk6foYO0Un61vY7ds+7AeWFuoOtvC0oQJwRCM2FXQv+qlaOUeB
 FLFfAMVqeT0JckEHQC6QY+ZPOwBKz/AsRlXNRRfVMPr0A8LZtV/OSLX0mVWj5HKWYgwT
 ZQkmp6CQx4zqVVs5gmQcj66Xm9DoftYPogx4o1j2yUhTBHlsrkz4n6XuLywRvelBRDqq
 LA6zdydkAWp1mRpBjzvmhRhm4uiSq6p/M3TjMXQ1DMR/Ylp4bfYBaxjMntOfDa0ibtkY
 ioYQ==
X-Gm-Message-State: APjAAAUXv58E0hpQL6iBWWiO47kExewqNPlxamGW+lvDE+K9lrOK62Uy
 d68pnYcaisDqK7asWnsgzxQkfDJBvzfbVRhDnCzQCLlIEZVZd1H7XxcSSk6i8RMUBdo8sGt28zj
 1Gi/XhRxYC6N3rPk=
X-Received: by 2002:a1c:9956:: with SMTP id b83mr2668487wme.63.1568369760023; 
 Fri, 13 Sep 2019 03:16:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwRsnPKHNd1xA7v6M9ZYZYEpshrotdnreNckCwDsghljNTY/ohwmY6/yzlzX3QuGyrY1CuueQ==
X-Received: by 2002:a1c:9956:: with SMTP id b83mr2668470wme.63.1568369759833; 
 Fri, 13 Sep 2019 03:15:59 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id h9sm12852786wrv.30.2019.09.13.03.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 03:15:59 -0700 (PDT)
References: <20190912161624.40886-1-slp@redhat.com>
 <3ceab9a7-e002-a33e-d996-8c4fba374ece@redhat.com> <87v9twwn8r.fsf@redhat.com>
 <26ff362d-10a8-bcca-0b05-a4d51e88ad37@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Max Reitz <mreitz@redhat.com>
In-reply-to: <26ff362d-10a8-bcca-0b05-a4d51e88ad37@redhat.com>
Date: Fri, 13 Sep 2019 12:15:57 +0200
Message-ID: <87tv9gwlgi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] blockdev: avoid acquiring AioContext lock
 twice at do_drive_backup()
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Max Reitz <mreitz@redhat.com> writes:

> On 13.09.19 11:37, Sergio Lopez wrote:
>>=20
>> Max Reitz <mreitz@redhat.com> writes:
>>=20
>>> On 12.09.19 18:16, Sergio Lopez wrote:
>>>> do_drive_backup() acquires the AioContext lock of the corresponding
>>>> BlockDriverState. This is not a problem when it's called from
>>>> qmp_drive_backup(), but drive_backup_prepare() also acquires the lock
>>>> before calling it.
>>>>
>>>> This change adds a BlockDriverState argument to do_drive_backup(),
>>>> which is used to signal that the context lock is already acquired and
>>>> to save a couple of redundant calls.
>>>
>>> But those redundant calls don=E2=80=99t really hurt (it=E2=80=99s just =
bdrv_lookup_bs(),
>>> as far as I can tell).  Wouldn=E2=80=99t it be simpler to just release =
the
>>> context lock in drive_backup_prepare() before calling do_drive_backup()?
>>>  The BDS is drained anyway.
>>=20
>> Redundant calls rarely hurt, they're just redundant ;-)
>
> If they=E2=80=99re expensive and in a hot path, they hurt.
>
>>> On top of that, do_backup_common() calls bdrv_try_set_aio_context() to
>>> bring the target into the source=E2=80=99s AioContext.  However, this f=
unction
>>> must be called with the old AioContext held, and the new context not he=
ld.
>>=20
>> Is this documented somewhere? I see nothing in the function declaration
>> nor definition.
>>=20
>> I'm starting to get the feeling that the block layer is riddled with
>> unwritten rules and assumptions that makes every change a lot harder
>> than it should be.
>
> It is written, it=E2=80=99s just that it=E2=80=99s written in
> bdrv_set_aio_context_ignore()=E2=80=99s definition.
>
> Yes, we should document it directly for bdrv_try_set_aio_context(), too,
> because that=E2=80=99s what external callers are much more likely to use.
>
>>> Currently, it=E2=80=99s called exactly the other way around: With the n=
ew
>>> context held, but the old one not held.
>>>
>>> So I think it indeed actually makes more sense to release the AioContext
>>> before calling do_drive_backup(), and to move the
>>> bdrv_try_set_aio_context() call for target_bs to the callers of
>>> do_backup_common() (where they have not yet taken the AioContext lock).
>>=20
>> OK. I see this also happens in external_snapshot_prepare() and
>> qmp_drive_mirror() too. I guess we should fix these too.
>>=20
>> In qmp_drive_mirror(), would it be safe to delay the acquisition of any
>> context until just before the blockdev_mirror_common()?
>
> From mirror=E2=80=99s perspective I think so, but I don=E2=80=99t think i=
t=E2=80=99s safe to
> access any of a BDS=E2=80=99s fields without having acquired its AioConte=
xt.
> (In fact, I wonder whether we should acquire the context even before
> bdrv_op_is_blocked()...)

In that case, I wonder if we can safely release the context to honor
bdrv_try_set_aio_context() requirements, knowing we aren't in a drained
section.

Sergio.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl17bF0ACgkQ9GknjS8M
AjXypw//cPjupiOM2i2dKbaUylqM3TRySyit4T9i/sHUW3DGfW5ZodgxGZlcsije
h2YgXd6UTJBvl5sbyAZY33OARuhdMbIZaoeY3jnZDyuMbCoMe78Zkl4hIVe/iyC1
94r6ObaEO+3dKT4Qej+BazYr6Ie8OcZqd/oeLbwHBbKlKQCFJb+q+nujeFsXWs8h
OnPuiLv0rmmRlj/QZ5nZF8tSUrPCn0YuYRx1NSIgQKAMm7vHxm37phRScBz1LlOm
uHQavm0HJ3iLGq3SgZgElRU/ni0yuEBi19SDzewmp0DeSga+4qSou3ZZTyrX40FZ
7nAtu80hvFtDNTY0Ff+ItIypVOID8Ncr9vA2etg+FQxuq/cdlY/c7GfflVQLVuVK
GZMqjH4gIVhTJX/6I+L2uB1zlGzIKAGRj2M18ORI8wpP89SrY2Cg5KoG3/MYmbdL
Xh+uZbIUDtqpg/sOGyCVIZtb3qui8H9/CTLDlrYsJCN8bB1D1Mirb2ZK6y9F+Gpv
iB4ZFeGOMHfQBVvSO5gS58kRHCs9kiKrkuS+niKu5waFrJ1SWPljHyltsmyVv6iY
wA4i/Ec9H2dvGQ1YUsTuWURDToEKDKmpaJuefsoaxLWQyqBeENL6xr+2jIVlc+vi
ddwz33qecTnK9LKlldRZDoFi9ifR6qNrddMMmq+lN+41RjlXaik=
=8s48
-----END PGP SIGNATURE-----
--=-=-=--

