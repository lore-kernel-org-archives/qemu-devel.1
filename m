Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFFEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B91521841
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jqx7+APr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B91521841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUa3-0003eQ-Bw
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsUSG-0005gB-FX; Mon, 06 Jul 2020 12:58:56 -0400
Received: from mail-eopbgr140137.outbound.protection.outlook.com
 ([40.107.14.137]:4072 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsUSE-0005nU-Gt; Mon, 06 Jul 2020 12:58:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPcD+G4SwFsbHLB1oeJsCaVIMSqCGgK1vgi+FuwIkt52q7ErAPnxOI7Yt1NjrFnpl/BTaTS2VhTaQc5y46D86oGUEC74MV9bOj0xV4UBYQp0OoqSl+DJX4cAcIC32p17fyPK/JpvEju6ZeQDB8SFL0ABV5ghBEJ0o+6FsTezbUQniEvquwT+YARAkTrUHhc2Y6TC1ZO99a1k2QgosbJmBCaMf5ogC3FrNb9MsKoFruKfOZ13M29byZNKzRC/4aRVUiBJvGNik+MFyqa4FdU5jiS3j1E86sY9vwQqJkYVQG40SZRW2B9U6/8tsLD8/3BKcNqhZFxG2kSF0sNO5AQe0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRTzz5nQdo1nr3w8+VAXSYo9wD4nUM59kJcD+FmQbgQ=;
 b=bKI07+2SUCChmN1EmZuXNIy1Xqz5oh7AnEvngb5+VfKt8H8sXnPdXqV/IO2v4XTtNdZF8/3xkyuUem5fkdHaKayJl0wDJntZmH+GOyc/PQRJnih8hGmOhmR0ssTvaHhIkxJClJUw0oUwaVI9PwZ23YcTf3uc2hzARSRY3/X3p95hV2YyM6jv+jcN2WC80fTKD9nyGPEMXYyo9IwCA1f2S+gzf4KzdxLEQEnWBQSp46+pT31rV4BiGfLPfUY8LNOasy29J/nFPOyKKS+FPFJVySgRS9vatXzZmyN83Qi6rQHPvS8CYnJZ3uUc+dLJNkdBKfVWWDrZ531ayOtAmf6x6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRTzz5nQdo1nr3w8+VAXSYo9wD4nUM59kJcD+FmQbgQ=;
 b=jqx7+APrYrqdYws/nFETknh8a1OExFTpY5iwP+p9lJJwc9HXVxL0uXT1isQ1Wd45R85kaITZUjPUqjdT4f05hMEE7prv1/yXhma/Ws5C6b3e+qhfMBYHRq8fR4kz1Lban1bmBr/utzffaqi4GspqoFoCjP0Jd2mCW/Vdy8gsy6k=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4166.eurprd08.prod.outlook.com (2603:10a6:20b:a6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 16:58:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 16:58:50 +0000
Subject: Re: [PATCH v3 30/44] qdev: Make functions taking Error ** return
 bool, not void
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-31-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d67e82bd-0454-542f-8c9c-ec0261534d7e@virtuozzo.com>
Date: Mon, 6 Jul 2020 19:58:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200706080950.403087-31-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.12] (185.215.60.58) by
 FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.8 via Frontend Transport; Mon, 6 Jul 2020 16:58:50 +0000
X-Originating-IP: [185.215.60.58]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f58e234-bdb0-474e-7e5c-08d821cddb84
X-MS-TrafficTypeDiagnostic: AM6PR08MB4166:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4166706DE40D538ECB2846F6C1690@AM6PR08MB4166.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:183;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7MIWdmPbmQ+MH34QcdT9Ss8T46zW9CsvlpOs02vn16c2RvpOlA9aU/DvIiRGkNc5ufS3gZTrwCb6Bf4bP5PmwYt/VsHcALeRoFwBJZzQ3YUfFdVV0OD8Wuy+Kr/L5WwB6MMEDNdVzHLJtuCU5zf951sn8AuXjlUxHPkvU6W7cnUBW7o/D+92Se+sKBk8eQSPe7FBgpMOxkzF4dnr8GV//eXoBDfqSZKEVUJ5LRmxl/XWWLS6J9qCrWSx8LLegyNjLh7GiWLuPs2EOU0qXBsWJDjXKcn2ysTJPiW7KRbleIIrwp3XSvy5EQKmHtdclwVCIAvMmHJsQSnSlg/F1XPqZRTFKo68vAaLopVTWTEou3vJp6NPj/3YcgdDnVjmzqY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(39840400004)(376002)(396003)(36756003)(186003)(16526019)(558084003)(66946007)(8936002)(66556008)(66476007)(4326008)(2906002)(53546011)(86362001)(26005)(5660300002)(16576012)(316002)(956004)(31686004)(31696002)(2616005)(478600001)(6486002)(8676002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: d3munVXPRycAX6K6nmqQuhcn06dozQygZL+cIZGdXuxUJZ/hWihnof6dnwY8FvMLedPhDybxRVBnr78v8WjzUBxyW0I9tI7OaYN65x/wJ8SLJRVBYTLf9hkaDp3Fy46GzHuz4lS3BFgIs7mO4Y5DSJfToXly5Kr4Ls4oJWWHG8NZiGNY+lMzkR0Ok5Jw5XVKnvDIGXqmt6MPe4J/VIQu5TaCJjQjbpFka7kw6CHohm2EDsq7I//ZEKBbkZ1Tyx+G10rIJC+Bt5xzjPfjxGU4ftYgd0vqkyqv4UcpdP2h2tZlUaZxSF7USokKIhEtalA9owh9R/vpyKHyIrPGcMMz5hW/wSv8EzH+olvfAlTeq/V2vK3CQwFpZ2CNS7U5uzdD5NESspCggnBar/3dvku3T3U6umrOsC0g3ljeTASHEF9JIHiPwI75R/AD9uuWY/w6snSaG4ziff2deXm/93fFBcKk6yWlVJyT6Wwr/ui0L7w=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f58e234-bdb0-474e-7e5c-08d821cddb84
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 16:58:50.9135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4f5NKc94w1YzIUE6JxcozMW3pdrGuI4WrAUhQ9J+jQFbmhUD1nh1PgnXEHesOqM1PZ/pudUQuiMKeyP51YR40/GzzAyV2Km2SmL0uZLZKyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4166
Received-SPF: pass client-ip=40.107.14.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 12:58:52
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
 qemu-block@nongnu.org, groug@kaod.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.07.2020 11:09, Markus Armbruster wrote:
> See recent commit "error: Document Error API usage rules" for
> rationale.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

