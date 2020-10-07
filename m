Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80DFC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37BD320789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y6McWAJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BD320789
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7zf-0006el-W7
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ7yq-00067n-Lt; Wed, 07 Oct 2020 07:51:36 -0400
Received: from mail-eopbgr50109.outbound.protection.outlook.com
 ([40.107.5.109]:4742 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ7yn-00011A-FK; Wed, 07 Oct 2020 07:51:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr1Ioa24z1HTzp9NUkkUuPg6ZbQ3lvogDxS8oCsgBkh375q1ErA1pXQhb4p0T088zOIV/3NdrCp957182eYJ+Pyhq6Ygm7Xq7VwToD11zxJTHk0jCkyYvm5vQs0ieTzijoOa//nBt4D6GmHZEDAPKoo2OAxLK79gKWbGHHEVpitk/NW8ZcyROjU0AHmlRr64k8lnTihqvHltj4qq3i41cwj/PEq3mYEA/T0I3F5wgUDd+WN8wzit9eywQ+A5GhxdDrNvI9wvI/OGexLaw2vVvEHiza6omxgqrwIiEfugbB+tvnZNyJ/U0TOxrcc9ZGd6iMGsQTLm2L8cnJ7mzngKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/unYEJvhgtFKWgPcspFhR3mKsxDz4GL25zrirDiQVU=;
 b=kW2PqVfHOyowT81djDo6426MQ+gJ9+9B8XtoV7AaGIfPpFznyq7RJNKd7N+WjmaWM5iIjHf0F7XcdXFuQkfp53bai3vweHFO/5XEQ6RW/qn2+qENjehRL3yCLLyeFoUTCRxXWWrDVs9wKPHHViCSAP+mR3eWMPPQs/ItVXAJiyvV/T9RidC0nf/OLZXkiWevxtW4Yan6zG9V+2LRZ1DxAMjCob3Xle/4d4dovwOu59+CfNZvTTR9LeCzxjHN3JroG4uMyQxwEB1RQ3StfF7liOYmdzdhGD4gxmzA8oucu4Bl9l+x7Bi26j8p6dKGyjw2V1mXU2phkWN78KmzEOUbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/unYEJvhgtFKWgPcspFhR3mKsxDz4GL25zrirDiQVU=;
 b=Y6McWAJ8txMJ6db5GLGP9fRfmzyB03QwysAA6MDEEOckphijSKvArvmjQl8xAYMOlB8cjJUVuJixuIruv9R2fPRlJb6Lt/GB5Z/FlVIX+0IRCbcouiICcdSWirvq6QAgEDtFA3VCdFKGXzZKZ3kHpcKsMxWiYxrTFPaF7T+1fAI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3446.eurprd08.prod.outlook.com (2603:10a6:20b:45::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 11:51:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 11:51:29 +0000
Subject: Re: [PATCH v2 3/5] nbd: Simplify meta-context parsing
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pkrempa@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9a8a379a-0f43-017c-113a-a355ff9ec5df@virtuozzo.com>
Date: Wed, 7 Oct 2020 14:51:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20200930121105.667049-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 11:51:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2097bf3-2b70-439e-b2a0-08d86ab75400
X-MS-TrafficTypeDiagnostic: AM6PR08MB3446:
X-Microsoft-Antispam-PRVS: <AM6PR08MB344612E4C7F71517C2F3FC91C10A0@AM6PR08MB3446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tLUqKzLLMcw8Vnja098n/eUXqqXP6A0Qn0rXy/wY2v1lcPZkCsUtzCGXdmH0KX4IUrnKzvQ1S1Di9nMwkWg855QhZL3rY8zNuMVQPXhA6v2hRiqzIzWBHr/4MTS65A2kWWC4czWfs6VMpypz1VphHqS2DXBBx/CEMgNVCzyEqjoxhBRBl6rK2AFz0SxF6bLinqi1AcjR3k/Yg0RwBpIU7FDIxbbqGiAaGY9sQi0bQTY0qKle5jZlA9Xvi0d07WJKa/vM7Z0S+1o39mDUFOLLHwK0OuoFQ3z0BM33FCDC2E0kxJavX9Mms1lbdiAssjD5BeVBoaEfkKR1z4J0P9tQvzBWlfOKgfUfAz8sgHdiag1trPwj53IifZv+d+1dQNA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(136003)(346002)(366004)(376002)(5660300002)(6486002)(66946007)(4744005)(478600001)(66556008)(83380400001)(4326008)(66476007)(31686004)(2906002)(16576012)(16526019)(186003)(31696002)(26005)(316002)(52116002)(2616005)(956004)(8676002)(8936002)(86362001)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: X3miG3h2KIyWrPgg57cEDzfbX1E8KCvtFD3c09QhiB7buigNw8JxDFyU334T76GFYXwws08vwmjhVJsnaPBvUTl9wrzQ8oE2k8Oq2dyBlHSamH0V97ubyKht6mTc7S+PsMHG1JIXWIrHPC0NOAgkN6YfWmJuJK1oW6DccaY71S+9Ug4hijGVW6xdc7A50zNwZ7urGdSx2JE8putyzvqYnJg14Mg8diQaD9K2pXKLFB5csT0QVKWFbcJ+wU+llPFRUuuu4tEMUTrppurqW5FvYmhuFAUjfYUNwCLB0l1PkKR8IU/+lRbwKZ9GKpEta4YgYUC6Npy4OFAyI5Vo8o2uHWrk8Hi51Qp7glBcNDrRkw/Ao7Is0kAcTX6+rnVyH4urz3RG+DvrbBSDoX1NFW0ULxDnUTw8LgM5aSVw9kL2Lbbpanu3nJOvXLn1SETxtiCoqmZbEkITxQ3VhkONFX1UmN38C1E8ia7Rdx4CyFdKxXwPNZrMuiR6VEwHaLZ8eQt8qnmdjzNDMMCXVmLeD0r/gyiC+IFNZ4HPGamqb1nK8ROIiaj3C7vdw9leua0+KebBZjv8XlNvMt7yxifZAgeabPHJbg1zEarAzMB3yEh1bwcn+L+x4LcRk++JASGuiSscGqLOwVs4dF05XThJ5ORawA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2097bf3-2b70-439e-b2a0-08d86ab75400
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 11:51:29.4622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8R9YWcKgVGtD5zN145yXmTHaTeUkizXU92C+d97q/vNRMfxJhAMA04IMf1a8YOtUnkdivz/qjZRU43wsdCrrN+PNyPonOtoqgozGbByP8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3446
Received-SPF: pass client-ip=40.107.5.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 07:51:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

30.09.2020 15:11, Eric Blake wrote:
> We had a premature optimization of trying to read as little from the
> wire as possible while handling NBD_OPT_SET_META_CONTEXT in phases.
> But in reality, we HAVE to read the entire string from the client
> before we can get to the next command, and it is easier to just read
> it all at once than it is to read it in pieces.  And once we do that,
> several functions end up no longer performing I/O, so they can drop
> length and errp parameters, and just return a bool instead of
> modifying through a pointer.
> 
> Our iotests still pass; I also checked that libnbd's testsuite (which
> covers more corner cases of odd meta context requests) still passes.
> 

Also, do not advertise bitmaps meta context when bitmap export is not set.

> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

