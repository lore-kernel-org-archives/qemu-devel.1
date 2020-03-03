Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ACCC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53EDA2072A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hA8VFpSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EDA2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j92gR-0007fE-Fr
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 03:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j92fh-00078N-8j
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j92fg-0004AW-9x
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:12:57 -0500
Received: from mail-db3eur04on071e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::71e]:56453
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j92fc-000482-5u; Tue, 03 Mar 2020 03:12:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bpjk7gZTrYOiox0HwCmOW2ZJv13N9INM7cEt5G1O1AHSqYoEtIK91bNxXsR4X3iV7PgjG1XlckZewpRHVsbckFCEcsnUSmlh95048evXIyRU0cfhoP8L8rEI4CQQn8Ie85N8O34X47LVbwOy125P2wK58Nf5DyhUK/ZzfyQ8U4XNrjGX6ShVRvhcfFflWTocCd9i64Ys0cAShZeYBDktXhzk54CDM3kUjtZf5F3d5OkjEvnTFLQkSVE4MOpAVrA7DpgTJac1f7PZsjkPRPCYjLKmVUOq55NrYyozGB0A/Io/6M2BLyW93KXg+FDYPnu7MIuhJmYK2HCbrtqVAZ4kfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=469FiHZuZry8HBY8cmslj/6UeoVwRhHUEw0zxLSxSrs=;
 b=M6KkgsjvTGkVvtsDSN2eEw0EX2bZwofMCZ5H4egR26HIjTHGM9LtsuMCvh2wBD7zb7c/C52utwV81lbqbjBciYJA+UxjNYOSfdt4o0rV/QW55G6UJ5zCEwyKkU7epfB5t59GLsORWlxT79T5m4/GPPR+dx858RzGPcoIpGL6QyB5T7/wtZddE7uYinLFtNQwZuos8Vp5LvE0+QqeZNFlKwITjlLJrZdniOcKcmpPhYrP7hr87PwTUhrbspP8CP4rJZQkpnxIllgl4sxj2fVIcLhtD2jZ+6yKlcDnM65eymoe5qt+c+jHiR8XdI9ukqwL25AprvAT3L9vydLjwfdauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=469FiHZuZry8HBY8cmslj/6UeoVwRhHUEw0zxLSxSrs=;
 b=hA8VFpSldK0AokXbCFB0kAYNKqTx5t9dy8dwo5bK8RhancPWLQHFq1jV1M+yKVMUrElpAjmILjo2Zz7ZwAFK+Ilkxfl7ZcCOIdEqTgCQbXNJA83JiPHT7h3960rVCYNmJBPSq+znbj3dt+BH25C+Y2mJMr3eMgapxdMWK89+Hvc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3287.eurprd08.prod.outlook.com (52.135.161.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 3 Mar 2020 08:12:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 08:12:49 +0000
Subject: Re: [PATCH v7 00/11] error: auto propagated local_err part I
To: Markus Armbruster <armbru@redhat.com>
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <87y2shdg00.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200303111246391
Message-ID: <87abeabb-c8ee-ed6f-6b3a-b3fc24d07b89@virtuozzo.com>
Date: Tue, 3 Mar 2020 11:12:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87y2shdg00.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0146.eurprd05.prod.outlook.com
 (2603:10a6:7:28::33) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0146.eurprd05.prod.outlook.com (2603:10a6:7:28::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 08:12:48 +0000
X-Tagtoolbar-Keys: D20200303111246391
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6451adb3-e14e-4ca2-66b5-08d7bf4aa989
X-MS-TrafficTypeDiagnostic: AM6PR08MB3287:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3287FE441B1DA4DAFD75BE7CC1E40@AM6PR08MB3287.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(376002)(136003)(39850400004)(366004)(189003)(199004)(16526019)(81156014)(36756003)(86362001)(6916009)(6486002)(7416002)(54906003)(478600001)(16576012)(52116002)(81166006)(8676002)(8936002)(186003)(66946007)(31696002)(66556008)(66476007)(4744005)(4326008)(2616005)(5660300002)(26005)(2906002)(31686004)(316002)(956004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3287;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+fhlR43Eb8qE71knmAwcIdZfEYV+HMReDGVbQzJhIyfaP6N5th+aMZZKzCMn0xj6g9GDpcOtr3JSxyJRsuRrlum++6ZDAmH56E3Z3ZVoQ16sK9nr1wxbKw43trO3L/5Oi5/hR/Ql7DmQwKQBhxKi45swGwLA1nSgR6Yf4LtD//+9sAl+1HdrmreMN2PY4njlqg0lK2bOOsLLDDT63LjfZfUh3DOmVVLNCkzJyYAHONVd5RKyfgWoGwPsTGlodyyO3+BPmwqhc46dVYHgNefazxXnipu3EbMtOCFjSgQzlXdRUKUobTPf7wc29NKmFGbYoPqVh0rzdWqNx9jHxAYwMd4XV2P74EW3DMDqpL7BRiTmIiYxLWflnBy1lgWcJocww6M/+qqL7qcqSzDV1NYMwNIqd0RpEXV3P6i/ceJ6d1ztUmpoujW9OlYtw+UOUAN
X-MS-Exchange-AntiSpam-MessageData: gNY935rUtjuY+dLqkQAG2EomnVrdof9fV2ZE8NJPWI/84lkFti0/p3UDeThaiEihHbgO6kDAS2tgYeTvseXHAi0MH6YLt7VFEyiCksj/Mpb4pjaNOcxq0SEeOhueGsgjq+OjLyX/u3qBeDLLLKXVnA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6451adb3-e14e-4ca2-66b5-08d7bf4aa989
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 08:12:49.0293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs/SFqutS1jlJmj54CFKn+LXdWeRmPK1P2PYuMlAZ1iNZ1VGqy10o5/wM+yz4gAyFuox+D+praoIySRrD7aZfsVr9Zmaj+xKegrAGunkZkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3287
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0c::71e
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
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.03.2020 11:01, Markus Armbruster wrote:
> Hi Vladimir,
> 
> I've come to rather like your ERRP_AUTO_PROPAGATE() idea.  What I
> wouldn't like is a protracted conversion.
> 
> Once we're happy with PATCH 1-3, it's a matter of running Coccinelle and
> reviewing its output.  I'm confident we can converge on PATCH 1-3.
> 
> It's two weeks until soft freeze.  We need to decide whether to pursue a
> partial conversion for 5.0 (basically this series plus the two patches
> we identified in review of PATCH 1), or delay until 5.1.  In either
> case, I want the conversion to be finished in 5.1.
> 
> Please do not feel pressured to make the 5.0 deadline.
> 
> I can queue up patches for 5.1 during the freeze.
> 
> How would you like to proceed?
> 

Hi Markus! Funny coincidence: exactly now (less than 1 hour ago), I've
started working for the next version for these series. So, I'm going to
resend today. Of course, I'd prefer to merge something to 5.0 if at all
possible.


-- 
Best regards,
Vladimir

