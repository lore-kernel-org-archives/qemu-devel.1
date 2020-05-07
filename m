Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E402FC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 07:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65042075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 07:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Bc0lDAmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65042075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWaej-0001j0-Sc
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 03:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWae0-0001Fa-Hz; Thu, 07 May 2020 03:08:32 -0400
Received: from mail-am6eur05on2127.outbound.protection.outlook.com
 ([40.107.22.127]:42720 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWadz-0008RH-LF; Thu, 07 May 2020 03:08:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv9k5vECyQIl+qLY7dyiFsUmuQsgNkQiTWDklz0GSAXM5+X9gnYE2dE2PZr8Ss824gGMtH3xifVteRrkEqV8ojg4noMMVKtqeTicxDWOmJWBwKENZOd3p2nrndWpdJ88tFlKlZZqlVVKty9m2TAhkSl/GvnDcXE5qAS4Hn8gyYXI38cocDIOCe8TAUadrJnllTbbWReXfkatDqomWlr8pow9IgE+Vb03uz4DpjVbcPE+pMogHW4thF1+8C2EN/5/jH0FW2L2i2pRZaLz9fk2Li0b6icQydQXx5e/jJXoCY8qOp8oDLlY39+eSoVW+uq1U6/dxRemn4gcWzsTuqz2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa3VwSwF7Y1US/T79SKizQ3mPPU+IuGKeN6TxME9hoA=;
 b=BXMuv9R5uSLyixesKTm1kYvmdG2mgej87w5F5HyTRYinoi6jlznf+Qbd6wdniuOG17ULd5IJbGSy9Hv+7q5nyn9BBwQIvfwbe3gAYarQmSsRKUJg3t6+B8gloWCWXnJThbBqQMN9m1OHF66GiWW/NLMbIUVtKSJ1QVFJmXjnQgKSmNluTIuUGLVktYA0nAre0+o6UF5v6O7JJDOQO7+9wKEdDLkFsPFP1uqOOChqdT3lOwkO8R6gkAsWJWmpkl21u/jPZSV7x89NwrQON0wsk7fPIkRFWnpI+7ZgIux2mpsMka3BEs6i6Q0M2UQCuTK698wFxdkfj1/Si9Dfu6QMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa3VwSwF7Y1US/T79SKizQ3mPPU+IuGKeN6TxME9hoA=;
 b=Bc0lDAmDERbRFFhiZ427ZnvrdbwRL3ohH3gD57Vz+mOOjxGQMMUf1XUpVGALhrqQI1ZpFkqceqQJLCN3/mcNjJzX+Zz0LmZY+uZEBA8vrSHdSiSTMeqwjtwBiM9frijpil6B6ebV3IhyGc7z16F3l7KmZBxCYOIRv09RU3DzOCE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5479.eurprd08.prod.outlook.com (2603:10a6:20b:104::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 07:08:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 07:08:29 +0000
Subject: Re: [PATCH 2/8] block/vpc: return ZERO block-status when appropriate
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
 <20200506092513.20904-3-vsementsov@virtuozzo.com>
 <235e0619-3b54-28fe-d1b6-d00ac1d37cfe@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200507100827241
Message-ID: <b0252c4f-e2ff-536d-cd8f-9e01f4165577@virtuozzo.com>
Date: Thu, 7 May 2020 10:08:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <235e0619-3b54-28fe-d1b6-d00ac1d37cfe@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.171) by
 FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 07:08:28 +0000
X-Tagtoolbar-Keys: D20200507100827241
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 952115c8-b7a2-44e9-b47e-08d7f2557194
X-MS-TrafficTypeDiagnostic: AM7PR08MB5479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB547937AB55225FA66E9450E0C1A50@AM7PR08MB5479.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/AVLK2rluRTTfcJdwOQY1FMH5OmdGBNq9XhcJYffK18EJtZAkp1BO6cvPO476rPE5MDJ2mvAUC9ZYPhgo5/3brOehPIN8Y3M159TgsJyYpnsLCwcvYyGmH0HGK9rz17lkWmgoAcZ1Wg+462s2BIe66U6vt5NhDuYMTpGwStaUAUpy5A6j9Uu5v4O6MD6AWArhehmgl2MJXw+PwTC1V5RScoyLMkRWZVq63SCKwrW3o7o6qEJSCKibOpkMGPdU7Bx/ITad5Ey2cl3hbldqJlkL3950C7Fw+mzvXPfIWOt04KWn1fUEsOgh6t5LcyjRL8W4hZhxBfMvLvFWUe/07Qxm4HRyZEdaFIz1QR9p+hOSIFrmrBeZsC/wR67xHP8WVpGgPEX4uhdEfZ2l4kG4i6Qyv8JfWHOIhFsWqeTHQhFOuxdKsnaeW4/K57W0bVPmCnKnYbody9fvJnbQGsCyR2UtpejVYPjgpcTcB+AJUvntcz9UrEJVtYvgfv9xRPr35mrz7rdR7w5ljgWCh5L6nuUKTNnAiXRlhIC8zp9GDRoVmErAC1U462/Yk1jcM8sk/k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(366004)(376002)(136003)(346002)(33430700001)(4326008)(16576012)(33440700001)(2616005)(5660300002)(956004)(36756003)(478600001)(2906002)(8936002)(316002)(7416002)(66946007)(186003)(66476007)(66556008)(31696002)(6486002)(52116002)(8676002)(83320400001)(16526019)(26005)(31686004)(86362001)(83280400001)(83300400001)(83310400001)(83290400001)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aNsytQD1yCwWNw/vnBGm+7+mian8BEGYCQHNaGfZAJCuWA420Abpdltwa/YJox5H1Z+jQ3Y286GNGCE8sr7FE6lTkibup+xBGWAj+3ay9QxNN1i3Bug5V9SGGp7cgy4/cLAF66Cz53v813YBzzoY0gFIgQIqU990+mmiBIc3qMK9tz931xJUPUhYEYFnTOzz8V2JRKBqa1T1fvq0H7qdVJFcj8qazogjJ+Ph5D7bQAazx8JCxIbKHfkIefn49SvcVLRnYi6zKyG312qDOE85/bSfIoB5iQIRAt190EH3POTi/wNmH/ooCYC9ENQCDd8TsngjibpfKiE4h5DEXhAEm+zxTLRIad4XZNAb/YLrfW/dupZh98Z/1VlZYKHZ4euquU2qHRiVIV1ai8CProc7+tXUztWpWpRVCeTiTBs4kOYWCCRDaO+AIbo1b1KVMaLdzyGu/c8MJMPByoU7KYncDSygQrFomaUXkEDE8uMOh3OpwWtCbWlTTq9EhoybjemHbPqkwyIZxNIg/SV4fbun96mpvM4VlegL+y255vUZx7VIOObeYxssStk5+/PlaJYwI9qO0NWPTlKYpRIQJHh1cZImZMoyN/lH0JDyL8av+8uVIrggiLZv6vhrXS87FYCNzTL2dWHhwNtXgRs2EePEYA8lEzTDDi+qs6iVtan+yoyO2i7eP0ah5jT4FjWcWuBp4SIecARIoVjfE4IWr842uP1dr0VC489tQ6HIBipSEYu3xd/kxSXumGyRp79qFCtHiR4nBvOKq5vBnf16++/Ik7CGP/Pw8nNReLYtPM05rcM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952115c8-b7a2-44e9-b47e-08d7f2557194
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 07:08:28.9311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2v71O038PObpPTkfFyLuyVxhxrofV/M8x1unHUcA1RuPNO/im7UZ8uA7doG1Kk98IvbozHQ0VZcHMNFMss7ldeh4wZkU4wfpjffT4WnZncg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5479
Received-SPF: pass client-ip=40.107.22.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:08:29
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_DKIM_INVALID=0.01,
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
Cc: fam@euphon.net, kwolf@redhat.com, ronniesahlberg@gmail.com,
 codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.05.2020 0:18, Eric Blake wrote:
> On 5/6/20 4:25 AM, Vladimir Sementsov-Ogievskiy wrote:
>> In case when get_image_offset() returns -1, we do zero out the
>> corresponding chunk of qiov. So, this should be reported as ZERO.
>>
>> After block-status update, it never reports 0, so setting
>> unallocated_blocks_are_zero doesn't make sense. Drop it.
> 
> Same analysis as in patch 1 as to the lone two clients that cared, and the fact that we are changing 'qemu-io -c map' output by reporting data as allocated now.  But I concur that as there is never a backing file, the change is not a regression, but rather a bug fix.

Note that we have a problem with meaning of unallocated for protocol drivers. For example, iscsi block_status return 0, and it means "unallocated garbage", i.e. not occupying space, read may return any garbage. But vdi and vpc are format drivers, just don't support backing and they would better return ZERO status where appropriate.

> 
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/vpc.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> While the commit message could be improved, the code change itself looks correct.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 


-- 
Best regards,
Vladimir

