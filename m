Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914FCC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 09:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528DC2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 09:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528DC2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43783 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJxAd-0004cs-IX
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 05:29:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJx8k-0002ec-H0
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJx5K-0005Hw-HD
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:23:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:48346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hJx5K-0005GI-9y
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:23:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Apr 2019 02:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; d="scan'208";a="165266785"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
	by fmsmga004.fm.intel.com with ESMTP; 26 Apr 2019 02:23:55 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
	fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Fri, 26 Apr 2019 02:23:52 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
	FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Fri, 26 Apr 2019 02:23:51 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.206]) by
	SHSMSX152.ccr.corp.intel.com ([169.254.6.42]) with mapi id
	14.03.0415.000; Fri, 26 Apr 2019 17:23:36 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Laurent Vivier <laurent@vivier.eu>, "Dr. David Alan Gilbert"
	<dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang
	<zhang.zhanghailiang@huawei.com>, qemu-dev <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] migration/colo.h: Remove obsolete codes
Thread-Index: AQHU++JcSMiDq5SUckayJHjWs4WkA6ZOKuMA
Date: Fri, 26 Apr 2019 09:23:35 +0000
Message-ID:
 <9CFF81C0F6B98A43A459C9EDAD400D78060E0DC1@shsmsx102.ccr.corp.intel.com>
References: <20190426034028.4794-1-chen.zhang@intel.com>
In-Reply-To: <20190426034028.4794-1-chen.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTg4YjBlOGMtYzlhMS00YTZmLTg0MmQtNzg3ZmU5ZjY0NzYxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN2pnYW9zTHdOaWdzQkRcL3NubCtaVEFNNkFnWnRWXC9pbXo3OFQ5OHR2clRVQnNZRVhnTVVMNWZWKzhxYWRUbUVlIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [PATCH] migration/colo.h: Remove obsolete codes
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426092335.pMGBxIKsEjJvP0fSYv1_SXLqdHASwj8nWw-R_Mlq0Ik@z>

This patch have been integrated in this series:
http://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg04520.html
Please review it at this link.

Thanks
Zhang Chen

> -----Original Message-----
> From: Zhang, Chen
> Sent: Friday, April 26, 2019 11:40 AM
> To: Laurent Vivier <laurent@vivier.eu>; Dr. David Alan Gilbert
> <dgilbert@redhat.com>; Juan Quintela <quintela@redhat.com>; zhanghailiang
> <zhang.zhanghailiang@huawei.com>; qemu-dev <qemu-devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH] migration/colo.h: Remove obsolete codes
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  include/migration/colo.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/include/migration/colo.h b/include/migration/colo.h index
> ddebe0ad27..f6fbe23ec9 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -22,8 +22,6 @@ enum colo_event {
>      COLO_EVENT_FAILOVER,
>  };
>=20
> -void colo_info_init(void);
> -
>  void migrate_start_colo_process(MigrationState *s);  bool
> migration_in_colo_state(void);
>=20
> --
> 2.17.GIT


