Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC112C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEEA20700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LJIOm0FK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEEA20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSn4R-0004ra-CF
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 15:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmuU-0001Ae-Ic
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmuT-0005cZ-VM
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:25:50 -0400
Received: from mout.web.de ([212.227.15.3]:57637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSmuT-0005b4-8X
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587929135;
 bh=mkZVV6LtsoPFVdmtzzWwTA750eKiRLqCznFGLokBVh0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=LJIOm0FKp1Cl+vzwtLBlT34AcEQM7JPeTDu9Du8A5jW8lxquDJkv/H4tbv3aLDqla
 j4+iyDCexjXBSMOeokKONMkk5bcRyWjmcOqON4TadCLi8PG7FAt/sK/dlb0r71+rIJ
 UWnVjcLygug+k1XFCB1CCONRH+CpwDSrQ2WIETOs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.95]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfidG-1irnSG30O2-00pN31; Sun, 26
 Apr 2020 21:25:34 +0200
Date: Sun, 26 Apr 2020 21:25:23 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 0/6] colo-compare bugfixes
Message-ID: <cover.1587927878.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K.d8fToMrkxjLIuiwbrWwR5";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:UpEPzzjDZjy+eWo+B6899hOCYyrT4IYf8To0DiOrDxESXWQUml5
 o3ylY2mStQ3kDZu3s4eg0oTNxgF/BirQS5cUZYfsN9giPm4STNwZHnJtv0+b0GYTFfwX+gp
 X5fl+TD0RjbbYGJg3rmygLgohq1TWDODS9v1kc+atYHHgUghZ5fy//xZbwXRqGFuPjEJB/z
 lXfuWRWYK84S5icyJ3QOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:evVsrSQZP7o=:t5tCtEdjm2kh5oGtRnBbs4
 MqUBROos5v3S9pZLWOSprwl5RqqC8bIT3YIdcnbGdbI31W+5KCUGa2IDoDBDy3+0EtvKSDfhP
 5OdsKKyRNk0cTTIKLg14PxdlQA/M2KOOSc1CyzhYcLrAlCLCmXISIigDIYYLd5xvxJJGbtZMs
 ytJ5ISRVY7CaEqTBZvTFgVNe+T4xaBPr5XE2iXm+dvtzVoFiScaqEHCw/27XyR8pxPRw/E1z5
 NRieiZDQeEBsH0nQneDIfWGBQAUDZPvCce3CBYziClEsmnhlDNSLb3kfSnru9v0pTLUpT9OZv
 wveHmE9Cobgi/yKoYbAn6GrgGcFHZT73yYjlRfX0DB34C2eCrWgXcOuo8besg9mVTeSy419Zl
 TAXi1+ZreNIFtuKQfhYaOgEfyb/z4cgdfcz4W8po1L5oFWN6GvQngNPdfDMrNupcfLxcv/8W3
 /1BhfRwK1GO3PZMopv7hjA250paHINyOVMIqXlXpV4plxKm8JXLj4iq7NC90ChYbUuTIsn4va
 gMJ829VjGg8JroM4pn+14AI5A2of25sVc8ih4Q2umJnpnrwardyLZwkRMK9MrB5CjIaKX26eq
 pyyTyUywi8kE6EvuBDjH2c8OEr9LMWPMTk2H4lyzIRWuJXMI1Czi0qujnYpZ3oUS3ESZRLmRs
 0mOFLuE6cMqz+AQZeD8kfsV1FbsSme8NJ+oa8FsAQtMPcYYQyz0bKjhVppO/eaSHbqo0ZPQX8
 rYk9WgydtU0fwhODwTIU3mzY8/HkdvpcBH8x4W5TgIgRuMAmpEo4y7loiiv1p+jsJZjpNvvYW
 LCg31c4koJlmFgCrN97PByJ9NMy7xlq4aadMq+/xOQOp99zco3dSkDU0SsJUoChNzRKcJclP6
 YyzwZ3ozKPxz6KgeZxukr/XCK+cImGGJuVNn1iTXCVOb6AOWt1eAf/DvnhoepO2QqLA2BC0nj
 oQUsoNeisFUzRTlIVXqLViVESG9eyB638YUfutTTSiT+JBuhZfKNeV/ZfJOjV0vH7s0zTntVE
 lFw6rCuvCsNmebtoyuGzyuPqBsLVbth7Wg9CN/IhxdVUIJ8FX/IcMIGUcMafYnNBexkvNeTx1
 5p4M7ItdLN3lL7/h00pEV+ZICycDfhtpedAVyJ9B2oMfB/+rcHUUbI5NdXaNZYqjNwTK0Ip4d
 qwCN/3fY3ZDvIMHrLbdBUC0o4HN5r4FkLaal3ociIkp3Ppf/tfC/u5y5dwr3NrQlNmdLgGcIi
 LpIhdFryQrzzuRp43
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 15:25:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.15.3
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/K.d8fToMrkxjLIuiwbrWwR5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
The performance-regression in patch 3 "net/colo-compare.c: Fix deadlock in
compare_chr_send", has been fixed in this version by putting the packets in=
 a
