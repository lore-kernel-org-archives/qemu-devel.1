Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80AAC32759
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 11:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873DF2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 11:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gTrC+iSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873DF2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyDhd-0005K7-Mv
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 07:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyDgR-0004pM-HX
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 07:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyDgQ-0006Dz-Do
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 07:12:43 -0400
Received: from mail-eopbgr70138.outbound.protection.outlook.com
 ([40.107.7.138]:16578 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyDgM-00069m-I8; Thu, 15 Aug 2019 07:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnY/XxOlzoPi69PsE2PC9KQux2EngrTdIrNK/cfM0AnGHG4tRf8a+2BVPHYAOCTjcC8iqn1GfWWMVkuGPxq0KuzrWxWQXtdL9M6d2+pwuDUBlv+sr8YG4CtmSdvv+j1xwAIDb3ZddYc3nQ+bYEGRcv7m0tKG0Q+ZTqAqcSFofl1dKj+6U/XxCwJzYSA5LqohIsXoYQgNdzrz3KGLnmV9x3/Fr+BiEczPfccaiZwgxLn0fz8BYd3UfsoccPkC3FRBCo8DFP0uRqbPIjbstXo2R3ujETSWInlL61d83jrniilpo/ra25oewbw2pY5Cj+zkNa5az6T/JY+r82TthB1k1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynR5FBjcbr7lWRnxiIysFiiYakpnfEio1ZIwm3p42qQ=;
 b=O9JlZ0wF/Yqtr+cRedTZwEOF6zs/xu0IbpF1Q+gsoqzlIq3Sn9i0lhevyZE5PSMOu68K+J6Ci9xb6cCL0BboAXv6AoLQJv10Q+3PH2XFIrzDEYMmXL9CIQAE+g/A5cCAbBsGc50SHk6WB/yHGuVbQEwNvAUuXKnLmVBL7Yt6rzHHEtEc7CFRNhlE1VLso38zts32tZH2OScCYrS6OeRbVtiQTG1R/8Y/8+8LH/jnv7bPluktTtlsV03FMdWKnzLksj7SfQBth9yESv45EqA+qzHglfvUeKdrwa1xyjMrx/wiXbTBUVyxvyWGCNlzP2aBw6SXaoZIsTnlzeD+O254cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynR5FBjcbr7lWRnxiIysFiiYakpnfEio1ZIwm3p42qQ=;
 b=gTrC+iSYVtjgL5hvuBMczOmp4XL+8sNMG3KOP58pc3z+6FEDe05uGFxKHWSZMZlRowL+o23Q9WMKAHwPcZG9uALiHZqN04JBDpTbV5iAfP66oCdT5vfwB50lmNE8wXZ9l8RJmJlHyfjo7AtWuNj5ehTJ4xomA5kE5S2zfw1ySsw=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3964.eurprd08.prod.outlook.com (20.179.9.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 15 Aug 2019 11:12:35 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 11:12:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Thread-Topic: [PATCH v2 00/12] block: qiov_offset parameter for io
Thread-Index: AQHVGvDDN3N+yvQgRE6fCgP4uttDuabiDWkAgBpxYAA=
Date: Thu, 15 Aug 2019 11:12:35 +0000
Message-ID: <5936085a-a811-87ee-b1b2-0a12c3c745ec@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
 <20190729152400.GB21033@stefanha-x1.localdomain>
In-Reply-To: <20190729152400.GB21033@stefanha-x1.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0150.eurprd06.prod.outlook.com
 (2603:10a6:7:16::37) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190815141232127
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a775def3-28b1-4cc9-e9f6-08d721717986
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3964; 
x-ms-traffictypediagnostic: DB8PR08MB3964:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB3964C1CFF9BD33C6AAFCFF83C1AC0@DB8PR08MB3964.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(136003)(396003)(39850400004)(376002)(199004)(189003)(53754006)(71200400001)(26005)(54906003)(71190400001)(36756003)(102836004)(6512007)(8936002)(2906002)(316002)(229853002)(107886003)(256004)(31696002)(186003)(478600001)(8676002)(66066001)(14454004)(31686004)(6306002)(966005)(53936002)(446003)(86362001)(66446008)(81166006)(3846002)(6116002)(81156014)(66946007)(64756008)(66476007)(476003)(2616005)(66556008)(486006)(25786009)(6486002)(5660300002)(7736002)(76176011)(52116002)(305945005)(4326008)(6246003)(6436002)(386003)(6506007)(11346002)(6916009)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3964;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z8zNxy1Soh6FFMeWHAZgSiquifcDvt6h2VAI0TC8dq8jYDefF3JTkiYnov5nvoupDhVb5Q6IxlmmZ3BBTAYiMP8db+kZK8l57dYuBQv6c6JQ6l3GurCxvQQv1A/U4DnsZSzHWOZ2gotRjelFZCXQHi2mu4EgsbVPSSSkFbX9CObhzX3irtBoZWrlG0nnzZosM8rjeX/6/CHZu/hH70gTMPCA1DkFnpJMN67EFg32f3nQ0Ut+cMZzNbin/ywblRao3w10DrevmEIGlQFi9xSMiNJZVlQunNArohJY7sBOTTbodBe60q+/8HTXiB1O3mxCZ0DU0YKWkrZcqTyzyZ8nHkptuAGfvHyiPLgv/1HXUBV5gHRir5CLTbXEYQtsWlNzeSrWoE01nzSidD+UmJg9XwAF+VmnFh/dpFyi5b1xfvM=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <D79DF9CFFEA8AE4F9D9819792E0484A0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a775def3-28b1-4cc9-e9f6-08d721717986
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 11:12:35.2932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67p2bHkU9sBnROUZ3/uhpAcR+nyLI+7TfKrzMO3ba7Fj0qU4t/DKjSwlkUPH6TDqDs0ccBtkET/uU07UonRAscxpVC73Q4q6BQW63w5ljxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3964
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.138
Subject: Re: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for
 io
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.07.2019 18:24, Stefan Hajnoczi wrote:
> On Tue, Jun 04, 2019 at 07:15:02PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi all!
>>
>> Here is new parameter qiov_offset for io path, to avoid
>> a lot of places with same pattern of creating local_qiov or hd_qiov
>> variables.
>>
>> These series also includes my
>> "[Qemu-devel] [PATCH 0/2] block/io: refactor padding"
>> with some changes [described in 01 and 03 emails]
>>
>> Vladimir Sementsov-Ogievskiy (12):
>>    util/iov: introduce qemu_iovec_init_extended
>>    util/iov: improve qemu_iovec_is_zero
>>    block/io: refactor padding
>>    block: define .*_part io handlers in BlockDriver
>>    block/io: bdrv_co_do_copy_on_readv: use and support qiov_offset
>>    block/io: bdrv_co_do_copy_on_readv: lazy allocation
>>    block/io: bdrv_aligned_preadv: use and support qiov_offset
>>    block/io: bdrv_aligned_pwritev: use and support qiov_offset
>>    block/io: introduce bdrv_co_p{read,write}v_part
>>    block/qcow2: refactor qcow2_co_preadv to use buffer-based io
>>    block/qcow2: implement .bdrv_co_preadv_part
>>    block/qcow2: implement .bdrv_co_pwritev(_compressed)_part
>>
>>   block/qcow2.h             |   1 +
>>   include/block/block_int.h |  21 ++
>>   include/qemu/iov.h        |  10 +-
>>   block/backup.c            |   2 +-
>>   block/io.c                | 532 ++++++++++++++++++++++----------------
>>   block/qcow2-cluster.c     |  14 +-
>>   block/qcow2.c             | 131 +++++-----
>>   qemu-img.c                |   4 +-
>>   util/iov.c                | 153 +++++++++--
>>   9 files changed, 559 insertions(+), 309 deletions(-)
>>
>> --=20
>> 2.18.0
>=20
> Thanks, applied to my block tree:
> https://github.com/stefanha/qemu/commits/block
>=20
> Stefan
>=20

Could you please squash this into 01:

diff --git a/util/iov.c b/util/iov.c
index 0ed75e764c..5059e10431 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -422,7 +422,7 @@ void qemu_iovec_init_extended(
          void *tail_buf, size_t tail_len)
  {
      size_t mid_head, mid_tail;
-    int total_niov, mid_niov;
+    int total_niov, mid_niov =3D 0;
      struct iovec *p, *mid_iov;

      if (mid_len) {



--=20
Best regards,
Vladimir

