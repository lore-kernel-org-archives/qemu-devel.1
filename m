Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D6FC04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 01:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C2B20848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 01:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C2B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39595 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRS0X-0006Xd-C7
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 21:50:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hRRzd-0006Gc-Tj
	for qemu-devel@nongnu.org; Thu, 16 May 2019 21:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hRRzc-0004W2-SZ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 21:49:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:22016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hRRzc-0004V9-Kf
	for qemu-devel@nongnu.org; Thu, 16 May 2019 21:49:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	16 May 2019 18:49:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,478,1549958400"; d="scan'208";a="172606018"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga002.fm.intel.com with ESMTP; 16 May 2019 18:49:02 -0700
Date: Fri, 17 May 2019 09:48:30 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190517014830.GA8322@richard>
References: <20190515121146.7248-1-mst@redhat.com>
	<CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
	<6d652ee6-ffee-6316-88f4-ba9f2a237817@redhat.com>
	<CAP+75-XuuUamjbouNYRJzm2Qwtorwhbe+QX8BHBK_WaUc8F+7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP+75-XuuUamjbouNYRJzm2Qwtorwhbe+QX8BHBK_WaUc8F+7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PULL 00/37] pci, pc, virtio: features, fixes
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Wei Yang <richardw.yang@linux.intel.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 08:53:04PM +0200, Philippe Mathieu-Daudé wrote:
>On Thu, May 16, 2019 at 8:33 PM Philippe Mathieu-Daudé
><philmd@redhat.com> wrote:
>> On 5/16/19 6:04 PM, Peter Maydell wrote:
>> > On Thu, 16 May 2019 at 13:17, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >>
>> >> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>> >>
>> >>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>> >>
>> >> are available in the Git repository at:
>> >>
>> >>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>> >>
>> >> for you to fetch changes up to 0534d255dae78450d90d59db0f3a9a46b32ebd73:
>> >>
>> >>   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-14 21:19:14 -0400)
>> >>
>> >> ----------------------------------------------------------------
>> >> pci, pc, virtio: features, fixes
>> >>
>> >> reconnect for vhost blk
>> >> tests for UEFI
>> >> misc other stuff
>> >>
>> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> >>
>> >> ----------------------------------------------------------------
>> >
>> > Hi -- this pullreq has a conflict in default-configs/arm-softmmu.mak
>> > because the conversion of arm to Kconfig has landed in master.
>> > Could you rebase and fix up to use whatever the Kconfig
>> > equivalent of these changes is, please?
>>
>> Culprit is "hw/acpi: Consolidate build_mcfg to pci.c"
>>
>> The conflict doesn't look trivial to resolve (to me) so I'd rather see
>> it reviewed (by Thomas). I suggest to drop the patch(es) from your PR :(
>
>Thomas, FYI I did this to resolve the conflict:
>
>- keep default-configs/arm-softmmu.mak from master:
>
>  git checkout origin/master default-configs/arm-softmmu.mak
>
>- applied the following !fixup snippet:
>
>-- >8 --
>--- a/hw/acpi/Kconfig
>+++ b/hw/acpi/Kconfig
>@@ -25,7 +25,7 @@ config ACPI_NVDIMM
>
> config ACPI_PCI
>     bool
>-    depends on ACPI
>+    depends on ACPI && PCI

Take a look into hw/arm/Kconfig. Only ARM_VIRT selects ACPI, but this one
doesn't select PCI.

Which option on arm select both?

>
>---
>
>I felt it easier to review on top of "hw/acpi: Improve build modularity"
>https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04718.html
>
>Sadly both series clash :(
>
>Regards,
>
>Phil.

-- 
Wei Yang
Help you, Help me

