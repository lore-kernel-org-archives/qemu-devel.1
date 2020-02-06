Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BF0C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C82B20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OaVGROWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C82B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izjWE-00037a-MF
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1izjVC-0002UW-DU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1izjVB-0005Bb-Ew
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:55:38 -0500
Received: from mail-eopbgr680065.outbound.protection.outlook.com
 ([40.107.68.65]:43846 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1izjVB-00058K-2g
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:55:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CC38QUfK//hhWYOf/K6njYWe5h6DzmmxgxUuFFg6VuVPRvCjQ4WukMGsk756c0NHREujIYYuiy7Hxl9368e7kSVSRPPlTKDX0iMGLKm/SKLVS0NfHn8r9y32h0sZ+0Q3BoUDSNLEti7CYUbvewpgX9pKPphj22GRonAm/OtPWRBrsowayQavO4rkic79Xw7iNCOsQ7z7DlgR6dgeTucKxAuDwMnVBcyGdXZkK67vG4ux0giPpXSuslUyGKzBzXtIroe8NHq648isi/W58WelGBacuFMjRAH9kF3IlL/8PasGjyBo9iPB75w9xNgW41JTuYbuUHcBboN2ZyL1b/7SIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2rxi5WzTqU8Ikp4HS5FikJ7s2ynHuJlAJsb6KBr/xg=;
 b=H8NcpDVr14qpB0efz6arWBi07ao/h6RJD01M3tZh0bSZ7NzsKXgc1CigYYAk7G7H1doCD6LzGLUL3xcLOqCunuULF0mO2nAdeewr6+CdNdBYKxV0JqCbUB66jaSuIKXnD8ICl8aRniFNXvfQOo454nkGwHObg2G4ju9qPZHesgfcGvb05oleN8g4t+pkqKikOwvakr41KA7w7DhpflB/jNc3pqBCBc6pS00d/9GTHD/Ls1FTeUleB+Hbzul67Pl23NiUIwUEWr+Pb8kwv+7QFFP5znsD8I+gBmOcwrJH0XdcXY5+lLVqE7qNl6yhGsn4ZY8DXvKT4rrESQ8Uehx8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2rxi5WzTqU8Ikp4HS5FikJ7s2ynHuJlAJsb6KBr/xg=;
 b=OaVGROWKkrl8SOckCkxbAMVGsYP1ll6ib1a57WEq0CdkNFxeVFWyO/yuuxVM3yUGz9XavtWw0hE1uqgbV+VGV1MJpTc8AZDNsZeGQErMgiRQkuen9HQfujkA0rgGaFH+1Gl7/xnIFP0Uwdkx9M9BZf+5uaozTYNcpYMKweqdBlQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1592.namprd12.prod.outlook.com (10.172.70.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Thu, 6 Feb 2020 15:55:35 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 15:55:35 +0000
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
 <20191218151144.GN498046@habkost.net>
 <D67E411E-4398-4F1B-A397-E637BCD4F666@nutanix.com>
 <20200205223731.GY25446@habkost.net>
 <CY4PR12MB157489B70F2AD26C97779E40951D0@CY4PR12MB1574.namprd12.prod.outlook.com>
 <20200206155250.GA25446@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <70a1e609-69de-8913-d20a-d4433876b444@amd.com>
Date: Thu, 6 Feb 2020 09:55:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200206155250.GA25446@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0081.prod.exchangelabs.com (2603:10b6:800::49) To
 CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 SN2PR01CA0081.prod.exchangelabs.com (2603:10b6:800::49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 15:55:34 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34a35f9e-d4f9-4e3c-351e-08d7ab1d00e2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1592:|CY4PR12MB1592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB159261E84ED520847E4C4272951D0@CY4PR12MB1592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(6916009)(31696002)(86362001)(52116002)(4326008)(66476007)(316002)(16576012)(6486002)(478600001)(66946007)(54906003)(8936002)(2616005)(81166006)(81156014)(8676002)(956004)(4744005)(5660300002)(2906002)(36756003)(66556008)(44832011)(53546011)(31686004)(186003)(26005)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1592;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qz/qlGihed1RVvvKfV0WVwrWuxiZhxJ8LZC6orKx7RYI2X03iSUm+TTzyzRWs+86HshR/UjzySclQZy4WgN9G668yDsvEGZ6Y+4mK4BNJ3/PTzvLwVv5OfjQUCJgNLnkQgW8RztfV2n3IecbxQr4e/aNFqOfCYoU4okUzz/sqz391ZBh6HUT/kV+c1qeObc6YoxsiLVBNIfOSuOzICiJFzQnjI8ID5/rulNp2RqBuagThafUFpq/icMAz8rI4lFenpFMOTY0q9G7cOI71doWyY0pdLWZNMPlO9BEUKzAa+0yeHlQ2s/PSpuerUrNf/1XjvAhxX66jAHxAdGVBrcJM6hqPfioJkDDXvA3E1LXaZFpTzRmXt0lWrEgFxrK8YmoAubGi8xaUr4uJJaGByNwpyx5+xKYvHI6Bs2YHLHzQQAa/s7PigpgF1bdJQsIv0Qe
X-MS-Exchange-AntiSpam-MessageData: 9GjiSER3Sl1bxvq8anp5v86hBBizS7g+X5I/Bm7On5HGyiqb5FUqRRTKuY+McF2E7DCA7qfmdKKzvIYr7Zlbb6YVoZ1ZKyj3WdhNZQ7BZn5wGNlmtjCV0m1tTmHgt2u8eVhUifm1Uxivvc9Du+9jbA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a35f9e-d4f9-4e3c-351e-08d7ab1d00e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 15:55:35.5859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9srY9jqaYmuwCvVYid74q313sSRRp+Yp7JjW9AeXbjtYiNS1aC36D0WUULZLaMK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1592
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.65
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani.sinha@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/6/20 9:52 AM, Eduardo Habkost wrote:
> On Thu, Feb 06, 2020 at 12:00:04AM +0000, Moger, Babu wrote:
>> [AMD Official Use Only - Internal Distribution Only]
> 
> Considering that this was posted to qemu-devel, I'm assuming this
> notice was added by accident.

Yes. I noticed that after sending out the email. Please ignore that line.

