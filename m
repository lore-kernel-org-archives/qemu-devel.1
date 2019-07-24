Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AE2C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:00:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB92922ADC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB92922ADC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqBGe-0007Xe-Kj
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 03:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36417)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yang.zhong@intel.com>) id 1hqBGM-00079I-K9
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yang.zhong@intel.com>) id 1hqBGL-0005Xn-8D
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:00:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:61818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yang.zhong@intel.com>)
 id 1hqBGK-0005SO-UU
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:00:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jul 2019 00:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,302,1559545200"; d="scan'208";a="174792966"
Received: from yangzhon-virtual.bj.intel.com (HELO localhost) ([10.238.145.78])
 by orsmga006.jf.intel.com with ESMTP; 24 Jul 2019 00:00:26 -0700
Date: Wed, 24 Jul 2019 14:55:13 +0800
From: Yang Zhong <yang.zhong@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190724065513.GA3369@yangzhon-Virtual>
References: <7A85DF989CAE8F42902CF7B31A7D94A1487D6D13@shsmsx102.ccr.corp.intel.com>
 <93e3762a-d906-6d6b-9a5f-7497af188f94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93e3762a-d906-6d6b-9a5f-7497af188f94@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] The WCE issue in guest when i enable WCE in Qemu
 side.
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
Cc: yang.zhong@intel.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 05:32:12PM +0200, Paolo Bonzini wrote:
> On 23/07/19 14:17, Zhong, Yang wrote:
> > When I set config-wce=true or false, the below value never change
> >  root@unicorn ~ # cat /sys/block/vda/cache_type
> > write back
> > root@unicorn ~ # cat /sys/block/vda/device/features
> > 0010 0010 0110 0110 0000 0000 0000 1000 1000 0000 0000 0000 0000 0000 0000 0000 
> > From left to right, bit 11=0, which show there is no WCE feature in vhost-user-blk device.
> 
> Does your backend expose the feature in the VHOST_GET_FEATURES message?

  Paolo, thanks for your comments.
  
  The get features value in vhost-user-blk is 0x154007646(bit 11 is 0), which
  does not include WCE feature in default of SPDK vhost-blk module.

> > I also did one simple patch to add config_wce value into s->blkcfg.wce, but the result is same.
> 
> config_wce doesn't tell you if you are in writeback or writethrough
> mode, it tells you if you can *change* the mode.
> 
> If your backend did not expose the feature, try changing that and then
> "echo write through > /sys/block/vda/cache_type" should work?
> 
  Paolo, yes, i enabled WCE feature in the backend code(SPDK), and did
  the test config-wce= true or false as below

  (1).config-wce=true in qemu command for vhosr-user-blk's perporty 
      ##root@unicorn ~ # cat /sys/block/vda/device/features
       0010 0010 0111 0110 000000000000100010000000000000000000000000000000 ---> bit 11 is "1", which support WCE feature.

     ##set the "write through"
       echo write through > /sys/block/vda/cache_type
       root@unicorn ~ # cat /sys/block/vda/cache_type
       write through

   (2).config-wce=false in qemu command for vhost-ser-blk
      root@unicorn ~ # cat /sys/block/vda/cache_type
      write back
      root@unicorn ~ # cat /sys/block/vda/device/features
      0010 0010 0110 0110 0000 0000 0000 1000 1000 0000 0000 00000000000000000000 ---> bit 11 is "0" because of config-wce=false
      root@unicorn ~ # echo "write through" > /sys/block/vda/cache_type
      -bash: /sys/block/vda/cache_type: Permission denied

      Only config-wce=true can change the cache mode, thanks.

      The SPDK code i am using is latest version, So, i feel we should enable WCE feature in SPDK side by default. thanks for your help!
       
      Yang
> Paolo

