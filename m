Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABD4C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 03:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572F720848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 03:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572F720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40612 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRTJS-00032D-JX
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 23:13:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hRTIa-0002j6-V5
	for qemu-devel@nongnu.org; Thu, 16 May 2019 23:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hRTIZ-0001vC-0M
	for qemu-devel@nongnu.org; Thu, 16 May 2019 23:12:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:62011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hRTIT-0001tm-Q8
	for qemu-devel@nongnu.org; Thu, 16 May 2019 23:12:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	16 May 2019 20:12:35 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga004.fm.intel.com with ESMTP; 16 May 2019 20:12:34 -0700
Date: Fri, 17 May 2019 11:12:03 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190517031203.GA17339@richard>
References: <20190515121146.7248-1-mst@redhat.com>
	<CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
	<6d652ee6-ffee-6316-88f4-ba9f2a237817@redhat.com>
	<CAP+75-XuuUamjbouNYRJzm2Qwtorwhbe+QX8BHBK_WaUc8F+7A@mail.gmail.com>
	<20190517025903.GA17182@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517025903.GA17182@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
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
Cc: Peter Maydell <peter.maydell@linaro.org>, imammedo@redhat.com,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 10:59:03AM +0800, Wei Yang wrote:
>On Thu, May 16, 2019 at 08:53:04PM +0200, Philippe Mathieu-Daudé wrote:
>>On Thu, May 16, 2019 at 8:33 PM Philippe Mathieu-Daudé
>><philmd@redhat.com> wrote:
>>> On 5/16/19 6:04 PM, Peter Maydell wrote:
>>> > On Thu, 16 May 2019 at 13:17, Michael S. Tsirkin <mst@redhat.com> wrote:
>>> >>
>>> >> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>>> >>
>>> >>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>>> >>
>>> >> are available in the Git repository at:
>>> >>
>>> >>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>> >>
>>> >> for you to fetch changes up to 0534d255dae78450d90d59db0f3a9a46b32ebd73:
>>> >>
>>> >>   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-14 21:19:14 -0400)
>>> >>
>>> >> ----------------------------------------------------------------
>>> >> pci, pc, virtio: features, fixes
>>> >>
>>> >> reconnect for vhost blk
>>> >> tests for UEFI
>>> >> misc other stuff
>>> >>
>>> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> >>
>>> >> ----------------------------------------------------------------
>>> >
>>> > Hi -- this pullreq has a conflict in default-configs/arm-softmmu.mak
>>> > because the conversion of arm to Kconfig has landed in master.
>>> > Could you rebase and fix up to use whatever the Kconfig
>>> > equivalent of these changes is, please?
>>>
>>> Culprit is "hw/acpi: Consolidate build_mcfg to pci.c"
>>>
>>> The conflict doesn't look trivial to resolve (to me) so I'd rather see
>>> it reviewed (by Thomas). I suggest to drop the patch(es) from your PR :(
>>
>>Thomas, FYI I did this to resolve the conflict:
>>
>>- keep default-configs/arm-softmmu.mak from master:
>>
>>  git checkout origin/master default-configs/arm-softmmu.mak
>>
>>- applied the following !fixup snippet:
>>
>>-- >8 --
>>--- a/hw/acpi/Kconfig
>>+++ b/hw/acpi/Kconfig
>>@@ -25,7 +25,7 @@ config ACPI_NVDIMM
>>
>> config ACPI_PCI
>>     bool
>>-    depends on ACPI
>>+    depends on ACPI && PCI
>>
>>---
>>
>>I felt it easier to review on top of "hw/acpi: Improve build modularity"
>>https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04718.html
>>
>
>Well, I hope this will not block the merge.
>
>I took a look in the change of default-configs/arm-softmmu.mak. The general
>idea from Thomas is put those hard-coded config to Kconfig.
>
>This is fine and what I need to change in my patch is to select ACPI_PCI in
>the proper place, if my understanding is correct.
>
>Two things I need to fix:
>
>  * add select ACPI_PCI in proper place of hw/arm/Kconfig
>  * add a dummy build_mcfg() for link when ACPI_PCI is not configured.
>
>Then I have two questions:
>
>  * In hw/arm/Kconfig, I don't see one option contains both PCI and ACPI. I am
>    confused where to put the select.
>  * put dummy build_mcfg() in aml-build.c works. Igor, do you like this? Or
>    you haver other preference?

Hmm... put build_mcfg() in aml-build.c seems not work when we config both x86
and arm. e.g. --target-list=x86_64-softmmu,arm-softmmu. Because we only have
one aml-build.o object file.

What comes into my mind is wrap build_mcfg() with #ifdef CONFIG_ACPI_PCI.

Any better idea?

>
>>Sadly both series clash :(
>>
>>Regards,
>>
>>Phil.
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me

