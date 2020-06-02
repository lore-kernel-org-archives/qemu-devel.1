Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACB2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3139C206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jdK9aQ/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3139C206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCep-0006TG-G3
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgCeB-0005yh-7z; Tue, 02 Jun 2020 15:32:27 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com
 ([40.107.15.109]:31360 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgCe9-0006j8-CH; Tue, 02 Jun 2020 15:32:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JO7uHZ9RWZKkUisMHgpumH9NKIpTn4bDR7Gvrp2SPI0a7bEBD1zxVXuqn7KI8E4jRdEOB2jk5Jc0cXgccpRbIWbaqtXvGKDzaa5tkrxc5Xi2yZjVDUcvhQaf4/02aX3qxM8/+SOP6nmx2DaI8SxP7cW4A3m9kUa14KNkllw5A8sz5gdGL2PGzJNu0aFTSbb74rjZlUf4U4gMLKB9z+DVMzpW2upPJVJ9kawXt83DGnbsgyudJQDbe4yxsos2lWoiCrI7QZvXKw4dBq9VmWvN+1CygH+z28BwwRDO8GwzIwKBD/SaVk95bW+bODibz9Hwo+ig32Kuyhed/slMj68rKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUcx42mkCchVDWKt9hV4YXCYk0JcEVab6F09WHqHgXw=;
 b=IkjslzFvj9dBN87aqlCVpnTWTaOE0MRuTTKiyomdfFli1QdoVfQb5BGxOPxfYw2Noic0aAJEwgRLgJmu/P7RWNA3qyi4I1SrfY6eeNWviFHDHpybuFSg0micp6mN9Hjch8uaRX679oLJ1IEqop/Zdf0rLAI7DdmZDoSiXtFzNYhTNjQ2xYrcZwA3wosWJtPqb8I9rb0rK7iJDBqDazCf6o11bg0uGMOfU/uBUHvkSue/l5ZmfD6kVe6XlKfyMoez9rhmfLKENlmpaLQpJ+yNZH4SLQ3uT0eXrpbHpquP4uR6bx/GbmJFKPiIASxnR6wqnU0eCA9Jazl2xGL3Jg8FyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUcx42mkCchVDWKt9hV4YXCYk0JcEVab6F09WHqHgXw=;
 b=jdK9aQ/OLlc6V5cmYsYqF98BM6AnrltpRzlZy4ttlPk7nziiKYTDIJC3wg2RvBs8okPNlzHaBM1Ee3QOYfZaSBbxyhy4QX00TcVQ8RqZPOA+uPBw/wDDd75Wdm1qXs4sIxJPMAlhYyZ0vk6dBKBrSzM8XGAbT4Qs1hMczYk0lWk=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 19:32:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 19:32:22 +0000
Subject: Re: [PATCH v3 2/6] iotests: move check for printable data to
 QcowHeaderExtension class
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1591019293-211155-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <900a35ee-96f0-42ed-afc6-4bc206197535@virtuozzo.com>
Date: Tue, 2 Jun 2020 22:32:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591019293-211155-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:205:1::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.153) by
 AM4PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:205:1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Tue, 2 Jun 2020 19:32:21 +0000
X-Originating-IP: [185.215.60.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ac20376-7c12-4813-f8ce-08d8072babb0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54304D2FFADC22B4B317E2F9C18B0@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YewsYHZRuRkXFCnWPxRhtX3bDqfT4Mzv71sHcvd0YdRGDUw+zmItQSrXa6a0MDnlAUjsIRxQnCr+nZuFYrq8h0SNGypcQ4LMlYqDFXxGKdiDdXQTdeVXWbEY7uCnKBdR8TfEIv2dLQcRDDWlZmOKXncb+B3tt0VK90mOVLyTlUSJYy/Hzqk60QFrcZpToUONxcDPcxeybqgrCKHzOspbScF+8pMCicZy5xwMjHebYLU+78vRKdOwnhZw+hdecQYAqYU/lZyqBqymRLoVeSLbj2lXnYAdqo9B8zdKx91k0E7gaFXxIoESWGamRfhCou4Qmbv0O/0BSPV/+V7OXBuuHGCCxCl5On6jQk+7zbuU4WGPZdm/hNlaxrHigLYwl2Xy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(39850400004)(396003)(346002)(8676002)(52116002)(316002)(107886003)(31696002)(16576012)(31686004)(4744005)(4326008)(36756003)(5660300002)(66556008)(2906002)(66476007)(66946007)(6486002)(478600001)(86362001)(2616005)(956004)(26005)(186003)(8936002)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JjRLmHWOBsImua3kCkTy6kbiD8O4k4C6XUZcaLNaDk68F7cOlHnJGAN/UiQokWu5ZhdvtOvpvRWzjlDrj1DS1LaMVyRsFAcz3Lpdf8iOQMlEr6oAX9Amobdn7lYUPJCkCLoNPLgyJnjhdw0r6fhoinzZNZzdKWCQ4z6MI3CToPoKoYGjabDNGmMOhyKtpiiUWAQbPJqf1rl2GOf1ucdX1uD08P8PUkSbVgRZfMRUN5jAF0riK+Jd9QrXUOiKAPJxe7h5f2OOkEyAsuHxxO36X4dWRd3jrm/ddsD9Z2acDLeGQEkEoaDoZy45mdxn1Pf7pKLrXBQzJ8mIiqRHIggHfy2Pfxu+DxGGS+cUiVlfMX74cnMOrzE6L5KVQ8NitF9w6FaWLyqQwFiry7JOAv5QsxPi3qthvnee+pzgDKwrgKXblE4DEmY9BOWKB2wxWUtwdR9tXhjve02glngaZ+zMmvGseGHfcApPg4N4ah953hulruYJGwCQq4Ntu6SjCCy2
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac20376-7c12-4813-f8ce-08d8072babb0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 19:32:21.9769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQvmAFOdwqU3UHFgCECIk606eGdK4p3qJ9ebX1AMeODMoNkCtsiemFU1w9Z96Iy/7ev0nWCWbqsi5qxcslAHxD+5W5igqnghXzZ4NDVPYlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.15.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 15:32:22
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.06.2020 16:48, Andrey Shinkevich wrote:
> Let us differ binary data type from string one for the extension data
> variable and keep the string as the QcowHeaderExtension class member
> in the script qcow2.py.
> 
> Signed-off-by: Andrey Shinkevich<andrey.shinkevich@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

