Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17BAC31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9542147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9542147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSZJ-0000Y5-Pd
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53079)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hbROn-0005YE-SQ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hbROm-0006Ws-JP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:12:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hbROm-0006Qj-Cv
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:12:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C12330820C9
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 15:12:14 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-127.ams2.redhat.com
 [10.36.117.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E76E2537B3;
 Thu, 13 Jun 2019 15:12:10 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190606133110.13754-1-lersek@redhat.com>
Message-ID: <611d1efd-3052-c98d-e88a-294d07c822ab@redhat.com>
Date: Thu, 13 Jun 2019 17:12:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190606133110.13754-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 13 Jun 2019 15:12:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/6] update edk2 submodule & binaries to
 edk2-stable201905
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
Cc: qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/06/19 15:31, Laszlo Ersek wrote:
> Launchpad: https://bugs.launchpad.net/qemu/+bug/1831477
> Repo:      https://github.com/lersek/qemu.git
> Branch:    edk2-stable201905-lp-1831477
>=20
> edk2-stable201905 has been released today; let's update QEMU's
> submodule, and the binaries built thereof. This should be the edk2
> release that goes into QEMU 4.1.
>=20
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Thanks
> Laszlo
>=20
> Laszlo Ersek (6):
>   roms/Makefile.edk2: define edk2-stable201905 network feature test
>     macros
>   roms/edk2: update submodule from edk2-stable201903 to
>     edk2-stable201905
>   roms/Makefile.edk2: remove edk2-stable201903 network feature test
>     macros
>   roms/Makefile.edk2: update input file list for
>     "pc-bios/edk2-licenses.txt"
>   pc-bios: refresh edk2 build artifacts for edk2-stable201905
>   pc-bios: update the README file with edk2-stable201905 information
>=20
>  pc-bios/README                         |  14 +-
>  pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1177603 -> 1178070 bytes
>  pc-bios/edk2-arm-code.fd.bz2           | Bin 1173662 -> 1172752 bytes
>  pc-bios/edk2-i386-code.fd.bz2          | Bin 1688659 -> 1736199 bytes
>  pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 1881979 -> 1943949 bytes
>  pc-bios/edk2-licenses.txt              | 752 ++++++++++++++++++--
>  pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1669280 -> 1717094 bytes
>  pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 1901210 -> 1958037 bytes
>  roms/Makefile.edk2                     |  22 +-
>  roms/edk2                              |   2 +-
>  10 files changed, 714 insertions(+), 76 deletions(-)
>=20

Ping :)

