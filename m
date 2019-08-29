Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFE1C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597522166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597522166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MI3-0001QZ-Em
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.gao@intel.com>) id 1i3MBg-0003sm-8m
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chao.gao@intel.com>) id 1i3MBc-0005Af-6q
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:18:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:47645)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chao.gao@intel.com>) id 1i3MBb-00057i-Oa
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:18:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Aug 2019 08:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; d="scan'208";a="182370528"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.26])
 by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2019 08:18:03 -0700
Date: Thu, 29 Aug 2019 23:22:08 +0800
From: Chao Gao <chao.gao@intel.com>
To: Jan Beulich <jbeulich@suse.com>
Message-ID: <20190829152206.GA3174@gao-cwp>
References: <1567069347-22841-1-git-send-email-chao.gao@intel.com>
 <131d5f04-7ef9-9a2b-3009-2a93587186ef@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <131d5f04-7ef9-9a2b-3009-2a93587186ef@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
 Paul Durrant <paul.durrant@citrix.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 29, 2019 at 12:03:44PM +0200, Jan Beulich wrote:
>On 29.08.2019 11:02, Chao Gao wrote:
>> Currently, for a HVM on Xen, no reset method is virtualized. So in a VM's
>> perspective, assigned devices cannot be reset. But some devices rely on PCI
>> reset to recover from hardware hangs. When being assigned to a VM, those
>> devices cannot be reset and won't work any longer if a hardware hang occurs.
>> We have to reboot VM to trigger PCI reset on host to recover the device.
>
>Did you consider a hot-unplug, reset (by host), hot-plug cycle instead?

Yes. I considered this means. But it needs host to initiate this action.
However, when a device needs reset is determined by the device driver
in VM. So in practice, VM still needs a way to notify host to do
unplug/reset/plug. As the standard FLR capability can meet the
requirement, I don't try to invent one.

>
>> +static int xen_pt_devctl_reg_write(XenPCIPassthroughState *s,
>> +                                   XenPTReg *cfg_entry, uint16_t *val,
>> +                                   uint16_t dev_value, uint16_t valid_mask)
>> +{
>> +    if (s->real_device.is_resetable && (*val & PCI_EXP_DEVCTL_BCR_FLR)) {
>> +        xen_pt_reset(s);
>> +    }
>> +    return xen_pt_word_reg_write(s, cfg_entry, val, dev_value, valid_mask);
>
>I think you also need to clear the bit before handing on the request,
>such that reads will always observe it clear.

Will do.

Thanks
Chao

