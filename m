Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124DEC4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 09:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7B620735
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 09:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OgQQfkdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7B620735
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWFWc-000087-8G
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 05:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kWFVi-00084J-7Q; Sat, 24 Oct 2020 05:06:50 -0400
Received: from mail-eopbgr80093.outbound.protection.outlook.com
 ([40.107.8.93]:7847 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kWFVf-0006Cr-Cj; Sat, 24 Oct 2020 05:06:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ed8qsYV2E3/lC708/2Y1AHAUTDs3HmFh2D+5gNBLdI+SbtkXbMzxZZYnadvkshqQbEKRBhy8TARUYaRZo/8z53EpR+cjW+vtyb4GVKLGlftsqlJe27hrWdCUoeTTMuswUbTyN0xXl5z+q+DFDQAlFkUMgcWgZG8oRahG1IMxZjcvxakWrGOXxfSWhFNAhc8v+d4yLtUwkhKMictqKe4UR8zeHmKfgd2davdMBuNvLZK3l78ITko33R43DctIqJwt17bltJT9V2smQ7W5aJRaT93ljsL1+saTZ9NRIKEqxSR18LBU7ugiiYAMowvVHpKAgRSpshinwt74on3oNaC/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYfHblcTPUvyCg1j1af20fnnWIFYIcnsh3tK4Nj1aK8=;
 b=hyWFkD3Oz+NwUHwNFwckh5Aw6FiD4ytphG25/QAeDc+p8/nHmpRjwWNx00bOrHN2wFkdP7ADOC7OseLxQrXpLEHem+1l1KJwpMUIEn2pACralFSGsyHefPWOGY6tScf3yS1agQP0sw0r6SMI9/s5Gy8cQvePCSvd/gtu3LmOs0ntEg0cFaeLmU7i7cBUOrZe6mxqgv8W5+kWVWPMNhtMmFqb6FfGtdDSDOKKlnyg5EVB5wEhHU35/jtiN/epJckslS9SaiZkPIOsjeBGviPFJ8ebUsJG3+6wZQVM+A2ILM+/98XlI6l3YZdVud6inaWdBDmZxgL2MwOkfJ8KCaxEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYfHblcTPUvyCg1j1af20fnnWIFYIcnsh3tK4Nj1aK8=;
 b=OgQQfkdz0k26eBoqiQ80zdMb86Qhh0nm7DHaW/enIL46RRkbfM1sbs8iNjpIXOASPyZFhTSEYSxEtf23JeBozQZA4McWPQAc4dVpvMXWxUBw9dVOFINRL2nHo95NZxobVbF9ykreUBCpAU0tXDOYJwxsuMIoUadzWo6FJWKFVGo=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2419.eurprd08.prod.outlook.com (2603:10a6:203:a1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sat, 24 Oct
 2020 09:06:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Sat, 24 Oct 2020
 09:06:41 +0000
Subject: Re: [PATCH v5 01/12] qapi: Move GenericList to qapi/util.h
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 rjones@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a0111ce3-f635-1ac0-f0db-247bad5d9bb4@virtuozzo.com>
Date: Sat, 24 Oct 2020 12:06:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201023183652.478921-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR04CA0023.eurprd04.prod.outlook.com
 (2603:10a6:208:122::36) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.99) by
 AM0PR04CA0023.eurprd04.prod.outlook.com (2603:10a6:208:122::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Sat, 24 Oct 2020 09:06:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83269a5c-20c9-4b07-72ab-08d877fc1f25
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2419:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB241945CAF60DBD01001EFEA5C11B0@AM5PR0802MB2419.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDCbgQhwgmWgf1TcZ8A5EXZYN8LH8vsrD7LSLxOa7IQRdDwJwEkXqgTWxr41qanjuht0RvKvy90rD1WhM0Ltcm/Lj95Y2ZC2gTnUNDccVECdMLzcA9zL66/rJH7pl8TnzTR8dKBLoDAR4ZKW6ovvsvdP6t0oqAJqtyCi86xZ/nc3Avb7eYdPAXZ/u3ZKrYQUJommVoSZqueD/d9l2aRAwwR2f4Hpy+9bYj+2m1Mpo3jkp2+nL1RPMInL5PkBh2FEXy0K4nVZf9ioU8hh5jdE/Y48txgpwewWp/XmTYtrxo1TEVUHTbMLIiYHVNyMcKpyLsJ+Ei5/YpygWskpTwGLbiETi7gz8pVZdm2G10E2XAuqlFFrty2wt6oLTv19Omuh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39840400004)(2616005)(66946007)(956004)(83380400001)(86362001)(66476007)(66556008)(36756003)(5660300002)(6486002)(16576012)(316002)(31696002)(31686004)(478600001)(2906002)(8676002)(54906003)(26005)(16526019)(4326008)(186003)(8936002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: A7oA6i+ei9bndWNELVElxpqk6sU7dk4pi7losDJRq2SkTHKdUHrUQtHmz+iNgfCNmu9ZaQlJahEPmS+SiSFHjX5tMsmElT7rr6qVumm05l3J1ubZy3VssYtA15fQEN2bK0HaVka2Q3WFg0DQIQgSEqXtlsxmcENRcYazvTRiSphiEACO8kXIzZZCczpA7smav4haLUoSU6Mi3lw+YY+Wg/Cvz+fRjNKLZXmbet5KbJehZbFAST0LLPlawjG+lX4zh3YIlqyiSgSau3phsKBpSMeKIIAkHY8prs8B37E+M4Pljs8dJyZ56CndQuXYP89csI39QH1EyOpn/2ylcmhLRNR1HUDQUUy9DnxZ03FOtIKZ/dyka4e9uSDEEaoKLwhQVVJK2lM+oSKRy9oKzKDKd+wIMjBFesnInogzpjy4IkyxaOGZpAIGT9XY1aTY6VuQmluhzNqoFuVHAxygrKkbYdi2g6k12sGNjV3fqzTVl49xzhBZSO3rjbH95qguOj2EHpFUPkNc5JvK7UEiGJyDk0tAZHGzLzayDk4066TXVsUKpS+hpfZ9EW8yvRbuPchGxuQOdnnh6iodnA8GdPf/m7CV88t6q2tCGJBRHoImGjU+BQKT0VvPU6hokpUOETmGbPkPUP9cp2dDO84y5d8MYg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83269a5c-20c9-4b07-72ab-08d877fc1f25
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2020 09:06:41.2689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyBPqs0L/W76kv+6wY5/+LZC4P2CWMQqep8hnGsImGqYAsiKrZBCN7aKpF9bGJyHt534k6lxHpvDRyumgmEggPrG9OQz60stUnR96gBASU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2419
Received-SPF: pass client-ip=40.107.8.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 05:06:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_LOW=-0.7,
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

23.10.2020 21:36, Eric Blake wrote:
> Placing GenericList in util.h will make it easier for the next patch
> to promote QAPI_LIST_ADD() into a public macro without requiring more
> files to include the unrelated visitor.h.
> 
> However, we can't also move GenericAlternate; this is because it would
> introduce a circular dependency: qapi-builtin-types.h needs a complete
> definition of QEnumLookup (so it includes qapi/util.h), and
> GenericAlternate needs a complete definition of QType (declared in
> qapi-builtin-types.h).  Leaving GenericAlternate in visitor.h breaks
> the cycle, and doesn't matter since we don't have any further planned
> uses for that type outside of visitors.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   include/qapi/visitor.h | 9 +--------
>   include/qapi/util.h    | 8 ++++++++
>   2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
> index ebc19ede7fff..8c2e1c29ad8b 100644
> --- a/include/qapi/visitor.h
> +++ b/include/qapi/visitor.h
> @@ -16,6 +16,7 @@
>   #define QAPI_VISITOR_H
> 
>   #include "qapi/qapi-builtin-types.h"
> +#include "qapi/util.h"
> 
>   /*
>    * The QAPI schema defines both a set of C data types, and a QMP wire
> @@ -228,14 +229,6 @@
> 
>   /*** Useful types ***/
> 
> -/* This struct is layout-compatible with all other *List structs
> - * created by the QAPI generator.  It is used as a typical
> - * singly-linked list. */
> -typedef struct GenericList {
> -    struct GenericList *next;
> -    char padding[];
> -} GenericList;
> -
>   /* This struct is layout-compatible with all Alternate types
>    * created by the QAPI generator. */
>   typedef struct GenericAlternate {
> diff --git a/include/qapi/util.h b/include/qapi/util.h
> index a7c3c6414874..50201896c7a4 100644
> --- a/include/qapi/util.h
> +++ b/include/qapi/util.h
> @@ -11,6 +11,14 @@
>   #ifndef QAPI_UTIL_H
>   #define QAPI_UTIL_H
> 
> +/* This struct is layout-compatible with all other *List structs
> + * created by the QAPI generator.  It is used as a typical
> + * singly-linked list. */

doesn't checkpatch complain for comment style?

> +typedef struct GenericList {
> +    struct GenericList *next;
> +    char padding[];
> +} GenericList;
> +
>   typedef struct QEnumLookup {
>       const char *const *array;
>       int size;
> 


-- 
Best regards,
Vladimir

