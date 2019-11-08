Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8B6FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14637214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cpNLpffn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14637214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4lB-0004VW-4O
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT4kD-0003eY-3a
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT4kB-0005J3-IC
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:56:08 -0500
Received: from mail-eopbgr60109.outbound.protection.outlook.com
 ([40.107.6.109]:9347 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iT4kA-0005Fm-TF; Fri, 08 Nov 2019 08:56:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OASpH4Fuezu1qrSHop2iGrm0tXQD0LJxThFmMg+TZ91XZ5s5gw+u/bbNu4d9ADMVoP70qBLrlppIKqAaJEalEBYNn3JT095pyTBKvj6EiPafTcLfdi+SiOHyNKIfZWkXohTAaofDhlbuUicx2udzcxRtuSRyWEhEXzfzf+imyZ/e72RWgUqQBxD0JltF0C++l+zPKJDi1NnkJIBaG6QivzSR7ZOur99Uk1qc/9leliQnfaKAjNphXCTby4Ccxor4z7y02Fd43UAtvkWwdBHRXhIAiFd7Grw2TD199lU8UqVchQgcbOB2diVX6YqP6rDBxpZ3gldPRiSIVw9B1L1bsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGTK4ES6yuh9vbo3stm6MAnBmp7bQbXJ16gm1i+umEk=;
 b=TdHIbl2K4/Wrr9ZLip5LhTkgYkpvSMucVEOTIbLarkYQuD5Y0LvQk4YUAn9SiRoIQz58k48z2VwDO4NPzQpWeo2opLdSskndxDDApWL8HWq2K/WQf7W7LklOPKuDIoerNgG4BtHSiDkuT/UuZ3YzNlrpLCMQL8JlDTncLrFOmsWxbqIXUxf2gnAL4U7nlLce163cd/p9R6jIfdKB/rB2Xv7R1RFE0un6z+KHCF1Psth5m/2R8gaDAxfeu+7PuYgaQhF47biOa0+F9xwxbk2Nl/kMvleOdgdweQ63rJv07qQcnb7ThK5NSl6hsXRiflyZhugPCRKppgD9gp02P9j+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGTK4ES6yuh9vbo3stm6MAnBmp7bQbXJ16gm1i+umEk=;
 b=cpNLpffnnm0uXy4Q7MbME2zGeXT9xx5VLVYR3nJiCEr+Yaul+D7yp+kpcSszB9LiyhdDeMlrcpW/Uh/mTyaCd3NxNVOPb8n8W0bffdQ8bAOT5TaEwN9Q343KfjWz3/mK1pjy25bvCbledyykCLcJPhycb8YzmCuWz0XxllbS+js=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB4452.eurprd08.prod.outlook.com (20.179.35.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 13:56:03 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 13:56:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v2 2/2] qapi: deprecate implicit filters
Thread-Topic: [PATCH v2 2/2] qapi: deprecate implicit filters
Thread-Index: AQHVlh2qedmxDYBOH0uB5CRitXquqaeBREmAgAAH/AA=
Date: Fri, 8 Nov 2019 13:56:03 +0000
Message-ID: <f0209640-36fe-ed7c-c58b-0df401364a8d@virtuozzo.com>
References: <20191108101655.10611-1-vsementsov@virtuozzo.com>
 <20191108101655.10611-3-vsementsov@virtuozzo.com>
 <20191108132725.GH9577@angien.pipo.sk>
In-Reply-To: <20191108132725.GH9577@angien.pipo.sk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0047.eurprd07.prod.outlook.com
 (2603:10a6:7:66::33) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191108165600596
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a12dc26-a812-4fdd-2a26-08d7645364b9
x-ms-traffictypediagnostic: AM0PR08MB4452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4452B0A3290D239AB8F369F1C17B0@AM0PR08MB4452.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(396003)(346002)(136003)(376002)(189003)(199004)(66476007)(8936002)(6512007)(3846002)(6916009)(8676002)(229853002)(71190400001)(25786009)(6116002)(81166006)(81156014)(2906002)(6436002)(256004)(7416002)(14454004)(5660300002)(71200400001)(305945005)(316002)(14444005)(6486002)(7736002)(6246003)(66446008)(64756008)(54906003)(99286004)(26005)(6506007)(4326008)(86362001)(76176011)(31686004)(102836004)(53546011)(11346002)(36756003)(52116002)(486006)(478600001)(66556008)(386003)(186003)(31696002)(66066001)(66946007)(2616005)(446003)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4452;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b4BDSDnGHSBkB1DJKAZHWOghX6XRDMI/1AHl+5siZ5oZo8tbswZkuvwgttMkpKOPQbN2d6j/NWgiMiahRyEgUNEM+y2tcLd7Oxfdiu27dfcRjhRpEb+zwKXQShy9KqDo/0VdtD6f5NPgXfCCuLt7anZAXg1xtA/7XwJcrkgtMWJCR6kkyFJj3pw0t83z8eiJoWPy8mEOD1YsQ4IbVMQxiNb1HBTp7I3GbVHqeyggFI0w6KW3Sm/YNgQ+i7oTvLqQp6Jl4UDczWcIAs/2+7/6QM2k6gxaMSDtbwcZ4s0G2zTkpI4aARwzNdRMI40k2WBCNe6vW5/IjRPD+VSwzVK6YDOYFqcJPykNFOvgwnHdMuRFY0Hd4bEu/uFLjvWLKfSqWYHKZ3SQQo8Afqpg1EMHZkNLL3hG4i3h5DIZvzfJMb3GvJosw/ZUserZEkDQwtRF
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <42962ABD67E91B40B006D39846020046@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a12dc26-a812-4fdd-2a26-08d7645364b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 13:56:03.2343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zzM+2rBu/166N604oG9eJIqhn8uiudjSJXiO8CAmnba8gawo82t6ZTFe7X0BGK3bEL3426xqyMN8LJxxFqoQvJRd55f2rlE0RuwPNsmV6Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4452
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.109
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
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dinechin@redhat.com" <dinechin@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.11.2019 16:27, Peter Krempa wrote:
> On Fri, Nov 08, 2019 at 13:16:55 +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
>> To get rid of implicit filters related workarounds in future let's
>> deprecate them now.
>>
>> Deprecation warning breaks some bash iotests output, so fix it here
>> too: in most of cases just add filter-node-name in test.
>>
>> In 161 add FIXME and deprecation warning into 161.out.
>>
>> In 249, the test case is changed, as we don't need to test "default"
>> filter node name anymore.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qemu-deprecated.texi       |  6 ++++++
>>   qapi/block-core.json       |  9 ++++++---
>>   include/block/block_int.h  | 10 +++++++++-
>>   blockdev.c                 | 10 ++++++++++
>>   tests/qemu-iotests/094     |  1 +
>>   tests/qemu-iotests/095     |  6 ++++--
>>   tests/qemu-iotests/109     |  1 +
>>   tests/qemu-iotests/127     |  1 +
>>   tests/qemu-iotests/141     |  5 ++++-
>>   tests/qemu-iotests/144     |  3 ++-
>>   tests/qemu-iotests/156     |  1 +
>>   tests/qemu-iotests/161     |  7 +++++++
>>   tests/qemu-iotests/161.out |  1 +
>>   tests/qemu-iotests/185     |  3 +++
>>   tests/qemu-iotests/191     |  2 ++
>>   tests/qemu-iotests/229     |  1 +
>>   tests/qemu-iotests/247     |  8 +++++---
>>   tests/qemu-iotests/249     |  5 +++--
>>   tests/qemu-iotests/249.out |  2 +-
>>   19 files changed, 68 insertions(+), 14 deletions(-)
>>
>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>> index 296bfc93a3..c969faf55a 100644
>> --- a/qemu-deprecated.texi
>> +++ b/qemu-deprecated.texi
>> @@ -204,6 +204,12 @@ and accurate ``query-qmp-schema'' command.
>>   Character devices creating sockets in client mode should not specify
>>   the 'wait' field, which is only applicable to sockets in server mode
>>  =20
>> +@subsection implicit filters in mirror and commit (since 4.2)
>> +
>> +Mirror and commit jobs insert filters, which becomes implicit if user
>> +omitted @option(filter-node-name) parameter. So omitting it is deprecat=
ed
>> +in ``blockdev-mirror'', ``drive-mirror'' and ``block-commit'', set it a=
lways.
>> +
>>   @section Human Monitor Protocol (HMP) commands
>>  =20
>>   @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (=
since 3.1)
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 93530d3a13..37caed775f 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1659,7 +1659,8 @@
>>   # @filter-node-name: the node name that should be assigned to the
>>   #                    filter driver that the commit job inserts into th=
e graph
>>   #                    above @top. If this option is not given, a node n=
ame is
>> -#                    autogenerated. (Since: 2.9)
>> +#                    autogenerated. Omitting this option is deprecated,=
 it will
>> +#                    be required in future. (Since: 2.9)
>>   #
>>   # @auto-finalize: When false, this job will wait in a PENDING state af=
ter it has
>>   #                 finished its work, waiting for @block-job-finalize b=
efore
>=20
> Note that 'block-commit' and 'drive-mirror' commands are used by libvirt
> in the pre-blockdev era. In those instances we gather statistics of
> block devices by nesting in the output of query-blockstats and
> query-block rather than selecting the appropriate info by any other
> means (e.g. by node name).
>=20
> This means that the output MUST stay consistend when block jobs are used
> and the hack this patch is deprcating will break those.
>=20
> Note that in libvirt we don't plan to invest time to add workarounds for
> non-blockdev cases since blockdev by itself is complex enough and I'd
> strongly prefer not having a third code path to care about.
>=20
> Given that -blockdev can't be used in all cases (e.g. for sd-cards)
> which also blocks deprecation of -drive I don't think that hiding of
> implicit filter nodes can be deprecated until -drive is deprecated.
>=20


OK, so, we can't deprecate anything around it now.

What is the problem with sd-cards?


--=20
Best regards,
Vladimir

