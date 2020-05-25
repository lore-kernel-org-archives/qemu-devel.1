Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DAEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 07:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFED02071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 07:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CHBYvDzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFED02071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd7CG-0001E9-72
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 03:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jd7B8-00008b-7G; Mon, 25 May 2020 03:05:42 -0400
Received: from mail-am6eur05on2105.outbound.protection.outlook.com
 ([40.107.22.105]:9185 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jd7B5-0006bu-Rx; Mon, 25 May 2020 03:05:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjDDsKCKTHYk/I2p0VpTKmOs8Rw540okfbjOEM1o4yIMOqEv8j4ea3/2lnN9Oz2AqmO0D1Z54aMjz7W+BWSpvQQDRBuh+Ou6rRZVC/r4jRhSUrfUJhRocLqtmS50g3Pprz9dXrSUe4NclSS3iTqUDqQETeFGUMrnd1Xdr3zC6iFlS7posolthqyTy7tInVZ2VDuOk6Qlhv9u3WK0wKTf9H38cDKaW8RXkYKQNu8TgLPSKP7xv+A+bfkTXre777W0o6NeQc7VJBONojJr+BJXh4v0T2ijU2OY/HXziD3Y8WXjTTtH8mz21ssL00Ddma7YivOOeqAL+KObkwiB9Z2LPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Xh9pldVoSoI3EoyR2kvpKXbQKj7VS9tilRL0mMes/w=;
 b=Z894XCPRCWkKZ0vz3WUjwffUgRTDiikXJrmkgAjtJyz4SFfMLmOpl6+pnAyy6vPc0FrTDprOFRcaFzWAGw9IDwTtfycaRJTcMbs5VzxR7875MA1FXb3IXedXfdmO8J6UckP50rBQwnQFIJYlDPJfMvo4/LRbYWPjhVTMk8QK19bvFR+BbttGN8G3keshTpE9FNbXAbBircy3ZQ39XNIPU6waeISJJjViHzuvBhxXP1BPsHyrl4QJhtqZ4aST/Jq/Wd++7dZYu6bBsEeG2Nz2aBIHj5DlHCGmWWnbMP3nZHOsgO+SL40sIt41m2+B58UEyZls6wSgcXoI32PsW9c0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Xh9pldVoSoI3EoyR2kvpKXbQKj7VS9tilRL0mMes/w=;
 b=CHBYvDzz/0T+ut/k0yY3ZzYrujwtZl7lfxSgotzZr9yjxWzvdPMvpikubauejwIgc9BOSpkXezS0otrkW2CTw2fTrc+FD9QXFOlcDECAmKiT14gMwckyNx2zrVXFCOBEhvArqrl08GwPImTrQ5Io4q8QfA/8WCAxRVwFOL4bSh8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5464.eurprd08.prod.outlook.com (2603:10a6:20b:10a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 07:05:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 07:05:34 +0000
Subject: Re: [PATCH v6 2/5] qcow2: Expose bitmaps' size during measure
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200521192137.1120211-1-eblake@redhat.com>
 <20200521192137.1120211-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <abf6557a-6f31-8e2a-4825-62178c300a01@virtuozzo.com>
Date: Mon, 25 May 2020 10:05:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200521192137.1120211-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0045.eurprd04.prod.outlook.com
 (2603:10a6:208:1::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.147) by
 AM0PR04CA0045.eurprd04.prod.outlook.com (2603:10a6:208:1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 07:05:34 +0000
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c9c5428-f0c6-429c-83a1-08d8007a054a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-Microsoft-Antispam-PRVS: <AM7PR08MB546451C8D3AB2BCD9C53F554C1B30@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fipy3/oQ8iIIVA6NxZNeoxykzhVNP+86ewhpPEKE9qBxzJ9rN6TCbvKW9EieWhIOs/dc2V0oSNLMIBNB3HT0hlAAsT+Grw2XXzcfgedKItspuEvitFn/0bPpQvsnWHZzhSQ1bBiq6ObvYWvAjiB0wilzj+3mHvo/EsXVNs6zUDZGU3+18T3YrTQQF7SnKUp+e58tNXeQHn1TAwjTLQ13czcfnzybLTG2G6RPxmDTE+PE6lI1Al+C0Th1WKScTg+gUdjc8932j6R3dud6IcnAD1dpLU55hbN8205BemFT4pk2VwQAJOGYJxDLoHFV7GoLoeS3NS5XNSI4uuP6XqkNC2T/9tkytdEncH/LXDu3U+kW23SYevyxZKxP1R3nA3d2rSHldyxLvSTObKvqtOFwrs8BoODmKSsGwDmDMSyoc+haXlXpPAZNmcVO8SXuaXdUMijKAR/fVzFsVfHEBRtWsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39830400003)(396003)(376002)(366004)(136003)(6486002)(16576012)(54906003)(316002)(52116002)(31686004)(26005)(478600001)(956004)(8676002)(2616005)(8936002)(86362001)(31696002)(16526019)(186003)(36756003)(5660300002)(2906002)(66556008)(66946007)(4326008)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wEzGgNqP2SCA73/tYibVwwoQNyim78hU2lYPEUNesqINQpl4v3ji4rQ9+2B7AeqXtJQM37HkfeSShLEf03r5HjC0HtmGqwXjytFSsrxUGEqDcqej+6Ogxui8H+sPtxnyZLmkLKckYk1iIDpmqYtOWgEPT9sIjqKNSv0kM+OF+9fDhiIyGE0Ujopy92TMlK5xwh4a6stFIVJg8kWvI8Nph09f3j5Y6SNAYfNHCZxvecvrNKa7uD1KtGL46b1kY1ZizmKbZexWOhqMt8L4bq0zwLkDTXlZe3LW+Eap4whFHwj3SSeMNLRl0bA9++poKHkueJjdePmorWqYkeZIKevEt/hg6WzMHsqZBC6chLUKmKKx5qFsjPMm7ubtd7nnIZTxKjzysQLWX8jYGpVImJfpmGBI3eQMobBenb5nEfaD+ra7unOPyZ+KgeyIWwJTIz5ItVdYUj7uN/E3gNIGsxpWxRmzZEfJ+Q++LdliRdczmjQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9c5428-f0c6-429c-83a1-08d8007a054a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 07:05:34.8919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9d0KZhNNtaZwsjJHJDC5A3etAjFWyfataBF5VbkpGihG+UagRWsLnrWLxdbk+PwmANymxn3Q6iSL9BOkZ21d0PuXqHQ0MVTwaEtUqFYh4nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5464
Received-SPF: pass client-ip=40.107.22.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 03:05:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, mreitz@redhat.com, nsoffer@redhat.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.05.2020 22:21, Eric Blake wrote:
> It's useful to know how much space can be occupied by qcow2 persistent
> bitmaps, even though such metadata is unrelated to the guest-visible
> data.  Report this value as an additional QMP field, present when
> measuring an existing image and output format that both support
> bitmaps.  Update iotest 178 and 190 to updated output, as well as new
> coverage in 190 demonstrating non-zero values made possible with the
> recently-added qemu-img bitmap command (see 3b51ab4b).
> 
> The new 'bitmaps size:' field is displayed automatically as part of
> 'qemu-img measure' any time it is present in QMP (that is, any time
> both the source image being measured and destination format support
> bitmaps, even if the measurement is 0 because there are no bitmaps
> present).  If the field is absent, it means that no bitmaps can be
> copied (source, destination, or both lack bitmaps, including when
> measuring based on size rather than on a source image).  This behavior
> is compatible with an upcoming patch adding 'qemu-img convert
> --bitmaps': that command will fail in the same situations where this
> patch omits the field.
> 
> The addition of a new field demonstrates why we should always
> zero-initialize qapi C structs; while the qcow2 driver still fully
> populates all fields, the raw and crypto drivers had to be tweaked to
> avoid uninitialized data.
> 
> See also:https://bugzilla.redhat.com/1779904
> 
> Reported-by: Nir Soffer<nsoffer@redhat.com>
> Signed-off-by: Eric Blake<eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

