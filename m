Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D070C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D188120771
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YAK/DHf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D188120771
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI7se-0004RJ-BA
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI7rG-0003rX-DK; Tue, 15 Sep 2020 06:06:42 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com
 ([40.107.4.92]:14403 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI7qV-0007lu-8G; Tue, 15 Sep 2020 06:06:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYuA9BaiO/g71Yl5H+1/V1tO5MULEC4TnQTKh3bfdmecOeafxJi493mNKvyydDWadzzMqHaW8T2Th6xlMuX4dFFSdi9b1ugcw3x0d9dCvD0wUCStqb2nj4lJEqygF56Grl6E0oMkP/wT4AiUDg7CVpkpEyAEsvzTd0ryn/25ShggqVkw32YPCQsyFDfvZqaWxw3iAMPxDayy5oXlsQc5fXgtclVoTpRAnbjPaf2mPlD/kGngXRlBNbY1HUp/jsYNVxccdTh7QNfVcO38jAud5NMBTaTocOvFPeU7TCqXc8SKiSfLoDLonoxMSibkV66P8PHJJEUz5mhJo7+xZ7D6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmhfZLEo4e7eZBEN9/QZx4LuJdvR3UyFKUFipSrtsIU=;
 b=l/p4piAjNy0nyrQPj1XAuvtSqnlX7MS2Cugo+ZOGm6SD3/1cSi6zt9ubOFhXpHw2radIV7Uo8JgfWYzWEQQLi5D0Jp/obuqV0w/J2REc6ifuZTt0stEZP2lQi0Ipulw0c6bDQVy9sBrK5Clyg+SnvX9Yv3EigXsOh623UmeCymj5jHWcKofaeJF6ecE6ZS6jnjoQhAKboRmeTW+l3V8wDAIi3cUtF3tA6PCG6HfaQGARX8892bTheUmHFznunhN8kL4ctHd1nbfIuZjMpJ2mrqlQzIhLsNzO5IGs/F7W3e7QqHEc5jQEKN3Ht6/w8ftOWa7MMHuG0R+mNrB3IyugXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmhfZLEo4e7eZBEN9/QZx4LuJdvR3UyFKUFipSrtsIU=;
 b=YAK/DHf/R75W0ZJTuL2kUFXmRatEikf+Uj4wi/+SiN7i4QxR/HEaHdky1ezHOYrN1T8+A/s89wOI6doUR6zxITuCYT1MXjsIWOKH5ItYhkEW7RCc3CdCd6maAHYJFMamzqrilpZemCfduGKRZ5tm1VgYOTDla4QRRm5WKXecq+w=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2452.eurprd08.prod.outlook.com (2603:10a6:203:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 10:05:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 10:05:49 +0000
Subject: Re: [PATCH 06/15] spapr: Simplify error handling in
 do_client_architecture_support()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-7-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e97b7d2d-1f2d-677a-9132-65ee1bb904e4@virtuozzo.com>
Date: Tue, 15 Sep 2020 13:05:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-7-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0006.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR10CA0006.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19 via Frontend
 Transport; Tue, 15 Sep 2020 10:05:49 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b82d18d-2ffa-40a2-cf99-08d8595eec24
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2452:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB245268B8BDE6DC38DF328CA6C1200@AM5PR0802MB2452.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cK6fxbC1IQ1aYh/HPPRFnu0EfRZwJX2A4Og2lx7LrIOXGx2WkG/x/WOolo+K0JSSJfJjdfggafmvGpl/C2eHmhfRlkMl8MBpnpQPxz90qAE0yAzEyyd5QeDC4Ium5eqAWUDgs2c+o/1dEWz41zbnbAoraNG8kiighJ6dmqDsve+mAPiV/UEb5I1pepguUuTzJ3hWowGWGagdljEWWixSk0ycz6sOWKyW2fhlHJTDoMWzwb+lsMUPSWijD3Z40HO1+kQQFEClB3l4bW2mViXDIII4p/fGiODm30N3TiSNtEZTvS5dnNHx7qHWPTZZOA1gj3jiG/bQkpX9niy+ogvyM9DwCYhYRQ7Ex9iVtKoD+hVvOLJHasF5WivjdmcCAkGZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39840400004)(366004)(316002)(8936002)(16526019)(6486002)(478600001)(31686004)(26005)(2906002)(83380400001)(186003)(31696002)(36756003)(558084003)(5660300002)(2616005)(16576012)(86362001)(956004)(8676002)(4326008)(54906003)(52116002)(66946007)(66476007)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8tScpD6ERKsofLoSrTi6oLWndKBa6V2mwzFEJv8lvYvrn3wTs37iDgx96gvD0Ro7Wm/QBn/MPqwJwB6Prh3OJh7C8C6D4ek1kd87TbF6twN2/xLVyds6s1FendVZ1OiXmRavVkATKMZSJOE1xFjVCRr6NNYvHmP/HfwzhnKxadUC2bOwZgrmWcq0At3b5SUvjos3hFt6g9Di/0rSIlVxqTkIITYS+8srkW1dasP2+sDQ9iMkMeH08OmWvIpihD8lb46RuheFibjtY+y0A10mM7zQOtVFIj796W3maRZz8d0GR3WDDuq5p78OuYvT4kV0G+YAMqmcRcTAZSpfDJmkfy37prZcDngHBBJGWY6CzNnJTlVgHSqXwwmnN+YS0Sfzz26GYKz7xF8fJCI3oNownEe9Ds71EAotmdv0UPXdaseBd97GD0j0g9tWMbQXi+qvMVZEFUUqVAK1iVxPl8kder89N1+GpPn8A309AofGrPoA7kjMRwIGMQQTwb5VOjjmxJQCHD7AAnLSAjRcRBo/cqrkt32+uOXeCZsc5BzNDzdcev1Z7T41HO1TFUkrtODENKZuw9dhfgHRDGv9lH4mQF7sH50VTnQ/agC+6/xBiOMnrhK/vPd/KpbbmGTwsvboVKr6l7hgjvm6aOCHBM3L9g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b82d18d-2ffa-40a2-cf99-08d8595eec24
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 10:05:49.7743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaMjRj+bcBbVvPDRcQidsDSBSmyZ4iatpKfQxYREWj9EHwubAmmDU03rK4c3j+9ndpKo9phTxbqeaOQr+m/Sy6Pyg+PR9Ou3iUxydHXodC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2452
Received-SPF: pass client-ip=40.107.4.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 06:05:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.09.2020 15:34, Greg Kurz wrote:
> Use the return value of ppc_set_compat_all() to check failures,
> which is preferred over hijacking local_err.
> 
> Signed-off-by: Greg Kurz<groug@kaod.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

