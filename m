Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814A6C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B91B2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW+C1jyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B91B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLqT-0007dE-Hh
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1izLpk-000747-I9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1izLpj-0006k1-7X
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:39:16 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1izLpi-0006f1-UJ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:39:15 -0500
Received: by mail-wr1-x442.google.com with SMTP id m16so2993651wrx.11
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DOxkzKgZVI4/JpcCqaI2No5FrvN9Zhd4CWpcVIgS8oc=;
 b=YW+C1jyJKYV5gOtvrQ103fin3rSaHVi7JTePKHHPCiu1fMqdgkXujfb/TES7JbzwoY
 QTcNaTJez9Qg9ABPzSjeNrog+wUzL7VFdmjVWglTJldEfj+icQ9sf92qz+zxOxW1A/2p
 frStdK0/aR0EYi8UaWu2JVSmvef1bJiOmdiSRx3AmRCqJYdHoAFudBTsRtybdmvNOlXn
 ZH4K9meEIEQn0v2lujWSq+sIgk001f2tcxHQJSKKpNcVrh55xYTH8eGTgYdo33y7zm0q
 zjBvySy0q8eGMN8AhNpfbiRE5g8y12k8Tn40KWwoYGmt+LiAn5NIJpNFwAI0pPfVw6Ru
 RYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DOxkzKgZVI4/JpcCqaI2No5FrvN9Zhd4CWpcVIgS8oc=;
 b=hI+L0UR/Y0YyZTgw04pcEfVYfa0qhQigls8wFkixILbhwDO3aFUzxiLl+o9VQDy8DA
 g2aVsl2sbsuh+mqyA3itZzGcJlvK3ZSY86Dy/6Nf44UaRG3u2rm8+tz/wpNT6i5DNcEA
 oAPeucbXQNLHDb8qfreFng5WqIu2xdnh4hymiZfej98A4T8pyQmDWNO0/os7EbDXU/fl
 tiyEW7AdEprDI2ozmvdGlCEpJRD7H+KNeiYSaPPJ/2+GV8xVfvjWSlncs3GyTPYVGah0
 I3KrR+OQ/DuhwfRGXB1o5PkWQeAKJjKcLYXQjdtWJrN1BNJuHONjWTqWMBOYJ/rk/6OZ
 9NoQ==
X-Gm-Message-State: APjAAAU46Vs09jgW/dmS2GHpMNhYPfMC2i+HoYgYisoVVZ3T/AgPyTMz
 Zpfo85hct4nnBFNUdGZtd9A=
X-Google-Smtp-Source: APXvYqw+UZBA4bhgXdrS1wgnJ39kb8TrdWovydN1UFMG01HRzfJqXG+s81relIv5gvC2HrTpnC9HoQ==
X-Received: by 2002:a05:6000:367:: with SMTP id
 f7mr28190339wrf.174.1580913553627; 
 Wed, 05 Feb 2020 06:39:13 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o2sm8149079wmh.46.2020.02.05.06.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:39:12 -0800 (PST)
Date: Wed, 5 Feb 2020 14:39:11 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: i.kotrasinsk@partner.samsung.com
Subject: Re: [RFC 0/9] Add an interVM memory sharing device
Message-ID: <20200205143911.GG58062@stefanha-x1.localdomain>
References: <CGME20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a@eucas1p1.samsung.com>
 <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="j2AXaZ4YhVcLc+PQ"
Content-Disposition: inline
In-Reply-To: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org, Igor Mammedov <imammedo@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--j2AXaZ4YhVcLc+PQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2020 at 12:30:42PM +0100, i.kotrasinsk@partner.samsung.com =
wrote:
> From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
>=20
> This patchset adds a "memory exposing" device that allows two QEMU
> instances to share arbitrary memory regions. Unlike ivshmem, it does not
> create a new region of memory that's shared between VMs, but instead
> allows one VM to access any memory region of the other VM we choose to
> share.
>=20
> The motivation for this device is a sort of ARM Trustzone "emulation",
> where a rich system running on one machine (e.g. x86_64 linux) is able
> to perform SMCs to a trusted system running on another (e.g. OpTEE on
> ARM). With a device that allows sharing arbitrary memory between VMs,
> this can be achieved with minimal changes to the trusted system and its
> linux driver while allowing the rich system to run on a speedier x86
> emulator. I prepared additional patches for linux, OpTEE OS and OpTEE
> build system as a PoC that such emulation works and passes OpTEE tests;
> I'm not sure what would be the best way to share them.
>=20
> This patchset is my first foray into QEMU source code and I'm certain
> it's not yet ready to be merged in. I'm not sure whether memory sharing
> code has any race conditions or breaks rules of working with memory
> regions, or if having VMs communicate synchronously via chardevs is the
> right way to do it. I do believe the basic idea for sharing memory
> regions is sound and that it could be useful for inter-VM communication.

