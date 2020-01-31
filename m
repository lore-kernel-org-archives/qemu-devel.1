Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405C8C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1453C206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1453C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixUgb-0005ns-94
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1ixUfS-0004nS-RN
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1ixUfR-0004mj-1d
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:40:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:39208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1ixUfQ-0004YT-PS
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:40:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 03:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; d="scan'208";a="233378783"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga006.jf.intel.com with ESMTP; 31 Jan 2020 03:40:47 -0800
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 03:40:47 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.197]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.139]) with mapi id 14.03.0439.000;
 Fri, 31 Jan 2020 19:40:46 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: RE: [RFC v3 06/25] scripts/update-linux-headers: Import iommu.h
Thread-Topic: [RFC v3 06/25] scripts/update-linux-headers: Import iommu.h
Thread-Index: AQHV1p1JB5RJbb2oEUCOopiClyQHHqgBCu6AgAOeP/A=
Date: Fri, 31 Jan 2020 11:40:45 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1992CC@SHSMSX104.ccr.corp.intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-7-git-send-email-yi.l.liu@intel.com>
 <20200129132505.52501bda.cohuck@redhat.com>
In-Reply-To: <20200129132505.52501bda.cohuck@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTNiYmJjYmUtN2IwMi00YjJmLTgxYTktY2FiYTVhZGVlZTI0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicDdXcFg1NXBFYXVXdWpMRjZsd1ZJUkVNZUk4eE5BeWsrOE5KYnZQNzZKSk9YU1VkS0FiY1RxajE0d0NDZlU2UCJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Cornelia Huck [mailto:cohuck@redhat.com]
> Sent: Wednesday, January 29, 2020 8:25 PM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v3 06/25] scripts/update-linux-headers: Import iommu.h
>=20
> On Wed, 29 Jan 2020 04:16:37 -0800
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
>=20
> > From: Eric Auger <eric.auger@redhat.com>
> >
> > Update the script to import the new iommu.h uapi header.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >  scripts/update-linux-headers.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-hea=
ders.sh
> > index f76d773..dfdfdfd 100755
> > --- a/scripts/update-linux-headers.sh
> > +++ b/scripts/update-linux-headers.sh
> > @@ -141,7 +141,7 @@ done
> >
> >  rm -rf "$output/linux-headers/linux"
> >  mkdir -p "$output/linux-headers/linux"
> > -for header in kvm.h vfio.h vfio_ccw.h vhost.h \
> > +for header in kvm.h vfio.h vfio_ccw.h vhost.h iommu.h \
> >                psci.h psp-sev.h userfaultfd.h mman.h; do
> >      cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
> >  done
>=20
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Thanks, Cornelia.

Regards,
Yi Liu

