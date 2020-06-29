Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFBEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:17:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679BE23A32
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lJsMheDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679BE23A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprmv-00077z-M4
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jprlU-0005pl-EG; Mon, 29 Jun 2020 07:15:57 -0400
Received: from mail-eopbgr150114.outbound.protection.outlook.com
 ([40.107.15.114]:49806 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jprlR-0000Za-KK; Mon, 29 Jun 2020 07:15:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iI/ydQ6gcONchVizv+hN4DI4Fj7fT9KHtOYx/o5g9GIRr6hvOvOqVexjq1Az3/D+eQfkegBcrMgdYly3UyzrK2wFngqTI588u04qI6S6xfCZjT3lVHBJpOMqSLaWIVqIZfDAxn0cUY58bMH76Gk0WEeC8g1CeaN5ibjgxweGgB/wFAM5xNXG2qq4FY8pBss2XMlLdGq7WYY5W5BKuAda4mvDty9XalRNM3DRiS/24ET5aM5FAsHYgJ42VH32k0XaI3vscLZRaaBYZlfhgnXI1tldYJV+9lTSE4E9k4/09ckl3omSkXvgftF2L6o2hIHcReal4HIitzZLbmI25htSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xRb+WMnJ+MuUnvWNqr2W3USpnc/Peprbyb619tRC1M=;
 b=H2vEaLsipO0kE7cVuxSPXPL0zfMgxytB+uTkqcVmRf4/kfIBbpILwfNrxQaBFXcw1K8oWfucMQSDKVUoXB08V9bfAjWKIUho5VmWP6SerdpYXwaajVShJ/cQrAo2jwj/AMD8ROzLxyHdyJw4gb9k6iE4irE1+bDp31NLR9rVCSuRT3t4SLcY9mxe2sE5WH6x4JXlRF9JTXoI+YkniBP9fWpYIMUfaGr56EkghD8H6D2ESSwQCP7lxBc6FZ0v7LzkqKCSS7zn9sQU5jgLjLrQgahJyY6IFWgWmw0+Llga993m3APFeHeCm+IsdrWq0ndhjRb0GXBycWrQJWE4Sk/aXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xRb+WMnJ+MuUnvWNqr2W3USpnc/Peprbyb619tRC1M=;
 b=lJsMheDp48VK12Wb8gJNtgaOBxMiZz2LfpbYiVjKnC7psb6m927dHyM9UbhRyIS3ot3vpTcf2DwpDnjg5q1jrZstIKI1xg5y4G0WlUe6ntck6/KYM8ga/wpCSAe4CCJWj9DwamhEs72WgXO/MxbpHUFJ2RlLMA70Ipv7YHyo3Zw=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 11:15:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 11:15:50 +0000
Subject: Re: [PATCH 16/46] qemu-option: Make functions taking Error ** return
 bool, not void
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-17-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <06e46718-238a-7a87-effe-eb2e0a3b3eac@virtuozzo.com>
Date: Mon, 29 Jun 2020 14:15:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-17-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0902CA0022.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 AM4PR0902CA0022.eurprd09.prod.outlook.com (2603:10a6:200:9b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Mon, 29 Jun 2020 11:15:49 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e789e7ed-2fd1-490c-0ede-08d81c1dc76f
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610B79524810FD007C62A7BC16E0@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:183;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIaSDmbhGzm7wJIMqvDasGKaFbvG0PzpIjWiNq8tUPWHbYnO5l1CY4AzcqPJKw5PEZFAuWdq5VlFlKjdOaoojAo4ByJAv//VKcNWKluSHJzgz3ywUQuM3hhjMR85lAQr6Gi4eTCIp7OT9A+XmVgtWj56WKvVEntIoVoRLqYmRqoVtnaDVwJa0K+urTwoWtFo8H6p80aNenq84kZIcBJZU+NXMfr+csPJlUrsiX5uOOmkmtdoopBUEh+Sj3FoyH2TitFo5FRXnFRSA4qV34n7vNZtCHzAdEDB/MHUDzZy9WAYs0ukJ/m/b6Sue+iwVnDx1Twd+hZFZXWxgei+tnPomKJmD0jY3d7yFVNneJRinx2Dang6IxN3IIVBH+uvQ0DQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39840400004)(5660300002)(316002)(16576012)(2906002)(186003)(558084003)(478600001)(86362001)(26005)(956004)(2616005)(31696002)(16526019)(36756003)(52116002)(8936002)(31686004)(4326008)(66556008)(6486002)(8676002)(66476007)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aET7kkajqrHIfibDpMBw6ku0PptJ6rk+BmvPwP9ScHZbPqo/u/pUIid3r0Y81vPgi5/aquiorPbvNplUW1+d2UVt6XAHJdMVJP1/+s/74D3eNo65HO1tP08lLE7wp5R9IT7DGyvHJN1V7n2syhJsEqPe4fk/w+RUwy06KFpv9FpuUp1UgSgUh1RfCOCjNfAJSa1RvVC09d1tRt2AleYoB0s2k7YzF8wyd4cbfe6ziVW8DEVmrUG275aa21eA5LkQ4A5GSd/dzcEvbrTF3X9bFhXfhjNQ7uFhhU7VyRH11SBZh4D8I5Th8pZZBBOeRMOE/C2k9yq9IxiQ4Q+0ZxfrApu9WOuHdojROxhcOmXVG5M2JMY5wHfSvT7Ekvtbph2l5wTVF88rY8cjsbNWP48VwHySVslKbW11Sy97FPJwC4e3LMA5kZrQZSxpdm2aPyi6BnusQ+GcqxebvmySN7bLOvQhnpk4JvJsJ00W9lGEx3bU1FDu6rODc8X7nmFlQVCY
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e789e7ed-2fd1-490c-0ede-08d81c1dc76f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 11:15:50.0051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBAr6w8KzW4ef1AdtyabjK27aSxlpxujaE1lcmP0mT24cc8xFeFTxlY1j8N9ln98EOV3YZCNIwnC7uqDb+wZ2ZAaARL1VPEUMyzWgVGdMVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.15.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 07:15:50
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> See recent commit "error: Document Error API usage rules" for
> rationale.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

