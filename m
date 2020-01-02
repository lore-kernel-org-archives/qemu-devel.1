Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6056C2D0DD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 08:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D8620866
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 08:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D8620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imw8N-00052Q-NF
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 03:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sw@weilnetz.de>) id 1imw7a-0004Fb-LB
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 03:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sw@weilnetz.de>) id 1imw7Z-0003k2-B2
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 03:46:22 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:33262
 helo=v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sw@weilnetz.de>)
 id 1imw7V-0003gP-LD; Thu, 02 Jan 2020 03:46:17 -0500
Received: from localhost (localhost [127.0.0.1])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id 81018DBAA3B;
 Thu,  2 Jan 2020 09:46:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
 by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id GfGnssiESocV; Thu,  2 Jan 2020 09:46:12 +0100 (CET)
Received: from edv-macbook-pro.fritz.box (pD9EC3B33.dip0.t-ipconnect.de
 [217.236.59.51])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 891F2DBAA3E;
 Thu,  2 Jan 2020 09:46:11 +0100 (CET)
Subject: Re: [PATCH v2 0/4] tcg: Include tcg files using tcg/ dirname, reduce
 cpp search path list
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200101112303.20724-1-philmd@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Autocrypt: addr=sw@weilnetz.de; keydata=
 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
Message-ID: <d1c4873f-a394-9d24-8afb-bdcc863d0eae@weilnetz.de>
Date: Thu, 2 Jan 2020 09:46:01 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200101112303.20724-1-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d4BnQkunNGNKjBmuITflI5uWYXBXPxjak"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 37.120.169.71
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d4BnQkunNGNKjBmuITflI5uWYXBXPxjak
Content-Type: multipart/mixed; boundary="Z26opEMc5rUUSmPMbaTLlsX8tAWAczyte"

--Z26opEMc5rUUSmPMbaTLlsX8tAWAczyte
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 01.01.20 um 12:22 schrieb Philippe Mathieu-Daud=C3=A9:

> Noticed we could clean this while reviewing Richard patch last night:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg667606.html
>
> Since v1:
> - moved headers to include/tcg/ (Paolo)
> - include in .inc.c relative to parent (Stefan)
>
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg05356.html=

>
> Philippe Mathieu-Daud=C3=A9 (4):
>   tcg: Search includes from the project root source directory
>   tcg: Search includes in the parent source directory
>   tcg: Move TCG headers to include/tcg/
>   configure: Remove tcg/ from the preprocessor include search list
>
>  configure                            | 1 -
>  include/exec/cpu_ldst.h              | 2 +-
>  {tcg =3D> include/tcg}/tcg-gvec-desc.h | 0
>  {tcg =3D> include/tcg}/tcg-mo.h        | 0
>  {tcg =3D> include/tcg}/tcg-op-gvec.h   | 0
>  {tcg =3D> include/tcg}/tcg-op.h        | 2 +-
>  {tcg =3D> include/tcg}/tcg-opc.h       | 0
>  {tcg =3D> include/tcg}/tcg.h           | 4 ++--
>  tcg/i386/tcg-target.h                | 2 +-
>  accel/tcg/cpu-exec.c                 | 2 +-
>  accel/tcg/tcg-runtime-gvec.c         | 2 +-
>  accel/tcg/translate-all.c            | 2 +-
>  accel/tcg/user-exec.c                | 2 +-
>  bsd-user/main.c                      | 2 +-
>  cpus.c                               | 2 +-
>  exec.c                               | 2 +-
>  linux-user/main.c                    | 2 +-
>  target/alpha/translate.c             | 2 +-
>  target/arm/helper-a64.c              | 2 +-
>  target/arm/translate-a64.c           | 4 ++--
>  target/arm/translate-sve.c           | 6 +++---
>  target/arm/translate.c               | 4 ++--
>  target/cris/translate.c              | 2 +-
>  target/hppa/translate.c              | 2 +-
>  target/i386/mem_helper.c             | 2 +-
>  target/i386/translate.c              | 2 +-
>  target/lm32/translate.c              | 2 +-
>  target/m68k/translate.c              | 2 +-
>  target/microblaze/translate.c        | 2 +-
>  target/mips/translate.c              | 2 +-
>  target/moxie/translate.c             | 2 +-
>  target/nios2/translate.c             | 2 +-
>  target/openrisc/translate.c          | 2 +-
>  target/ppc/mem_helper.c              | 2 +-
>  target/ppc/translate.c               | 4 ++--
>  target/riscv/cpu_helper.c            | 2 +-
>  target/riscv/translate.c             | 2 +-
>  target/s390x/translate.c             | 4 ++--
>  target/sh4/translate.c               | 2 +-
>  target/sparc/ldst_helper.c           | 2 +-
>  target/sparc/translate.c             | 2 +-
>  target/tilegx/translate.c            | 2 +-
>  target/tricore/translate.c           | 2 +-
>  target/unicore32/translate.c         | 2 +-
>  target/xtensa/translate.c            | 2 +-
>  tcg/aarch64/tcg-target.inc.c         | 4 ++--
>  tcg/arm/tcg-target.inc.c             | 4 ++--
>  tcg/i386/tcg-target.inc.c            | 4 ++--
>  tcg/mips/tcg-target.inc.c            | 2 +-
>  tcg/optimize.c                       | 2 +-
>  tcg/ppc/tcg-target.inc.c             | 4 ++--
>  tcg/riscv/tcg-target.inc.c           | 4 ++--
>  tcg/s390/tcg-target.inc.c            | 4 ++--
>  tcg/sparc/tcg-target.inc.c           | 2 +-
>  tcg/tcg-common.c                     | 2 +-
>  tcg/tcg-op-gvec.c                    | 8 ++++----
>  tcg/tcg-op-vec.c                     | 6 +++---
>  tcg/tcg-op.c                         | 6 +++---
>  tcg/tcg.c                            | 2 +-
>  tcg/tci.c                            | 2 +-
>  MAINTAINERS                          | 1 +
>  61 files changed, 76 insertions(+), 76 deletions(-)
>  rename {tcg =3D> include/tcg}/tcg-gvec-desc.h (100%)
>  rename {tcg =3D> include/tcg}/tcg-mo.h (100%)
>  rename {tcg =3D> include/tcg}/tcg-op-gvec.h (100%)
>  rename {tcg =3D> include/tcg}/tcg-op.h (99%)
>  rename {tcg =3D> include/tcg}/tcg-opc.h (100%)
>  rename {tcg =3D> include/tcg}/tcg.h (99%)


