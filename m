Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CFAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4826208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="g2KeBOXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4826208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNNb-0006bd-QC
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrNL6-0004jZ-JN; Fri, 03 Jul 2020 11:10:56 -0400
Received: from mail-eopbgr70137.outbound.protection.outlook.com
 ([40.107.7.137]:60995 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrNL3-0002Io-Jv; Fri, 03 Jul 2020 11:10:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbHKhm5ebrt0Vpn0Z/NJsbW9p7Ouz2RMPwQj6BNiSqqqGtGafyoLNg1DgsAJWhOt9gOWjnOvWAdl+9ic4YJcyrKqwQrVNySt99TfNkUvK6xZF4kqBr7XL0hUYn1iERPwwRV3tCdQFiT7NuMRLAplevnxUuUogbgriSks00p9COY13qBF/Jrlo6iQd0hiJXfdOar2oNJ9kbn9k1rPbeFBoOpM4rYuuDGDIW5L6CRyrHJEnzyD0MnOJjw+5UjZo9vunAhyOIPhw/hLUZt0UpKqg+quVTTKdhG1ptblc9Odvdl0JpoqqRwd+fWdDLSm1l6aaHZoTMybavMw+hFC3Bs4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSoRlrMuF28Jc//CJNY2yMhsW+2LzbWwmu4x5F+lJLw=;
 b=IjYHEJHwMq1lNEczndw6FTnJmuICfR9LrzZaFxyZJgauLQr+xzLgPNEItYD428eB1VnR5ia5Y7lxbqMGfdDhwo0R3NnoszRF6gLxH1mv/O/cM2quvvvmKipMk7c/a4cJmrNhBHJyfh8tdCUoADNM0Al2yvt8CuZskztnZ7JyOFUdwsxEl+JvG9jZZTeoTGYIqPFyZlqDnY6MolG8dIdJXIkrLTfh4XXoAWvFNoQLQ+MwCFGr7wY4xPDLq2fr7GrNV4vMSDoCR/Tl3uz4A3ezQulOrOlUfrlRfOUxeGBw43vZOx74AyvHchfERAutjENsz3i1td+15vE7hcQmcH5G5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSoRlrMuF28Jc//CJNY2yMhsW+2LzbWwmu4x5F+lJLw=;
 b=g2KeBOXs4szMB1zknEPFAh6SKMv8Hzk0L9jzU1UNponaD+nqRwc4hrjfWMyUjS+5htD9wSp5MWvfXt3xAKPfOqXaddRmEe0YSbKzHJVZtoGbDfXQPr8nuuBwf5xXLXqkvsjYKnVhnl12Gunwsyv+GsRGl6OS4c13EhBnUNbnyDs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2419.eurprd08.prod.outlook.com (2603:10a6:203:a1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 15:10:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 15:10:48 +0000
Subject: Re: [PATCH v2 18/44] qapi: Use returned bool to check for failure,
 manual part
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-19-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ac9e71b1-5e4f-c93a-8532-2c8539372e26@virtuozzo.com>
Date: Fri, 3 Jul 2020 18:10:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-19-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0080.eurprd07.prod.outlook.com
 (2603:10a6:207:6::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM3PR07CA0080.eurprd07.prod.outlook.com (2603:10a6:207:6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.8 via Frontend Transport; Fri, 3 Jul 2020 15:10:47 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0351d4f3-95ac-4578-16d3-08d81f634488
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2419:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB241919D08D53EBEAAB423CC7C16A0@AM5PR0802MB2419.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mu0QimIVk5BYOFj1Nswms3Ca8D5A6bOl9xMArTFId9Ynb6aZMl+WwYffPq8ixDNR2pHl0kSeGWZ1TdiTHjfBjNPGuO/6bMmWX1buOXL4WRewRJPzuF1e/gVbWlwfXthOefUWJuSpjhyanma0Xym+aiuTWA4eiUoSKhbEyVO9H8AnTYusgbvQe4q97vl2YjP1CzDi/lEQS6pCw1rTXT4+2ZRWDeg46AmmScVMD9ueKgTLcn4BUFpN1+5nnst86X8i0xTdYlWTIvCwbhua5DZGz6LnTMndD4ewUUeVYgaQSDgl/3wK/pok4wM9HlDEN89mv5kvAGY+L8LPjwL/KsRMK091x7VbLGNE4yBKZHCQ3LfH8kkprLjygmzATmnb06gv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39840400004)(376002)(16526019)(956004)(52116002)(86362001)(8936002)(2616005)(478600001)(8676002)(2906002)(31696002)(26005)(5660300002)(36756003)(186003)(31686004)(4744005)(4326008)(66556008)(16576012)(316002)(6486002)(66946007)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zh5nDlEalmXDhGWwyfJn8nDxZE6d9GFBjvrm0EHHVVLSvbOHQE0Rp78JK0+VJ1lb6OR67l93+LgK53lWEPVmd99e9aPAoMCrAA0mLDFC738Cjcb/l1LS/uP2dHcSQq9koxyipw0A9OoPaclodQjiieivoWcAVT1RA6o48l9snOrnRa1unTjI5i5hikOSjOLhzZowkQh9yQI2pEZiAuqjfWKX0VLUf/x/7HtigfVZnh9/kkoDGaMhvMLiFEjRGuxI8JGcZ9r4gKG9TvECFuBhdliancizoGvnvzTq9pOYbl6sSBQn50Vz765QrADpnPkFm1tZfcCWDWbbRo8j9Lx7xa6pC3K003NugmGh8BM5UTHl62FnlJgFA9oDzV6auC2dNGgT+Hh91qjBmH2A0cy+aMadu9KdEkT5dz6MaEJdSuW7RJHmiQBlOorBFS/vky6W9DEn1wnHKGPr3uh3wEfiXpHHg18ucekKupfQmP7eGFev9B2TlZlJ33+k/UsutqSU
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0351d4f3-95ac-4578-16d3-08d81f634488
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 15:10:48.5983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSXJrYUF9VOce/UlTo5PpWn86xE4x4l632Gp5UZGivC8vCrqg55G0qZl/e8N07MHkx3MileEfIyqCsH+eb0L03zBwGLCIsXHjvBinQgFCpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2419
Received-SPF: pass client-ip=40.107.7.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 11:10:50
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

02.07.2020 18:49, Markus Armbruster wrote:
> The previous commit used Coccinelle to convert from checking the Error
> object to checking the return value.  Convert a few more manually.
> Also tweak control flow in places to conform to the conventional "if
> error bail out" pattern.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

