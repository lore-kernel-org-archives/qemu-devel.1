Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B57C282DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8551620870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8551620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50197 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQo3-00036Z-Q6
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:43:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDQnL-0002pm-1D
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDQnK-0006gr-11
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:42:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDQnJ-0006gZ-Mu
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:42:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3D423082B66;
	Mon,  8 Apr 2019 09:42:23 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-29.rdu2.redhat.com
	[10.10.121.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 590F35F9C6;
	Mon,  8 Apr 2019 09:42:17 +0000 (UTC)
To: Olaf Hering <olaf@aepfle.de>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
	<9a4ea235-29ce-2a98-a723-0a61be55433f@redhat.com>
	<20190408110911.46d3b9d0.olaf@aepfle.de>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <002dd129-cda3-77b5-ac8b-4734cdb1b902@redhat.com>
Date: Mon, 8 Apr 2019 11:42:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190408110911.46d3b9d0.olaf@aepfle.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 08 Apr 2019 09:42:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
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
	qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408094217.zR-VIe9_jYgc4krfQaabWVkNLPSWMh4J45PgGVC-A-s@z>

On 04/08/19 11:09, Olaf Hering wrote:
> Am Mon, 8 Apr 2019 11:04:09 +0200
> schrieb Laszlo Ersek <lersek@redhat.com>:
>
>> This is not a QEMU build failure, but an issue in the downstream
>> packaging that not only tries to build QEMU, but performs a
>> maintainer build on binary artifacts.
>
> I'm sure everyone will rebuild the things from source that can be
> rebuilt.

Define "everyone".

- Every direct end-user of upstream QEMU? (That is, every human user
  that runs configure and make and make install?) Absolutely not. Those
  users are already not rebuilding the full contents of pc-bios. Look
  for INSTALL_BLOBS in the top-level makefile.

- Every *packager* / distribution that provides QEMU packages? Yes, they
  will definitely rebuild whatever they can from source. That's only
  prudent and ethical. That's what I called a "maintainer build".

> Who would ship random binary blobs from unknown origin?

I don't expect you to, and any of the patches related to the edk2
submodule don't force you to.

commit f590a812c21074e82228de3e1dfb57b75fc02b62
Author: Laszlo Ersek <lersek@redhat.com>
Date:   Mon Feb 4 17:03:22 2019 +0100

    roms: build the EfiRom utility from the roms/edk2 submodule

    Building the EfiRom utility from "roms/edk2/BaseTools" should make
    "roms/Makefile" more self-contained. Otherwise, we'd call the system-wide
    EfiRom for building the combined iPXE option ROMs, but call the sibling
    utilities from "roms/edk2/BaseTools" for building "roms/edk2" content.

Without this patch, if you ran "make -C roms", you'd use one instance of
EfiRom (from who knows where) for producing the combined iPXE oproms,
and another EfiRom, from the edk2.git submodule, for anything inside
that same edk2.git submodule that requires EfiRom. That's *wrong*.

- You are invoking "make -C roms" in QEMU, so you should use precisely
  the same EfiRom for all purposes that need EfiRom.

- And given that the EfiRom source code is available in the submodule,
  the one EfiRom used (for whatever purpose) should be *that* EfiRom
  (i.e., built from source).

If you need to inject specific compiler/linker flags, into the building
of EfiRom itself, you can already do that; you just need to update your
spec file to take advantage of that edk2 BaseTools build feature.

Laszlo

