Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB7AC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6C021871
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K0tKl7Tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6C021871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZ7f-0004WO-Hr
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44103)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqZ7T-00043a-CC
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqZ7S-0007kv-9W
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:28:59 -0400
Received: from mail-eopbgr60135.outbound.protection.outlook.com
 ([40.107.6.135]:50070 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqZ7P-0007gv-K6; Thu, 25 Jul 2019 04:28:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAhxkbHh3ruIrpF2xKMZTVkpzVAe3MZ4l+c610Pi7qcMC1VTfoDNvTi6Jo23q9nq2e3ghK8gyaLq5gsIgc4ACt2SW5t0ofGOTFoNkv0sosJbG7KzQcpyLeHztZB770+6paLsemzGUFwSGz3wLC8Nzzm80dSNqjpIE3cGgBUngB8oILUBVZ0IepKuxKIeDUqUcLD6ktA8T2IzximZ5MyoRweqvwGOyn+394fdNf1RXi70sDG5YLAV7nwvDYbawMMQGopCBPTH/mjeKyEV31iMxgvzdWes63DymZS1AAaJDvCsgR6TX3ybjrkqCc+Lu8J+MxY/pcU4xFMN2NHV15X5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYUleWWp/ORsccnY0ig45/IgUCp0gcAuRCK4l7mMVes=;
 b=Xe4QIFw0mAomLVQ1wlJ+xmvMMCF0FYDeYzSSOJTUNV/d23u0MIsEx3nRys3qRNxmODZrlHsVSW2LI+b5gnWSKW+PtYIgfpZFoEsQZxyH3e+JZVceURsFXLSsFc/4TQ+Mp/ocim1dAzUZIovhYsy+0VWPxEkVp6fR+QTsJbBYwQGPMBpb3M8zlL67K6IOlO7T3lhd9qjgtIKB7lm/kdPug1rFlJOKCnX/bjcT5wm5LLyir7UVCGV6fwd8Mvln54OMNsUGkuFRHCCU0QUjP/bWdHxob6eYfkSEqmRBf8BbBBlFXBlVw2VQeiwxfsxLB0h6wo1ZKv2MIFdyWTOApsMHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYUleWWp/ORsccnY0ig45/IgUCp0gcAuRCK4l7mMVes=;
 b=K0tKl7Tt6Iamqt6LbTk5y9rtLRl5y3y3kSXYh6lbvwHFwKGlAacPeLgVRKqQeYWuP167irHLlZgQipWRZngqr0QLGJTHEVzJVFyGw3OG7tNAMdlArMa21xEGrWWwh/dBbSJaHVT0pVO1+lWqtBGe5S3rgXr7raQbMFWauskbPlg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5098.eurprd08.prod.outlook.com (10.255.19.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Thu, 25 Jul 2019 08:28:51 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 08:28:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Thread-Topic: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for io
Thread-Index: AQHVGvDDN3N+yvQgRE6fCgP4uttDuaaw5TYAgCpq34A=
Date: Thu, 25 Jul 2019 08:28:51 +0000
Message-ID: <1d2fec8f-d61a-cb8c-9110-0af9e0f77e1a@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
 <20190628084324.GA3316@stefanha-x1.localdomain>
In-Reply-To: <20190628084324.GA3316@stefanha-x1.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0002.eurprd03.prod.outlook.com
 (2603:10a6:3:76::12) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190725112849379
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 960dc50b-cf9d-4b38-ee82-08d710da1fa4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5098; 
x-ms-traffictypediagnostic: DB8PR08MB5098:
x-microsoft-antispam-prvs: <DB8PR08MB5098590904BE5EC60E3E46D1C1C10@DB8PR08MB5098.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(366004)(396003)(39850400004)(376002)(53754006)(189003)(199004)(6246003)(14444005)(2616005)(256004)(8936002)(186003)(446003)(476003)(66066001)(11346002)(64756008)(5660300002)(66556008)(66446008)(66946007)(66476007)(6506007)(2906002)(36756003)(52116002)(102836004)(305945005)(31686004)(26005)(386003)(68736007)(486006)(4326008)(1411001)(76176011)(71190400001)(86362001)(6512007)(81166006)(3846002)(229853002)(71200400001)(53936002)(6486002)(81156014)(6916009)(99286004)(14454004)(54906003)(7736002)(6436002)(478600001)(25786009)(6116002)(8676002)(31696002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5098;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Oh6XOU5NlA6j/3tQyovXWHExWpDhabYqrcnVUsEHn0C/RDdPhy0WcfposYe3zfRxFbbaj8/y/WsuX6Ee4d253NER29WubMMhNzuEl+0AalTB4g/g/9xp49t7YqXQIKieqgaa5PqYu8ehiNC8GN94yIVoHUYqgdjOS/kvf5cu+MbqZhuEsj4R2Bhaeofakpq2nrSxLC8amcUBkd48kMiRaKpWw2WwRmPDGLN1L/+GBbntoJebq8Pma+zsrDhNBwfEJus3dN4vCpqj1vVzBH+ZHfGHaEpGeZx7VX5Tn2qA/IB7PuIdmeVR+spz4t/W0bJodDE/X6v89oQwItkS1pDoSee0iD14/PyznxABttBWUH8oRijCr+WeAYwdlxdgMcXzuJZx2TKpjaI7ZB3WtdtfadZZluSBsXT/kOTOLNAHocU=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3C5ED27124D61F4EB02A6254B3F8BA08@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960dc50b-cf9d-4b38-ee82-08d710da1fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 08:28:51.7693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5098
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.135
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
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.06.2019 11:43, Stefan Hajnoczi wrote:
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
>>
>>
>=20
> I don't see a significant advantage after taking into account more
> complex code (e.g. additional block driver interfaces) and the risk of
> introducing new bugs.  A measurable performance improvement would make
> this refactoring more attractive.  Still:
>=20
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

Hmm, I understand your doubt. And I doubt that there will be some significa=
nt performance
gain.

What will you say if instead of adding new interfaces I just add qiov_offse=
t parameter to
old ones, and add one boolean field to BlockDriver like .supports_qiov_offs=
et, so, generic
code will use non-zero qiov_offset only for drivers supporting it? And, may=
be, add corresponding
asserts to all not-supporting driver handlers?

--=20
Best regards,
Vladimir

