Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44120C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CF92084C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="uh8RpHLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CF92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPdA-0004Sb-9Z
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jrPcD-0002gI-5M; Fri, 03 Jul 2020 13:36:45 -0400
Received: from mail-eopbgr30139.outbound.protection.outlook.com
 ([40.107.3.139]:31556 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jrPcA-00077R-IT; Fri, 03 Jul 2020 13:36:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vxp1mYJmq7CqG4IQA7JGZxVsGJW8vx5eyPkrAr8HbiwVWVKNhqJPsWzIO2YdJhpwE4cd8q8QVnxhfOpWBGTYmSWbdXbLBEUFV0uLO5I7Bqxc3SbV8uTp2m9yauOSEmkz6xWC9ABi1pBjlQ8KkG13Wtd9hPqhEJVj5TpDB6bJtxHNjErpaE/wa0hU/IwBNeXego06hd2FnlYKQ1DhbFD3bonN7lQVb4uhIGTKhqC48AjAYzceC4AOzQgdSsNuwY9JLmiA73Zo4IjoZ2zUFKNTWIUWHNCW66ihUiDdX5zzj8Cp3Y79vM3VZGC9Hfcq9kd+pzCTxjBUhuzRVqF3A6rAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z36VX7SNgukkd8u14n5sYCfvEppR6iV3ydfCNYQiZVo=;
 b=A/+HmZBkJnC4WsgRHf5AsVoH/khsRMyyJpSpCOCokbg1KXq+BFighBYIrmgjTm2P1m9iYr+uPROlDE/pP4Fabl+ZFE/SVqreyF4dbsfqJZhQZpRYcFmXgV6CAmN0OkSxGgI2huGTcioucR6Xsj/6AzYwR8l1ZaxSA7Ywn6kC+KiqQlKhOl+iPXz4Sr0UCZ2+yDW3lPzsf7NsCmhQ+GNOBEmYAjl9kawsV2rJNRCNpLpsGuP5pPV3hf5a7y5qIpd1Uaman0sHvIO8MpPimsea9WH57YY0BjUwr2bs4YTTZczrl2M7P/7bjF8Jqjb6+UujOIST3ntMFPlgLI56GTg1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z36VX7SNgukkd8u14n5sYCfvEppR6iV3ydfCNYQiZVo=;
 b=uh8RpHLLxt14Sdo2iAz16m7lBgH2RL4VIcMS8/10K1L6NvfCpjK8moG2MHgFWJSk54ngvB4dIEy/z0j1Oh4Y74hz/eZOE0iasOB/IOXmv7fq0Bmbd5MdzP4gBgUyJY6Ppfov2P78XlPFQ+95MEspOUCL6Ti/O1jPx65VrnNMWBE=
Authentication-Results: euphon.net; dkim=none (message not signed)
 header.d=none;euphon.net; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4533.eurprd08.prod.outlook.com (2603:10a6:20b:b5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 17:36:39 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 17:36:39 +0000
Subject: Re: [PATCH 0/2] block: propagate discard alignment from format
 drivers to the guest
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200611171608.22052-1-den@openvz.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <258241ea-d1c9-02ad-c8d7-7ba993652e76@openvz.org>
Date: Fri, 3 Jul 2020 20:36:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200611171608.22052-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0401CA0072.eurprd04.prod.outlook.com
 (2603:10a6:3:19::40) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR0401CA0072.eurprd04.prod.outlook.com (2603:10a6:3:19::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Fri, 3 Jul 2020 17:36:38 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95b7575d-c1bb-448e-09f1-08d81f77a426
X-MS-TrafficTypeDiagnostic: AM6PR08MB4533:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4533B19F103891AF1678C167B66A0@AM6PR08MB4533.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUE3OcWs1WKPpUkQC/tQ6/3W9TK1ZYt0Gt2dGRTgSvnWLNqf0BnQygPReEq4URA0PyVqkuuQPK7kVTfY8MDkDzmNR3tvbLUlSit8CQyyWnNEeBOzXQiwcjN8H3OexdVXC14XZJ3BK6Bx4CqpT46fIsvOzGW5y8Kq4NKPvWGK5eER8vTEr1RuSljUL82HDfBuv8re5SXANtSnrS39PgPChe5aFal0hIkRyEjjhu66RlaPwr7entLjVG3Bd412MSdj8q68F5HgMc2VBhgVcQ3bPvetisyRfPDLQQ7aHUrVTk2cf1kT2P7JadTvOtvN5TbDi8jsrMzCeJQM7GvtH5QWGShUS+9sUNfoY2NDM/BOpiHpzJeUb50cpRKY58f379g6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39850400004)(136003)(52116002)(31696002)(8936002)(66556008)(66476007)(316002)(2906002)(26005)(478600001)(83380400001)(66946007)(5660300002)(83170400001)(6666004)(53546011)(8676002)(31686004)(2616005)(16526019)(16576012)(186003)(6486002)(4326008)(42882007)(956004)(54906003)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9N5lUlVmd3sEG5Hkajnk96C+LXB/RRUfqkgCaspCmf3nhOdaFlKLQuHsTdQ9fckZj9qEudEquB5rzEhvM01tdlbplyRde3xg76ZgFfwC7VeXF2IRLed3EvC0JrzjqoJDeMZvxFskmw7dNpc94CvokbJdJbD32e0Kw27fNADnZQ8ytr3evsN1Ryd5weDxtomdq6UzI78oIqdmY0EzMRK/JFxr+A5ypugJnL22fNPcCrohN4okSW9ZeovdBzl+dHb8KnuIQ4APfQbwRSgBUsu1dpObVas/Wzqr/iCWUpVURo7bIyVjEf+xI/rTYh5RXQMcM5UsUnq1jFxREBw2RdihvMM1b3+eglO9r0blewQs7XurBNUT6k8yK02OkU5MY0/AHKbQ8ehDaoOMGSy2iEY3JsK/1fb4JU3Hazc7wPbvo7zQ20HZA1yno49Lj9Zry0lhpLPOr4xYTB8lBac4sPbkrY16l7DzR2sELWLgUTrqFzI=
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b7575d-c1bb-448e-09f1-08d81f77a426
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 17:36:38.9860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Em0j591JrOA3IseUuj0/QRScl9mlOAHLTNpYKsQTcfMu8xJzVVWUTZdYrdIHkLog8h/Z/9rzi/hdI7VxsWas8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4533
Received-SPF: pass client-ip=40.107.3.139; envelope-from=den@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 13:36:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 8:16 PM, Denis V. Lunev wrote:
> Nowaday SCSI drivers in guests are able to align UNMAP requests before
> sending to the device. Right now QEMU provides an ability to set
> this via "discard_granularity" property of the block device which could
> be used by management layer.
>
> Though, in particular, from the point of QEMU, there is
> pdiscard_granularity on the format driver level, f.e. on QCOW2 or iSCSI.
> It would be beneficial to pass this value as a default for this
> property.
>
> Technically this should reduce the amount of use less UNMAP requests
> from the guest to the host. Basic test confirms this. Fedora 31 guest
> during 'fstrim /' on 32 Gb disk has issued 401/415 requests with/without
> proper alignment to QEMU.
>
> Changes from v2:
> - 172 iotest fixed
>
> Changes from v1:
> - fixed typos in description
> - added machine type compatibility layer as suggested by Kevin
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> CC: John Snow <jsnow@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Fam Zheng <fam@euphon.net>
>
>
ping v3

