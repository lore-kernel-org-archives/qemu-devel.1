Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D0FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3295C20707
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Lkuueipe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3295C20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot0Y-00044a-Fo
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joszU-0002WC-Cz; Fri, 26 Jun 2020 14:22:20 -0400
Received: from mail-am6eur05on2117.outbound.protection.outlook.com
 ([40.107.22.117]:57537 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joszQ-0004fx-Hf; Fri, 26 Jun 2020 14:22:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH2a/pcAXZKo8i83Sk/G84uuRlMeDSHqNaCk4fTIDUX7kycW8/yl81Gd021U1XyPM0Z0P31py0etnEQLv0qk6CXhbD1TG82Aeq4+hSgXg2st3I/u56eyqe9rjYCG9LEwmsvyEQWvhD0j08WgQ9qyfDvSzmXDYmKHvlQIoyqYGSKArKp9uarp5HfOOi+NCkuI3mo6Jh3J927sij89WgXVRQC8PSRE/WSFJ09FzoDJ2yjeeFK39J9PKdAYFqW96b0SLV0uFwXJIiDjkasZ5KUuvpHs59WtF9Z8JVc6fwyq9ESRceLqxf6FsQ+Q1MvoG/UhP7CL5USlkuTl53kDL1zwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pi2OX51hvDEDOkAGVZwPmo9k1EcbT3vQMcZfHJbOEVw=;
 b=JFEaA1GKWzjiFLe4ygVmqlYetivHvz0detcgzh5k7qxFe/iY8JoJ8mhELMp0TKV0FzHDZCxhjuTssDNoW4A+GpnP0tqWiC2KSkIvgfk0uoYjMWbQiTiykqfIwG39zsrhO/o5YAX32ex3Eo/n1yLZOviTmpbmzrczluzG5hZwqb8rNNae7VcNPQz9EwgCU5SsusDNWgR6FupEi8sNH+k5DBDVYonb73ELYZH4VRcxNu3kGiFu+CR/NKh5gF7t4rJ5sO5F975DbiT3nZdLpVoPcndl4R35SwIzbwKiB7L/ykWPtN7kW4ytUJF3soaIvCMSp3ONh5t76EHXJU8CMBYYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pi2OX51hvDEDOkAGVZwPmo9k1EcbT3vQMcZfHJbOEVw=;
 b=LkuueipemJCm/Rm1ofvN+Z8SnqqrWifUUQ+0p79R4IolvKoL0e+WYI87Q32vtBGcLlZ9HTxL8jguew2O6ZhjW99nVx/ORRfjDRO2BkO6lbk1qbQn2tjshQTKIp0XeCZ+Zp36zNeFsPEAgktSOHlt3197+HBTLXT6VNxj9nHkoCc=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3718.eurprd08.prod.outlook.com (2603:10a6:20b:81::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 18:22:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.025; Fri, 26 Jun 2020
 18:22:13 +0000
Subject: Re: [PATCH 08/46] error: Avoid unnecessary error_propagate() after
 error_setg()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-9-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5e155834-78c3-4a64-834b-7d83328d7bed@virtuozzo.com>
Date: Fri, 26 Jun 2020 21:22:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.7) by
 AM4PR0101CA0046.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Fri, 26 Jun 2020 18:22:12 +0000
X-Originating-IP: [185.215.60.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d323e007-3ba8-40e6-f8b7-08d819fdd8e7
X-MS-TrafficTypeDiagnostic: AM6PR08MB3718:
X-Microsoft-Antispam-PRVS: <AM6PR08MB37184C3AA87630EECE2E9659C1930@AM6PR08MB3718.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SUFliRUqNVc0bLPmmqrQSlj5JGKC7KRBsV/L+wrVEVBEdiIVfxR6g1Wliy19zsdM3+BBuTthIhmUK5uJEEpnRkZf1uKJ6hawIOM8/GxDm+VlRY2M1t3vXbTvaB1dFiL9HMZqFmxRZBKscOFs+3fGHo/BpGE/ECZNYKF8fd1naR6Pr8qdwMbQaAMtGBcaU5Fk5QQbvO1h6a7mPnI/URU6t/vq4yKSk/4cMQudn8KCtkhMA7/I/6u3BBITViP2EHJ7fe41JYLxHCuwd33gILgd+bqv2ZlgRu9HasrAPENsbcGSBvbWWlcxfpAipyEFxFdvAz8j9yVj57LsW0+ek0G58F8xjnwUdeuatBDSboO6xWGjA1uSsxWZn6Y0SOEgnUi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(8676002)(478600001)(66946007)(31696002)(6486002)(31686004)(8936002)(86362001)(4326008)(5660300002)(956004)(2906002)(66476007)(186003)(66556008)(316002)(16576012)(26005)(83380400001)(16526019)(2616005)(36756003)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0ykezujOhBoJ4XWwgEEw6eRSwPTC7SO+qbtT0H6bPAIErUrakyHcrXKCR5HrhTz1yWEmLzKd2/jnQAKui5dp4Izr2sbGLcl/xyUrscvowZ2uzYZ4ft9llfI0Rj2uxXKRXtKJpU0HRnnDwu3ZVSl/SFAnh2M7ESgDUm12onagWqLwvutWfzM1CZAykCrm3SbvR5OYYBzSWSNQ6IqOZgi/LMM/gFf46T3435nkSmKoxXDz58e51ZzxLKOYJ3YYPqtmqanG3ZyoLtlBtQ51DORL8L9qjsptNq7RX+dqDNfoDaa3Dbgjb0lpII8HpOJaTPawoCe/U8AFl1kEKUJeE6KYi6suunFd1okw/zrpM2QHg8ZYn63M3BgOOZGuXrio0cLY89BMpU2ZLmb2nWnhJ9PJLz4P9suALA6M9pBxx+QQoqTfUJu70F8PCXQtlHHZOLECcj2E1mwIib4+b4ht5onXw1CIF9yU6+WMFBFoQFIH5lY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d323e007-3ba8-40e6-f8b7-08d819fdd8e7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 18:22:13.0332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOv+NEvlVcgVgPCLQCGXcnQATAyyfepLLNyC8HdJ+jx7dSTEESuth/X3qW4XIcGwb90Ofd//IvFH1nl7lXBhU2d1koyEaredrzREfi4IJXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3718
Received-SPF: pass client-ip=40.107.22.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 14:22:14
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
> Replace
> 
>      error_setg(&err, ...);
>      error_propagate(errp, err);
> 
> by
> 
>      error_setg(errp, ...);
> 
> Related pattern:
> 
>      if (...) {
>          error_setg(&err, ...);
>          goto out;
>      }
>      ...
>   out:
>      error_propagate(errp, err);
>      return;
> 
> When all paths to label out are that way, replace by
> 
>      if (...) {
>          error_setg(errp, ...);
>          return;
>      }
> 
> and delete the label along with the error_propagate().
> 
> When we have at most one other path that actually needs to propagate,
> and maybe one at the end that where propagation is unnecessary, e.g.
> 
>      foo(..., &err);
>      if (err) {
>          goto out;
>      }
>      ...
>      bar(..., &err);
>   out:
>      error_propagate(errp, err);
>      return;
> 
> move the error_propagate() to where it's needed, like
> 
>      if (...) {
>          foo(..., &err);
>          error_propagate(errp, err);
>          return;
>      }
>      ...
>      bar(..., errp);
>      return;
> 
> and transform the error_setg() as above.
> 
> Bonus: the elimination of gotos will make later patches in this series
> easier to review.
> 
> Candidates for conversion tracked down with this Coccinelle script:
> 
>      @@
>      identifier err, errp;
>      expression list args;
>      @@
>      -    error_setg(&err, args);
>      +    error_setg(errp, args);
> 	 ... when != err
> 	 error_propagate(errp, err);
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/cryptodev.c        | 11 +++---
>   backends/hostmem-file.c     | 19 +++-------
>   backends/hostmem-memfd.c    | 15 ++++----
>   backends/hostmem.c          | 27 ++++++--------
>   block/throttle-groups.c     | 22 +++++------
>   hw/hyperv/vmbus.c           |  5 +--
>   hw/i386/pc.c                | 35 ++++++------------
>   hw/mem/nvdimm.c             | 17 ++++-----
>   hw/mem/pc-dimm.c            | 14 +++----
>   hw/misc/aspeed_sdmc.c       |  3 +-
>   hw/ppc/rs6000_mc.c          |  9 ++---
>   hw/ppc/spapr.c              | 73 ++++++++++++++++---------------------
>   hw/ppc/spapr_pci.c          | 14 +++----
>   hw/s390x/ipl.c              | 23 +++++-------
>   hw/s390x/sclp.c             | 12 ++----
>   hw/xen/xen_pt_config_init.c |  3 +-
>   iothread.c                  | 12 +++---
>   net/colo-compare.c          | 20 ++++------
>   net/dump.c                  | 10 ++---
>   net/filter-buffer.c         | 10 ++---
>   qga/commands-win32.c        | 16 +++-----
>   21 files changed, 151 insertions(+), 219 deletions(-)
> 

[..]

> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -282,9 +282,8 @@ static void execute_async(DWORD WINAPI (*func)(LPVOID), LPVOID opaque,

You forget to remove unused local_err variable

>   
>       HANDLE thread = CreateThread(NULL, 0, func, opaque, 0, NULL);
>       if (!thread) {
> -        error_setg(&local_err, QERR_QGA_COMMAND_FAILED,
> +        error_setg(errp, QERR_QGA_COMMAND_FAILED,
>                      "failed to dispatch asynchronous command");
> -        error_propagate(errp, local_err);
>       }
>   }
>   
> @@ -1274,31 +1273,28 @@ static void check_suspend_mode(GuestSuspendMode mode, Error **errp)

and here (I assume, you remove unused variables with help of compiler, but don't compile for win32 :)


with these two local_err removed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


Ohh, my brain is broken, I'd prefer to create such patches than to review them :)

>   
>       ZeroMemory(&sys_pwr_caps, sizeof(sys_pwr_caps));
>       if (!GetPwrCapabilities(&sys_pwr_caps)) {
> -        error_setg(&local_err, QERR_QGA_COMMAND_FAILED,
> +        error_setg(errp, QERR_QGA_COMMAND_FAILED,
>                      "failed to determine guest suspend capabilities");
> -        goto out;
> +        return;
>       }
>   
>       switch (mode) {
>       case GUEST_SUSPEND_MODE_DISK:
>           if (!sys_pwr_caps.SystemS4) {
> -            error_setg(&local_err, QERR_QGA_COMMAND_FAILED,
> +            error_setg(errp, QERR_QGA_COMMAND_FAILED,
>                          "suspend-to-disk not supported by OS");
>           }
>           break;
>       case GUEST_SUSPEND_MODE_RAM:
>           if (!sys_pwr_caps.SystemS3) {
> -            error_setg(&local_err, QERR_QGA_COMMAND_FAILED,
> +            error_setg(errp, QERR_QGA_COMMAND_FAILED,
>                          "suspend-to-ram not supported by OS");
>           }
>           break;
>       default:
> -        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "mode",
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "mode",
>                      "GuestSuspendMode");
>       }
> -
> -out:
> -    error_propagate(errp, local_err);
>   }
>   
>   static DWORD WINAPI do_suspend(LPVOID opaque)
> 


-- 
Best regards,
Vladimir