Thank you, Philippe and Paolo.

Reviewed-by: Stefan Weil <sw@weilnetz.de>




--Z26opEMc5rUUSmPMbaTLlsX8tAWAczyte--

--d4BnQkunNGNKjBmuITflI5uWYXBXPxjak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESSNv6nXJXWmOwreK4Iwh1Wd0UK0FAl4NrdMACgkQ4Iwh1Wd0
UK3PDg//dm8FfxCThzXQObJNDFdI8j0mo9TLEoSSp8yfwdSGqyGQNLfc09rV/ok0
FbXNRzUJe278sq1SJEtTvcLjNVBTfPyWTO1yTplJWCmQkvRx0mkHCmwKq0kIAA2M
gApxUfYtEzYMKKTnyodqvhSw5Uuep4bOtP59KsvO+OsnfDOoO+3/TGWp0WYaljDB
5PXUrffR4E5oR353u+oF8Z6jqJprZBklz0VApa0AX2BXl7AIw3bNNG5bCdfpf2B3
UoUoAs7fUh+izpktsJ+p7+WQYf48bLOCE6BppDkGTTkQ7KsbR26klVeL1OrcpT0q
M/Z0YqBVQjzQRbHS8OmAATYn8Nvvf6qdAEFWQNT2riktpZG5VDU4bTNTOBQcgk8j
8GScSzOWPWyJijjdaDF7aT3YGeNXDawfKZLujZDUdGqdoW4XrBRwVwBAZ8r/9NzJ
hvy+8SMs4WBZOmvJ3tlNLGFODHfv56dycdXHUKJXQvAw+40Cqn7m17YVyQuy9EQW
yNogVLXzMRQwpBPMhGIBSOUoiC6a0m4TQH2s1dE2pZKVeZQFP1IKO+ZEWgX3eRxO
LSVmOp3Q4AGcKO9SwL/WXTQKARR7X5tVWlmpMZitlQBJcsOyFmo3v68gmuRLZy5p
YQmeofszSxukHBSGZXrVv6xe7+Bd1nfOeDcfD2vFKKWkLZPVIFw=
=udhw
-----END PGP SIGNATURE-----

--d4BnQkunNGNKjBmuITflI5uWYXBXPxjak--

