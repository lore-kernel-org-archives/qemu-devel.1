Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E92C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0C520578
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0C520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6A41-0005nR-Vn
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.gao@intel.com>) id 1i6A3Q-0005Nr-5N
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chao.gao@intel.com>) id 1i6A3O-0008TG-Fp
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:57:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:54493)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chao.gao@intel.com>) id 1i6A3O-0008Ph-7H
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:57:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Sep 2019 01:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; d="scan'208";a="188253981"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.26])
 by orsmga006.jf.intel.com with ESMTP; 06 Sep 2019 01:57:05 -0700
Date: Fri, 6 Sep 2019 17:01:09 +0800
From: Chao Gao <chao.gao@intel.com>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20190906090107.GA25703@gao-cwp>
References: <1567069347-22841-1-git-send-email-chao.gao@intel.com>
 <20190829102059.bk4l7itydj73d3ua@Air-de-Roger>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190829102059.bk4l7itydj73d3ua@Air-de-Roger>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [RFC Patch] xen/pt: Emulate FLR capability
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 Paul Durrant <paul.durrant@citrix.com>, Jan Beulich <jbeulich@suse.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 29, 2019 at 12:21:11PM +0200, Roger Pau Monné wrote:
>On Thu, Aug 29, 2019 at 05:02:27PM +0800, Chao Gao wrote:
>> Currently, for a HVM on Xen, no reset method is virtualized. So in a VM's
>> perspective, assigned devices cannot be reset. But some devices rely on PCI
>> reset to recover from hardware hangs. When being assigned to a VM, those
>> devices cannot be reset and won't work any longer if a hardware hang occurs.
>> We have to reboot VM to trigger PCI reset on host to recover the device.
>>
>> This patch exposes FLR capability to VMs if the assigned device can be reset on
>> host. When VM initiates an FLR to a device, qemu cleans up the device state,
>> (including disabling of intx and/or MSI and unmapping BARs from guest, deleting
>> emulated registers), then initiate PCI reset through 'reset' knob under the
>> device's sysfs, finally initialize the device again.
>
>I think you likely need to deassign the device from the VM, perform
>the reset, and then assign the device again, so that there's no Xen
>internal state carried over prior to the reset?

Yes. It is the safest way. But here I want to present the feature as FLR
(such that the device driver in guest can issue PCI reset whenever
needed and no change is needed to device driver).  Current device
deassignment notifies guest that the device is going to be removed
It is not the standard PCI reset. Is it possible to make guest unaware
of the device deassignment to emulate a standard PCI reset? In my mind,
we can expose do_pci_remove/add to qemu or rewrite them in qemu (but
don't remove the device from guest's PCI hierarchy). Do you think it is
the right direction?

Thanks
Chao

