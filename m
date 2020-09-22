Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B727AC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC60F2376F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="e8kY21Qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC60F2376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmRY-0002Qa-M2
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kKmNM-0006uO-Q4; Tue, 22 Sep 2020 13:46:48 -0400
Received: from mail-eopbgr130092.outbound.protection.outlook.com
 ([40.107.13.92]:53219 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kKmNI-0004Eg-RR; Tue, 22 Sep 2020 13:46:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZeprT6aeYrFaaDSGlPK30ztea8ZA0swNzfH2e3T8G0MHUhtR5B9pLmmgxauy9qiSout8qm2GLlHkRWsoQLuvEy9jSkr3vQSuk+tVa+RYOwJ3qq+nyp12iBHZYaHoZH+6qEFu2nJ11yNl+r0Td1aZCm4FGFEOz2DdGfd1PpUYAkxDc/++S/gni6HW9l6zkkDfTExe4DHyRzTR/xD0ERgvXnlqIXmKkJ2UG/Jq8ScI9e/kb0PpkNnomUA1Lu07bYxYNwRZiiu4qN+E0qr4+GQH84cqQB2XEBejZ/Rv+sAej/Lj+PklaHeWDEAAa5ZIHNS+Ezdu9OEXnH3pGIRKFasqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfrRlP82xagcMMUoPQvddjJ9v/exV5ed0th0dUnyN/A=;
 b=QdMDHol0BmOHdU1z1fGonn9QLsZLGFW7KNiTRnk2k/ou+JZ8dHXY+lYI/LQspL+2dTSd6VU+IKEkqOKvux1AkhtGg5UPchzO6a8lOo/2XHXKvVFxa74y1Q/77Z/Pa1v7dfmo/Xocrw828T9p8Awd8ni3BnKBJyVlJLH5OS6xLPYk5kYi5ft2s44ZxBpWnbmY1dCsDRXi/yRDW7WezDq3/hFDdOyNlh1r9JFqQ4v/8qfXeg7/aLJwWQRSdg74liJquNWFnkblpl9gWsnO+AByM6ONn2sKvKy1NrOPJDvq++K9yTT6VSKSJLavfKTMi6/ZSKRbTVBUQyxnVQY1CxqLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfrRlP82xagcMMUoPQvddjJ9v/exV5ed0th0dUnyN/A=;
 b=e8kY21Qw9qoh19tGkk6O+vm5HnSB0D6o6LwXQEFxVZ/mWTbCyJ3s61Jt2OJJbsZH1wP2bncQNtUErmukLt4lHXTqiMKnTizXocKOtuz4VXksyKywtNAKcx3Sy+yrekpmSsHEsJZ1qCTCM5rQf7VN64lkI7Sz4YdRGzyI4Rw5GBA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3768.eurprd08.prod.outlook.com (2603:10a6:20b:90::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Tue, 22 Sep
 2020 17:46:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Tue, 22 Sep 2020
 17:46:39 +0000
Subject: Re: [PATCH v2 1/2] block: drop moderated sheepdog mailing list from
 MAINTAINERS file
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20200922161611.2049616-1-berrange@redhat.com>
 <20200922161611.2049616-2-berrange@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1fe6bbe0-58e1-1dd8-9795-6a10ee6c136e@virtuozzo.com>
Date: Tue, 22 Sep 2020 20:46:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200922161611.2049616-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0126.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM0PR01CA0126.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Tue, 22 Sep 2020 17:46:38 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a339ff48-785e-4217-abdf-08d85f1f7565
X-MS-TrafficTypeDiagnostic: AM6PR08MB3768:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3768BD7D99C5BF7ADA46F33FC13B0@AM6PR08MB3768.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5pp52TctZvSXl587tKFnMQqyKxojykBSPYHVdDEh9CCauM70H5TpXNa7hU5mXxouTGB6XtP2qR6+6c3SmFVrK8/LyNr6S/4DJVmTc8E9RnS4xfjyprLhvysTBXzHjH9BjBv/X/bGR8WWC7oxdpnhnNua+USVZrGqYJuNXFijx7F8fB6kFaj+iYuDwRUEjzJsGfM6tbXBrdMU5/1G9zg/JU5Hzsq8vRvvf9Nfgln9M47ES0VIS9ToSWc9I+TjgstSRMQKCnmSn5toujGFdGHB7sgnhw40lzbFI+XQhTgaICcucz6yJdtv3QMjMffANU29TD9x8QlewHMirvnHiP9XJwC+4iy3R4LKK54B74jbqvc/n17ChkWxwoWPP+XcCm8iKoAvA1bAour7iWYoxgMQdkMRdoNSZcLbTXkAz5c1jIY094odMxaSq/aBHdrZs7E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39830400003)(366004)(31696002)(16526019)(186003)(16576012)(316002)(8936002)(83380400001)(6486002)(26005)(31686004)(8676002)(86362001)(66946007)(2616005)(956004)(5660300002)(7416002)(52116002)(478600001)(54906003)(66556008)(2906002)(66476007)(36756003)(4744005)(4326008)(223123001)(130980200001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IS7LAUlBAiHcDyG9ShzAsL3pZqJgMgV4mQAcRDiJQCtou6DCA6pFnAQ9kfiy/+MJKVidP27xOB3InOEO62J/BY2IZXED4p3dbssA4AtdtFeRij1zq+1DgKReltTjcIH6OJQnwMHV7eqkOlp7pw+cui5dwRhFh/iuurPN29eeY6GqwytnD3lCIIKBf7KOCS0rA+X/l/33e1EbyNT0f9Bev958TN4jk+klB8/wIA4n6rPU1qAGO/NWWMkiZRKJs7WTvJvPb2Ig0WcmdAO0Ov5mPGorAuzfMoDV6lX7qrCemFzO9bgquRCYIlRAJX3s4UbdK6MHgQQN1IDyFaSy9FiaVXOXx8ZZUL0FyGLvFZFP2TMp4i38foszq+nNhz/du9O+5igTX4eTXXvW1DPUEPsXhbImv86nkghqSMMTQFJPH6CegcTgpyRNaQpPIRwZktcz8RRId38fnYn9o1Rh5rQpvXfhpzg+ApJdgxcvGKOMXCu+mTphHfw6aHAjnIxwcZWPmyRxKfNl8aXLrid1gaBYLgnzdH+wQKyLZEkh/3S4qXcfFsPxnB6c5QBlhEYmvkKHBpNpNE4SW4zdc1z7rn7RZO7elSMl8SnkEAiYu9jteaObzohC9BLizg1taFZx2/PZnelX+QsHdkNt0fXN7bf8Bg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a339ff48-785e-4217-abdf-08d85f1f7565
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 17:46:39.4084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPjmLFjw7IWtC4Q8bQjVQkLU0i3KeGl4v/YalkuTfWbICxeVmz1JlQk2Td66ZLEWHAYzSsPDIid98zbOwsKl9wRu5nRh2TD/QfmNyevoLMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3768
Received-SPF: pass client-ip=40.107.13.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 13:46:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

22.09.2020 19:16, Daniel P. Berrangé wrote:
> The sheepdog mailing list is setup to stop and queue messages from
> non-subscribers, pending moderator approval. Unfortunately it seems
> that the moderation queue is not actively dealt with. Even when messages
> are approved, the sender is never added to the whitelist, so every
> future mail from the same sender continues to get stopped for moderation.
> 
> MAINTAINERS entries should be responsive and not unneccessarily block
> mails from QEMU contributors, so drop the sheepdog mailing list.
> 
> Reviewed-by: Philippe Mathieu-Daudé<philmd@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

