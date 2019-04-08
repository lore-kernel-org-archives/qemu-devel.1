Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2CBC282DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32D520870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32D520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49847 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQJd-0000dN-73
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:11:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDQIL-0008HO-4g
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDQIK-0006oU-0Q
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:10:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDQIJ-0006nw-Mg
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:10:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E09727DCE1;
	Mon,  8 Apr 2019 09:02:19 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-29.rdu2.redhat.com
	[10.10.121.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 683DE60471;
	Mon,  8 Apr 2019 09:02:10 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Olaf Hering <olaf@aepfle.de>
References: <20190405153314.2068-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7fde154a-4384-0233-fae5-7dc9e288ccec@redhat.com>
Date: Mon, 8 Apr 2019 11:02:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190405153314.2068-1-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 08 Apr 2019 09:02:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 0/2] roms: Rename the EFIROM
 variable and let it be overridable
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408090209.Z1gz5cC7PmjoYWl_kIVgc0NFyi1C_HxgwVb0EgyNIsM@z>

On 04/05/19 17:33, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>
> Two trivial fixes to avoid the latest EDK2 testing series to
> cause trouble to downstream distributions (in particular if
> they have PIE enforced).

I disgree with this.

(1) In the first commit message, you say,

"The iPXE project already uses the EFIROM for a tool named 'efirom'
which is not the Intel EfiRom used by the EDK2 project".

That's wrong. For building the combined (UEFI+BIOS) iPXE oprom binaries,
the efirom tool that is invoked is *most definitely* the tool from edk2.

What changes is that we now build efirom directly from the edk2
submodule, rather than using a binary that could possibly be found on a
GNU/Linux system from another package.

This is entirely aligned with the addition of the edk2 submodule. The
source for the efirom tool is now directly available, so in a
*maintainer* build -- i.e., when you decide to rebuild iPXE binaries --
we should certainly prefer to build everything from source.

Again, this is a *maintainer* build (which also covers downstream
package builds), not end-user build. If you decide to rebuild artifacts
that are otherwise offered in binary form to end-users, you commit to
building everything from source that goes into (or is necessary for)
producing those artifacts.

In the thread "edk2 fails to compile in v4.0.0-rc2", Olaf wrote,

"It is in ovmf-tools.rpm, which comes from ovmf."

That only proves my point.

(2) For a while now, it has been possible for downstream build scripts
to inject their preferred build flags into the BaseTools build recipes
(makefiles) themselves. Please see
<https://bugzilla.redhat.com/show_bug.cgi?id=3D1540244>. This is the
relevant upstream commit list:

  1  67983484a443 BaseTools/footer.makefile: expand BUILD_CFLAGS last
                  for C files too
  2  03252ae287c4 BaseTools/header.makefile: remove "-c" from
                  BUILD_CFLAGS
  3  b8a661702643 BaseTools/Source/C: split "-O2" to BUILD_OPTFLAGS
  4  b0ca5dae78ff BaseTools/Source/C: take EXTRA_OPTFLAGS from the
                  caller
  5  81502cee20ac BaseTools/Source/C: take EXTRA_LDFLAGS from the caller
  6  aa4e0df1f0c7 BaseTools/VfrCompile: honor EXTRA_LDFLAGS

Build BaseTools as follows:

  make -C "$EDK_TOOLS_PATH" EXTRA_OPTFLAGS=3D"..."  EXTRA_LDFLAGS=3D"..."

If you need to inject PIC/PIE-related flags into the BaseTools
compilation/linking, please use the above facility.

I think it's pretty usual that new upstream releases (of any open source
project) bring some changes for downstream packaging scripts.

Thanks
Laszlo