queue instead of returning error. I also found and fixed some more bugs.

Benchmark results:
Client-to-server tcp:
without patch: ~63 Mbit/s
with patch: ~66 Mbit/s
Server-to-client tcp:
without patch: ~771 Kbit/s
with patch: ~702 Kbit/s

Regards,
Lukas Straub

Changes in v2:
 -better wording
 -fix performance-regression in patch 3 "net/colo-compare.c: Fix deadlock i=
n compare_chr_send"
 -add more bugfixes

Lukas Straub (6):
  net/colo-compare.c: Create event_bh with the right AioContext
  chardev/char.c: Use qemu_co_sleep_ns if in coroutine
  net/colo-compare.c: Fix deadlock in compare_chr_send
  net/colo-compare.c: Only hexdump packets if tracing is enabled
  net/colo-compare.c, softmmu/vl.c: Check that colo-compare is active
  net/colo-compare.c: Correct ordering in complete and finalize

 chardev/char.c     |   7 +-
 net/colo-compare.c | 237 +++++++++++++++++++++++++++++++++------------
 net/colo-compare.h |   1 +
 softmmu/vl.c       |   2 +
 4 files changed, 184 insertions(+), 63 deletions(-)

--=20
2.20.1

--Sig_/K.d8fToMrkxjLIuiwbrWwR5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l4CQACgkQNasLKJxd
sliaXQ//dX2KdL/3yj7Hu/pVat2UirI0HirD54PfhEAjDiz4CYtP9uflVSDAGdX6
LJ66A1m3w0gvdnhRRpQmuUwaiej/Ri1pGyrkojBTUNtPgibtD2gMGMKr/9sp1onS
8MHcJcMnduGi5DdqSy1DkmFhw/9A0PcBroteOXye/jj9PFrSaxqow/1YphZxWtv1
cCjA67AzQTadkt1wdX3LfPZJ7j3yfL0BUo3mYtg2B2GiEHkAyVJtYdvFU2e2FGID
4YTC0MJcPC6mEmecxM5wkaXjNyuqE1J8Zc7WDTugHqzFsXU2gPaYc9wNqq/R7+MJ
Es7zBFTCUU8kclDWupgaK+PpxcG7uPiIn5NyQGd1pboMfA5Gh8xYVy+Q6g6D72lI
+R+8ydO/F09bdoTrAxoyxxgeqOSlnWiLGbUwm3ivBlNvze5ysSA4rO8HsoahYaWe
eI58lhDO/V4THUR2D1JgTeHwCPqvlFS5xSwOw0sDVTHOiDVBk8/noh+nkgYSFhDX
ItxafvPllfq2iO+92bw8+Pe0fy7/ILFtl3eqt3FZzCGXpz5dXnrwEY72EdvY5VvW
b4FxYB+uo7QcbcJtBjBsLKYGk9nMwlkN+CVFJYvupeHJtdMucoJUnEsQnDJvtByW
a4pn6+cMKHWIaC4N84ry7NfEmiGXfB+4tgkldAWNt/Ty+zQZinM=
=ZR75
-----END PGP SIGNATURE-----

--Sig_/K.d8fToMrkxjLIuiwbrWwR5--

