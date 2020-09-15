Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF99C2D0E0
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B74120735
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LxSaJvmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B74120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI81L-0001Np-8l
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI80M-0000fF-Nj; Tue, 15 Sep 2020 06:16:06 -0400
Received: from mail-am6eur05on2122.outbound.protection.outlook.com
 ([40.107.22.122]:8673 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI80I-0000oi-P3; Tue, 15 Sep 2020 06:16:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vzo/Pozzu4d6WRCojgknGgHK5fBcx5Rh17lTe0N4BQm3yLIlPClWMfDavrMRN5TmtUZi12MRauPCeRQ5GYXjqorE8njaMObR/hsyxhn6XlAPpQVyXlJSQpqBacPlv3YDQyoHWo5HpvdMpeV3/tjOX3bc9nf/x0xPxDRzrM05gvO/iVCHz74tphM/4wX77/50Ap96MwPcDtTgz756d5Yw4A9OpvsnKVjh+EQVsjeVEvAtYK9iJg6hxcB6R7ADIUTkVveG9BjmS7Vx1cHflNnuksA+82alPZ3fW6SUhOejEdm9j/QCW4EMENkdERXfFjCDroN5ZN1/oXpVRywnyfaiCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLr4nVZZAS4T5L3k3+xzJioHzPXPuCJIH1g14+zzRKM=;
 b=kT0amurivQpRUyUFgRCo5iHkmPym6/GkyBqUjdKBD8OGfry1h9lMq5m5MHzPa7WJYFpYGnFBKg8jVQNzenRd89O+8R/raq8B+LLUjPVsnHZoMh23uYS9YbRCKSwuvwFRcNfUptoBoGDpkL8d/jhFVOros4DgQEHAsbezy/ry4xKNz8Nl469kHLSuSLQugPksCWrMT0slg8qM1gnNoeSscfbFOwz6nsZXAhpQPmNFdo5erMK0kIzC2OLe8xdqOzEAfg0U+CA7fK0VxpKH4Ikud+E4HTPsceQSOxgft7648eZI3tt38d73/2C8toO6YjsC/ZL0pOtwOlw7wNTyZbIknA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLr4nVZZAS4T5L3k3+xzJioHzPXPuCJIH1g14+zzRKM=;
 b=LxSaJvmP7Se20X/6CCih5oSeGWOLLnlnTmXGUigBJj9/sYpP1U4smne7Tp/BPaJzh6xsC+XH22ApXWJfcCxQae7nMmP/FfUgepW3OEH6TXqKF80S8vgNQVI3h6dHnGiinGpQGYXfUfoTsKalcSTYtiIun3AMRpxP2kZPx31TFf8=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3222.eurprd08.prod.outlook.com (2603:10a6:209:43::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 10:15:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 10:15:57 +0000
Subject: Re: [PATCH 07/15] spapr: Simplify error handling in
 spapr_vio_busdev_realize()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-8-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b5d2510e-a002-20a7-06ca-66820e5dd02d@virtuozzo.com>
Date: Tue, 15 Sep 2020 13:15:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-8-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0128.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR01CA0128.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Tue, 15 Sep 2020 10:15:56 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6393d80-2ace-4b15-0191-08d859605653
X-MS-TrafficTypeDiagnostic: AM6PR08MB3222:
X-Microsoft-Antispam-PRVS: <AM6PR08MB32220616247CB35581D9DE16C1200@AM6PR08MB3222.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2xDLUjOR31l+RfQzYba5HlZZ/mZByXYLdyq92FV+/4XjF/pf7OD/FVyeG4ZgA0bE9G2Qj6X8bSEhSrUADI/tOX5iLvhzoDinH5flNp9GhzDIC/bMIPs9qdnLlj6yDmpavxIAIgPNUCohcyL0HL7X2dfEmVedLmRvMRRpZB5XRDY3D7FQ2aa6v10RdKx3zF+YLsr6dE6iW8rr9/PJ0YZhGfXm4AuvVIBkimuXOKmrJ338uzweg7YuCW1HZHJvbJVBOTxB9c/DcZ65Mz7OJ4Hox5Ge3AgDnIX9il12IQ9Tb11Gn+bs3tLsnnhkvU32FtnEe4wB5yK9gxnnQcUAkBP3AW1ae1F1VHMFSfCPYQGbylWhf4uSj3GTjdix+NtDVc3wdnpEveNpoCxjiH5oPwU3STs+u/1UTHPEJ3iYm5U0iOJeorqVJiVEJSyFxvLKX7m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(136003)(346002)(396003)(376002)(52116002)(2906002)(31696002)(26005)(54906003)(186003)(8676002)(16526019)(86362001)(4326008)(31686004)(478600001)(5660300002)(956004)(2616005)(16576012)(6486002)(83380400001)(36756003)(4744005)(66476007)(8936002)(316002)(66946007)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DitecbiEVlVjGJHgjDsCCyRR8UnCD0vQVyAeRKir+WbawiqrfctwsZ78wuD1cXWos6coexwh97PQnuA3XQH7We/H8eWZUlzbAcUX2eskhu9AFqnEjBcXh1h6nNhi3v7jxPY280A/zPfw7NP2+NODNArr992ojq2OIS9yuuyrQI2+widg1EapcTmX+urZUG5J0UheRkwq6BY+eG4AazC4mvtRlVCpyaJUgCmrWn6DzJC+TpVHMfp30ipjD8JvMFoFcbBFzsoXmWjh7lQAsN57qWUyolfqbsyym0Ip9iPK75BP+S+VHwwX/yRP8YMHY5wLpAIIMF6jByFF+fafdDrxUUHrBbZhgYDNlTzORtOHVdMLNQ0Udd/APW89Jps7FkOtliSEuQhPU7cOrc0qDKSnFe8Qu5YkbSik2fH/evsGgeoTP26Js8sPdEiZDmQtMzmO4XcqHsuBoUIRVU2CbpHoM1PFx6DjmKfSPng826yNH2R8rL5+bf7M+QmJAG5A026YzEr4/xHQ16xurFz8nTTypWBOwijrBYMyM3McSPj9mwwrISkFmZNDaMy0ge8R6s201WtTlgmMewf1Ls8gSmnyNtVcQO5ru7j+zC0Mb7XJirb9sywem37fBPcupzimydQzbnbHOYnDbKv0ZYC5G5cQpw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6393d80-2ace-4b15-0191-08d859605653
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 10:15:57.4949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDIgXlyqQ9YJkUEBsYxXVsbTB5Sd9Ni9J4KWuTCuzPSMgjv3LkxE/EliZPvvt2bE8ltWtpbtYysr+QxUqsS7hB47x8j/8YwhDH5zf49BkgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3222
Received-SPF: pass client-ip=40.107.22.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 06:15:58
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

14.09.2020 15:34, Greg Kurz wrote:
> Use the return value of spapr_irq_findone() and spapr_irq_claim()
> to detect failures. This allows to reduce the error propagation
> overhead.
> 
> Signed-off-by: Greg Kurz<groug@kaod.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