Hi,
Without having looked into the patches yet, I'm already wondering if you
can use the existing -object
memory-backend-file,size=3D512M,mem-path=3D/my/shared/mem feature for your
use case?

That's the existing mechanism for fully sharing guest RAM and if you
want to share all of memory then maybe a device is not necessary - just
share the memory.

Stefan

> Igor Kotrasinski (9):
>   memory: Add function for finding flat memory ranges
>   memory: Support mmap offset for fd-backed memory regions
>   memory: Hack - use shared memory when possible
>   hw/misc/memexpose: Add documentation
>   hw/misc/memexpose: Add core memexpose files
>   hw/misc/memexpose: Add memexpose pci device
>   hw/misc/memexpose: Add memexpose memory region device
>   hw/misc/memexpose: Add simple tests
>   hw/arm/virt: Hack in support for memexpose device
>=20
>  Kconfig.host                            |   3 +
>  MAINTAINERS                             |  12 +
>  Makefile                                |   1 +
>  backends/hostmem-memfd.c                |   2 +-
>  configure                               |   8 +
>  docs/specs/memexpose-spec.txt           | 168 +++++++++
>  exec.c                                  |  10 +-
>  hw/arm/virt.c                           | 110 +++++-
>  hw/core/numa.c                          |   4 +-
>  hw/mem/Kconfig                          |   3 +
>  hw/misc/Makefile.objs                   |   1 +
>  hw/misc/ivshmem.c                       |   3 +-
>  hw/misc/memexpose/Makefile.objs         |   4 +
>  hw/misc/memexpose/memexpose-core.c      | 630 ++++++++++++++++++++++++++=
++++++
>  hw/misc/memexpose/memexpose-core.h      | 109 ++++++
>  hw/misc/memexpose/memexpose-memregion.c | 142 +++++++
>  hw/misc/memexpose/memexpose-memregion.h |  41 +++
>  hw/misc/memexpose/memexpose-msg.c       | 261 +++++++++++++
>  hw/misc/memexpose/memexpose-msg.h       | 161 ++++++++
>  hw/misc/memexpose/memexpose-pci.c       | 218 +++++++++++
>  include/exec/memory.h                   |  20 +
>  include/exec/ram_addr.h                 |   2 +-
>  include/hw/arm/virt.h                   |   5 +
>  include/qemu/mmap-alloc.h               |   1 +
>  memory.c                                |  82 ++++-
>  tests/qtest/Makefile.include            |   2 +
>  tests/qtest/memexpose-test.c            | 364 ++++++++++++++++++
>  util/mmap-alloc.c                       |   7 +-
>  util/oslib-posix.c                      |   2 +-
>  29 files changed, 2360 insertions(+), 16 deletions(-)
>  create mode 100644 docs/specs/memexpose-spec.txt
>  create mode 100644 hw/misc/memexpose/Makefile.objs
>  create mode 100644 hw/misc/memexpose/memexpose-core.c
>  create mode 100644 hw/misc/memexpose/memexpose-core.h
>  create mode 100644 hw/misc/memexpose/memexpose-memregion.c
>  create mode 100644 hw/misc/memexpose/memexpose-memregion.h
>  create mode 100644 hw/misc/memexpose/memexpose-msg.c
>  create mode 100644 hw/misc/memexpose/memexpose-msg.h
>  create mode 100644 hw/misc/memexpose/memexpose-pci.c
>  create mode 100644 tests/qtest/memexpose-test.c
>=20
> --=20
> 2.7.4
>=20
>=20

--j2AXaZ4YhVcLc+PQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl46048ACgkQnKSrs4Gr
c8iddAgAuwnstz5oYM9PFNmKV/yZzJfgRbBn5QMiN+lVp+XgNvECeU+c6xsryMnA
IuobpKF11b+cWd/bHlNR3rLQ3X73tLmTW3KEhiSE8APuYww1CE9/MwKBpIt9sIIA
gUsnvGcegt/DDMGYBpzr/QPoxgj/V1j9njgLu4qNOFKOl0ShQxy3V/SOq/uFC9TP
oSNhqEfvfJBjfFWYB4ZnHwTYrO00ZzWuYiJBK9k1mXvVrJCrNwpLoFJYYgd0o13F
9lwvjLLsWcqaPg8dveMnse3bh3dVGhjQB6aMfqgCl7rXwNV8G+zGGh51a6/3CqKN
JRuXBj9StxIWGNM/HcD8BdZbhF2aIA==
=w/ta
-----END PGP SIGNATURE-----

--j2AXaZ4YhVcLc+PQ--

