Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5836AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C542065C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X2UQaYUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C542065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhBc5-0002uJ-Cl
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 08:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhBaz-0002KE-Ah; Fri, 05 Jun 2020 08:37:13 -0400
Received: from mail-eopbgr140137.outbound.protection.outlook.com
 ([40.107.14.137]:35906 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhBax-0001gL-Qq; Fri, 05 Jun 2020 08:37:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kca/2urShLnEnC8LMiJcfRiqSvoagkRcYvFZqA1FG4/4Pe8WrEZGnNlNLLVgljIywiP53UU60yq7o6OaxCfs1Xla1L1NEQ5dCB5LjMtMPs/RvbXTw+kMrxYxG7BQH8wiHqr7cewiaU/pQoXRwjGwrxrHS/KIV4oO6bFjS6RR7VNXbZ7NuyIbQ3yTyioTwcgWjh+AxD+YJpa4yx2RVv1jM0PIB6b6g2TkPPEjFiNQhOkQHyENxSG/7Qf5h6OqoiFvQHqWHHt6IDGCa28s+wQe22KeBZcaFl/S+OwIUP2dNpiUeUh7PJzDVG7wzVet6U5pv8Octi6EjYXNAaOhU2S8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YlNY3tsCDqVNpxBHaqXjuUDzdujIm2byPxGfYPZSF4=;
 b=hxgXHGFyaEO5Dp5WyiXt7+0rQAkvoYuczYSnG8dE03j2dbkW4B14oFa5HXXHeUVGIjP5sNMkwSEdIcs65cxjsPJ/OdXb7gPiAHyY4nVJZCNzPUptiErHuXYAb1iZYcuPVA2HIApyMx+maetKUO/gVCGK/eDwSd2e1d66J7aMStIksLkr23p9smdTdUdkDOOsOcvRjaG0l0mOb23+H2kyzuB/IM+3xrI38Znf1af6kOlmrACedlvjYBTi4X+6i04GJ4/Y/V4LxS+7kU0YnAps3jSGg3SKF3AKU0jrhYF+zDrn4p3rent2UMMqvfesZsJKh2RVecODEhZLtw93NVodXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YlNY3tsCDqVNpxBHaqXjuUDzdujIm2byPxGfYPZSF4=;
 b=X2UQaYUeVSHtyRexisEMjH80MiCCgLtg3G17l/VoFtlcQNEQ1tww/R+AADHYkvSZTRAWNvREt73Mfy5GRzk8BLxCcJe0XsyjB3Sn3qcPkyJATjLRTMnLj5DSMLVR74gDre6Xg3X6Rj1myDmG0Yf0ZeE+glM03RWXON6u/tW1NLc=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 12:37:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 12:37:09 +0000
Subject: Re: [PATCH v4 07/12] qcow2_format.py: separate generic functionality
 of structure classes
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
 <20200604174135.11042-8-vsementsov@virtuozzo.com>
 <AM6PR08MB4070FDB41EB8996982EEAF1CF4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c9514cbd-d09b-562c-4a9e-8b643a68a24e@virtuozzo.com>
Date: Fri, 5 Jun 2020 15:37:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <AM6PR08MB4070FDB41EB8996982EEAF1CF4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-ClientProxiedBy: AM0P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM0P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 12:37:08 +0000
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eed6e8d-af21-47ca-56a3-08d8094d299f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5512795633B99BC95D3AD4E1C1860@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XL7kGkkjPITSPgTyddXTlsPxtlZWw7lM2FYKiSEw4x8g8MB/TO+6wuNHEnzEPz0kqY1ezEYKRkdbs8CHEozN4FlPFM1MNm8rAkvgFUAdjQzQ8Fg8Hp39o+JFTMIEKpC660cRZiIxPHiG24tQWdz0F5G69qhm7t6sXMG234RtM3e8uDshkPmI2gHr6ZGpa/ZdZIftRcFIHKWfvjeoVmR58xHrw8joj6tAwoFPxeI2sYN8LhmZu4htc/sfrr4GOw8QUnEMcbsaEeshvpD7vBY2lWx4n/kUWOwLCHrLFcCM8QHkIwJAgkoSl6HwRBphNXsqPSe6z6HA560dMftKbduI3BOGzVO8xqeEURMTuPFqFlDOkh2EkQP2wADP8LNbDdQv2w/lBV2PIqPkFPEHddb0Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39850400004)(8676002)(86362001)(52116002)(31696002)(8936002)(83380400001)(66946007)(31686004)(66476007)(66556008)(54906003)(110136005)(2616005)(26005)(2906002)(107886003)(478600001)(36756003)(186003)(16526019)(4326008)(956004)(6486002)(16576012)(316002)(5660300002)(41533002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SXctIRS060hi2zjFTaCu9Wh7CvDLTZYWxw+XiAVtoLzTektrXyurVmu35pBqUQLwRB9int78HrG4YDvduuML7QIfrIT7amj+HvfhVqj9qOlbtAn/ZBgYD43jPPIZOVCn3fPT+R90SzjZXn/+5UW9ApSrpB0bycUEfDUVA+y3gWaxjsSAES+5T0YIdT1GJtRSssbffMh38nv/XFOvWglNhPoRk5CLgI2F8afvUDppmByyFvuYYkpUMT4+r/Ja7f8M+jSlkxFRDc8FVXg0oTMh5qZ8agd2w6cphItsApku59D13ptS1gINEZ5Bd8Vmh4ZsGKMJn28h48ZSL5s+FEvsgtjRA0XdSENZi0/MKYZZZanfz4Dz8e5j7oyJVLDWXMb/9xkmeZliSerlYaxfBSU7wlwBTHqkxclIof5udnNsYXhByrCXbMaHdV7OG8pWFbBRxXEPHzI1mU9y/VoIZ6EmfnR8Jc6sFptSeFNpyXhcEkotqPSz2nagLOIcgKUtIbZF
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eed6e8d-af21-47ca-56a3-08d8094d299f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 12:37:08.9291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QADCh6QS1e0+WqpUUH8oLZGvzBYpTxKg/BR/PDGRw3DM5JiBur3M0TnuETrOlU3zg2iIV3s/VUipUiB0fRGJGNqdGmMHg+6cYie1CVotJIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
Received-SPF: pass client-ip=40.107.14.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 08:37:09
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMDYuMjAyMCAxNToyOSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFR3byBtb3JlIGlu
dCB0eXBlcyBpbiB0aGUgY29tbWVudD8NCj4gDQo+IFJldmlld2VkLWJ5OiBBbmRyZXkgU2hpbmtl
dmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4gDQo+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAqRnJvbToqIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4NCj4gKlNlbnQ6KiBUaHVyc2RheSwgSnVuZSA0LCAyMDIwIDg6
NDEgUE0NCj4gKlRvOiogcWVtdS1ibG9ja0Bub25nbnUub3JnIDxxZW11LWJsb2NrQG5vbmdudS5v
cmc+DQo+ICpDYzoqIHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyA8cWVtdS1kZXZlbEBub25nbnUub3Jn
PjsgbXJlaXR6QHJlZGhhdC5jb20gPG1yZWl0ekByZWRoYXQuY29tPjsga3dvbGZAcmVkaGF0LmNv
bSA8a3dvbGZAcmVkaGF0LmNvbT47IGVibGFrZUByZWRoYXQuY29tIDxlYmxha2VAcmVkaGF0LmNv
bT47IERlbmlzIEx1bmV2IDxkZW5AdmlydHVvenpvLmNvbT47IFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT47IEFuZHJleSBTaGlua2V2aWNoIDxh
bmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPiAqU3ViamVjdDoqIFtQQVRDSCB2NCAw
Ny8xMl0gcWNvdzJfZm9ybWF0LnB5OiBzZXBhcmF0ZSBnZW5lcmljIGZ1bmN0aW9uYWxpdHkgb2Yg
c3RydWN0dXJlIGNsYXNzZXMNCj4gV2UgYXJlIGdvaW5nIHRvIGludHJvZHVjZSBtb3JlIFFjb3cy
IHN0cnVjdHVyZSB0eXBlcywgZGVmaW5lZCBsaWtlDQo+IFFjb3dIZWFkZXIuIE1vdmUgZ2VuZXJp
YyBmdW5jdGlvbmFsaXR5IGludG8gYmFzZSBjbGFzcyB0byBiZSByZXVzZWQgZm9yDQo+IGZ1cnRo
ZXIgc3RydWN0dXJlIGNsYXNzZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IC0tLQ0KPiAgwqB0
ZXN0cy9xZW11LWlvdGVzdHMvcWNvdzJfZm9ybWF0LnB5IHwgOTMgKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tDQo+ICDCoDEgZmlsZSBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCAzNSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvcWNvdzJf
Zm9ybWF0LnB5IGIvdGVzdHMvcWVtdS1pb3Rlc3RzL3Fjb3cyX2Zvcm1hdC5weQ0KPiBpbmRleCAx
ZmQ5NDczYjdmLi5kNzFmNTc4Mzc3IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMv
cWNvdzJfZm9ybWF0LnB5DQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9xY293Ml9mb3JtYXQu
cHkNCj4gQEAgLTIsNiArMiw2MiBAQCBpbXBvcnQgc3RydWN0DQo+IA0KPiArDQo+ICtjbGFzcyBR
Y293MlN0cnVjdChtZXRhY2xhc3M9UWNvdzJTdHJ1Y3RNZXRhKToNCj4gKw0KPiArwqDCoMKgICIi
IlFjb3cyU3RydWN0OiBiYXNlIGNsYXNzIGZvciBxY293MiBkYXRhIHN0cnVjdHVyZXMNCj4gKw0K
PiArwqDCoMKgIFN1Y2Nlc3NvcnMgc2hvdWxkIGRlZmluZSBmaWVsZHMgY2xhc3MgdmFyaWFibGUs
IHdoaWNoIGlzOiBsaXN0IG9mIHR1cGxlcywNCj4gK8KgwqDCoCBlYWNoIG9mIHRocmVlIGVsZW1l
bnRzOg0KPiArwqDCoMKgwqDCoMKgwqAgLSBjLXR5cGUgKG9uZSBvZiAndTMyJywgJ3U2NCcpDQo+
IA0KPiB1OCwgdTE2ID8NCg0KeWVzDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

