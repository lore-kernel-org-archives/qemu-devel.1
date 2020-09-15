Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DB1C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F15A20735
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jMxwG9et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F15A20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8HS-0001P2-Cn
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI8GT-0000TX-1o; Tue, 15 Sep 2020 06:32:45 -0400
Received: from mail-eopbgr40113.outbound.protection.outlook.com
 ([40.107.4.113]:8449 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI8GQ-000324-La; Tue, 15 Sep 2020 06:32:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgg/qlAunEnfEUGH0JuKNnkAoVG0Dh4Wvsh5r753yJzSzp8pDAuymG+ptCS53w9CaE2h0iMquBHib9t5sJ4SBTJQ8WOGlgCUNMQe25fVlFcpWKZIQWiZiy7sJv9eJzErunUJ+Kw56w5KqKo33ULLd957EsecqBWzuyR4jDy/vJfTxwTBeq5bTkIXGo21ojcnI/0hk0ACf7Ehp7450YagUGTwDNM4c5UTT+XclRgMbiy5/XZWDs95f/9n2DQNwOmeC+hatwilk9mPq0njSevFWhkgVBNXAHZgdAPsK0eHyw8vUz8GRbVzriLxyfIZaTLpubdbyOLT0jp/8L7zvPlbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynBohAISRB6n/F7k8omEo3PbNn9G3knn9nr52N8FvTg=;
 b=U2EG147Es3TxTVextJB1dvjTXTb8TZ340ZGAiiPQ3skJdDQyZYjKVV9kO6kOi9dEi17/wSvIk/DkMe3j7MfbGHDn4KnyewLtkURE9xr5hMknpX/misTqwpYEiUHffkD8451DfjUfjII1pIsofHTeUSrGYM9QO9Ut3HRHSzuVdyzbDBFeA85Z4dN7lcKnoqntkB0bIyrUmZ7Jzv0TmeSL7XUS5eoG1DqAZ58LQ7ssH6l55CyRxw8pztS37oxOrkYZXlRaUco/VeML1nFMTvDcKDdQS8nEUjd07Ppo+uu/gCPACXd0VaGlJH5W/wki07JMJoUn5+cIGOQ/xiYQJV9nrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynBohAISRB6n/F7k8omEo3PbNn9G3knn9nr52N8FvTg=;
 b=jMxwG9etanea8pf5KuMl5X1FPn64K4d2lkIu1Ewotwl4fdUStyhY/AODCPBnvdlFLEDJw1FlBKyhvo5aSaxqz7+kgxmw1wQm9tTg9x9BMdkFjl4760HO31O9psoTQ+ymm3yTL22yvVdohfyYtcEtEZVWAvOVxs2/Nb9j6su0CAI=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5334.eurprd08.prod.outlook.com (2603:10a6:20b:10b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 10:32:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 10:32:36 +0000
Subject: Re: [PATCH 10/15] spapr: Add a return value to spapr_set_vcpu_id()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-11-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c8d62afc-ca80-b22e-b423-42d7426595dc@virtuozzo.com>
Date: Tue, 15 Sep 2020 13:32:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-11-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0094.eurprd03.prod.outlook.com
 (2603:10a6:208:69::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR03CA0094.eurprd03.prod.outlook.com (2603:10a6:208:69::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 10:32:35 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9cdb828-eceb-4101-71a5-08d85962a98a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5334:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5334BE4B23B90446F7A303B3C1200@AM7PR08MB5334.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a66xn0QEwRttHoJbNF2vGqVMTHVgNrl0KdonNpzl6uhZjtD8TTl0vMF4d7GLFv2uvh+ZY2Joj3dz14R1AzVCKWt3SoV7t2FFBHjCcmgPlh4rRcXAeck35bQtYOysAUPjpX8G/mjIf1fjXZVqTMc23E1EMmJp5O1kijRdpsSVqfv5EeJ5XWC3wRGS1FSv3pdAan/Um2gLLdyyb98ikgW4BYJgcp+W8cOH4WmgRezLePgrQwU+MuD9WidiHgcIr2sTQgQd7pGJCrW8U7FjOgc+cHzSviwGIsSLyGsIXlPaYfNVGF74Hebumk6A1xOti3xD/RnNueopu19K0RAttCxhXnKUZ9HFIalZvaxLSPFWJzNVQD7ucDE20DkyolsyqXXT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39840400004)(376002)(396003)(136003)(16576012)(2616005)(956004)(86362001)(4744005)(31696002)(5660300002)(36756003)(66476007)(66946007)(66556008)(4326008)(8676002)(52116002)(54906003)(6486002)(478600001)(316002)(8936002)(16526019)(26005)(2906002)(83380400001)(186003)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ezDIh0jg5oYdW5EhqfmXVPp3JLHSFoEGwO3fx9VNXOQXcs+XYjFVdAcMSo3tDFjxLszIh3HR7DNEQ/J7eIT5EALPPJo5Cl97ZKmzFqcSv4vGx2kNccoL2ukvWJQXR+xX/wMOHm1OZztu100+paEjjE2am2kzKsgEcluSD2e8ohm81Hf2o1JJvH6j2OrO0BAq+tbAjBJ9+BUNiowIRtjvC77aZcYIbF6aqgD4VMXPVQUSsNnd8itm1fWW5IC2aYmxjbL/cbQMW8Wwm6tqYeg/RvpscgI8FucpAeowEKs4yRVnJ0um54bEMHx0yFifjcRt+S8im8LAN88vmq0CzS3w+ijxOh93xue2aaOUttf3Y69B6gh8gp/OCpTlmvW6nb4/pbjMXJpWczzVpolCbiI2s5Tt0O0HOvgTTRajHVUk7Qja9QiUrBZTjhUxnjX9njgajkWPs2FRxKOwQx4jgHFwsInL5uv52K2c8ZsCCXHyRxLIMpj3zKBuNFUcQ2UKab579GTbYZ3i7OtsCSOCRZB9BxtyrfKQyiczgRvZG53h/vOELkwKU2/44fCjC1lBJNIFE7pEhS+D+ptPtsL/mxB0HIGPMJnpgcLlaF98gZv7unQzWmP59D26o7ahJsesLeau+h+24vuq9/CyT4NeJ0I7Gg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cdb828-eceb-4101-71a5-08d85962a98a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 10:32:36.0866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcYmig5jJTkO/1BFdey8RUlv+eywDlWfjky+PPoG1nug1DaGgtfTg3bCTpt1q38wW08DHoKzNurdA95qczEAmCgfGcNO5n7Whga2QL0lWUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5334
Received-SPF: pass client-ip=40.107.4.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 06:32:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

14.09.2020 15:35, Greg Kurz wrote:
> As recommended in "qapi/error.h", return true on success and false on
> failure. This allows to reduce error propagation overhead in the callers.
> 
> Signed-off-by: Greg Kurz<groug@kaod.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

