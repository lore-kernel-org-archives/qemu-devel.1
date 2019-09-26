Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC4CC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59C1222C7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59C1222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDY71-0003S1-Jv
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iDXkY-0008Id-EP
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iDXkR-0002CV-37
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:40:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:51787)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iDXkQ-00023r-0n
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:40:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 10:40:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; d="scan'208";a="194208449"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga006.jf.intel.com with ESMTP; 26 Sep 2019 10:40:05 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 10:40:05 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Sep 2019 10:40:04 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Sep 2019 10:40:04 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.113]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.92]) with mapi id 14.03.0439.000;
 Fri, 27 Sep 2019 01:40:03 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH v5 2/4] tests/test-replication.c: Add test for ignoring
 requests after failover
Thread-Topic: [PATCH v5 2/4] tests/test-replication.c: Add test for ignoring
 requests after failover
Thread-Index: AQHVa/qhYqqFivT2Tkmj/wvfs4Rj+6c+SXUA
Date: Thu, 26 Sep 2019 17:40:03 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780627E731@shsmsx102.ccr.corp.intel.com>
References: <cover.1568574478.git.lukasstraub2@web.de>
 <e3f1e1ec5b2bd2ce2c9a6c7669284a3fc2fdbaaa.1568574478.git.lukasstraub2@web.de>
In-Reply-To: <e3f1e1ec5b2bd2ce2c9a6c7669284a3fc2fdbaaa.1568574478.git.lukasstraub2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjBlY2EzOGUtOGU5ZS00NGVlLThiZjgtZGEzNjgyNjc2OTRhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia0h0OGFuQzkwY3VwTFR3dU1DSiszVGY3eXQ1alVSUjUxSUNBVjhLaTcxa3Vyd3NjYWlCMk1EbytzbnJqOGl3QSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Monday, September 16, 2019 3:20 AM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> Xie Changlong <xiechanglong.d@gmail.com>; kwolf@redhat.com;
> mreitz@redhat.com
> Subject: [PATCH v5 2/4] tests/test-replication.c: Add test for ignoring
> requests after failover
>=20
> This simulates the case that happens when we resume COLO after failover.
>=20

It looks change the title to "Add test for secondary node continuous backup=
" is better.

> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  tests/test-replication.c | 52
> ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>=20
> diff --git a/tests/test-replication.c b/tests/test-replication.c index
> f085d1993a..5addfc2227 100644
> --- a/tests/test-replication.c
> +++ b/tests/test-replication.c
> @@ -489,6 +489,56 @@ static void test_secondary_stop(void)
>      teardown_secondary();
>  }
>=20
> +static void test_secondary_failover_then_ignore_requests(void)

Same as title, I think change to "test_secondary_continuous_backup" is more=
 clear.

Thanks
Zhang Chen

> +{
> +    BlockBackend *top_blk, *local_blk;
> +    Error *local_err =3D NULL;
> +
> +    top_blk =3D start_secondary();
> +    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
> +    g_assert(!local_err);
> +
> +    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
> +    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);
> +    test_blk_write(local_blk, 0x22, IMG_SIZE / 2, IMG_SIZE / 2, false);
> +
> +    /* replication will backup s_local_disk to s_hidden_disk */
> +    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,
> +                  IMG_SIZE / 2, 0, IMG_SIZE, false);
> +
> +    /* write 0x33 to s_active_disk (0, IMG_SIZE / 2) */
> +    test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);
> +
> +    /* do failover (active commit) */
> +    replication_stop_all(true, &local_err);
> +    g_assert(!local_err);
> +
> +    /* it should ignore all requests from now on */
> +
> +    /* start after failover */
> +    replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
> +    g_assert(!local_err);
> +
> +    /* checkpoint */
> +    replication_do_checkpoint_all(&local_err);
> +    g_assert(!local_err);
> +
> +    /* stop */
> +    replication_stop_all(true, &local_err);
> +    g_assert(!local_err);
> +
> +    /* read from s_local_disk (0, IMG_SIZE / 2) */
> +    test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,
> +                  0, IMG_SIZE / 2, false);
> +
> +
> +    /* read from s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
> +    test_blk_read(top_blk, 0x22, IMG_SIZE / 2,
> +                  IMG_SIZE / 2, 0, IMG_SIZE, false);
> +
> +    teardown_secondary();
> +}
> +
>  static void test_secondary_do_checkpoint(void)
>  {
>      BlockBackend *top_blk, *local_blk;
> @@ -584,6 +634,8 @@ int main(int argc, char **argv)
>      g_test_add_func("/replication/secondary/write", test_secondary_write=
);
>      g_test_add_func("/replication/secondary/start", test_secondary_start=
);
>      g_test_add_func("/replication/secondary/stop",  test_secondary_stop)=
;
> +
> g_test_add_func("/replication/secondary/failover_then_ignore_requests",
> +                    test_secondary_failover_then_ignore_requests);
>      g_test_add_func("/replication/secondary/do_checkpoint",
>                      test_secondary_do_checkpoint);
>      g_test_add_func("/replication/secondary/get_error_all",
> --
> 2.20.1


