Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1ECC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1772076A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c3iycoao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1772076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGMAv-0002gZ-1U
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGMA6-0001hr-2v
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGMA3-0008IB-TF
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:26:33 -0400
Received: from mail-db8eur05on2116.outbound.protection.outlook.com
 ([40.107.20.116]:10336 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGM9z-0008Et-HN; Mon, 23 Mar 2020 08:26:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa7cEEe2Dp4CZHS3kEvrW0Z+5uDMXZlPXfNRcA7kUSubKd8PZPHDlbb/6UFm7YupOjdg4sW260LzaHBxrnu8AT8MloymLo24pOpreYZ1yplDuCTNqYH7PcHSpLSna1U5ZgerJg0bitrrq5ZI6837QBhS6D4meAMFR57IJGhbFP9Qdf31Y4JCz7JtgCeZD7mtoBEQ+enoNWuROYr1ywp/8HqAa/iVZgmW8cGh0waP8iOeYkHRNSa3CJDbhXh4bceGGzF4kmrXq5w/Hcak8likCWas+OqCQn5/ZXvCf8h+KXIkd03iix6YMmSC/X9oLFkYZJ+/LDbs9ylUQ/etiNVFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt113aHkQ2cLQzyiy+ZDLV0v6QnAdHONNITsUK26AHE=;
 b=cvR6lVW1lZWg0CU2Eo3jrBvh23ajsSHkB8pegqhHaSSLtYrtkvBEftwk/8Qk3in7/boShqotFwL+GJXMQvdWs3w50+wvDkKzDY+TAXxm7DKDFk31GBh/0idiIBLcLqiCQ5sS21qISA8VTJcfSZSTxJJO3iKTfGCQ9PViMRt/kAPCIobGarbTDbgcz+yY3VtPiPPhdFmpY1ro2Q4RV03pRIXHnXuRtl4K7bnoS2nPTr9w39x7gAxV6/3RbToLCktJ8QCag2ogjJYev8V/AdoFPbc5OGnt4tMiK8nycd6Mk1VP0RPszNB+4Shp0aV0IqPxQRDQf1aOCWti+gsFmETPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt113aHkQ2cLQzyiy+ZDLV0v6QnAdHONNITsUK26AHE=;
 b=c3iycoaoXfqxd7vX54IjX0kT+v1W2MEzW4X4OyJWDRxHLcQ9qWR2YHhZq/4DYp5wgpfU6LOhODysIrG9U8hb2NhQBVT/vcawRid/Dg1hlVeFPsKSbUhJHk3tDUMn9NGPg8A+XnLUACQ7JQmH9pr9Jdvecf/LBtfsnVVk7pl+8WU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5317.eurprd08.prod.outlook.com (10.255.191.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Mon, 23 Mar 2020 12:26:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 12:26:25 +0000
Subject: Re: [PATCH v8 1/4] qcow2: introduce compression type feature
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200321143431.19629-1-dplotnikov@virtuozzo.com>
 <20200321143431.19629-2-dplotnikov@virtuozzo.com>
 <401c0627-a7ad-3434-a861-69f4a5d58d21@virtuozzo.com>
 <ea557760-b2a5-db20-cb48-fa94a4a2d1e9@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200323152623871
Message-ID: <b263d14d-b667-898f-8757-f9363d126c29@virtuozzo.com>
Date: Mon, 23 Mar 2020 15:26:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ea557760-b2a5-db20-cb48-fa94a4a2d1e9@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.41) by
 ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Mon, 23 Mar 2020 12:26:25 +0000
X-Tagtoolbar-Keys: D20200323152623871
X-Originating-IP: [185.215.60.41]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dace4c6b-0574-4256-2d12-08d7cf2567ca
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5317967EA28107B3FF47B7C6C1F00@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39840400004)(376002)(346002)(136003)(366004)(396003)(199004)(52116002)(316002)(16576012)(8676002)(81166006)(81156014)(53546011)(8936002)(31696002)(86362001)(478600001)(31686004)(4326008)(2906002)(956004)(2616005)(6486002)(26005)(66946007)(36756003)(66556008)(66476007)(16526019)(186003)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5317;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6ykxLz5Wa9sI8IR32QQLQd7nNHaGcj2RCva6As5R+dFBuOhpMPPOUYdUGX4urs4apmhBWwa4+rbuzP/MS33mrzrSRQHNHf/F1tHyoKHCntk5xB/crVV1GkH0NCFY/QudPLZc4qy2Swp2X7xRMJJ85GkFnE9Z7rKPSUtcUD5lXz2dCjOfpWI6Wlg1Ef8Ua71Pvv2vpVtRLxgcxe0RI/7qiBSttzTyJg3yOR6R6kKRSO6RvRb7iek4D9G4n8r8X1b196j3jUHuNmUiX2utXZVDSD81+2JpQQZE6Tu39781toiFoZzWTYtn1Mod6+H383gMaOGOOgEPUC1e0l36Wq3ZeK4NLbaOd7hTmU4Ix5CpbsivWLEBXWopxaqL5hTP6j99Urrk3TFuPDhW0bc4VJyJBo3x1oUkLx+0YihltAx2Nwtr56nbRxdxASEcdX+rBS1
X-MS-Exchange-AntiSpam-MessageData: OsLuUmp6iH8CGzyhTr2NwuVMhBJ34pdJYUu7/eO+TJfZzGiJW771MD0t6HMEjInw5mENV2RBHtkoyMZUy4+3Td1BMdhhSChbCQ8CTcxX5tUEGTrozUjBkPUcBMWyK2B2KS18bOBO3SXQ5Ojgl/DTcw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dace4c6b-0574-4256-2d12-08d7cf2567ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 12:26:25.9382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnlzlYmAHhcT/r6zsdcAJXjdkCjXpfhWTtAqcK/tCxIRKMYytVwniT6ZHhP3Q/+/5haRnLvwpTDZwp4CavNdrdstNpD3gTq0zjQIwA9Pgrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.116
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.03.2020 15:22, Denis Plotnikov wrote:
>=20
>=20
> On 23.03.2020 11:00, Vladimir Sementsov-Ogievskiy wrote:
>> 21.03.2020 17:34, Denis Plotnikov wrote:
>>> The patch adds some preparation parts for incompatible compression type
>>> feature to qcow2 allowing the use different compression methods for
>>> image clusters (de)compressing.
>>>
>>> It is implied that the compression type is set on the image creation an=
d
>>> can be changed only later by image conversion, thus compression type
>>> defines the only compression algorithm used for the image, and thus,
>>> for all image clusters.
>>>
>>> The goal of the feature is to add support of other compression methods
>>> to qcow2. For example, ZSTD which is more effective on compression than=
 ZLIB.
