Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7706C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 02:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BFC20758
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 02:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BFC20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFpdj-0007dy-9y
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 22:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kFpcx-0007A6-10
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 22:14:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:7042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kFpct-0006rj-Qr
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 22:14:26 -0400
IronPort-SDR: qM+TS/0fQrq25FndVG2jF1YVZ92HTWMF6S8eBJ0HmMgoH1u+2eZzvIiP2xvk9jRrGJ9++M4uDe
 Z3UGDTrshG5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155737969"
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; d="scan'208";a="155737969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 19:14:15 -0700
IronPort-SDR: oo/ud125TYByVRHHJ5qg2GWa+ZHCBXGAPNIQz7XvqtmJUH6vWTuCkGOrmYvKqirKrVeZj+g829
 JFl8hWPU2hyg==
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; d="scan'208";a="480286722"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 19:14:09 -0700
Date: Wed, 9 Sep 2020 10:13:09 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200909021308.GA1277@joy-OptiPlex-7040>
References: <20200818113652.5d81a392.cohuck@redhat.com>
 <20200820003922.GE21172@joy-OptiPlex-7040>
 <20200819212234.223667b3@x1.home>
 <20200820031621.GA24997@joy-OptiPlex-7040>
 <20200825163925.1c19b0f0.cohuck@redhat.com>
 <20200826064117.GA22243@joy-OptiPlex-7040>
 <20200828154741.30cfc1a3.cohuck@redhat.com>
 <8f5345be73ebf4f8f7f51d6cdc9c2a0d8e0aa45e.camel@redhat.com>
 <20200831044344.GB13784@joy-OptiPlex-7040>
 <20200908164130.2fe0d106.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908164130.2fe0d106.cohuck@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.93; envelope-from=yan.y.zhao@intel.com;
 helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 22:14:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Parav Pandit <parav@mellanox.com>,
 jian-feng.ding@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
 hejie.xu@intel.com, bao.yumeng@zte.com.cn,
 Alex Williamson <alex.williamson@redhat.com>, Sean Mooney <smooney@redhat.com>,
 intel-gvt-dev@lists.freedesktop.org,
 Daniel =?iso-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 eskultet@redhat.com, Jiri Pirko <jiri@mellanox.com>, dinechin@redhat.com,
 devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > still, I'd like to put it more explicitly to make ensure it's not missed:
> > the reason we want to specify compatible_type as a trait and check
> > whether target compatible_type is the superset of source
> > compatible_type is for the consideration of backward compatibility.
> > e.g.
> > an old generation device may have a mdev type xxx-v4-yyy, while a newer
> > generation  device may be of mdev type xxx-v5-yyy.
> > with the compatible_type traits, the old generation device is still
> > able to be regarded as compatible to newer generation device even their
> > mdev types are not equal.
> 
> If you want to support migration from v4 to v5, can't the (presumably
> newer) driver that supports v5 simply register the v4 type as well, so
> that the mdev can be created as v4? (Just like QEMU versioned machine
> types work.)
yes, it should work in some conditions.
but it may not be that good in some cases when v5 and v4 in the name string
of mdev type identify hardware generation (e.g. v4 for gen8, and v5 for
gen9)

e.g.
(1). when src mdev type is v4 and target mdev type is v5 as
software does not support it initially, and v4 and v5 identify hardware
differences.
then after software upgrade, v5 is now compatible to v4, should the
software now downgrade mdev type from v5 to v4?
not sure if moving hardware generation info into a separate attribute
from mdev type name is better. e.g. remove v4, v5 in mdev type, while use
compatible_pci_ids to identify compatibility.

(2) name string of mdev type is composed by "driver_name + type_name".
in some devices, e.g. qat, different generations of devices are binding to
drivers of different names, e.g. "qat-v4", "qat-v5".
then though type_name is equal, mdev type is not equal. e.g.
"qat-v4-type1", "qat-v5-type1".

Thanks
Yan


