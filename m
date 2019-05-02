Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD0EC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B03A20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B03A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7sD-0007hx-LD
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 05:19:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hM7pL-00063p-1O
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hM7pG-0000OU-EF
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:16:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hM7pA-0000CF-MU
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:16:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 340553082E60
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 09:16:08 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-207.rdu2.redhat.com
	[10.10.120.207])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 50F715DA35;
	Thu,  2 May 2019 09:16:04 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
References: <20190425104326.12835-1-lersek@redhat.com>
Message-ID: <b08ac193-357f-6032-8083-45b46971500f@redhat.com>
Date: Thu, 2 May 2019 11:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190425104326.12835-1-lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 02 May 2019 09:16:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] tests/uefi-test-tools: report the
 SMBIOS entry point structures
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502091603.9q93OK0jaRVOxvwITWOiweTrYyS82Zhek7QzJ5SR4DE@z>

Hi Igor,

On 04/25/19 12:43, Laszlo Ersek wrote:
> Repo:      https://github.com/lersek/qemu.git
> Branch:    smbios_lp_1821884
> Launchpad: https://bugs.launchpad.net/qemu/+bug/1821884
>=20
> In
>=20
>   [Qemu-devel] [PATCH for 4.1 v2 09/13]
>   tests: acpi: ignore SMBIOS tests when UEFI firmware is used
>=20
> at
>=20
>   http://mid.mail-archive.com/1553605799-168605-10-git-send-email-imamm=
edo@redhat.com
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07037.html
>=20
> Igor had to temporarily exclude SMBIOS unit testing with UEFI guests.
>=20
> Let the BiosTablesTest guest UEFI app report the SMBIOS entry point(s),
> so that SMBIOS unit tests can cover UEFI guests.
>=20
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
>=20
> Thanks
> Laszlo
>=20
> Laszlo Ersek (2):
>   tests/uefi-test-tools: report the SMBIOS entry point structures
>   tests/uefi-boot-images: report the SMBIOS entry point structures
>=20
>  tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h  =
   |  25 +++++++++++++++-----
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.i=
nf |   2 ++
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c=
   |  23 ++++++++++++++----
>  tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2        =
   | Bin 11776 -> 12288 bytes
>  tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2            =
   | Bin 11776 -> 11776 bytes
>  tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2           =
   | Bin 12800 -> 13312 bytes
>  tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2         =
   | Bin 13312 -> 13312 bytes
>  7 files changed, 40 insertions(+), 10 deletions(-)
>=20

can you ACK or test (or both) this series, please?

Thanks
Laszlo

