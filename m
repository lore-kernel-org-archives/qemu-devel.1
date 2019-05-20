Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FE5C04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 00:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9435206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 00:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9435206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55497 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSWIL-0004pe-7H
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 20:36:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSWHV-0004Bt-6s
	for qemu-devel@nongnu.org; Sun, 19 May 2019 20:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSWHR-00060A-Ni
	for qemu-devel@nongnu.org; Sun, 19 May 2019 20:35:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:59507)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSWHO-0005vv-SM
	for qemu-devel@nongnu.org; Sun, 19 May 2019 20:35:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 May 2019 17:35:46 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga001.fm.intel.com with ESMTP; 19 May 2019 17:35:45 -0700
Date: Mon, 20 May 2019 08:35:14 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190520003514.GB18144@richard>
References: <20190517005114.19456-1-richardw.yang@linux.intel.com>
	<20190517131116.02b25408@Igors-MacBook-Pro>
	<20190517125957.56uoupbo3ai4jybr@master>
	<20190517162903.4fc94708@Igors-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517162903.4fc94708@Igors-MacBook-Pro>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH] hw/acpi: ACPI_PCI should depends on both
 ACPI and PCI
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
Cc: qemu-devel@nongnu.org, mst@redhat.com,
	Wei Yang <richardw.yang@linux.intel.com>,
	Wei Yang <richard.weiyang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 04:29:03PM +0200, Igor Mammedov wrote:
>On Fri, 17 May 2019 12:59:57 +0000
>Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> On Fri, May 17, 2019 at 01:11:16PM +0200, Igor Mammedov wrote:
>> >On Fri, 17 May 2019 08:51:14 +0800
>> >Wei Yang <richardw.yang@linux.intel.com> wrote:
>> >
>> >> Pointed out by Philippe Mathieu-Daud?? <philmd@redhat.com>.
>> >> 
>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> ---
>> >>  hw/acpi/Kconfig | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> 
>> >> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
>> >> index 7265843cc3..7c59cf900b 100644
>> >> --- a/hw/acpi/Kconfig
>> >> +++ b/hw/acpi/Kconfig
>> >> @@ -25,7 +25,7 @@ config ACPI_NVDIMM
>> >>  
>> >>  config ACPI_PCI
>> >>      bool
>> >> -    depends on ACPI
>> >> +    depends on ACPI && PCI
>> >>  
>> >>  config ACPI_VMGENID
>> >>      bool
>> >
>> >are you sure you didn't miss anything?
>> >
>> 
>> This patch is based on the comment in
>> http://qemu.11.n7.nabble.com/PATCH-v4-0-6-Extract-build-mcfg-tt650106.html#a655913
>> 
>> My understanding is not correct?
>
>That wasn't the end of discussion, it continued on until Philippe suggested
>the below changes
>

Yep, just see the latest reply.

>> 
>> >On Fri, 17 May 2019 10:37:42 +0200
>> >Philippe Mathieu-Daud?? <philmd@redhat.com> wrote:
>> >
>> >[...]
>> >> 
>> >> config ARM_VIRT
>> >>     ...
>> >>     select ACPI_PCI
>> >> 
>> >> config ACPI_PCI
>> >>     bool
>> >>     depends on ACPI && PCI
>> >> 
>> >
>> >
>> 

-- 
Wei Yang
Help you, Help me

