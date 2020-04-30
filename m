Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B34C47253
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F332073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZgduwrfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F332073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEC9-0007bF-W1
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jUDxR-0008WC-UZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jUDxQ-000832-Vt
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:30:49 -0400
Received: from mail-db8eur05on2108.outbound.protection.outlook.com
 ([40.107.20.108]:19777 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jUDxP-00082a-Ue; Thu, 30 Apr 2020 14:30:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRHP6m99I73ANrgFlkgm5wKqy8sR/vszLUVpkdagPXzQdev/ALFp5/vXYXTPgMla8OSpH/ch/JN2op7SYfOOMQohw8j7XWV21ORjPPD5R0vaTBrapQHBo9bwHe8zWEFq6EclSWYFVBU1/gVhKZI4pFh1lq3j3EytUtNnEDjVHntku6t64qkzwAF3KJ5sD1FaRYTQ/Uav/4nPbj6xVfhpQ8bGhxt2WjU7oOZ8ObCbusVYUbp4pAPAR3xFbBjPMYpF4Fxc1ZnuiOyySJOIq5kIBrd0ljb71ZSMXQkriwGKw1NHVevJ2cv/YXA9ThuX3ac/HwmOBmQLOEwK0A4D9ZFwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jehl2i7GQpCljmCTN09j94Z1lL3aCcRju2Y6+wDtdYE=;
 b=McO07zeeNRJRzHUGvbmgDEw5gukgD84Bdvm/Z5JAmhqOe9bLVCroEiY2VaUNbEYBkfwBT3uhc59FfClgo4LgToWW5K3CPQo0YJtOQ9aH8vLbE3rQiEwaZMoYxtmE8sgtaWJkJ0YzlonUfT+jkv0B52QvI2Rii6m7xmX40a7vRJPOA8OxHbqIyS9DAaL8UziRzQwngmtFXbErA8cnCXF0DtDRtMZic9vnhbo/MArLPprm+vd7Emu4beaRzR8I0zV2b1qOM9i3/lVbRp9RmO7bZXwOFgW7xF+fEu9sFrDJaa0sbgmZsSHzx+aG0I/eM6nelGXiFJni9OY1KFK5vUebnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jehl2i7GQpCljmCTN09j94Z1lL3aCcRju2Y6+wDtdYE=;
 b=ZgduwrfI7DJK8mjMPE8ew5Vz63fqK2AA7HVRR7Pre9QkcSCbLyekqIV7Mcd2oz4+NDRoGwo3j3kXR5LHRF4TZjpxPUg/C354cRdY/PUJt+8R2D0U+qa1UqeAryzKinuPXLIHEBLPtvuwx7zjLere+5Xf0kGox4QehGeLBOHUXeU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5479.eurprd08.prod.outlook.com (2603:10a6:20b:104::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 18:30:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 18:30:44 +0000
Subject: Re: [PATCH v2 4/4] iotests: Backup with different source/target size
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200430142755.315494-1-kwolf@redhat.com>
 <20200430142755.315494-5-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430213041888
Message-ID: <f2849004-31c2-9177-20c7-a549f21f4c60@virtuozzo.com>
Date: Thu, 30 Apr 2020 21:30:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200430142755.315494-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0134.eurprd04.prod.outlook.com (2603:10a6:207::18)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 AM3PR04CA0134.eurprd04.prod.outlook.com (2603:10a6:207::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 18:30:43 +0000
X-Tagtoolbar-Keys: D20200430213041888
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f47ec237-83f3-4ded-8e40-08d7ed349810
X-MS-TrafficTypeDiagnostic: AM7PR08MB5479:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5479CFFA00C7459993E6EFFEC1AA0@AM7PR08MB5479.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiY8Rcvpd34nrll5aIC0NwRFFsyu4HtZaVZO/2qCE2YC+eRfn5xnYfl4QYYu0HHGpHkL8CBH5qngaINJzlXaWmAbG54j5aEPz/kLkSjL1jBxFsfyTqeG1euuZo/DoyG/h7PMvmOZp8ZhAI+6azZr4z1ERoZSgZ9KIo75s2nc9jOkxe0y7mXmgV8lhQ3DdJ6UIQZS08hm3ZxwTrI/t/IHQzXFiYSkVAjHngC4CZNN2jHO7C+5sxbs7n1CMhhNrVJkniv5G7rp2zegSXGt43+vnyJn19vqxcw7XV5xjpOSHauJhRBA/b2g+5/RZ+4hzuzZCoKBHyutEElfqTMdzY3RWi6xVQKEqerUQZ6W0ZouXpdG1olLHWKHxdb3q4WLo9Fymozdcce2taXqJ9QMM2jgD3XqY75z8GjWOpT1MTTgEfKXAukWvPMZ3kPBloSlNJlz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(346002)(396003)(366004)(376002)(136003)(66476007)(186003)(16526019)(6486002)(36756003)(16576012)(8936002)(5660300002)(316002)(26005)(4744005)(8676002)(66556008)(31686004)(31696002)(2616005)(956004)(52116002)(478600001)(4326008)(2906002)(86362001)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8APosVoj9s4nkejw1k5+jnw51z12U6mZKo4W9NClRW0SpyRxF3MZpk9rf3p7XLwnuI9tAH/oT2Tcc6PdLQG3JsPFTnnT4Bh1tM89d/TWyafrxTdd3o0DN2XS5+DY5FZ1RUtKVO2XXM6+Ryy0UHcVho05XurSSFnivQHX2NYe9w6h8bBK2GdKJb2hTyNCN0qKRigAShWYTrdNqm5594ErZcxj3gzME/4H9x6foaMVqKN3ub+xMIxNY/c3a6Uw2rSghlfYGYUlgKEkfUjA8BDQO3/DD2ZVvQLMJ/NjTgk7cNgcHsbye2RJWmTRrJet+9pJuD0gzrrRdNIesOTFpDlx24ROXEAtThATXr0iUR0yy0xdDa1bWWUQwV1HOMcC48GCjQ/pP+JkJOa9MrhIJJqim7d10SIgoBeq1l8wTQbTCUo9+QhwQxhi77XcsuBESg1jDFNdszemqkz7dSC/ZmhyTveI99YgUnyRSx+ioP5wNJUzlGxr8tfZQHzfn+kOjdzcS1cI9S6muwWZKOkZrayYPxYmlJAaPKl6s85RAQBUEOUk82chkSE+EKn3kpUgId+Yj1ShaSVnSUOzyJ7d04GgeEDIE5RFfoaMkcYETm0LLZdqwHs78pSwSSbLEUzv2Wao0TtHrxYA+8qUwxQ6HPc+NguOfdv9Am1X+nMSrfqFUmqceeUbKKlMQXRfutgVBmvBn/bnrO6fEMSDScdH71vewwcbtgYDn1s4MDlB9yAPh4wWJuV/8MRpYdkbaPR1Q9Dyg5wYM/yRJ0fcr8xSTg0FYZr905ufx0+0NRT10Sk7ydg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47ec237-83f3-4ded-8e40-08d7ed349810
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 18:30:44.2374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mFw4VjVZNJRKOUB99rjbVuuZkOsNyqeG/Cq7ryzDFy1lN7or0pwe5tNADoj6xjIFiPqQfZvaVA1X/z3v7gY74NM1j2YMBDEkMGyfFO/VBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5479
Received-SPF: pass client-ip=40.107.20.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 14:30:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.108
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.04.2020 17:27, Kevin Wolf wrote:
> This tests that the backup job catches situations where the target node
> has a different size than the source node. It must also forbid resize
> operations when the job is already running.
> 
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>

Thanks!

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

