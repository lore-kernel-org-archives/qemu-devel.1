Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9EAC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5820520735
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HuNl9UC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5820520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8NG-0006Yu-9I
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI8M9-00061M-31; Tue, 15 Sep 2020 06:38:40 -0400
Received: from mail-eopbgr30124.outbound.protection.outlook.com
 ([40.107.3.124]:1603 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI8M6-0003eK-2a; Tue, 15 Sep 2020 06:38:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0/XcYuTsdZ+aAYIjESLoNq8Iw28XkPK79mc6Ry4PFSP5CbnCxaR++jBca7oeGlznoiN6vjjKx9QARPLuOR3bbJ+RZg3hdM5kp0jlKT1Nb4FAHPV9LbHjH+myzY9kMyAO2/4QqSVQDwsQIKuI22LbnixsNDbBINixmlujZb1I9aSUdDCmcaaBsqYxiYoPsGV/aGgYXuNBlHfnAt/ZQJyu5/QiHYuuVGEGLx7z3JlN/xnWy8pDnljvMKjac1Yc16/m4qfwaZjpKUDH//owkTdhUf1sStedAjzyJbTo3mZZsVEkvZd/G8Z1txxpWZZtoiJmy9U0TrbbgIBarCij2yxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbI8A48ywqYrFy1M7dygb5HElaoJPgDWatmNndIaghw=;
 b=iQalAMTPC/jX9HEvFWXe5t45xoPR46wrfNuBzrS66eQyDFiod5ruQ/KP5rAsjjoeifVEAvqe9r2MKbacuW+QIzINPB0rMjaL0LbOYJL9VSI57JmFPDsuiK+qQ1laqpw0O3WXC8B6xvCrUu5OlWPj1hF7O3NzAyeLjFGbLBlJ+5WD7tfcGjiY5C/IzmAdiScxYvgnO9wrMcZtmeN1RFE8Y/Wy3kNQ3M2TB1HglQvYIjNl6pYfKdPqZa5We8xqXzhMqcRVpvgqRN9tj125xlr0jwXT1pespeNwpFnQLrcqZsmLsmZVDqd5HIkJ2e7DFYl0xK6SqomISKOMieK9hcnISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbI8A48ywqYrFy1M7dygb5HElaoJPgDWatmNndIaghw=;
 b=HuNl9UC7q8b9wGl663r3sqckPa5IMMLrBurH3+M2wne7Q4Uknk1o9lMRMO4x+HWSww9xRphPmLaLHQ53NbC3Am64efRDHAY9BsA0j6qwjswQrbkRqYPmI/RvESkDgaDWQz7oav+YnyiXeRxYkQ7qtyqOU5m/EHEPAJnTiSn2/tQ=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5030.eurprd08.prod.outlook.com (2603:10a6:20b:e1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 10:38:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 10:38:30 +0000
Subject: Re: [PATCH 11/15] spapr: Simplify error handling in
 spapr_cpu_core_realize()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-12-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <62863116-9e37-7d7a-1e98-83f7ee27a74a@virtuozzo.com>
Date: Tue, 15 Sep 2020 13:38:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-12-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0041.eurprd03.prod.outlook.com (2603:10a6:208::18)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR03CA0041.eurprd03.prod.outlook.com (2603:10a6:208::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 10:38:30 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a455af85-22a5-4305-473c-08d859637cd1
X-MS-TrafficTypeDiagnostic: AM6PR08MB5030:
X-Microsoft-Antispam-PRVS: <AM6PR08MB503078F6BB60B15F1AA64A5AC1200@AM6PR08MB5030.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpSg/TPtIPKhcFqpVbkmtOCYt4e7dwKiVDGBuJSK7UVcWWaI4JZ3b+w82JMP5V/TCYBMP1Kl4g/mLQ5MZ/QcxMZfnwx2pxsCDhnqIV3F/rS0khgt0Jl1m4uEnqoR24zqfncHgll/yR02GVDdEPiMLsdiJIFpjsC04eXiWKMM20urh29lXqoCDV4d2QSrfnSw/Cjhd4tpN9YHWSE3ENOpskJejjdW5tWqfFSqGhmTBVNJt0eIkKOFje9PLeGmNehNRZtk9HVLpw34mbcn8e0OcBPcEPV5yuxwhiKgOjYENpbsH1s+8u161LRUSIUAaKIlxSvupqZ4gvXURVSlb+YBFvV+rglr+qKogdbRmkug9PVz/Jenb3vj2QM2WBnBW+fK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(346002)(366004)(376002)(136003)(396003)(2906002)(8936002)(4744005)(6486002)(186003)(86362001)(26005)(16526019)(956004)(31696002)(16576012)(36756003)(478600001)(66476007)(316002)(31686004)(4326008)(83380400001)(54906003)(52116002)(8676002)(66946007)(5660300002)(2616005)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OXYy7Keptl3yxIVnp5jUsGxJsPbio+uUcuKXtUpQa+3V0+E84M7Z93/sRtmlhjHiondWv008rHr2zOSqc44TK3nmDkqYv930IvlTiARudGaQH/S0ednbORepkURv7siBOYVyYh7FCzyFQhAFQqNY03/2SEiz523d41QE7mkGKb7KqqMhahSIzAJilbdGGEYPE+N3m4wLdZ9ttPVtSKuUrRnWbANydbeId2lpo2zBOGz4mOjdSsxd/6M8uigyXHRsUQ2HRElPQm6PJCwoyhWZNHqWnAfLQ/d8rxdciNdeP5uCpSyns6k90jb6lUajv65MihVeDGPqMdlnzSFEpLeACo+5qyu7ueVMAYFfWgwjZ9rKnvfclfPrkUbsb+o2Pi3lhsZ1xh1Yc4IUbKZQPEoGBPFzAZci5PD1WkbvraTaLkzZ1eAxjoFLrBjm0+pejraX+QqFapYcxal+sbg0Ra5xxWfShdqOEzQjUH4C8IULxepuKjUx1ooty6tL4vV1trMxQBeJH0D2dziKTwf5rQXVsZg2LW32pV9WW8xZqH/VpPDByDUJrWqRHDwzlzQTCWEyOF9kdm+KXryvzGjKEujQJotpFWkxFQCqBmwYUEzbZk2PwjxiUqliiHVn4HshfctxntZHF6McBW5YXoQYjLuh/w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a455af85-22a5-4305-473c-08d859637cd1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 10:38:30.5123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qT3tLEVTx0ymMLFKmErahrdQcI0QafJotbcmSf8mTHuVhVKAuO/XP1KflpOGYu+vOQN2JwRHcT1bhPr/uxpxwuH7cMlrpsDijh3WXaSu+os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5030
Received-SPF: pass client-ip=40.107.3.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 06:38:31
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

14.09.2020 15:35, Greg Kurz wrote:
> As recommended in "qapi/error.h", add a bool return value to
> spapr_realize_vcpu() and use it in spapr_cpu_core_realize()
> in order to get rid of the error propagation overhead.
> 
> Signed-off-by: Greg Kurz<groug@kaod.org>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