>>>
>>> The default compression is ZLIB. Images created with ZLIB compression t=
ype
>>> are backward compatible with older qemu versions.
>>>
>>> Adding of the compression type breaks a number of tests because now the
>>> compression type is reported on image creation and there are some chang=
es
>>> in the qcow2 header in size and offsets.
>>>
>>> The tests are fixed in the following ways:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 * filter out compression_type for many tests
>>> =C2=A0=C2=A0=C2=A0=C2=A0 * fix header size, feature table size and back=
ing file offset
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 affected tests: 031, 036, 061, 080
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 header_size +=3D8: 1 byte compress=
ion type
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 byt=
es padding
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feature_table +=3D 48: incompatibl=
e feature compression type
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backing_file_offset +=3D 56 (8 + 4=
8 -> header_change + feature_table_change)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 * add "compression type" for test output match=
ing when it isn't filtered
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 affected tests: 049, 060, 061, 065=
, 144, 182, 242, 255
>>>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>
>> [...]
>>
>>> @@ -4859,6 +4949,7 @@ static ImageInfoSpecific *qcow2_get_specific_info=
(BlockDriverState *bs,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .data_file=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D g_strdup(s->image_data_file),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .has_data_file_raw=C2=A0 =3D has_data_file(bs),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .data_file_raw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D data_file_is_raw=
(bs),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .co=
mpression_type=C2=A0=C2=A0 =3D s->compression_type,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* if this asser=
tion fails, this probably means a new version was
>>> @@ -5248,6 +5339,22 @@ static int qcow2_amend_options(BlockDriverState =
*bs, QemuOpts *opts,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "images");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!strcmp(desc->na=
me, BLOCK_OPT_COMPRESSION_TYPE)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=
 compression_type =3D
>>> + qapi_enum_parse(&Qcow2CompressionType_lookup,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_opt_get(opts, BLOCK_OPT_COM=
PRESSION_TYPE),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1, errp);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(compression_type =3D=3D -EINVAL) {
>>
>> You should compare to -1, as qapi_enum_parse returns given default on er=
ror.
> ok
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Unknown compression type");
>>
>> and errp is already set (ofcourse, if qemu_opt_get returned non NULL, bu=
t I hope it is guaranteed by if (!strcmp(desc->name, BLOCK_OPT_COMPRESSION_=
TYPE)) condition
> I wouldn't propagate the error from qapi_enum_parse because it looks like=
 "invalid parameter value: foo". I think it's better to print "Unknown comp=
ression type: foo"

No objections. Then you should pass NULL to qapi_enum_parse instead of errp=
. (As you can't set errp twice, second try will crash).

>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(compression_type !=3D s->compression_type) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Changing the compression type "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "is not supported");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* if this point is reached, this probably means a new option was
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 * added without having it covered here */
>>> @@ -5516,6 +5623,12 @@ static QemuOptsList qcow2_create_opts =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .help =3D "Width of a reference count entry in bits",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .def_value_str =3D "16"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .na=
me =3D BLOCK_OPT_COMPRESSION_TYPE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ty=
pe =3D QEMU_OPT_STRING,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .he=
lp =3D "Compression method used for image cluster compression",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .de=
f_value_str =3D "zlib"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* end of list=
 */ }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 };
>>
>>
>> [...]
>>
>>
>=20


--=20
Best regards,
Vladimir

