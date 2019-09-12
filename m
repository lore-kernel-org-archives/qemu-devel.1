Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291F0C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F298C206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F298C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MRx-00043J-1b
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i8MMh-0007KQ-Vi
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i8MMg-0003rD-6e
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:30:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23421)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i8MMf-0003qg-Uo
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:30:14 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0815CC050061
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 10:30:13 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j2so3575734wre.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 03:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=BIayWO072TUf1lM1FVIPdkQy/JjvQQCrtODiET1IZhI=;
 b=cUjgNNpHMHpyOj+mU9uI/BEP70Rr5iin5Xz0gElX1qIEwUmmGnfGkirUvt1vAIwy+p
 w7YnlRbpMGTD0Na+arMWduw/AHdKvTDgB2N2UaEkpSK/2fWxfwN4OwJO57rEP1J0TRyI
 p8xK+ZgMP0uWhSI0ejNvCxpcNbzZI6/R5/ky/1zQlOcIeM2weY9LHCnnpT2nMvmhRHjc
 zWoxCSH22i4QoaS18b5DzBYlAd55E2XWNHtVKpdcACZqf5fxXvnDDJjvUEZIBYJfE1kM
 LZ92o5cbFjXRuGkvU1C1zh55ghrugOWWordx8JegctC1TlQzS6ahTNCR39jeVjhwW10v
 8foA==
X-Gm-Message-State: APjAAAWk94jP5eH8Rhrfpfyn9ln1TfVT8QaTfIm6JgrgcQD3S0L2gdxk
 Q2y67YYBxUzd96itKervEL0ard96DnHWf+P94yPjWMi23kuFPhBLbvBpmOynuSiArhQjSY8aGEX
 poqdbxUG32IR7wzM=
X-Received: by 2002:a1c:a546:: with SMTP id o67mr8030782wme.55.1568284211501; 
 Thu, 12 Sep 2019 03:30:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGuZKezobXipQyQIdCfglfbn3DoQ0z4zAhgz1zUmLiZtl2Nm2MeIkBlHv5EdObio1soWyJeA==
X-Received: by 2002:a1c:a546:: with SMTP id o67mr8030764wme.55.1568284211307; 
 Thu, 12 Sep 2019 03:30:11 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id u8sm4428047wmj.3.2019.09.12.03.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 03:30:10 -0700 (PDT)
References: <20190911161521.59261-1-slp@redhat.com>
 <d47f7e67-2f6a-0dd6-3ab5-93626bfbb02d@redhat.com>
 <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com>
 <20190912081414.GC5383@linux.fritz.box>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
In-reply-to: <20190912081414.GC5383@linux.fritz.box>
Date: Thu, 12 Sep 2019 12:30:08 +0200
Message-ID: <87y2ytx0wf.fsf@redhat.com>
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

