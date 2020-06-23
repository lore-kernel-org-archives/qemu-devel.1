Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04601C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37162072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dgamDj0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37162072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndFF-000793-3F
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jndEb-0006fg-DP; Tue, 23 Jun 2020 03:20:45 -0400
Received: from mail-vi1eur05on2101.outbound.protection.outlook.com
 ([40.107.21.101]:9440 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jndEZ-0002t3-33; Tue, 23 Jun 2020 03:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3xZGF8pL+VuQ0DS+hty14L9VX4ugBe9tQntdFsUuvNQ6jQaZ4nScXqoVRXnFi6Fvbwk6FwGSo8rHs0VlyAZ7KmRojbyqe0r20QjsOF5CcE/bpe3ribtKdyP5uIWvPyx8Gze4esWM3XzzDSxSc9OAWoz0zvY1+fltS7dQttT3poy9kj8vMUhvND+pWt+nbENGEO7pBB9ZcaeT+4azXAL6ka3YLb2ng7HBlDfkYo9TMehd4QQHaZE62r6+jMLTLLf2Eae8Ew7bc8H36vQO4BsPOMDHd3YarK1HuLcCCfXB4ucQX0bYnH+McTAB1pN/qqNoqaYN2ptJPy6CCKpPH38bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYQlcu1xk8nB1I3A2hFhd2lGBg4kO5djctummvfkrj8=;
 b=RoM5CL9j1DuBiQKX3IG1PJ8+awkEU5ko/2neaSI0tniF8QtKc4fZi1Mw6T9xeN1md/iex92ux4qMMlPR3idDzJ5Jq2JgMV8A6a5enwgaVaIRthAGXEHKjUobYSwgMQYuASbpRxLgyXMLEVy41w28DYA6fL+alASktBbL/uAzpFjmRuOmjpk5EffG0Hgk4lc6DYWIgsMiMUFQPpOUGL23jFpcKgb2mCNdu1ow5ZVw745R+km+hLFrPr7mcmBhFI7ospLMnlACXGH2Zw1G/R15z03IyN1TWyIYZxkD8sMY1U6lHG3fgrcXTS0LmQnssl0Hb+qkVZQKZlS/tqPun4VSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYQlcu1xk8nB1I3A2hFhd2lGBg4kO5djctummvfkrj8=;
 b=dgamDj0ifbtjw6/jwPhkou5NRu2THDEFkUEZS4KEuWGNBIc7lDns4BaFRim0bZ5xhVAPeSUis+LhCHWAdY8nTkGUpXDp/joXmdM9fLu+7Njl79HTLW666g2j5/EwIdQMBWuf2Rid65eBxrV1GVk4uyWT6DTWpbiZUvdK/xw13nc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB3199.eurprd08.prod.outlook.com (2603:10a6:803:46::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 23 Jun
 2020 07:20:38 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%5]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 07:20:38 +0000
Subject: Re: [PATCH] nbd: Avoid off-by-one in long export name truncation
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200622210355.414941-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f3182c3b-ff33-f733-a12f-86657713adc7@virtuozzo.com>
Date: Tue, 23 Jun 2020 10:20:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200622210355.414941-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0030.eurprd07.prod.outlook.com
 (2603:10a6:205:1::43) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.117) by
 AM4PR07CA0030.eurprd07.prod.outlook.com (2603:10a6:205:1::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.12 via Frontend Transport; Tue, 23 Jun 2020 07:20:36 +0000
X-Originating-IP: [185.215.60.117]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0faffaff-e5ef-4dea-8e0b-08d81745eddd
X-MS-TrafficTypeDiagnostic: VI1PR08MB3199:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3199E10731E19DFC1064F165C1940@VI1PR08MB3199.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99Z2O3zxi2L6oe7CX2SEwokyrLQKtW2uTB28eNIuxx690qOabQuf8wNRzB2Au4Bp+YdCzR2lvBXLYZaIaOPT1IYspvIdqA0FpaBLF7etjorOJjxZoDS6kJg2KeaKyAbyqlCtWI4eEUieYs8VpXSdUEf6AwtC8QaUOM/aLZtXkVG3kwSMvm/NUd6upy0w8rpleExg1pZIoA6mxUMZLN6/2O7yIFoKfXLQmrfmtlM2UsYwE8f9kq4UkbNHDVVKsDBNTjR31wrhZTE4L1SkA/wVdn74jC9MKLIM5MIRnunhMhCGn8rmX5awlwyF+tOW5AXpYUnZUpskmwtcWDoyhQ6YJZ56AG4AUXgQCgVQLwBNxcttsy6W/jvpNkP61wO8enQ3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(366004)(39840400004)(376002)(52116002)(16576012)(2616005)(66946007)(66556008)(31696002)(26005)(66476007)(956004)(186003)(2906002)(16526019)(86362001)(6486002)(36756003)(478600001)(8936002)(316002)(5660300002)(83380400001)(4326008)(8676002)(31686004)(54906003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cnPv8hdakLSXbVDSDFV5cnoDKQPw2nCOnxhn9yu0+YUkc/ryTcmjcAJYrVJrHZ5cyN9/IgscqQcMLG5hk1Cma8+k+y5VGP+imqrI+6bEjbMmHHXRNk+/kwyvFH9qdqXy88eSh9DAwtCnPZogn5tOMtRCkKwmh55BHmuJpiBhGIdjCgJFQ3F/Zdv5h/K2ASqoGeq3ibXQfc3WeTq7+Ol+fXvakduZhslH7RXoCuAEjG9ubpYI7I7Y+RR8GKLLTJn7WWwPCDPPN8+MKNCiSJhck6B7pYwfqtp71S0g5SAQDaMnbUxm+9V8Jsd8u21/tHIf9Cie1PKLi4OtE4KLNM5qpPqTJJnBBzbarikCoIiwUQ8TKMckNMmQbN3RwtSl/dt5VY2o2P5XBLZ4Fss8p3wOk89jhbyRafsL+eX5WHrX6o/bL5IpGVMq0X27/uepA9p8+tAn1+72hyX44Itzfi1vR7ACw5JgPqR9dqh2c2GbGkQMlokdz+YmlUWr9zcToZw0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faffaff-e5ef-4dea-8e0b-08d81745eddd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 07:20:38.5440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3a0Kh6HjxBaNnggua7d/yE83//futpXHMDxZYVYsqQxsLz1IgNXNvDR/gdl7wsc8ZhVSEo6+HhkMOsLrqJdSmI2h3loiHz4fm7SkkxU9MQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3199
Received-SPF: pass client-ip=40.107.21.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 03:20:40
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.06.2020 00:03, Eric Blake wrote:
> When snprintf returns the same value as the buffer size, the final
> byte was truncated to ensure a NUL terminator.  Fortunately, such long
> export names are unusual enough, with no real impact other than what
> is displayed to the user.
> 
> Fixes: 5c86bdf12089

Oh, I remember myself checking snprintf spec when reviewing this, but
still I missed this thing :(

> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   block/nbd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index eed160c5cda1..8301fcac0589 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -2009,7 +2009,7 @@ static void nbd_refresh_filename(BlockDriverState *bs)
>           len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
>                          "nbd://%s:%s", host, port);
>       }
> -    if (len > sizeof(bs->exact_filename)) {
> +    if (len >= sizeof(bs->exact_filename)) {
>           /* Name is too long to represent exactly, so leave it empty. */
>           bs->exact_filename[0] = '\0';
>       }
> 

Hmm, interesting, that in case of len=0 (no one branch was executed from previous
if-else-if, which seems possible) we do nothing. Shouldn't this if actually be
if (!len || len >= sizeof(bs->exact_filename)) {
   /* Name is too long or we have nothing to report */
   bs->exact_filename[0] = '\0';
}

Probably not, as bdrv_refresh_filename() does it anyway prior to calling drv->bdrv_refresh_filename().


-- 
Best regards,
Vladimir

