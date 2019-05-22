Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1831CC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55A12089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55A12089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTQyj-0005Nn-4a
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:08:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hTQxc-0004mL-2Z
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hTQxb-0003Vv-4f
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:07:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hTQxa-0003Sd-D1
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:07:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8B3730C250E;
	Wed, 22 May 2019 13:07:01 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A2CA36199B;
	Wed, 22 May 2019 13:06:46 +0000 (UTC)
Date: Wed, 22 May 2019 15:06:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190522150642.3da34e6b@redhat.com>
In-Reply-To: <20190521092553-mutt-send-email-mst@kernel.org>
References: <20190520231008.20140-1-mst@redhat.com>
	<CAFEAcA80Q8zWxM4TBVMZHLuOzo0HSpT=4C76uAwdMjLn2Xye=w@mail.gmail.com>
	<20190521092553-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 22 May 2019 13:07:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v2 00/36] pci, pc, virtio: features, fixes
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 09:26:16 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, May 21, 2019 at 12:49:48PM +0100, Peter Maydell wrote:
> > On Tue, 21 May 2019 at 00:10, Michael S. Tsirkin <mst@redhat.com> wrote:  
> > >
> > > The following changes since commit 2259637b95bef3116cc262459271de08e038cc66:
> > >
> > >   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-05-20 17:22:05 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > >
> > > for you to fetch changes up to 0c05ec64c388aea59facbef740651afa78e04f50:
> > >
> > >   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-20 18:40:02 -0400)
> > >
> > > ----------------------------------------------------------------
> > > pci, pc, virtio: features, fixes
> > >
> > > reconnect for vhost blk
> > > tests for UEFI
> > > misc other stuff
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > > ----------------------------------------------------------------  
> > 
> > Hi -- this failed 'make check' for 32-bit Arm hosts:
> > 
> > ERROR:/home/peter.maydell/qemu/tests/acpi-utils.c:145:acpi_find_rsdp_address_uefi:
> > code should not be reached
> > Aborted
> > ERROR - too few tests run (expected 1, got 0)
> > /home/peter.maydell/qemu/tests/Makefile.include:885: recipe for target
> > 'check-qtest-aarch64' failed
> > 
> > thanks
> > -- PMM  
> 
> Nothing jumps out ... Igor?
On 32-bit ARM host and it looks like UEFI crashes (CCing Laszlo) with:

InstallProtocolInterface: 5B1B31A1-9562-11D2-8E3F-00A0C969723B 469E52C0
ASSERT [DxeCore] /home/lacos/src/upstream/qemu/roms/edk2/MdePkg/Library/BaseLib/String.c(1090): Length < _gPcd_FixedAtBuild_PcdMaximumAsciiStringLength

CLI to reproduce:

qemu-system-aarch64  -display none -machine virt,accel=tcg -nodefaults -nographic -drive if=pflash,format=raw,file=pc-bios/edk2-aarch64-code.fd,readonly -drive if=pflash,format=raw,file=pc-bios/edk2-arm-vars.fd,snapshot=on -cdrom tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2 -cpu cortex-a57 -serial stdio



