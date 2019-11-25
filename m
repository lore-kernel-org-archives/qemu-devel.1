Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D219C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3493A2068F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3493A2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGGV-0008Lt-5H
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aurelien@aurel32.net>) id 1iZGDj-0007VX-DW
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aurelien@aurel32.net>) id 1iZGDh-0002SF-Sb
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:24:11 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:58894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aurelien@aurel32.net>)
 id 1iZGDh-0002Po-N0
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:24:09 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <aurelien@aurel32.net>)
 id 1iZGDU-0000Tn-1q; Mon, 25 Nov 2019 16:23:56 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
 (envelope-from <aurelien@aurel32.net>)
 id 1iZGDT-005kvo-HX; Mon, 25 Nov 2019 16:23:55 +0100
Date: Mon, 25 Nov 2019 16:23:55 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
Message-ID: <20191125152355.GA1367280@aurel32.net>
References: <20191125104103.28962-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191125104103.28962-1-philmd@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:bc8:30d7:100::1
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
Cc: Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org,
 =?iso-8859-15?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-11-25 11:41, Philippe Mathieu-Daud=E9 wrote:
> The r4k machine was introduced in 2005 (6af0bf9c7) and its last
> logical change was in 2005 (9542611a6). After we can count 164
> maintenance commits (QEMU API changes) with the exception of
> 1 fix in 2015 (memory leak, commit 3ad9fd5a).
>=20
> This machine was introduced as a proof of concept to run a MIPS
> CPU. 2 years later, the Malta machine was add (commit 5856de80)
> modeling a real platform.
>=20
> Note also this machine has no specification except 5 lines in
> the header of this file:
>=20
>  * emulates a simple machine with ISA-like bus.
>  * ISA IO space mapped to the 0x14000000 (PHYS) and
>  * ISA memory at the 0x10000000 (PHYS, 16Mb in size).
>  * All peripherial devices are attached to this "bus" with
>  * the standard PC ISA addresses.
>=20
> It is time to deprecate this obsolete machine. Users are
> recommended to use the Malta board, which hardware is well
> documented.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  qemu-deprecated.texi | 5 +++++
>  hw/mips/mips_r4k.c   | 1 +
>  MAINTAINERS          | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)

The Linux kernel support for this machine has been dropped more than 10
years ago in this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D302922e5f6901eb6f29c58539631f71b3d9746b8

I therefore think it's time to also drop support for it on the QEMU
side.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

