Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934F0C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67DA42075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DA42075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8IkH-0006SE-I9
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 02:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i8IjX-0005oE-D0
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i8IjU-0002lH-UT
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:37:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i8IjU-0002l0-MC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:37:32 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F003BC04BD48
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 06:37:30 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a4so10220118wrg.8
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 23:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=7u52KF3HxCgSngD0s7yi5RDE7kAPKuM/WHTidpfdNnE=;
 b=dJLJ++W+KS1rhUJJ2eBW4KPJYy5+6Q0yg0nEHMe9nf/ZpQiIcERJ8wcTYA29mLEMFz
 BMt5e04K8C8xopwFPjngppVWmRK1yEPtYKJlfrsqlXqS8A7oOadWfr3AsDgwMK8A1mEJ
 wMdVx6fVBI0Dxk3lI+K38Lo/SO2SJnElZkTHx41uGU3SQHsGy0hWu2W93n50U59iPgwV
 E5aV3lKtiW6SZ7rxwPCJ/vl6kFmtc4BEpBZjRJCFWigACxh6KWBnoDdAtoxF5HhW0UK+
 nf58wk8+szeGUqndxtz1Ym5d8I0iyR4c2GHPwZCoavhOkfU+NVke8U3L9bQmu9reWqNL
 MTKw==
X-Gm-Message-State: APjAAAVw/5VIGhQnIabV6gZM1uucPHRQiGAysYAngliPDo9vqp5DJaiE
 aWKPny25S9H1/Y68g5HLs5LgnGN9wUisje+RCMyDUT4cCYuX4WL5Jc0nxzukqH0jjBCZg9ovrcX
 8d7dlRXaOl4D7798=
X-Received: by 2002:a7b:c247:: with SMTP id b7mr363879wmj.121.1568270249351;
 Wed, 11 Sep 2019 23:37:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz4sjajXTcMSIQKiMMbYqt7dvQ1n1IaX66ZnA5jUpAylbmR69kZ+87CRTcGPnMprxelrn20bQ==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr363862wmj.121.1568270249054;
 Wed, 11 Sep 2019 23:37:29 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id l10sm24784896wrh.20.2019.09.11.23.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 23:37:28 -0700 (PDT)
References: <20190911161521.59261-1-slp@redhat.com>
 <d47f7e67-2f6a-0dd6-3ab5-93626bfbb02d@redhat.com>
 <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Eric Blake <eblake@redhat.com>
In-reply-to: <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com>
Date: Thu, 12 Sep 2019 08:37:26 +0200
Message-ID: <871rwmxbo9.fsf@redhat.com>
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Eric Blake <eblake@redhat.com> writes:

