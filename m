Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61718C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 06:46:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89B1206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 06:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ootGsCrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89B1206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSxWy-0007Ak-On
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 02:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSxVS-00061O-6N
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 02:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSxVQ-0007lL-2g
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 02:44:41 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
 ([40.107.4.94]:46816 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSxVP-0007Mw-5I; Mon, 27 Apr 2020 02:44:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFOLBYWPTASMERNoICJQ+Wcrt2b63sDzGs/ZogdJXaPUoVOismxmRmHfW9wMoeWFZRs3Yd77apruNLSv8Gsx6Dv0PXtHG4TwnaAmun/WI8JJmG+jeJo6hz7YJGx8DH0Lyur10/Taz1MteA2M2FNqAHP4SVtaCwXInlPjwDTNasiYx93FO8ai3whZGrq93jkD3cF8jbr9eJbC64miULPjsSUHvlULmzETn7LbpWIOT2ZLfPqCC62fImvYtjnAPEuCXl36O0dLaUfvlabzmXEXMF++vb22aou16uHj3Q+GsnkCM0V/cIuUNLWheSgEMG5gASpJhkKWQRIgtrDw8suohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Baqw75mWoET5/twRLL5RmEodRj4PRKHl/yEw26iSwl0=;
 b=oS9hEeQzG9NzNVRhsej8mCcLvzj1mKuWtSePd3zUp05YBdknXRewo1U3OeILNhiQNj3+2iXkXOw3BsslzQOLA8qzn+XmdkEyXl3u9azgOtOY2d1y4do2SDhsaWT6XxJ8OwXWoJ++qZfEu0+bZ3jy54U+TNzx9G9Oz3dzcioQj720NL0clzl0wzPCiJ63YYRgw/W073w0se+q8oNsTHwiSYz0Pr8RjcWiZslEzIWkrgdYDqtWFy/WYhZfVMoDEcKbE+Nxl9ZupsAqQdfeEB8nK8vpWXzKd5ASsIaSeLC+EP23iy7n6Ni200rVNgBOwsN94OnnnfqtgWVvdIQ9AVznDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Baqw75mWoET5/twRLL5RmEodRj4PRKHl/yEw26iSwl0=;
 b=ootGsCrlbpmpkHXxbcW3aNbS98V/Su7gGxCOmVr5hSk0m4M1O0hReEbjPHp5kJOYFjAlmXeX5nF7K/MqdQGl/7Q2aPH4EG7nGLhcHbsoc+6wIFThCpSq6nVNcBamtMccClWMlVpVvOrnrPU3OLHoFhGjLvvpmkN2zuU7JFAmPVg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 06:44:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 06:44:32 +0000
Subject: Re: [PATCH 7/7] block: apply COR-filter to block-stream jobs
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1587407806-109784-8-git-send-email-andrey.shinkevich@virtuozzo.com>
 <17237b84-d71a-0648-4614-65515b4ecc30@virtuozzo.com>
 <VI1PR0802MB22061455B6632D402C45ED88F4AF0@VI1PR0802MB2206.eurprd08.prod.outlook.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200427094430724
Message-ID: <c9257fa3-785c-0333-392d-27a0899a8061@virtuozzo.com>
Date: Mon, 27 Apr 2020 09:44:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <VI1PR0802MB22061455B6632D402C45ED88F4AF0@VI1PR0802MB2206.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-ClientProxiedBy: AM0PR02CA0077.eurprd02.prod.outlook.com
 (2603:10a6:208:154::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM0PR02CA0077.eurprd02.prod.outlook.com (2603:10a6:208:154::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Mon, 27 Apr 2020 06:44:31 +0000
X-Tagtoolbar-Keys: D20200427094430724
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a70cf7b-0218-4408-2bc9-08d7ea76713d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53502B6455F01040B31466D3C1AF0@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(366004)(31686004)(54906003)(66556008)(110136005)(36756003)(66946007)(66476007)(4326008)(81156014)(956004)(508600001)(2616005)(8676002)(8936002)(5660300002)(52116002)(31696002)(16526019)(26005)(16576012)(186003)(6486002)(86362001)(2906002)(107886003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPOFNtWyl0qXAiT7BTpgXmJEb1/PilpdemSaK1Dq1LYDNQJCHWeeyl04OPa8wjkFE0etX3ADOfyl7m1tu6n+MiTjcZcYOm/R4MMfJ3XbPAfzmkTiAGGL0aOaBa/uUOk6WdREd8HZw58L7gvjhX8+8vxTArbo+C/SMEyyLpOEuPDEew61M/0vkPIg+Ail6sLRTMv2NwjEoyppRAyovefgdOZ10v4a0R6tInTTQsylDH1zZXD6/GmeFZyhWkIlmdvG8mpcmbgEWPt/7usvRc8+gFlqPANCZ7Rd7QPUvV0XvWMI3DwbQcz8sOOzhv80VUnNED4LJbXR8WkwZ22TietxQ6huLHNXHVkhq8ZTCK9eZGLbsVSeFJWI+LerJjDzjB5CuTJaLg9WH7KLWsDuWeNDlzSSJwzi/Xtf1gOW6nHy/8/XspSbyC/3IkH8g0Aq+2VW
X-MS-Exchange-AntiSpam-MessageData: wTpBrK3YGCzrN+tu7a2zWNH4uO1iDOXSa+lEmo8nJkvEmvVzHB7KoUdaBGUcx380thCvEAZjs4EPNPZ0eKPBhkQAM8oo4ZtW5nStzlKq47b0vxtuvCWM4mU9KmAaUmBg5DlW9Ha6ak9m8xGN8qH9DgxrOEj447RSWU0JneeD8bv/x3ZvBhyzDQ3RqnOdDHcOgZuL27K9lYhBlFOrmtdR0mCkSWCh/xGExS7KnmVLDVhZ5eMDXXf6/ZFUMecOBPdOXvzeVEXEXQP++i4xSI2qRrF2R9p8kNOWxF8WSu7CKGLcTsgjcZA22SqhCPBXFJWJ9T5im/e7F1uB+jkn5BZMicKO7NblsVRpQfv4UUZr8ixibvc3mEhaT6pw0UiMnB7+55J354aPKgcsvMd3331EmO5BuWGvRaI+Xow2FPxdNDBWiKNMVlLFEzMkVT02dyBcftJN/sXwWEpTWcRPpEIeCAhC47ZZl8Vkko4naWiCasl+w6lO38I3oRoE6d9eewqq8mu7EiUbeSbYHpgP8dZ+esRBK1LnFVZ0DMCH+6q2SQsPbLB/iMijCWQbOY60fQ+/6rOCkFwf6BuANbhnohSEqfATeMx+g/jkNQSf9x5hhsdQ64LbtmXKVc3JQnVbyg9u9IcMM4Z8A0AQQ93g+t55sdlrBsqqiAF8ALzELtAmyhWLh5Js9loUx1992ZFdOIE187sl3XtwLMw47auFj2WMvPuuF40IAC0cOxchbiejNBJJwu7csfw7cmw5GAHGdB66RWb13Nfeli63nj/I4MDWKt9osDwf4/d+aKoR3xGH2Ks=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a70cf7b-0218-4408-2bc9-08d7ea76713d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 06:44:32.4403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SgWE5JT43Qtagpg3JfPUoMfd9iVcVPL8OL7nxXgeX6PQ8Vm+QtRB3rJyL+cNubIQUV0et9ulnw66KlS9Ia1+r9KOv769s5gFxLZIl01MHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
Received-SPF: pass client-ip=40.107.4.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:44:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.4.94
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMDQuMjAyMCA3OjA4LCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4gMS4gVGhlIG1pcnJv
ciB0ZWNobm9sb2d5IGluc3RhbnRpYXRlcyBpdHMgb3duIEJMSywgc2V0cyAwL0JMS19QRVJNX0FM
TCBmb3IgaXQgb24gZXhpdCBhbmQgdGhlbiwgdmlhIHN1YnNlcXVlbnQgY2FsbCB0byBiZHJ2X2No
aWxkX3JlZnJlc2hfcGVybXMoKSwgY2FsbHMgYmRydl9jaGlsZF90cnlfc2V0X3Blcm0oKS4gV2Ug
ZG9uJ3QgaGF2ZSB0aGUgZXh0cmEgQkxLIGZvciBvdXIgZmlsdGVyIGluIHN0cmVhbSBhbmQgZG8g
Y2FsbCB0aGUgc2FtZSBmdW5jdGlvbiBkaXJlY3RseS4NCg0KZGVhbCB3aXRoIGJsayBpcyB1bnJl
bGF0ZWQsIGFzIEkgdW5kZXJzdGFuZC4gQ2hhbmdpbmcgcGVybWlzc2lvbnMgc2hvdWQgZ28gdGhy
b3VnaCBiZHJ2X2NoaWxkX3JlZnJlc2hfcGVybXMgYW5kIG1vZGlmaWNhdGlvbiBvZiB0aGUgc3Rh
dGUgb2YgdGhlIG5vZGUsIGxpa2UgaXQgaXMgZG9uZSBpbiB1cHN0cmVhbSBtaXJyb3ItdG9wIGFu
ZCBiYWNrdXAtdG9wLiBKdXN0IGNhbGwgYmRydl9jaGlsZF90cnlfc2V0X3Blcm0oKSBpcyB2ZXJ5
IHJpc2t5OiBvbiBhbnkgc3Vic2VxdWVudCBjYWxsIG9mIGJkcnZfY2hpbGRfcmVmcmVzaF9wZXJt
cyAobWF5IGJlIGltcGxpY2l0LCBieSBvdGhlciBmdW5jdGlvbnMpIHlvdSdsbCBsb3NlIHRoZSBw
ZXJtaXNzaW9ucyB5b3Ugc2V0IGJ5IGhhbmQuIFNvLCBhZ2Fpbiwgc2V0dGluZyBwZXJtaXNzaW9u
cyBieSBoYW5kIGlzIHdyb25nIHRoaW5nLg0KDQo+IA0KPiAyLiBUaGUgZnVuY3Rpb24gcmVtb3Zl
X2ZpbHRlcigpIGNhbid0IGJlIHVzZWQgaW4gdGhlIHN0cmVhbSBqb2Igb24gZXhpdCBiZWNhdXNl
IHdlIHNob3VsZCByZW1vdmUgdGhlIGZpbHRlciBhbmQgY2hhbmdlIGEgYmFja2luZyBmaWxlIGlu
IHRoZSBzYW1lIGNyaXRpY2FsICdkcmFpbicgc2VjdGlvbi4NCg0KSG1tLiBJdCdzIGEgcXVlc3Rp
b24gb2YgcmVmYWN0b3JpbmcuIFdoeSBub3QgY3JlYXRlIGZ1bmN0aW9uIHJlbW92ZV9maWx0ZXJf
ZHJhaW5lZD8NCg0KPiANCj4gMy4gRHVlIHRvIHRoZSBzcGVjaWZpY3MgYWJvdmUsIEkgc3VnZ2Vz
dCB0aGF0IHdlIG1ha2UgaW5zZXJ0L3JlbW92ZSBmaWx0ZXIgYXMgYW4gaW50ZXJmYWNlIHdoZW4g
dGhlcmUgZ2V0cyBhbm90aGVyIHVzZXIgb2YgaXQuDQo+IA0KDQpQbGVhc2UgbG9vayBhdCBiYWNr
dXAtdG9wIGZpbHRlci4gQ291bGQgd2UgYmUgYXMgY2xvc2UgdG8gaXQgYXMgcG9zc2libGU/IEkn
bSBzdXJlLCB0aGF0IGZpbmFsbHkgd2Ugc2hvdWxkIGhhdmUgb25lIEFQSSBmb3IgZmlsdGVyIGlu
c2VydGlvbi9yZW1vdmluZywgbm90IHBlciBmaWx0ZXIuDQoNCj4gDQo+IC0tLS0tLS0tLS0tLS0t
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
LS0tLS0tLQ0KPiAqRnJvbToqIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4NCj4gKlNlbnQ6KiBUdWVzZGF5LCBBcHJpbCAyMSwgMjAyMCAzOjU4
IFBNDQo+ICpUbzoqIEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96
em8uY29tPjsgcWVtdS1ibG9ja0Bub25nbnUub3JnIDxxZW11LWJsb2NrQG5vbmdudS5vcmc+DQo+
ICpDYzoqIHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsga3dv
bGZAcmVkaGF0LmNvbSA8a3dvbGZAcmVkaGF0LmNvbT47IG1yZWl0ekByZWRoYXQuY29tIDxtcmVp
dHpAcmVkaGF0LmNvbT47IGpzbm93QHJlZGhhdC5jb20gPGpzbm93QHJlZGhhdC5jb20+OyBhcm1i
cnVAcmVkaGF0LmNvbSA8YXJtYnJ1QHJlZGhhdC5jb20+OyBkZ2lsYmVydEByZWRoYXQuY29tIDxk
Z2lsYmVydEByZWRoYXQuY29tPjsgZWJsYWtlQHJlZGhhdC5jb20gPGVibGFrZUByZWRoYXQuY29t
PjsgRGVuaXMgTHVuZXYgPGRlbkB2aXJ0dW96em8uY29tPg0KPiAqU3ViamVjdDoqIFJlOiBbUEFU
Q0ggNy83XSBibG9jazogYXBwbHkgQ09SLWZpbHRlciB0byBibG9jay1zdHJlYW0gam9icw0KPiAy
MC4wNC4yMDIwIDIxOjM2LCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+IFRoZSBwYXRjaCBj
b21wbGV0ZXMgdGhlIHNlcmllcyB3aXRoIHRoZSBDT1ItZmlsdGVyIGluc2VydGlvbiB0byBhbnkN
Cj4+IGJsb2NrLXN0cmVhbSBvcGVyYXRpb24uIEl0IGFsc28gbWFrZXMgY2hhbmdlcyB0byB0aGUg
aW90ZXN0cyAwMzAsIDE0MQ0KPj4gYW5kIDI0NS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogQW5k
cmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+PiAtLS0N
Cj4+wqDCoCBibG9jay9zdHJlYW0uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE1MSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4+wqDCoCB0ZXN0cy9x
ZW11LWlvdGVzdHMvMDMwwqDCoMKgwqAgfMKgwqAgNiArLQ0KPj7CoMKgIHRlc3RzL3FlbXUtaW90
ZXN0cy8xNDEub3V0IHzCoMKgIDIgKy0NCj4+wqDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvMjQ1wqDC
oMKgwqAgfMKgwqAgNSArLQ0KPj7CoMKgIDQgZmlsZXMgY2hhbmdlZCwgMTQxIGluc2VydGlvbnMo
KyksIDIzIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svc3RyZWFtLmMg
Yi9ibG9jay9zdHJlYW0uYw0KPj4gaW5kZXggZmFiNzkyMy4uYWYxNGJhOCAxMDA2NDQNCj4+IC0t
LSBhL2Jsb2NrL3N0cmVhbS5jDQo+PiArKysgYi9ibG9jay9zdHJlYW0uYw0KPiANCj4gDQo+IFsu
Ll0NCj4gDQo+PiArc3RhdGljIGludCBzdHJlYW1fZXhpdChKb2IgKmpvYiwgYm9vbCBhYm9ydCkN
Cj4+ICt7DQo+PiArwqDCoMKgIFN0cmVhbUJsb2NrSm9iICpzID0gY29udGFpbmVyX29mKGpvYiwg
U3RyZWFtQmxvY2tKb2IsIGNvbW1vbi5qb2IpOw0KPj4gK8KgwqDCoCBCbG9ja0pvYiAqYmpvYiA9
ICZzLT5jb21tb247DQo+PiArwqDCoMKgIEJsb2NrRHJpdmVyU3RhdGUgKnRhcmdldF9icyA9IHMt
PnRhcmdldF9iczsNCj4+ICvCoMKgwqAgaW50IHJldCA9IDA7DQo+PiArDQo+PiArwqDCoMKgIGlm
IChzLT5jaGFpbl9mcm96ZW4pIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBiZHJ2X3VuZnJlZXplX2No
YWluKHMtPnRhcmdldF9icywgcy0+Ym90dG9tX2Nvd19ub2RlKTsNCj4+ICvCoMKgwqDCoMKgwqDC
oCBzLT5jaGFpbl9mcm96ZW4gPSBmYWxzZTsNCj4+ICvCoMKgwqAgfQ0KPj4gKw0KPj4gK8KgwqDC
oCAvKiBSZXRhaW4gdGhlIEJEUyB1bnRpbCB3ZSBjb21wbGV0ZSB0aGUgZ3JhcGggY2hhbmdlLiAq
Lw0KPj4gK8KgwqDCoCBiZHJ2X3JlZih0YXJnZXRfYnMpOw0KPj4gK8KgwqDCoCAvKiBIb2xkIGEg
Z3Vlc3QgYmFjayBmcm9tIHdyaXRpbmcgd2hpbGUgcGVybWlzc2lvbnMgYXJlIGJlaW5nIHJlc2V0
LiAqLw0KPj4gK8KgwqDCoCBiZHJ2X2RyYWluZWRfYmVnaW4odGFyZ2V0X2JzKTsNCj4+ICvCoMKg
wqAgLyogRHJvcCBwZXJtaXNzaW9ucyBiZWZvcmUgdGhlIGdyYXBoIGNoYW5nZS4gKi8NCj4+ICvC
oMKgwqAgYmRydl9jaGlsZF90cnlfc2V0X3Blcm0oYmRydl9maWx0ZXJlZF9yd19jaGlsZChzLT5j
b3JfZmlsdGVyX2JzKSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMCwgQkxLX1BFUk1fQUxMLCAmZXJyb3JfYWJvcnQpOw0KPiANCj4g
SG1tLiBJIGRvbid0IHJlbWVtYmVyIHdoYXQncyB3cm9uZyB3aXRoIGl0LCBidXQgc29tZXRoaW5n
IGlzLiBOZWl0aGVyIG1pcnJvciBub3IgYmFja3VwIGRvIHRoaXMgbm93LA0KPiBpbnN0ZWFkIHRo
ZXkgdXNlIHNvbWUgZmxhZywgdGhhdCBwZXJtaXNzaW9ucyBhcmUgbm90IG5lZWRlZCBhbnltb3Jl
IGFuZCBjYWxsIGJkcnZfY2hpbGRfcmVmcmVzaF9wZXJtcygpDQo+IA0KPiBBbHNvLCBzdHJhbmdl
IHRoYXQgeW91IGhhdmUgaW5zZXJ0X2ZpbHRlciBmdW5jdGlvbiwgYnV0IGRvbid0IHVzZSBpdCBo
ZXJlLg0KPiANCj4gQWxzbywgY291bGQgd2Uga2VlcCBhZGQvcmVtb3ZlIGZpbHRlciBhcGkgaW4g
YmxvY2svY29weS1vbi1yZWFkLmMsIGxpa2UgaXQgaXMgZG9uZSBmb3IgYmFja3VwLXRvcCA/DQo+
IA0KPiAtLSANCj4gQmVzdCByZWdhcmRzLA0KPiBWbGFkaW1pcg0KDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==