> Am 11.09.2019 um 23:33 hat Eric Blake geschrieben:
>> On 9/11/19 12:21 PM, Eric Blake wrote:
>> > On 9/11/19 11:15 AM, Sergio Lopez wrote:
>> >> On creation, the export's AioContext is set to the same one as the
>> >> BlockBackend, while the AioContext in the client QIOChannel is left
>> >> untouched.
>> >>
>> >> As a result, when using data-plane, nbd_client_receive_next_request()
>> >> schedules coroutines in the IOThread AioContext, while the client's
>> >> QIOChannel is serviced from the main_loop, potentially triggering the
>> >> assertion at qio_channel_restart_[read|write].
>> >>
>> >> To fix this, as soon we have the export corresponding to the client,
>> >> we call qio_channel_attach_aio_context() to attach the QIOChannel
>> >> context to the export's AioContext. This matches with the logic in
>> >> blk_aio_attached().
>> >>
>> >> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1748253
>> >> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> >> ---
>> >>  nbd/server.c | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >=20
>> > I'd like a second opinion from Kevin, but the description makes sense =
to
>> > me.  I'm happy to queue this through my NBD tree.
>> >=20
>> > Reviewed-by: Eric Blake <eblake@redhat.com>
>>=20
>> I tried to test this patch, but even with it applied, I still got an
>> aio-context crasher by attempting an nbd-server-start, nbd-server-add,
>> nbd-server-stop (intentionally skipping the nbd-server-remove step) on a
>> domain using iothreads, with a backtrace of:
>>=20
>> #0  0x00007ff09d070e35 in raise () from target:/lib64/libc.so.6
>> #1  0x00007ff09d05b895 in abort () from target:/lib64/libc.so.6
>> #2  0x000055dd03b9ab86 in error_exit (err=3D1, msg=3D0x55dd03d59fb0
>> <__func__.15769> "qemu_mutex_unlock_impl")
>>     at util/qemu-thread-posix.c:36
>> #3  0x000055dd03b9adcf in qemu_mutex_unlock_impl (mutex=3D0x55dd062d5090,
>> file=3D0x55dd03d59041 "util/async.c",
>>     line=3D523) at util/qemu-thread-posix.c:96
>> #4  0x000055dd03b93433 in aio_context_release (ctx=3D0x55dd062d5030) at
>> util/async.c:523
>> #5  0x000055dd03ac421b in bdrv_do_drained_begin (bs=3D0x55dd0673a2d0,
>> recursive=3Dfalse, parent=3D0x0,
>>     ignore_bds_parents=3Dfalse, poll=3Dtrue) at block/io.c:428
>> #6  0x000055dd03ac4299 in bdrv_drained_begin (bs=3D0x55dd0673a2d0) at
>> block/io.c:434
>> #7  0x000055dd03aafb54 in blk_drain (blk=3D0x55dd06a3ec40) at
>> block/block-backend.c:1605
>> #8  0x000055dd03aae054 in blk_remove_bs (blk=3D0x55dd06a3ec40) at
>> block/block-backend.c:800
>> #9  0x000055dd03aad54a in blk_delete (blk=3D0x55dd06a3ec40) at
>> block/block-backend.c:420
>> #10 0x000055dd03aad7d6 in blk_unref (blk=3D0x55dd06a3ec40) at
>> block/block-backend.c:475
>> #11 0x000055dd03aecb68 in nbd_export_put (exp=3D0x55dd0726f920) at
>> nbd/server.c:1666
>> #12 0x000055dd03aec8fe in nbd_export_close (exp=3D0x55dd0726f920) at
>> nbd/server.c:1616
>> #13 0x000055dd03aecbf1 in nbd_export_close_all () at nbd/server.c:1689
>> #14 0x000055dd03748845 in qmp_nbd_server_stop (errp=3D0x7ffcdf3cb4e8) at
>> blockdev-nbd.c:233
>> ...
>>=20
>> Does that sound familiar to what you were seeing?  Does it mean we
>> missed another spot where the context is set incorrectly?
>
> I think nbd_export_close_all() or one of the NBD functions called by it
> needs to take the AioContext lock of the associated BlockBackend.
>
> The crash is because AIO_POLL_WHILE() wants to temporarily drop the lock
> that we're not even holding.

Yes, I think locking the context during the "if (exp->blk) {" block at
nbd/server.c:1646 should do the trick.

On the other hand, I wonder if there is any situation in which calling
to blk_unref() without locking the context could be safe. If there isn't
any, perhaps we should assert that the lock is held if blk->ctx !=3D NULL
to catch this kind of bugs earlier?

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl16HjAACgkQ9GknjS8M
AjVQiA/+IPuYpOMLq+ieey1WGqQFYkGtOlvRl8gn5AJ7W3UhW1850v0pnk26XfWr
7Y+b0jDOMo2brIobebOidmtJ5fX83BySD2sqSD9tON3XDz0u2Lo0rr5+5mePMhoD
Z/5Y2AuYKqqmyz5IvOBhVgMlOUqf32wxGYbkj+Ick/CH5GqMH+rrub8TlrXlRBCI
qlf0lRKXsXA3f5SgINiZ3deQTZNiBJwgKwqM5d/Jj6JrG/zXvW2j1DLQdVkLf6/D
/EgRkfiOg1sVzr6MvIdEuP4sofvhrzGNOkCeoMnxd360ifGBrTpYLwN1v8y1C1og
fHT4z28LZIHhE4F7xqBdNgIY0ld3Hupl9+EuiRpXI8FS8k4XYjd6xmZgRKuTHILP
cMcWtrpVVYURQBfehPuzJM0digvURASnKhJuq5iNay/DPyR7l5Y3X+qx8IdqHHL+
qfAVd0d7pw5rL12xIlw/EyJdF3iYZoDDalQZfWjonVKWEKry1FfKWbhjrSYx6+tV
qvTKe2T6Nr7NxyvybX3L7CyjIkfCFIxQY9shtAUm7hYRx2Hz2hmIugcfiMPDQz2P
yXI3ceYu7fRrXVFdm6wdHC0Ir/jty6KW/BwE3REw4INavHsXkWhHUX7kju7yWryN
tCB0e7SjRlwHE2dCUO0L7jpWJt79RoOO/n+sLt9I4+LX3UmZE0s=
=qvng
-----END PGP SIGNATURE-----
--=-=-=--

