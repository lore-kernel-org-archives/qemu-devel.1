Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4D2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 10:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF29620575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 10:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="STHfacHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF29620575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZBa5-0000GZ-Pz
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 06:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZBZT-0008CX-RQ; Thu, 14 May 2020 06:58:35 -0400
Received: from mail-eopbgr150099.outbound.protection.outlook.com
 ([40.107.15.99]:38565 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZBZR-0000bB-EV; Thu, 14 May 2020 06:58:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJgdrty4Y4LGzKNzqt4+TlFSVfUTWfo+wwNjIklaYK4+KzrLZeyJH89A8RtBGcrUl127iQhaTGhkGqCsH3oIakplJMjsAWDsO8VXWwD0kdbbVuHl+FJBbsjF/KJYNLrDbFXFEA8e40nT9e2tXhRMp1N+EzDrIrh6orNTn4/Cxj8izZ15CQUXAWRDVb0OHbbb248pswWIAR+NLCsi+zIBzmos38ZQBJ4hk9da3SnPZrsLesxDEuH+i06HuRC0YIakzbFbGju3jpEhECsgcnLIjGRL/ffZtntqsDOgHPqnKITOLozvLOIHrAz783cBGqaihc6A8Pe/4XBfEZERs3N2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYDo1vWgDbIyFNU7WAnOvSeLJYGdEUeN6WY74wmUYto=;
 b=FS4lhSaKSyUhrEPuo6rBP9aB3fhsVTLfEl4zRVX/GRD0v8vF60pHJe5jzNu2hWOs2PlG1PYPC5JD9gvbQsxZLd12Ne7zrzOrnYmu/fFVYIxB4sbplC18juV6RSvKChSL81+tzdqMdJdI5Ukl+RCbdVqr3FdFhGuFAdPKlyf8Ngh+8hbemjOu5fy+hhvZv02luID5PHgUWZZgWpHiy5cRnyP4NzyENk6vyl09df4ar2QVpx3qLIBR/k0znsrs5PAOUfznRMiPj4ns4m94HjJn2ltS7M0kDjfm0zL1eKtkio082XELZhviGATAzwjrjVkyUnsGiLoYp1RmurKR9n0ujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYDo1vWgDbIyFNU7WAnOvSeLJYGdEUeN6WY74wmUYto=;
 b=STHfacHsdn2Zwzd/j/TMc3iZnz9cIoVwf1gkPJn++tLJ2S4ArQ2ruEJEMU8HG69ErxmxRdG6qN3A7rOWGQM3Z3/iSHrjxp+aTMDKW0HmJmAnH+rYuN/jyjUUAq+NXeqpSPJIFTkWadsX235jctFCsTkg98kiJT83fdsfSz/+OxA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5333.eurprd08.prod.outlook.com (2603:10a6:20b:104::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 10:58:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 10:58:30 +0000
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200513145610.1484567-1-mreitz@redhat.com>
 <6a82008b-d272-82f2-a8a1-615437abcda7@virtuozzo.com>
 <dc5dbf70-a0da-67eb-b1b4-2f74778ec671@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cfd50989-49c1-7241-018d-a424dd615bf3@virtuozzo.com>
Date: Thu, 14 May 2020 13:58:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <dc5dbf70-a0da-67eb-b1b4-2f74778ec671@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0139.eurprd07.prod.outlook.com
 (2603:10a6:207:8::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM3PR07CA0139.eurprd07.prod.outlook.com (2603:10a6:207:8::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.13 via Frontend Transport; Thu, 14 May 2020 10:58:29 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5cc2bf6-cc76-47aa-5965-08d7f7f5bc92
X-MS-TrafficTypeDiagnostic: AM7PR08MB5333:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53330D4D74EE4F5C6CEDF306C1BC0@AM7PR08MB5333.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01nKwra/pKeOhByuG8zlBpkzbey+2apOWIpp8iNmSUJD1bgDIA4UJHIYlL5e3PlG00/c1yfroJEDVvjIeunc3bj0xvyrdZptADmbc8U9kYlCDnRtvtVbtWRTdKubvE30dAWiviIEjaW/0yQAIJ8y5D9hQTaSf0vT3OGiIPmxlfrTjg2rxyUUDujHmEd/e9iqQ9wTcztIBL8G+ACTgYwBwI8umrflLFqvut/XlMqP4j46+AsaZs0vz/M7clZCPCkoVN6+kRrXB2Mei2e3MFs6+xa67BtSaKvo6RD51tcnURxXSUnLjXj4c0MAzQblRBQ9WZoIXSxjxUbDjEM3E5cOLAy9ZGHYgDQOZIK3WiL6AgeIy1wO3BLueBZAHWbIFO95N1PPcayPXAxzf05qZNAydGs7n3grFRNZWmB2yaPeixVOdJqJC+6zfkON46UhcaduVmNVbV2UUsNA5t0qnjKW7KBjIKoNW3N+/0pbg0y8q6ctHombWGneNoDsy48PcvBw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(346002)(376002)(136003)(396003)(366004)(956004)(16526019)(8676002)(186003)(316002)(16576012)(2616005)(31686004)(54906003)(66946007)(66476007)(4326008)(6486002)(36756003)(66556008)(26005)(86362001)(53546011)(52116002)(478600001)(8936002)(31696002)(2906002)(5660300002)(4744005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: H7v+IGjOK0+oqC3FQ1mMOedfTrucEZjNd06eaqXrx+9nZ6quhoySp2nPqQKwII5Q2Pyh3uwJfzAma/igBx6a+XCuTQDjovJHAgOvfZJq6Euw1VvS2BGxwHcRNFse+PLu/JYZNDnYvXgBdGsv4Tu0TZnH3DeErJkt/A8N+HjpkEhHvU+mjTlPKbWDucmhg5ghU80BD8GrS0K0LcVOJWzJoYpCZZKmqIkwUbJ9/hoi2MK5PFBzDpdq4JCp7TP9gcwSC7NePIhGjAZEkPe5XPKOoDiVByMkcB75iQvMMCp0IbFPSCoKVx9lk+6uFWPrcG4wWKCadoC+aV7blH32lVbz+Klvvw2H3wusTu9NMWoKbuRGk+wx73/1gvwDeNMaFrTmNjKICCR1KUAicSMUWgZgrXc6U7W3iOUKc9dhJnKTMe8tfcMmAMHcz+B9FkCmpC5Tz5dZZPC18fcVeDW7NsU3/h4ha2HeLUKqzgjRl7wkOrjd0KEmg2DBceWTiCmO5xc0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cc2bf6-cc76-47aa-5965-08d7f7f5bc92
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 10:58:30.1439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wC5pkeZmjYQiMTnSULS4CT4avFNOH3IJVN4MKU7cEj2cyDMK+Xumy55feWZJIf0QStnjMY3MC9XdmC4VRZ4ELzVpBcggc8Vt+IXGrBDOjIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5333
Received-SPF: pass client-ip=40.107.15.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 06:58:31
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
Cc: Peter Krempa <pkrempa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.05.2020 12:09, Max Reitz wrote:
> On 13.05.20 22:09, Vladimir Sementsov-Ogievskiy wrote:
> [...]
>> 1. So, you decided to make only node-mapping, not bitmap-mapping, so we
>> can't rename bitmaps in-flight and can't migrate bitmaps from one node
>> to several and visa-versa. I think it's OK, nothing good in such
>> possibilities, and this simplifies things.
> 
> On second thought, I wonder whether it would be useful to migrate
> bitmaps from multiple nodes to a single one.  But probably not, this
> would only make sense for filters, really, and in such a case the
> bitmaps should probably just be moved prior to migration.

Yes, I think the moving before migration is enough.


-- 
Best regards,
Vladimir

