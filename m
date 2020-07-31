Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176FFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63612245C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="VjOsUGPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63612245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1SLX-0007xa-32
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 06:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k1SKY-0007Li-De; Fri, 31 Jul 2020 06:32:02 -0400
Received: from mail-eopbgr70091.outbound.protection.outlook.com
 ([40.107.7.91]:36993 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k1SKV-0002wF-AL; Fri, 31 Jul 2020 06:32:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJUseNN1oCIGB7t+inw0GVUjpIa6t8EJkWrp0wB6XZmeNEjCMfN0/KNPrCFYOU4oY1K8Dkci/S0UocdVM6ywQOSlw+NLuoFTJKI4kMYHjCPnLi96Z/fvLmBc39nXOCbialGtw03PDnt+rhx2+LVgcItX70VynMlAkJtcxSBIlOLnCuAFmvW41ENBX/DcpGZOqqz18+wizaYRqw6GCyBgXetp9VmIkUa5s5lFJIft4a7PE1hLZJUUGOwvSeoiguZRNEIMPuAWeYgKYI3UK4oLI4niOl5cFx6vXCXkm+SgKqC/OLoq16VVnaiHL5deJiEN1TiqbkKMjXi0KtInFO8L6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkGcpDc+JTa2N/sSVkRnh4ygiqgIsgmx/gzH2BdO/ps=;
 b=Y8VfS1xyk0Vjd+WdCj+vx1I1Jlcm97M2FzTRQCqXV9ZBbrnJhdbA3l1R7tH7lsUNkyKFlZPDctIxpI+TCjLBa9LX4dUlb33wtP+cs613zS5IQiAuLZfnkfkyfP7jHN/qJ45IpL9jNZYEvRA10WjlXe30N8uMYHygA2T1L9ysMuFYXO6B35TXgWm8fnmTIM79COTmFTAt7f0buKE09Xs0QlewWE+dRVeiA60Wh9aOW56DnaAfzwJYUEuvW59VzIP3XpuTOh1g61Bgf5Bs01Cc72xT9CV5gRH4S2Sxc62xoPHiEqF6Ky/2OEECYlOffCIaZlZHvq9lSCokNv7a7NYTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkGcpDc+JTa2N/sSVkRnh4ygiqgIsgmx/gzH2BdO/ps=;
 b=VjOsUGPS08IzZu7dpUDtUgEFALBTNE+2KTOT9/bIgLykJ0caFG+dkwU/2qdQrS+tpIzMmHVjlPBwUCzj7nqiC/u1aqgGZHZvFYAycD2cOQcMR4uCBbQZV8xGu3i/FgjTPdCqyeZLNDj3HTNGDY8ghrk9evjG7DzPLiI7CYZX5CQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3224.eurprd08.prod.outlook.com (2603:10a6:209:47::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 10:31:53 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 10:31:53 +0000
Subject: Re: [PATCH 0/2] block: add logging facility for long standing IO
 requests
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200710172711.8059-1-den@openvz.org>
 <20200731102531.GC177875@stefanha-x1.localdomain>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <43df6148-cec5-a866-4b81-7f4020c70f7d@openvz.org>
Date: Fri, 31 Jul 2020 13:31:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200731102531.GC177875@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR1001CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::22) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR1001CA0012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.18 via Frontend Transport; Fri, 31 Jul 2020 10:31:53 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6cf4617-db05-41ec-cc01-08d8353cf169
X-MS-TrafficTypeDiagnostic: AM6PR08MB3224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB322489EC0308B218A475F147B64E0@AM6PR08MB3224.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ig7WUdpVBtYYSSIPqgkbyDfb46b6z6pnFJepTZXI3E3Vdif+5HmGaqUza2VsnPETtpYu0DE5s8NT5kqn4ZUwvYihXF3/lo2C+MWhCftJQfQssZCzbPG92Sc/aJmg+nB4k9hCI411VF538ClnmYlg5ffjVVHrYENw+OqQOIoFDEGJ7/WNGidWCwYtK8IwofEl+du67esPEIyO+T0gaIcmao8Z0Iednh8ichDBRH7iS8bWD8VDD1DQfX8LYAzGCmXPSucjnIt/taE4AO4yeTqTy089taMAOQbwpQqAFQkCwGLRj5/4PchTaEXDfSEI+Fl85VXX62X+MiwL5jAzG26cHftwNUPVYk00TRLJLLqFFZrN1QloEFUPOIj6cnC8mhLQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39840400004)(6486002)(36756003)(53546011)(83170400001)(5660300002)(956004)(16526019)(2616005)(478600001)(186003)(52116002)(83380400001)(2906002)(6916009)(42882007)(26005)(31696002)(66946007)(66476007)(66556008)(16576012)(54906003)(316002)(8936002)(31686004)(8676002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ehm7dPLayH4nzuYtbI7wArQqrxgUOTuBlqQ8Gh1KJU4B68lDYn4DaoP82fRrApYsKsIt7d7Z4BrDeekzEv0p0tyUIDkjlkUUL6nWKgbWJL4JV5hbgFtoQ5EE4F1+cF6TmG0WDMB74Yqhos0/jlMe/scGWk4qBhY4wFNwubR/RavD7p1xgmge0CQAkSQLjpDZxjihAenN/3GvxIvt6bgMC6YAtHSeGzBZNOHDob6oN9XVu7c6ADJYDfXfJ52yolDVa4ebCEyhtZ7ywnqUEt7ZbJokLn7QmcCp+JoD+Ddeo8dcVJqHsVhqRxf+esJWKXvR7P2mUSwdqruqc2nXb7zZQGJ9HrSq19U350c5xuNwbnOiFoKvRdUgRz3ny8wmVDx6TYJiFHJ9k+DmywJNPsb/qFe6SA0LP1Nrn1KVdnr30rFtCmUA+gCMLYrNr3sZmgzX32oO/OSv4RFSGw5NsMdL10z8vgEeb2ldkHXv5TkiZoh11XOSRR72YATZww/rE0xRUE0hcHdfXOVrq3NX80Qaluoz4ngF74arkoqa8tO/ajgvMysu1/g9fzNY60Ku3XsDX0ZUWAcgfsqJKdaanMGBJxd0k4JNLPh+6nQUz3/1ZZ0cgjjrWAuC/J6aB5JiF89F7Vz3zgOxAUVxnjELK7k4/w==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cf4617-db05-41ec-cc01-08d8353cf169
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 10:31:53.8407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysNDp64FTMAobYUnD8zEtR/dqo8sjNS3n1XzdSIcD0wwEmI51T1Ge1GK5otZBO3+YchdP7qLt6SN0rV3yGGuFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3224
Received-SPF: pass client-ip=40.107.7.91; envelope-from=den@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 06:31:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HEADER_FROM_DIFFERENT_DOMAINS=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/20 1:25 PM, Stefan Hajnoczi wrote:
> On Fri, Jul 10, 2020 at 08:27:09PM +0300, Denis V. Lunev wrote:
>> There are severe delays with IO requests processing if QEMU is running in
>> virtual machine or over software defined storage. Such delays potentially
>> results in unpredictable guest behavior. For example, guests over IDE or
>> SATA drive could remount filesystem read-only if write is performed
>> longer than 10 seconds.
>>
>> Such reports are very complex to process. Some good starting point for this
>> seems quite reasonable. This patch provides one. It adds logging of such
>> potentially dangerous long IO operations.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
> If I understand correctly this only reports completed I/Os, so if the
> host hasn't given up on an I/O request yet then QEMU will not report it
> is taking a long time. In the meantime the guest could start printing
> timeout errors.
>
> I think this patch series is good as it is. In the future maybe a QMP
> command that lists in-flight I/O requests would be nice. That helps
> when troubleshooting I/Os that are hung.
We could dump requests at block level, we do have proper lists,
but the would be a little bit different.

Anyway, I __DO__ like this idea, I have missed this somehow :)

Thank you for the suggestion,
    Den

