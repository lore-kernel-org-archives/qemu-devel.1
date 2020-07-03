Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F21C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE152088E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OTWDlhOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE152088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrN8R-0005VK-CW
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 10:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrN6w-0003XO-8P; Fri, 03 Jul 2020 10:56:18 -0400
Received: from mail-eopbgr50138.outbound.protection.outlook.com
 ([40.107.5.138]:1411 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrN6t-0006i0-52; Fri, 03 Jul 2020 10:56:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZZ0e3A9AXupWhBLPSbA2Zi2+FuO/oK2o/XKEhQ/dDGy+Ut3+NeHmwMBlV89/rpjACkxoGP8rxFUrTiu8wIlLAky/eRv06FCsGVf+Wd7l9UYtRZvIiZTT63nY/jRCGo8YCMK01fVLNxf305BkhT5YmP/TmKGNBropCcCjFdxAnINfo5VF1Cn7bHcswt/quwor/GAtL8jHzdtiscG0QKF+HjmGVQojRvRFbXNVC0ZVtvfwo369WylgkyTMaCHbqxjY8FFq3EBgzpDWQj5w5uYWxKPhIQweIyvetg+Uraw7r9rlM3nyz2zjcPc81s3TcRH7Y7DG/59nHVh0xZUwp4uqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krHacxkAmAmkX82usBHO7U+3wJ5E0Ub/amAhA8+8ppw=;
 b=BOMJyn7f4zSm3tBsJ8Lfgnx2yeK7t71pqHNtx+zmQiZTsh6l9ss5OR7tu+wscvwhA3BmbEUSgK+hXWUH6iYSL5hWg3RTAyUZe71aksDptqYfCs6XRqsUACzFuHTaZk5FhRPmLEAOi8Dpp8iFIQXFsEeQtpQ6O7QgC0SisErDYfoTixF4GAmCfFqJUFtpLDSEK4stmdu8rC4sC5b9atPKAaB403b1sQe5UBbyKUgl5JI7CjqunfcaJ0B+uEjDwuGEAP+7b/Sb1F7noDsfctfBYDKFRgbFzzP9w981BNHo64Sn2UfVOoPkWz3ufexRV+S3qnbgOdJI/u/G5t4dnt5o6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krHacxkAmAmkX82usBHO7U+3wJ5E0Ub/amAhA8+8ppw=;
 b=OTWDlhOuxK60SYWX6AMBL/e9tpYA/A919+A5+fG2ANOJWebTxm+YhbbL8BxSjlLFQA2dI1UvXbd6GCpViXUtdLhpJjS0pPYS2Rlo9uG1HL+QWEfyr/SY9cZtYLpmOOQbFAKRMMziyfdt+5P4sY6DtKqBUHOmss1zuKihVdGMlZU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3960.eurprd08.prod.outlook.com (2603:10a6:20b:ad::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 14:56:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 14:56:11 +0000
Subject: Re: [PATCH v2 17/44] qapi: Use returned bool to check for failure,
 Coccinelle part
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-18-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f45ec064-b84c-4840-3348-550a1021e58d@virtuozzo.com>
Date: Fri, 3 Jul 2020 17:56:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-18-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-ClientProxiedBy: AM3PR05CA0101.eurprd05.prod.outlook.com
 (2603:10a6:207:1::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM3PR05CA0101.eurprd05.prod.outlook.com (2603:10a6:207:1::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Fri, 3 Jul 2020 14:56:10 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d27eab42-dc4e-4c0b-70a8-08d81f61396e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3960:
X-Microsoft-Antispam-PRVS: <AM6PR08MB39604EF573C22742FCFBB396C16A0@AM6PR08MB3960.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:132;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+Ot+FBVO0q5tZc4HzN64RFqoqpH/eWu97lfN3q9KtdlKYjuN6v79HISt7LpaFoMEx4yjVEvLl0XnsUX7fBnYjZyMQlntUAE1zzcTznHcFmE/yPBEY8JkcB2J1YzkLZzbpH9KTxFPrXVbs5LWJ4pWNB4RoeZZfHGCczYLif9PAXrQsFCCiM01THCawtTDE1ftbW+PLVHTWEY3zBb7DQNNkVUsNG2iAnQ6o59krxHsLmBsvDH39tKG3O/EgvCSG6iipzNc1r9mUEsfrpViZkFx/+TQvbvMkAtnpjYEV6EFArzwxrgEadW5KnG4Ie/qlPFRxDSAGmFY5Jpa+UGVldtaUlCWDceCggcMUfxmBLQjimSo9SDSHYpdyWLa58kOr7n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39840400004)(376002)(346002)(396003)(5660300002)(956004)(2616005)(316002)(478600001)(16576012)(36756003)(66946007)(31696002)(2906002)(4326008)(31686004)(52116002)(66556008)(66476007)(6486002)(16526019)(86362001)(186003)(26005)(83380400001)(8936002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tyscH92ZQnB48vm+AvT5UIx96tVYad/ZJafxOCIsUJUD+qhmjSAY/GYPdQpw4y6brxU4Ss53Jb0tIxJtF3QCwey/1TplBnF4w6Pboc1ZvNH1ScbsU3nsWJ6TqopzCGh9nCQgds1MAas8RcW4AU04uCHNxf5TiN3AqXXZtBBCWIV7EvlB8zTWDrhc7EnYfSx8EdGLfmExSaGYbcMQ+XVFl28LZGbVQlVkSTjU4mabLkvh+2Me5Y2yd/Tvjgx5sRVcN7ZcoTiW6X50dt+vbFAdE65hJ65dRVA2d+IigR7FGh9OAfvONtcOohQNH3O218O6VBw6w0anMTCqz5gyXyoYnUy32LWN8nXnP8eTrZywg4//Ozlc3ZE3nlcjTG9QBTD/kkrvxW0V3ZALAM/7CnKA6doInL1TBU2czm5HsuF9GGDunERsgBCexmtBhnTRIQaDqp4Pt6MhQ+SZDiwXqyNcaBEBeYQCE4vWFet7Dq+Rlo3OjFhG5r4v43GzhiTIoq3U
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27eab42-dc4e-4c0b-70a8-08d81f61396e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 14:56:11.0246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFxJxC7UujH2dl6gB3U+XQlZo5dwzmNS5IfCrgqqi/+GCrFbbsac8i5ieTFwcofHbMHxfHuSbSMciRgx4PGdbGhMRnU169Y4AyD8tDQyDuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3960
Received-SPF: pass client-ip=40.107.5.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 10:56:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMDcuMjAyMCAxODo0OSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFRoZSBwcmV2aW91
cyBjb21taXQgZW5hYmxlcyBjb252ZXJzaW9uIG9mDQo+IA0KPiAgICAgIHZpc2l0X2ZvbyguLi4s
ICZlcnIpOw0KPiAgICAgIGlmIChlcnIpIHsNCj4gCS4uLg0KPiAgICAgIH0NCj4gDQo+IHRvDQo+
IA0KPiAgICAgIGlmICghdmlzaXRfZm9vKC4uLiwgZXJycCkpIHsNCj4gCS4uLg0KPiAgICAgIH0N
Cj4gDQo+IGZvciB2aXNpdG9yIGZ1bmN0aW9ucyB0aGF0IG5vdyByZXR1cm4gdHJ1ZSAvIGZhbHNl
IG9uIHN1Y2Nlc3MgLyBlcnJvci4NCj4gQ29jY2luZWxsZSBzY3JpcHQ6DQo+IA0KPiAgICAgIEBA
DQo+ICAgICAgaWRlbnRpZmllciBmdW4gPX4gImNoZWNrX2xpc3R8aW5wdXRfdHlwZV9lbnVtfGx2
X3N0YXJ0X3N0cnVjdHxsdl90eXBlX2Jvb2x8bHZfdHlwZV9pbnQ2NHxsdl90eXBlX3N0cnxsdl90
eXBlX3VpbnQ2NHxvdXRwdXRfdHlwZV9lbnVtfHBhcnNlX3R5cGVfYm9vbHxwYXJzZV90eXBlX2lu
dDY0fHBhcnNlX3R5cGVfbnVsbHxwYXJzZV90eXBlX251bWJlcnxwYXJzZV90eXBlX3NpemV8cGFy
c2VfdHlwZV9zdHJ8cGFyc2VfdHlwZV91aW50NjR8cHJpbnRfdHlwZV9ib29sfHByaW50X3R5cGVf
aW50NjR8cHJpbnRfdHlwZV9udWxsfHByaW50X3R5cGVfbnVtYmVyfHByaW50X3R5cGVfc2l6ZXxw
cmludF90eXBlX3N0cnxwcmludF90eXBlX3VpbnQ2NHxxYXBpX2Nsb25lX3N0YXJ0X2FsdGVybmF0
ZXxxYXBpX2Nsb25lX3N0YXJ0X2xpc3R8cWFwaV9jbG9uZV9zdGFydF9zdHJ1Y3R8cWFwaV9jbG9u
ZV90eXBlX2Jvb2x8cWFwaV9jbG9uZV90eXBlX2ludDY0fHFhcGlfY2xvbmVfdHlwZV9udWxsfHFh
cGlfY2xvbmVfdHlwZV9udW1iZXJ8cWFwaV9jbG9uZV90eXBlX3N0cnxxYXBpX2Nsb25lX3R5cGVf
dWludDY0fHFhcGlfZGVhbGxvY19zdGFydF9saXN0fHFhcGlfZGVhbGxvY19zdGFydF9zdHJ1Y3R8
cWFwaV9kZWFsbG9jX3R5cGVfYW55dGhpbmd8cWFwaV9kZWFsbG9jX3R5cGVfYm9vbHxxYXBpX2Rl
YWxsb2NfdHlwZV9pbnQ2NHxxYXBpX2RlYWxsb2NfdHlwZV9udWxsfHFhcGlfZGVhbGxvY190eXBl
X251bWJlcnxxYXBpX2RlYWxsb2NfdHlwZV9zdHJ8cWFwaV9kZWFsbG9jX3R5cGVfdWludDY0fHFv
YmplY3RfaW5wdXRfY2hlY2tfbGlzdHxxb2JqZWN0X2lucHV0X2NoZWNrX3N0cnVjdHxxb2JqZWN0
X2lucHV0X3N0YXJ0X2FsdGVybmF0ZXxxb2JqZWN0X2lucHV0X3N0YXJ0X2xpc3R8cW9iamVjdF9p
bnB1dF9zdGFydF9zdHJ1Y3R8cW9iamVjdF9pbnB1dF90eXBlX2FueXxxb2JqZWN0X2lucHV0X3R5
cGVfYm9vbHxxb2JqZWN0X2lucHV0X3R5cGVfYm9vbF9rZXl2YWx8cW9iamVjdF9pbnB1dF90eXBl
X2ludDY0fHFvYmplY3RfaW5wdXRfdHlwZV9pbnQ2NF9rZXl2YWx8cW9iamVjdF9pbnB1dF90eXBl
X251bGx8cW9iamVjdF9pbnB1dF90eXBlX251bWJlcnxxb2JqZWN0X2lucHV0X3R5cGVfbnVtYmVy
X2tleXZhbHxxb2JqZWN0X2lucHV0X3R5cGVfc2l6ZV9rZXl2YWx8cW9iamVjdF9pbnB1dF90eXBl
X3N0cnxxb2JqZWN0X2lucHV0X3R5cGVfc3RyX2tleXZhbHxxb2JqZWN0X2lucHV0X3R5cGVfdWlu
dDY0fHFvYmplY3RfaW5wdXRfdHlwZV91aW50NjRfa2V5dmFsfHFvYmplY3Rfb3V0cHV0X3N0YXJ0
X2xpc3R8cW9iamVjdF9vdXRwdXRfc3RhcnRfc3RydWN0fHFvYmplY3Rfb3V0cHV0X3R5cGVfYW55
fHFvYmplY3Rfb3V0cHV0X3R5cGVfYm9vbHxxb2JqZWN0X291dHB1dF90eXBlX2ludDY0fHFvYmpl
Y3Rfb3V0cHV0X3R5cGVfbnVsbHxxb2JqZWN0X291dHB1dF90eXBlX251bWJlcnxxb2JqZWN0X291
dHB1dF90eXBlX3N0cnxxb2JqZWN0X291dHB1dF90eXBlX3VpbnQ2NHxzdGFydF9saXN0fHZpc2l0
X2NoZWNrX2xpc3R8dmlzaXRfY2hlY2tfc3RydWN0fHZpc2l0X3N0YXJ0X2FsdGVybmF0ZXx2aXNp
dF9zdGFydF9saXN0fHZpc2l0X3N0YXJ0X3N0cnVjdHx2aXNpdF90eXBlXy4qIjsNCj4gICAgICBl
eHByZXNzaW9uIGxpc3QgYXJnczsNCj4gICAgICB0eXBlZGVmIEVycm9yOw0KPiAgICAgIEVycm9y
ICplcnI7DQo+ICAgICAgQEANCj4gICAgICAtICAgIGZ1bihhcmdzLCAmZXJyKTsNCj4gICAgICAt
ICAgIGlmIChlcnIpDQo+ICAgICAgKyAgICBpZiAoIWZ1bihhcmdzLCAmZXJyKSkNCj4gICAgICAg
ICAgIHsNCj4gICAgICAgICAgICAgICAuLi4NCj4gICAgICAgICAgIH0NCj4gDQo+IEEgZmV3IGxp
bmUgYnJlYWtzIHRpZGllZCB1cCBtYW51YWxseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1
cyBBcm1icnVzdGVyPGFybWJydUByZWRoYXQuY29tPg0KDQpUaGEgcGxhaW4gZW1haWwgY29udGFp
bnMgIj0yMCIgaW5zdGVhZCBvZiBzb21lIHdoaXRlc3BhY2VzLCB3aGljaCBJIGRvbid0IGxpa2Ug
dG8gcGFyc2Ugd2l0aCBteSBzY3JpcHQuIFNvIHVwZGF0ZSB0aGUgc2NyaXB0IHRvIG9wZXJhdGUg
b24gZ2l0LXNob3cgb3V0cHV0IGZyb20gc3RkaW46DQoNCiMhL3Vzci9iaW4vZW52IHB5dGhvbjMN
Cg0KaW1wb3J0IHN5cw0KaW1wb3J0IHJlDQoNCg0KcmVfcmVtb3ZlX2FkZCA9IHJlLmNvbXBpbGUo
cicoP1A8cmVtb3ZlPiheLS4qXG4pKykoP1A8YWRkPiheXCsuKlxuKSspJywNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBmbGFncz1yZS5NVUxUSUxJTkUpDQpyZV9yZW1vdmUgPSByZS5jb21w
aWxlKHInKD9QPGZ1bmNfY2FsbD4oP1A8ZnVuYz5cdyspXCguKiwmKD9QPGVycj5cdyspXCkpOycN
CiAgICAgICAgICAgICAgICAgICAgICAgIHInaWZcKCg/UD1lcnIpKCE9TlVMTCk/XClceycpDQpy
ZV9hZGQgPSByZS5jb21waWxlKHInaWZcKCEoP1A8ZnVuY19jYWxsPi4qKVwpXHsnKQ0KYWxsX2Z1
bmN0aW9ucyA9IHNldCgpDQoNCg0KZGVmIGNoZWNrX3N1YmNodW5rKHN1YmNodW5rKToNCiAgICAg
IiIiY2hlY2sgc3ViY2h1bmsNCg0KICAgICBDaGVjayB0aGF0IHN1YmNodW5rIG1hdGNoZXMNCiAg
ICAgICAgIC0gZnVuYyhhcmdzLi4uLCAmZXJyKTsNCiAgICAgICAgIC0gaWYgKGVycikgew0KICAg
ICAgICAgKyBpZiAoIWZ1bmMoYXJncy4uLiwgJmVycikpIHsNCiAgICAgaWdub3JpbmcgaW5kZW50
YXRpb24gYW5kIHNwYWNlcw0KDQogICAgIEFsc28sIHdoaWxlIGJlaW5nIGhlcmUsIHJlZ2lzdGVy
IGVhY2ggZm91bmQgZnVuYyBpbiBhbGxfZnVuY3Rpb25zLg0KICAgICAiIiINCiAgICAgbSA9IHJl
X3JlbW92ZV9hZGQuZnVsbG1hdGNoKHN1YmNodW5rKQ0KICAgICBpZiBub3QgbToNCiAgICAgICAg
IHJldHVybiBGYWxzZQ0KDQogICAgIHJlbW92ZSA9IHJlLnN1YihyJ14tJywgJycsIG0uZ3JvdXAo
J3JlbW92ZScpLCBmbGFncz1yZS5NVUxUSUxJTkUpDQogICAgIHJlbW92ZSA9IHJlLnN1YihyJ1xz
JywgJycsIHJlbW92ZSkNCg0KICAgICBhZGQgPSByZS5zdWIocideXCsnLCAnJywgbS5ncm91cCgn
YWRkJyksIGZsYWdzPXJlLk1VTFRJTElORSkNCiAgICAgYWRkID0gcmUuc3ViKHInXHMnLCAnJywg
YWRkKQ0KDQogICAgIG0gPSByZV9yZW1vdmUuZnVsbG1hdGNoKHJlbW92ZSkNCiAgICAgaWYgbm90
IG06DQogICAgICAgICByZXR1cm4gRmFsc2UNCg0KICAgICBhbGxfZnVuY3Rpb25zLmFkZChtLmdy
b3VwKCdmdW5jJykpDQogICAgIGZ1bmNfY2FsbCA9IG0uZ3JvdXAoJ2Z1bmNfY2FsbCcpDQoNCiAg
ICAgbSA9IHJlX2FkZC5mdWxsbWF0Y2goYWRkKQ0KDQogICAgIGlmIG5vdCBtOg0KICAgICAgICAg
cmV0dXJuIEZhbHNlDQoNCiAgICAgcmV0dXJuIGZ1bmNfY2FsbCA9PSBtLmdyb3VwKCdmdW5jX2Nh
bGwnKQ0KDQoNCmlmIGxlbihzeXMuYXJndikgPiAxOg0KICAgICB3aXRoIG9wZW4oc3lzLmFyZ3Zb
MV0pIGFzIGY6DQogICAgICAgICBwYXRjaCA9IGYucmVhZCgpDQplbHNlOg0KICAgICBwYXRjaCA9
IHN5cy5zdGRpbi5yZWFkKCkNCg0KIyBEcm9wIHBhdGNoIGZvb3Rlcg0KcGF0Y2ggPSByZS5zdWIo
cideLS0gKlxuKFxkK1wuKStcZCtccypcWicsICcnLCBwYXRjaCwgZmxhZ3M9cmUuTVVMVElMSU5F
KQ0KDQpmaWxlcyA9IHJlLnNwbGl0KHInKF5kaWZmIC4qXG4nDQogICAgICAgICAgICAgICAgICBy
J15pbmRleCAuKlxuJw0KICAgICAgICAgICAgICAgICAgcideLS0tIC4qXG4nDQogICAgICAgICAg
ICAgICAgICByJ15cK1wrXCsgLiopXG4nLCBwYXRjaCwgZmxhZ3M9cmUuTVVMVElMSU5FKQ0KDQoj
IERyb3AgcGF0Y2ggaGVhZGVyDQpkZWwgZmlsZXNbMF0NCg0Kc3ViY2h1bmtfcmUgPSByZS5jb21w
aWxlKHInKF5bKy1dLipcbikrJywgZmxhZ3M9cmUuTVVMVElMSU5FKQ0KDQphbGxfb2sgPSBUcnVl
DQpmb3IgaSBpbiByYW5nZSgwLCBsZW4oZmlsZXMpLCAyKToNCiAgICAgZmlsZSA9IGZpbGVzW2ld
DQogICAgIHBhdGNoID0gZmlsZXNbaSArIDFdDQogICAgIHByaW50X2NhcHRpb24gPSBUcnVlDQoN
CiAgICAgZm9yIGNodW5rIGluIHJlLnNwbGl0KCdeQCcsIHBhdGNoLCBmbGFncz1yZS5NVUxUSUxJ
TkUpOg0KICAgICAgICAgaWYgbm90IGFsbChjaGVja19zdWJjaHVuayhtLmdyb3VwKDApKQ0KICAg
ICAgICAgICAgICAgICAgICBmb3IgbSBpbiBzdWJjaHVua19yZS5maW5kaXRlcihjaHVuaykpOg0K
ICAgICAgICAgICAgIGlmIHByaW50X2NhcHRpb246DQogICAgICAgICAgICAgICAgIHByaW50KGZp
bGUpDQogICAgICAgICAgICAgICAgIHByaW50X2NhcHRpb24gPSBGYWxzZQ0KICAgICAgICAgICAg
IHByaW50KGNodW5rKQ0KICAgICAgICAgICAgIGFsbF9vayA9IEZhbHNlDQoNCmlmIGFsbF9vazoN
CiAgICAgcHJpbnQoJ0FMTCBPSy5cbmZvdW5kIGZ1bmN0aW9uczpcbicpDQogICAgIHByaW50KCdc
bicuam9pbihsaXN0KGFsbF9mdW5jdGlvbnMpKSkNCg0KPT09PQ0KcnVuIGl0Og0KIyBnaXQgc2hv
dyB8IC4uL2NoZWNrMi5weQ0KQUxMIE9LLg0KZm91bmQgZnVuY3Rpb25zOg0KDQp2aXNpdF90eXBl
X2ludDY0DQp2aXNpdF9zdGFydF9saXN0DQp2aXNpdF90eXBlX2ludDMyDQp2aXNpdF90eXBlX2Jv
b2wNCnZpc2l0X3R5cGVfdWludDgNCnZpc2l0X3R5cGVfVGhyb3R0bGVMaW1pdHMNCnZpc2l0X3R5
cGVfc3RyDQp2aXNpdF9zdGFydF9zdHJ1Y3QNCnZpc2l0X3R5cGVfaW50DQp2aXNpdF90eXBlX2Vu
dW0NCnZpc2l0X3R5cGVfc2l6ZQ0KdmlzaXRfdHlwZV91aW50MTYNCnZpc2l0X3R5cGVfdWludDY0
DQp2aXNpdF90eXBlX1NvY2tldEFkZHJlc3MNCnZpc2l0X3R5cGVfdWludDMyDQp2aXNpdF90eXBl
X0Jsb2NrUGVybWlzc2lvbkxpc3QNCg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

