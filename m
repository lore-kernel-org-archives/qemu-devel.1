Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A666C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFC3217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFC3217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKsq-0005tJ-8x
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:11:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCKlp-0008QJ-31
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCKdg-0001lw-Rn
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:55:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:56713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hCKde-0001eM-IN; Fri, 05 Apr 2019 04:55:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Apr 2019 01:55:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,312,1549958400"; d="scan'208";a="137804519"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2019 01:55:50 -0700
Date: Fri, 5 Apr 2019 16:55:30 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190405085529.GA24071@richard>
References: <20190313044253.31988-1-richardw.yang@linux.intel.com>
	<20190313044253.31988-4-richardw.yang@linux.intel.com>
	<20190313132300.3f56a5ca@redhat.com>
	<20190313133359.h2njohyijgvkcbtv@master>
	<20190313170943.5384f5cf@redhat.com>
	<20190402035343.GA6527@richard>
	<20190402081512.6194a58f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190402081512.6194a58f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] hw/acpi: Extract build_mcfg
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, mst@redhat.com,
	qemu-devel@nongnu.org, Wei Yang <richard.weiyang@gmail.com>,
	shannon.zhaosl@gmail.com, wei.w.wang@intel.com,
	qemu-arm@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405085530.hQAUHJjtazaq658R177zgpIyhoEsj-j9gIDeG4x2sqw@z>

On Tue, Apr 02, 2019 at 08:15:12AM +0200, Igor Mammedov wrote:
>On Tue, 2 Apr 2019 11:53:43 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> 
>> The migration infrastructure has several SaveStateEntry to help migrate
>> different elements. The one with name "ram" take charge of RAMBlock. So this
>> SaveStateEntry and its ops is the next step for me to investigate. And from
>> this to see the effect of different size MemoryRegion during migration.
>I don't think that you need to dig in migration mechanics so deep.
>For our purpose of finding QEMU&machine version where migration between
>size mismatched MemoryRegions (or RAMBlocks) is fixed is sufficient.
>

ok.

>Aside from trying to grasp how migration works internally, you can try
>to simulate[1] problem and bisect it to a commit that fixed it.
>It still not easy due to amount of combinations you'd need to try,
>but it's probably much easier than trying to figure out issue just
>by reading code.
>
>1) to stimulate you need to recreate conditions for table_mr jumping
>from initial padded size to the next padded size after adding bridge
>so you'd have reproducer which makes table_mr differ in size.
>
>If I recall correctly in that time conditions were created by large
>amount hotpluggble CPUs (maxcpus - CLI option) and then addidng
>PCI bridges.
>I'd just hack QEMU to print table_mr size in acpi_build_update()
>to find coldplug CLI where we jump to the next padded size and then
>use it for bisection with bridge[s] hotplug on source and migrating that
>without reboot to target where hotplugged bridges are on CLI (one has to
>configure target so it would have all devices that source has including
>hotplugged ones)
>

Igor,

I got some confusion on how to re-produce this case. To be specific, how to 
expand table_mr from initial padded size to next padded size.

Let's see a normal hotplug case first. 

    I did one test to see the how a guest with hot-plug cpu migrate to
    destination.  It looks the migration fails if I just do hot-plug at
    source. So I have to do hot-plug both at source and at destination. This
    will expand the table_mr both at source and destination.

Then let's see the effect of hotplug more devices to exceed original padded
size. There are two cases, before re-sizable MemoryRegion and after.

1) Before re-sizable MemoryRegion introduced

    Before re-sizable MemoryRegion introduced, we just pad table_mr to 4K. And
    this size never gets bigger, if I am right. To be accurate, the table_blob
    would grow to next padded size if we hot-add more cpus/pci bridge, but we
    just copy the original size of MemoryRegion. Even without migration, the
    ACPI table is corrupted when we expand to next padded size.
    
    Is my understanding correct here?

2) After re-sizable MemoryRegion introduced

    This time both tabl_blob and MemoryRegion grows when it expand to next
    padded size. Since we need to hot-add device at both side, ACPI table
    grows at the same pace.

    Every thing looks good, until one of it exceed the resizable
    MemoryRegion's max size. (Not sure this is possible in reality, while
    possible in theory). Actually, this looks like case 1) when resizable
    MemoryRegion is not introduced. The too big ACPI table get corrupted.

So if my understanding is correct, the procedure you mentioned "expand from
initial padded size to next padded size" only applies to two different max
size resizable MemoryRegion. For other cases, the procedure corrupt the ACPI
table itself.

Then when we look at

    commit 07fb61760cdea7c3f1b9c897513986945bca8e89
    Author: Paolo Bonzini <pbonzini@redhat.com>
    Date:   Mon Jul 28 17:34:15 2014 +0200
    
        pc: hack for migration compatibility from QEMU 2.0
    
This fix ACPI migration issue before resizable MemoryRegion is
introduced(introduced in 2015-01-08). This looks expand to next padded size
always corrupt ACPI table at that time. And it make me think expand to next
padded size is not the procedure we should do?

And my colleague Wei Wang(in cc) mentioned, to make migration succeed, the
MemoryRegion has to be the same size at both side. So I guess the problem
doesn't lie in hotplug but in "main table" size difference.

For example, we have two version of Qemu: v1 and v2. Their "main table" size
is:

    v1: 3990
    v2: 4020

At this point, their ACPI table all padded to 4k, which is the same.

Then we create a machine with 1 more vcpu by these two versions. This will
expand the table to:

    v1: 4095
    v2: 4125

After padding, v1's ACPI table size is still 4k but v2's is 8k. Now the
migration is broken.

If this analysis is correct, the relationship between migration failure and
ACPI table is "the change of ACPI table size". Any size change of any
ACPI table would break migration. While of course, since we pad the table,
only some combinations of tables would result in a visible real size change in
MemoryRegion.

Then the principle for future ACPI development is to keep all ACPI table size
unchanged.

Now let's back to mcfg table. As the comment mentioned, guest could
enable/disable MCFG, so the code here reserve table no matter it is enabled or
not. This behavior ensures ACPI table size not changed. So do we need to find
the machine type as you suggested before?

-- 
Wei Yang
Help you, Help me