> On 9/11/19 12:21 PM, Eric Blake wrote:
>> On 9/11/19 11:15 AM, Sergio Lopez wrote:
>>> On creation, the export's AioContext is set to the same one as the
>>> BlockBackend, while the AioContext in the client QIOChannel is left
>>> untouched.
>>>
>>> As a result, when using data-plane, nbd_client_receive_next_request()
>>> schedules coroutines in the IOThread AioContext, while the client's
>>> QIOChannel is serviced from the main_loop, potentially triggering the
>>> assertion at qio_channel_restart_[read|write].
>>>
>>> To fix this, as soon we have the export corresponding to the client,
>>> we call qio_channel_attach_aio_context() to attach the QIOChannel
>>> context to the export's AioContext. This matches with the logic in
>>> blk_aio_attached().
>>>
>>> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1748253
>>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>>> ---
>>>  nbd/server.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>=20
>> I'd like a second opinion from Kevin, but the description makes sense to
>> me.  I'm happy to queue this through my NBD tree.
>>=20
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> I tried to test this patch, but even with it applied, I still got an
> aio-context crasher by attempting an nbd-server-start, nbd-server-add,
> nbd-server-stop (intentionally skipping the nbd-server-remove step) on a
> domain using iothreads, with a backtrace of:
>
> #0  0x00007ff09d070e35 in raise () from target:/lib64/libc.so.6
> #1  0x00007ff09d05b895 in abort () from target:/lib64/libc.so.6
> #2  0x000055dd03b9ab86 in error_exit (err=3D1, msg=3D0x55dd03d59fb0
> <__func__.15769> "qemu_mutex_unlock_impl")
>     at util/qemu-thread-posix.c:36
> #3  0x000055dd03b9adcf in qemu_mutex_unlock_impl (mutex=3D0x55dd062d5090,
> file=3D0x55dd03d59041 "util/async.c",
>     line=3D523) at util/qemu-thread-posix.c:96
> #4  0x000055dd03b93433 in aio_context_release (ctx=3D0x55dd062d5030) at
> util/async.c:523
> #5  0x000055dd03ac421b in bdrv_do_drained_begin (bs=3D0x55dd0673a2d0,
> recursive=3Dfalse, parent=3D0x0,
>     ignore_bds_parents=3Dfalse, poll=3Dtrue) at block/io.c:428
> #6  0x000055dd03ac4299 in bdrv_drained_begin (bs=3D0x55dd0673a2d0) at
> block/io.c:434
> #7  0x000055dd03aafb54 in blk_drain (blk=3D0x55dd06a3ec40) at
> block/block-backend.c:1605
> #8  0x000055dd03aae054 in blk_remove_bs (blk=3D0x55dd06a3ec40) at
> block/block-backend.c:800
> #9  0x000055dd03aad54a in blk_delete (blk=3D0x55dd06a3ec40) at
> block/block-backend.c:420
> #10 0x000055dd03aad7d6 in blk_unref (blk=3D0x55dd06a3ec40) at
> block/block-backend.c:475
> #11 0x000055dd03aecb68 in nbd_export_put (exp=3D0x55dd0726f920) at
> nbd/server.c:1666
> #12 0x000055dd03aec8fe in nbd_export_close (exp=3D0x55dd0726f920) at
> nbd/server.c:1616
> #13 0x000055dd03aecbf1 in nbd_export_close_all () at nbd/server.c:1689
> #14 0x000055dd03748845 in qmp_nbd_server_stop (errp=3D0x7ffcdf3cb4e8) at
> blockdev-nbd.c:233
> ...
>
> Does that sound familiar to what you were seeing?  Does it mean we
> missed another spot where the context is set incorrectly?

It looks like it was trying to release the AioContext while it was still
held by some other thread. Is this stacktrace from the main thread or an
iothread? What was the other one doing?

> I'm happy to work with you on IRC for more real-time debugging of this
> (I'm woefully behind on understanding how aio contexts are supposed to
> work).

I must be missing some step, because I can't reproduce this one
here. I've tried both with an idle NDB server and one with a client
generating I/O. Is it reproducible 100% of them time?

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl1556YACgkQ9GknjS8M
AjXYaw//Qo4VXFRa2yVy4qAx5Q9OxiE+1adlJmkUkbN22P5F5hCW19e5MXYMU+ns
qCElQgxiCVwAANN8iejygV6/kN5TqbYtKuUeloBTsJO1L0Pz++Z3tfLHGeyBzBBL
H3/QBD05pvx2DmN9tUat/j1DPl7kzGgEMmmo9DRvPCwMn5lI2hqvg9jrWAjPTdQS
wEsVaZy25OK/gRka4hfpaEyb5h0QdxJ2e847shf4T8NmhZOr02JwEXkHRaHI7OID
XpBcXD5bnkd8Q7RFG0nxxiUBSoKJzMf369+AtYPgpxRJ800unsGMtxL+9qjDJ+Pb
Y5TTOcFiDLfY6j8NAZP+AcFP3GD3FNfVI/8F0n2iJExki++CUmta184Qas/Yi1vz
GEJEuVsHrJBcJXgxdbK0N37JJticbdSfUlEPg7x145twj3u2pyuq5Wyc5LYeUt+U
5LxhvAl7oDeU2iBK1Nu2lL5rsMMVszqNLgjDGkw8xOiBp9/2CJEBB2Lhh44Zg1B6
aYGG8W+ungPYfzyAVY/HrqkN6asHGuHxggrz9LlD7Nm98FGdWuVTMWxh+IGaCQ/E
bm6sr5BAsxeff9NWk06ngOSTmLotvlHBXSMkhunerQq0Rx3CO6U5ik/kIWJtE1jf
MHynRKEp0a3OzRrmnh95Vb+rPF5Erxys2z60cDQEIhj2invcsFk=
=xC1g
-----END PGP SIGNATURE-----
--=-=-=--

