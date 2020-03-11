Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84893C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3572071B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZXIAPbYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3572071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jByLW-0002U8-G5
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 06:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jByKq-0001rt-Rp
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jByKp-0004H6-Vf
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:11:32 -0400
Received: from mail-eopbgr80119.outbound.protection.outlook.com
 ([40.107.8.119]:46979 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jByKm-0004Aj-M1; Wed, 11 Mar 2020 06:11:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1GdP5E/uPLu9EvbTtPUbcKs93xy5btDUIiw5iA/Sbbe290V5g7Zcir3LB7+4I8BM7VUfpTx0YZIx2+KNNFPQ+D013C7Y/bxFecltUSbLhrwvy/f1KFSinA0/V28f9vlNtiPoud2ZHWCiWhm5j43hS4WcHlgLKmN+TIJ3A/zoA6Lzm5lQ6ZqsI7uMMFaXAlYDcanKilKRP8EDLQlnZeloxS7HnHsCjfB9sB2NHhxCCdJQYamml+tLJ1NOWNXa/46POxNo9bxPaD9l+GZdbXpKKfsqLIy1DIF8yvnJsmHSMX9MUbsna4jVxVnE6osTVJCPHjaFxsQEl6ieYMx4kC8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBUQBS8DpUANyAqWYb9+wwAquIITxCdAAluuE0eK6k8=;
 b=TakvO4TAkl0EViwGe74Vn+STXj4GMFHrU1ARZT3x7dvGQKqJR0DrxK3UMFqvcwuO+5LukK4hARLIP2vTUBlI814cZD2yG/Fv3OaZxizMxzOWwhnJf7B1ogxNUDCHmBBKKGNYOxqnFQ8rQmgWIKCzwSUYufoJ1QLC29YopyKQ28T5Duo/Vf/SrT7GeNsGXYuOcG+YRulFmxQ/K3xT+n/QkEEHTR///k0rXwNIi8Pr8aghafobRr4+l0PvwgbJjRX4rIUAzqG2LM2VV/M+b/yv5+FG6kytFOi/nde0yO5l1Lv/ioIB+5fkFEFXSFk6lLfPNeZ1nQS4lKoTl7gjzBtuOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBUQBS8DpUANyAqWYb9+wwAquIITxCdAAluuE0eK6k8=;
 b=ZXIAPbYbL1zxQF/FwDAV2Z6vH7mNxYyxG5d6u3/JlDMykYpnbLGY9Qm5WzB2qme5Wg57k4i02Erw5BKh6nqO7pB8V+N2WdiO/Hfc0+3v4/myfd2GX3ZoAJ+bt54sVKcqYqsS2eVnBWnH+QQ+WYpX62iJx+JFiGx/opI+NJF8xVw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB2967.eurprd08.prod.outlook.com (52.135.163.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11; Wed, 11 Mar 2020 10:11:19 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 10:11:19 +0000
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
To: Markus Armbruster <armbru@redhat.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87r1xzfc9y.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200311131116572
Message-ID: <4ebcc5a5-4bc8-022b-8fe4-9ced0de08370@virtuozzo.com>
Date: Wed, 11 Mar 2020 13:11:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87r1xzfc9y.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0283.eurprd05.prod.outlook.com
 (2603:10a6:7:93::14) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0283.eurprd05.prod.outlook.com (2603:10a6:7:93::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14 via Frontend Transport; Wed, 11 Mar 2020 10:11:18 +0000
X-Tagtoolbar-Keys: D20200311131116572
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ab26d02-17f9-4da7-a123-08d7c5a48b20
X-MS-TrafficTypeDiagnostic: AM6PR08MB2967:
X-Microsoft-Antispam-PRVS: <AM6PR08MB2967463D7823538B6FCF78E6C1FC0@AM6PR08MB2967.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(376002)(366004)(396003)(346002)(199004)(956004)(31686004)(316002)(7416002)(26005)(8676002)(2616005)(16576012)(2906002)(6486002)(4326008)(81156014)(81166006)(478600001)(86362001)(52116002)(6916009)(36756003)(66556008)(66476007)(66946007)(5660300002)(8936002)(16526019)(54906003)(186003)(4744005)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB2967;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UcSgKfWTctJDBguePBhHs+vdhpPWBvGeCBktXe5tzaM6N85LZsSG0jrpySRJHQJmSmtDKna9QQnZ4sc4pIuXTlXl5uOTLNoF16caBphji6wZ5JUesjkeR1dJY0y62EX/znbS3NZadGP5H+BOhH+euS4B4uTLCuZymlC5H5TPNqe2p8Ei8RBpWLd279DOUfdqRPMOQ3w4zJS4aKJfKQGIagI4bpM9SXboo5L3Soa3/tiWIRfilNbxM4101xU9ebCqYPMBIjR5leohmS86V8jD38cexrOTWk+wPjE1lN98YpRFYRALZNGhoy0uHDER5DNMA18LHURAAwnTM2Yw8mcaFDlFKMjnz4bkY5GOpIAt47NFz7XpVUfVCl/pTpIEnVIASIju/FRO+fXg05J7AXc6yJBgn45JJ6wIb/ognWApsrjBN1VOXqZN4sQbstOuKoX0
X-MS-Exchange-AntiSpam-MessageData: kH7yW781IF4TkQ/MLFgx5sheIzBKBqd/FIL2kVqf36IEGAAtmubJdqCgIf+nETCnsev2YGK0LUzqmJvQqg7foTwY2NOky7fZ+oyKk1uhm01zViPdtQruzOqUYiXFxhll7+xfrws6fRs9DKgsNBsbEg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab26d02-17f9-4da7-a123-08d7c5a48b20
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 10:11:19.6963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOhKeMI4l0c66g2KBpBZs17tLQdCNaCxQO6VNYYvdNAef0qnAiO5Zot4OJ/JFlAXDdMTUD+YVwNyjukTLc/7yKZdWFld+Qd1jPtCQ6kDAsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2967
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.119
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.03.2020 12:53, Markus Armbruster wrote:
> I think a v9 makes sense now.
> 
> If any of the improvement ideas should turn into time sinks for you,
> let's talk.  We don't need perfection, we only need to get to the point
> where we trust the script to do what we believe it does, understand its
> limitations, and know how to compensate for them.
> 
> Right now I'm optimistic v9 will be ready for merging, perhaps with some
> minor tweaking in my tree.
> 

Good. I hope, I'll resend today.

-- 
Best regards,
Vladimir

