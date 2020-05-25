Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1107C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 01:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7852C2075F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 01:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7852C2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd1vp-0007c7-L6
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 21:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jd1vJ-0007Bz-Is
 for qemu-devel@nongnu.org; Sun, 24 May 2020 21:29:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:33765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jd1vI-0001FI-1S
 for qemu-devel@nongnu.org; Sun, 24 May 2020 21:29:01 -0400
IronPort-SDR: rPO99bOxtvfQANX8mAZpvLJOhnlfXU8KCiAGrwEdwBEWl5Q+tzp0MQzbriHCkaRGw5mupsY/TM
 EFgiwaDgoM8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2020 18:28:47 -0700
IronPort-SDR: cL+JnFFMNtHh1qoqDZqEjeq4pMUv4R0mMn2e/F0EGW/zcTLX+pmC74ceF8OQqKfE7pYYws3Rut
 0SmUVDI+Sm3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,431,1583222400"; d="scan'208";a="467815908"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga005.fm.intel.com with ESMTP; 24 May 2020 18:28:45 -0700
Date: Sun, 24 May 2020 21:18:53 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
Message-ID: <20200525011853.GB8867@joy-OptiPlex-7040>
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
 <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
 <9dd7f00b-1199-1097-80d4-1b700c0f28d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd7f00b-1199-1097-80d4-1b700c0f28d6@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.20; envelope-from=yan.y.zhao@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 21:28:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, xin.zeng@intel.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 04:38:47PM +0200, Paolo Bonzini wrote:
> On 30/04/20 11:40, Peter Maydell wrote:
> >> This does not "drop" a write to a r/o region -- it causes it to generate
> >> whatever the guest architecture's equivalent of a bus error is (eg data
> >> abort on Arm).
> 
> 
> > More generally, this change seems a bit odd: currently we do not
> > check the mr->readonly flag here, but in general guests don't get
> > to write to ROM areas. Where is that check currently done
> 
> Writes to ROM are directed to mr->ops unassigned_mem_ops.  Because _all_
> ram-device reads and writes go through the ops, for ram-device we have
> to stick the check for mr->readonly in the ops.
> 
> On one hand, I was quite surprised to see that unassigned_mem_write does
> not return MEMTX_ERROR now that I looked at it.
> 
> On the other hand, we should use MEMTX_ERROR in patch 2 as well, if we
> decide it's the way to go.
> 
> (Sorry Yan for the late response).
> 
hi Paolo,
thanks for your reply and never mind :)

But there's one thing I just can't figure out the reason and eagerly need
your guide.

why do we have to convert all .write operations to .write_with_attrs and
return MEMTX_ERROR? because of the handling of writes to read-only region?

however, it seems that all regions have to handle this case, so ultimately
we have to convert all .write to .write_with_attrs and there would be no
.write operations any more?

Thanks
Yan



