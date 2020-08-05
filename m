Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA306C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF98E20792
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF98E20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k39AY-00025J-U1
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 22:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k39A1-0001f4-Iv
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:28:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:36140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k399y-0002Lr-Mi
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:28:09 -0400
IronPort-SDR: 6dzbDfW2c2tgrA/+KV5pXzhGwbs/ZtFTL4qddFYCefQNkVzw4R1FVdKoxhJrESjHz4wrH8+lqD
 qLgSEykOXsTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="153600304"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; d="scan'208";a="153600304"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2020 19:28:00 -0700
IronPort-SDR: LX4R3k0iffTaiqM5OpI1cWhwKqIC5VWRP8Vx+UJnFeioBfw+oO5qHl5ETPIih7AENO50oqq4AG
 OmEpqTHMj+Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; d="scan'208";a="315578039"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2020 19:27:55 -0700
Date: Wed, 5 Aug 2020 10:16:54 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200805021654.GB30485@joy-OptiPlex-7040>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <9bfa8700-91f5-ebb4-3977-6321f0487a63@redhat.com>
 <20200716083230.GA25316@joy-OptiPlex-7040>
 <20200717101258.65555978@x1.home>
 <20200721005113.GA10502@joy-OptiPlex-7040>
 <20200727072440.GA28676@joy-OptiPlex-7040>
 <20200727162321.7097070e@x1.home>
 <20200729080503.GB28676@joy-OptiPlex-7040>
 <20200804183503.39f56516.cohuck@redhat.com>
 <c178a0d3-269d-1620-22b1-9010f602d8ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c178a0d3-269d-1620-22b1-9010f602d8ff@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.24; envelope-from=yan.y.zhao@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 22:28:01
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, eskultet@redhat.com,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, jian-feng.ding@intel.com, dgilbert@redhat.com,
 zhenyuw@linux.intel.com, hejie.xu@intel.com, bao.yumeng@zte.com.cn,
 Alex Williamson <alex.williamson@redhat.com>, smooney@redhat.com,
 intel-gvt-dev@lists.freedesktop.org, berrange@redhat.com, corbet@lwn.net,
 dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 05, 2020 at 10:22:15AM +0800, Jason Wang wrote:
> 
> On 2020/8/5 上午12:35, Cornelia Huck wrote:
> > [sorry about not chiming in earlier]
> > 
> > On Wed, 29 Jul 2020 16:05:03 +0800
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > 
> > > On Mon, Jul 27, 2020 at 04:23:21PM -0600, Alex Williamson wrote:
> > (...)
> > 
> > > > Based on the feedback we've received, the previously proposed interface
> > > > is not viable.  I think there's agreement that the user needs to be
> > > > able to parse and interpret the version information.  Using json seems
> > > > viable, but I don't know if it's the best option.  Is there any
> > > > precedent of markup strings returned via sysfs we could follow?
> > I don't think encoding complex information in a sysfs file is a viable
> > approach. Quoting Documentation/filesystems/sysfs.rst:
> > 
> > "Attributes should be ASCII text files, preferably with only one value
> > per file. It is noted that it may not be efficient to contain only one
> > value per file, so it is socially acceptable to express an array of
> > values of the same type.
> > Mixing types, expressing multiple lines of data, and doing fancy
> > formatting of data is heavily frowned upon."
> > 
> > Even though this is an older file, I think these restrictions still
> > apply.
> 
> 
> +1, that's another reason why devlink(netlink) is better.
>
hi Jason,
do you have any materials or sample code about devlink, so we can have a good
study of it?
I found some kernel docs about it but my preliminary study didn't show me the
advantage of devlink.

Thanks
Yan

