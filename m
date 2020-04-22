Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75237C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 05:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C06C206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 05:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GSNixXAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C06C206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR7jU-0003jT-97
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 01:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jR7iO-00036q-Hk
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 01:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jR7iN-0005pW-56
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 01:14:27 -0400
Received: from mail-vi1eur05on2106.outbound.protection.outlook.com
 ([40.107.21.106]:41056 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jR7iM-0005cd-Ci; Wed, 22 Apr 2020 01:14:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mz1SyWnVidUoxkeVjXp0ujKumJWdc2r/ZcMJdUs8EbJDjfLqwfeuI6dBfVA9fo3RuOvDsUzXdSpfa1Nbd+5ZEGSIjadjUaQ8polsuMsAjox8LiaaOBNPHJqco71xVBaiJq9SZjULoK7EeK0ud1AZohgF/b0u97G8+srB/7l7rQgN2hPRSQycQA215zMll1g+tl1rk4rNahFH7OnzgVOjKXnOSXCDGiX74OJt3tCWiLpfLp0w1T3MaEyTP92IGTYjvIbpLiVd3dqT5OolnZvdQbWDnpj0UEzw944R0+P3JWHpX05x459/kKZw9EtphdebfbNJVE8DXvCstAb/cUYumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzf0qjMbLMnQ7Bhx0+IHZcLFy4UgHaa7SUD5Wp0HQPw=;
 b=RpYE82oUs1JDMY+ITFYPWFYtO/XPrC1EvY2d3rxXwrVwSoDUFPJfuPQV+y32/TXmqWs8SMIVtOOGuvZctPv3WjwuD9eo6qNu9RZ0OddnHPC1L6ESbjTSzPO4ixQSmF3AO+ASVl/824pRHCmvkcDFouHsDROjaAaMzhttULQ1fsPw1F/FeSN2ZTqPlsz8SBAyVmGnDX05W3LVZelQ3veSySxyKu/XxKjviOlCnXzC/B83PdMqODY2jywpiHRpTG9Y/CnqAulZFGfy7OOcekIe6RC3xIUHHiWn4hyCt+36B2rGFGjqOo7NvZojiKm1UwYHX2xPbZOmaMrTqxQ2hfoDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzf0qjMbLMnQ7Bhx0+IHZcLFy4UgHaa7SUD5Wp0HQPw=;
 b=GSNixXAjHexyrYH6zDJy5Clom6DPQ6Dpirsd4FXEgy7DZn3ANA/uPKx/zaKYf2qsbr8HxfI2Nay50dFujUnlzs+CkhonJRRXZenyIloC45lD++oxiBmZvVmmTU0vBmkuF5b1daXcNyzz5YqM+AoqCAqPYnStbG5Yx/E0UhZqkok=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5320.eurprd08.prod.outlook.com (2603:10a6:20b:103::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 05:14:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 05:14:22 +0000
Subject: Re: [PATCH v3 04/10] iotests/check: move QEMU_VXHS_PROG to common.rc
To: Kevin Wolf <kwolf@redhat.com>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-5-vsementsov@virtuozzo.com>
 <20200421160335.GD22440@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422081420266
Message-ID: <6af6c36e-fb81-f304-b3a4-d5d8f3921580@virtuozzo.com>
Date: Wed, 22 Apr 2020 08:14:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200421160335.GD22440@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0068.eurprd07.prod.outlook.com
 (2603:10a6:207:4::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM3PR07CA0068.eurprd07.prod.outlook.com (2603:10a6:207:4::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.6 via Frontend Transport; Wed, 22 Apr 2020 05:14:21 +0000
X-Tagtoolbar-Keys: D20200422081420266
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 821348fa-2f39-4cfd-ace2-08d7e67c0450
X-MS-TrafficTypeDiagnostic: AM7PR08MB5320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5320B6714FCEFAE665DB6FFFC1D20@AM7PR08MB5320.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39830400003)(136003)(376002)(346002)(396003)(6486002)(4744005)(4326008)(66946007)(66476007)(66556008)(5660300002)(86362001)(36756003)(8936002)(81156014)(8676002)(26005)(31686004)(52116002)(16526019)(316002)(16576012)(6916009)(478600001)(956004)(186003)(2906002)(2616005)(31696002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STiA2E0y8wDfkeqvhtylI2XqpXaEqpvaBVCBr01k7gkWKkU1T9bDi0Cwao9Uzt5lOZrPyRFTIjPJKq7sMjOAGDYrWdiKSDZS7+olfSwZSbgFvJ69tG4438ezNLnbMP35AH6TNowaB1qwSuRzZyn+MmxnaH8IIUWCdGBIJDKXbVud3Z0GEpBZbv24dSn+nDqN36fhpyNHsSifrEbGXZIkElCH1EDlJwm1tFkXuui7vTr09FvMUGbWv5gC5dgfdZO9uAFnDlZjudw7B+n0L7rkVZDd66IuNq8JpJIDxlpbm/e+mUofuV2fc2ypECstddIP2ZKBHBMgesKwqhEbwiu8e/3V6bYFys/W14JS0Fna1MPcjplqX0eLFad1VphAyQMlTJEBfiDOtal403aIFys2NspAHdW1xWHA3XxEYO59vC4LOQLBXXnJePk2Rjdw0ggJ
X-MS-Exchange-AntiSpam-MessageData: eYBkZ6t/G24ExnwRDMxzjIQopE1I9880MPRu7P3fSnW+cKi4EIxtG0TYZ030PzshKWNJta86UcV/OaXXp63na+VuBE4hBVm0XOayRvfYWIzWwlnU9gcZPp4/5tsXa9/UCcVF0hwtWxTNjq+wLRGy+A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821348fa-2f39-4cfd-ace2-08d7e67c0450
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 05:14:22.2896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWgTB1fwRzpOQ3oCKhsN2ZPhdvakvSmjMf+MgOm1ezbMtOsKvEWgqQf/Vbdikiol5zblSyjc4M2ml4UEblxAGqIY0C/R/VX6VmgC16x+Qlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5320
Received-SPF: pass client-ip=40.107.21.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 01:14:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.106
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.04.2020 19:03, Kevin Wolf wrote:
> Am 21.04.2020 um 09:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> QEMU_VXHS_PROG is used only in common.rc. So, move it to common.rc,
>> simplifying a bit further conversion of check into python
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> This feels inconsistent when every other QEMU_*_PROG stays in check. Is
> QEMU_VXHS_PROG really so different?
> 

Hmm, I was just too lazy to understand set_prog_path logic :) If you think it worth it, I'll try.

+set_prog_path()
+{
+    p=$(command -v $1 2> /dev/null)
+    if [ -n "$p" -a -x "$p" ]; then
+        type -p "$p"
+    else
+        return 1
+    fi
+}

Aha. It just tries to get path to the command and check that it is executable.

So, in python, it probably should look like simply

p = shutil.which(command)
return p if os.access(p, os.X_OK) else None

OK, I'll add it in next version.


-- 
Best regards,
Vladimir

