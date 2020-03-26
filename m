Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A21C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 12:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50C620748
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 12:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50C620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHS6M-0007ES-5M
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 08:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jHS5b-0006fI-Gj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jHS5Z-0006eA-Fh
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:58:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:14599)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>)
 id 1jHS5Z-0006ap-6Y; Thu, 26 Mar 2020 08:58:25 -0400
IronPort-SDR: T1teCXClYK8nLHUXsxmHfMTrDS2PxIJvcGOOHv/dqzhUNKwK60UVPJIDHRrML7H4rqGx0MurKi
 1Q4Ttefepx9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 05:58:20 -0700
IronPort-SDR: O25GPqu9zdTdvlw2uc9GXZpHYSbvS8/6PjRrWR8kPtE+pIdaB2LWPOeCPepcaLgYqDI2Fnl1Mc
 cdyIjytpu51Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; d="scan'208";a="282488364"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2020 05:58:20 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 05:58:20 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 05:58:20 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.145]) with mapi id 14.03.0439.000;
 Thu, 26 Mar 2020 20:58:18 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
Subject: RE: [RFC v6 01/24] update-linux-headers: Import iommu.h
Thread-Topic: [RFC v6 01/24] update-linux-headers: Import iommu.h
Thread-Index: AQHV/tjqulacwOwv+ki+tG8kmRIeoKha3mEg
Date: Thu, 26 Mar 2020 12:58:17 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A204428@SHSMSX104.ccr.corp.intel.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
 <20200320165840.30057-2-eric.auger@redhat.com>
In-Reply-To: <20200320165840.30057-2-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.151
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "tnowicki@marvell.com" <tnowicki@marvell.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "bbhushan2@marvell.com" <bbhushan2@marvell.com>,
 "will@kernel.org" <will@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Eric Auger <eric.auger@redhat.com>
> Sent: Saturday, March 21, 2020 12:58 AM
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-devel@nongnu.or=
g;
> Subject: [RFC v6 01/24] update-linux-headers: Import iommu.h
>=20
> Update the script to import the new iommu.h uapi header.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  scripts/update-linux-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-heade=
rs.sh index
> 29c27f4681..5b64ee3912 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -141,7 +141,7 @@ done
>=20
>  rm -rf "$output/linux-headers/linux"
>  mkdir -p "$output/linux-headers/linux"
> -for header in kvm.h vfio.h vfio_ccw.h vhost.h \
> +for header in kvm.h vfio.h vfio_ccw.h vhost.h iommu.h \
>                psci.h psp-sev.h userfaultfd.h mman.h; do
>      cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
>  done

Hi Eric,

This patch already got acked by from Cornelia. :-)

https://patchwork.ozlabs.org/patch/1259643/

Regards,
Yi Liu

