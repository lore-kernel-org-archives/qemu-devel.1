Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5B7C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 09:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633032077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 09:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633032077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43781 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJxAc-0004cd-JT
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 05:29:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJx8k-0002lB-Ly
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJx5G-0005Ef-6E
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:23:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:18735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hJx5F-0005DJ-Te
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:23:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Apr 2019 02:23:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; d="scan'208";a="341004803"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
	by fmsmga006.fm.intel.com with ESMTP; 26 Apr 2019 02:23:50 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
	FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Fri, 26 Apr 2019 02:23:50 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
	fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Fri, 26 Apr 2019 02:23:49 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.206]) by
	SHSMSX105.ccr.corp.intel.com ([169.254.11.25]) with mapi id
	14.03.0415.000; Fri, 26 Apr 2019 17:23:47 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Laurent Vivier <laurent@vivier.eu>, "Dr. David Alan Gilbert"
	<dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang
	<zhang.zhanghailiang@huawei.com>, qemu-dev <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] migration/colo.c: Remove redundant input parameter
Thread-Index: AQHU++JX48gf76QXk0u79ce8kK4rxKZOK7Fw
Date: Fri, 26 Apr 2019 09:23:47 +0000
Message-ID:
 <9CFF81C0F6B98A43A459C9EDAD400D78060E0DCF@shsmsx102.ccr.corp.intel.com>
References: <20190426034015.4696-1-chen.zhang@intel.com>
In-Reply-To: <20190426034015.4696-1-chen.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTViMDdiZmEtOWEzMi00ZjVlLTkwZDYtNzZjYTg5N2RhNmIxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZXphKzBIVFJEdU5aSXlIZHNJQm11c1lBdGVLVXpkZHA3UlwvZVczakVVbWhCMXlQN2V6dVZPcDVuZHNrT0NZYUEifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH] migration/colo.c: Remove redundant input
 parameter
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
Message-ID: <20190426092347.csoy-R01_eYK7VnnyKaqWHOZe-U0ynNwr85vGnG0aPw@z>

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
> Subject: [PATCH] migration/colo.c: Remove redundant input parameter
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> The colo_do_failover no need the input parameter.
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  include/migration/colo.h  | 2 +-
>  migration/colo-failover.c | 2 +-
>  migration/colo.c          | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/migration/colo.h b/include/migration/colo.h index
> 99ce17aca7..ddebe0ad27 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -37,7 +37,7 @@ bool migration_incoming_in_colo_state(void);
>  COLOMode get_colo_mode(void);
>=20
>  /* failover */
> -void colo_do_failover(MigrationState *s);
> +void colo_do_failover(void);
>=20
>  void colo_checkpoint_notify(void *opaque);  #endif diff --git a/migratio=
n/colo-
> failover.c b/migration/colo-failover.c index 4854a96c92..e9ca0b4774 10064=
4
> --- a/migration/colo-failover.c
> +++ b/migration/colo-failover.c
> @@ -39,7 +39,7 @@ static void colo_failover_bh(void *opaque)
>          return;
>      }
>=20
> -    colo_do_failover(NULL);
> +    colo_do_failover();
>  }
>=20
>  void failover_request_active(Error **errp) diff --git a/migration/colo.c
> b/migration/colo.c index 238a6d62c7..8c1644091f 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -193,7 +193,7 @@ COLOMode get_colo_mode(void)
>      }
>  }
>=20
> -void colo_do_failover(MigrationState *s)
> +void colo_do_failover(void)
>  {
>      /* Make sure VM stopped while failover happened. */
>      if (!colo_runstate_is_stopped()) {
> --
> 2.17.GIT


