Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799DBC54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423DA206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NkQblebc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423DA206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsbT-0005TQ-EB
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 09:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQsa0-0003cR-SY
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQsZz-0003z9-05
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:04:47 -0400
Received: from mail-eopbgr20134.outbound.protection.outlook.com
 ([40.107.2.134]:63662 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQsZy-0003tw-3T; Tue, 21 Apr 2020 09:04:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abgSCjK2M1aJO8UgGNRm+6VXDL9OdCkbeqM4F9O1xhKzjC1g3q4fZ8WXDDbwSnm0wH7dH0Mn6rz42kR+29pTQKdPew+nzdMkWUvr5NHFn0wKsvZSFBW24mL6mK5SaFGRvom4aquc1M3MGP0M9Lwdprml+eyRlVCnrhxP3q2OMrOaX/aQlanXFAj4oDnnzlN5w3fwflPWU4hVXdLGSJGROqWvZWCV82A+edZKwt2SwYebI2fmugC8SMETL0bdLFjiPe1SoFtyGktt6a22EDB+6ElPXzwWaDTuelzmIFjWxkxcknSXMdKsnMxPyICHpoQQA9tWm5M+aNbutWmUsdZA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzsF9olHd3eTEd+oZLq6Z7Gad+aUBnvAuno+k4yCWP0=;
 b=m2b+jJvR9S/g/Gcu4/SQdEDGM72kC6hKe+vsG1NlsyXREbG1g52dpsSmoLSh0E6QLm7rkdKRS99N37MMbgKs/56rX5d4O1h2VR46ZDYHKL198AqNhzUTJqzW974tAJCoclXIF1AZQN9qAsK+aQpycJS+O17xbFrIUl91YmljA2rNgjwkUkkbXiRGfF+siwGUKkQiywzOCTdOhtpBAuThLM9Y99ZgeefIJEZ40vWg+5/XO7okjAVdvpK4YrfXf+5icE+fsH7YKr7Do6SbuTrFaEP6C7vjdMr32EJcF8L1dhVlrVrz4B3psr7nXqmiUI5Czp1AcdZMLbU6kqM7yAmSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzsF9olHd3eTEd+oZLq6Z7Gad+aUBnvAuno+k4yCWP0=;
 b=NkQblebc8rVSnww6YyMyIUct1sye1MYjwPZELIW7eyejLfLMFRtpAEPNDBNmSt/+e0Pp7A3QTqko840ylNZcRzCFUanB58J8jyJbSJ1bWQVBDCABecYzg6QrGovwB3f9Nr2m81TZ1Vmvv2xOKxryUbsY8O7p0cUk1W1caFHYRKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5352.eurprd08.prod.outlook.com (2603:10a6:20b:10e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 13:04:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 13:04:43 +0000
Subject: Re: [PATCH v3 01/10] iotests/277: use dot slash for
 nbd-fault-injector.py running
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-2-vsementsov@virtuozzo.com>
 <80af4905-332c-228c-cf3d-0b00d098a7d3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421160441033
Message-ID: <7f25ac0b-049d-46c1-53ce-0dd4850456cc@virtuozzo.com>
Date: Tue, 21 Apr 2020 16:04:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <80af4905-332c-228c-cf3d-0b00d098a7d3@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0056.eurprd07.prod.outlook.com
 (2603:10a6:207:4::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM3PR07CA0056.eurprd07.prod.outlook.com (2603:10a6:207:4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.9 via Frontend Transport; Tue, 21 Apr 2020 13:04:42 +0000
X-Tagtoolbar-Keys: D20200421160441033
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb10243c-c812-4da1-9907-08d7e5f48ef9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5352300C19B2A40071F62049C1D50@AM7PR08MB5352.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(39850400004)(366004)(346002)(396003)(136003)(478600001)(66946007)(66556008)(66476007)(81156014)(2906002)(8936002)(36756003)(16526019)(52116002)(2616005)(86362001)(186003)(26005)(956004)(8676002)(6486002)(31686004)(4326008)(31696002)(316002)(16576012)(53546011)(5660300002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +OHipZoL3E3kHBbL7lN7o0MXruRCk+UaCjuSFLd2CxjK5bSssES2Lms37i2Kf9skU4YxHYZQkroagOeFdUiqVVPbZQk5ideLjeKpKGmEZjbA4J+4REGFNy3SWDmW/z5BHgK4JY0QsYYUOskkJ3EMm9NwFTSUAl1d+5Z8OtE26NMvn01c5NRnQUF30I1eLlVfMMFBoyHjON8qc19h+w9o7q+3BC7xEF26jT1tYhvHqjHdLrzUs27+jAoJJ/h6i+vBubKCL/VWB8mjGzSxRKaFxlJPbpT7jN/fzCPLEAR+JPMlCreEX+DUOFxqbUBckdMizS+GJNdT4/Ky8NPrv4+0m2slmkuaJAFqxa1p5aSocDsQk885xyLMg6CjRco9BEMu59iVGF/OLeAUFYtO6trVwlS8Zfu9Lyk/o7ykfySXj/2a0MjfJxUttYba7napKDj5
X-MS-Exchange-AntiSpam-MessageData: qzNEkgHAk4LJWcqVlJ10Q50kixD9KZu/uWFTfMJMhCOjWoPS0gpLEfPZxGeDpBg8loxSNP6FzJKlgSShXxO9bbQItNLpx/aNdZ0n4fhmwB8xH543MWybhv3Bw7TbGCKOZLY1t0mTFbQFxR7PYJ95Ww==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb10243c-c812-4da1-9907-08d7e5f48ef9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 13:04:43.1340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0D9c2sCZs913oFcHkguQDqDNuoZzDY51OnIc0pdTpsVmMiHjfPH27c3suARI8IQShf62DwbsfvkSm9UKmTfZE4LvDHF685RqnAtnRcOOgPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5352
Received-SPF: pass client-ip=40.107.2.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 09:04:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.2.134
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.04.2020 15:54, Eric Blake wrote:
> On 4/21/20 2:35 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Somehow, this doesn't work if you just call ./277. But check 277 works.
>> We are going to new iotests running framework, which will consider test
>> files as self-executable, so let's just change it now.
> 
> This is a rather vague explanation. 

Yes, because I didn't understand why does it work with check:) But you make it clean.

> I'd prefer something a bit more forthcoming, maybe:
> 
> If you run './check 277', check includes common.config which adjusts $PATH to include '.' first, and therefore finds nbd-fault-injector.py on PATH.  But if you run './277' directly, there is nothing to adjust PATH, and if '.' is not already on your PATH by other means, the test fails because the executable is not found.  Adjust how we invoke the helper executable to avoid needing a PATH search in the first place.

That's better of course.

> 
> 
> At any rate, while the commit message could be improved, the fix itself is reasonable.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


-- 
Best regards,
Vladimir

