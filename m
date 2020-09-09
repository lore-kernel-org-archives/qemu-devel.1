Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A7DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 05:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC6421582
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 05:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC6421582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFsq0-0008MS-7i
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 01:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kFsp6-0007W2-Hy
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 01:39:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:15863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kFsp3-0002Eq-6d
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 01:39:12 -0400
IronPort-SDR: 2jKy0VwRnDXW4n29X1aT+azzKW5GFpFAhbsUTD8tGvEFDv5M2JYobjB1ser47ZRMToreBjBGPW
 8KHnTpdTSVLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="138316902"
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; d="scan'208";a="138316902"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 22:39:02 -0700
IronPort-SDR: whcmFigUgqLBadZ88oSuQUtx0F6IibdTMz/wnMKxzlk8/zn/jTBg4htIm5EhINSeN1YTLfMt/h
 Rf+LDUhf4P1Q==
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; d="scan'208";a="480331663"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 22:38:56 -0700
Date: Wed, 9 Sep 2020 13:37:56 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 openstack-discuss@lists.openstack.org, intel-gvt-dev@lists.freedesktop.org
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200909053755.GA721@joy-OptiPlex-7040>
References: <20200818091628.GC20215@redhat.com>
 <20200818113652.5d81a392.cohuck@redhat.com>
 <20200820003922.GE21172@joy-OptiPlex-7040>
 <20200819212234.223667b3@x1.home>
 <20200820031621.GA24997@joy-OptiPlex-7040>
 <20200825163925.1c19b0f0.cohuck@redhat.com>
 <20200826064117.GA22243@joy-OptiPlex-7040>
 <20200828154741.30cfc1a3.cohuck@redhat.com>
 <8f5345be73ebf4f8f7f51d6cdc9c2a0d8e0aa45e.camel@redhat.com>
 <20200831044344.GB13784@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831044344.GB13784@joy-OptiPlex-7040>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.151; envelope-from=yan.y.zhao@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 01:39:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: shaohe.feng@intel.com, kevin.tian@intel.com,
 Daniel =?iso-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 Parav Pandit <parav@mellanox.com>, corbet@lwn.net,
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 jian-feng.ding@intel.com, kwankhede@nvidia.com, zhenyuw@linux.intel.com,
 dgilbert@redhat.com, Jiri Pirko <jiri@mellanox.com>, bao.yumeng@zte.com.cn,
 Alex Williamson <alex.williamson@redhat.com>, eskultet@redhat.com,
 smooney@redhat.com, xin-ran.wang@intel.com, dinechin@redhat.com,
 hejie.xu@intel.com, intel-gvt-dev@lists.freedesktop.org, eauger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hi All,
Per our previous discussion, there are two main concerns to the previous
proposal:
(1) it's currently hard for openstack to match mdev types.
(2) complicated.

so, we further propose below changes:
(1) requiring two compatible mdevs to have the same mdev type for now.
    (though kernel still exposes compatible_type attributes for future use)  
(2) requiring 1:1 match for other attributes under sysfs type node for now
    (those attributes are specified via compatible_<attribute name> but
    with only 1 value in it.)
(3) do not match attributes under device instance node.
    rather, they are regarded as part of resource claiming process.
    so src and dest values are ensured to be 1:1.
    A dynamic_resources attribute under sysfs <type-id> node is added to
    list the attributes under device instance that mgt tools need to
    ensure 1:1 from src and dest.
    the "aggregator" attribute under device instance node is such one that
    needs to be listed.
    Those listed attributes can actually be treated as device state set by
    vendor driver during live migration. but we still want to ask for them to
    be set by mgt tools before live migration starts, in oder to reduce the
    chance of live migration failure.

do you like those changes?

after the changes, the sysfs interface would look like blow:

  |- [parent physical device]
  |--- Vendor-specific-attributes [optional]
  |--- [mdev_supported_types]
  |     |--- [<type-id>]
  |     |   |--- create
  |     |   |--- name
  |     |   |--- available_instances
  |     |   |--- device_api
  |     |   |--- software_version
  |     |   |--- compatible_type
  |     |   |--- compatible_<device_api_specific_field>
  |     |   |--- compatible_<type_specific_field>
  |     |   |--- dynamic_resources
  |     |   |--- description
  |     |   |--- [devices]

- device_api : exact match between src and dest is required.
               its value can be one of 
               "vfio-pci", "vfio-platform", "vfio-amba", "vfio-ccw", "vfio-ap"
- software_version: version of vendor driver.
                    in major.minor.bugfix scheme. 
                    dest major should be equal to src major,
	            dest minor should be no less than src minor.
		    once migration stream related code changed, vendor
		    drivers need to bump the version.
- compatible_type: not used by mgt tools currently.
                   vendor drivers can provide this attribute, but need to
		   know that mgt apps would ignore it.
		   when in future mgt tools support this attribute, it
		   would allow migration across different mdev types,
		   so that devices of older generation may be able to
		   migrate to newer generations.

- compatible_<device_api_specific_field>: for device api specific attributes,
                  e.g. compatible_subchannel_type,
                  dest values should be superset of arc values.
		  vendor drivers can specify only one value in this attribute,
		  in order to do exact match between src and dest.
		  It's ok for mgt tools to only read one value in the
		  attribute so that src:dest values are 1:1.

- compatible_<type_specific_field>: for mdev type specific attributes,
                  e.g. compatible_pci_ids, compatible_chpid_type
                  dest values should be superset of arc values.
		  vendor drivers can specify only one value in the attribute
		  in order to do exact match between src and dest.
		  It's ok for mgt tools to only read one value in the
		  attribute so that src:dest values are 1:1.

- dynamic_resources: though defined statically under <type-id>,
                  this attribute lists attributes under device instance that
		  need to be set as part of claiming dest resources.
		  e.g. $cat dynamic_resources: aggregator, fps,...
		  then after dest device is created, values of its device
		  attributes need to be set to that of src device attributes.
		  Failure in syncing src device values to dest device
		  values is treated the same as failing to claiming
		  dest resources.
		  attributes under device instance that are not listed
		  in this attribute would not be part of resource checking in
		  mgt tools.



Thanks
Yan

