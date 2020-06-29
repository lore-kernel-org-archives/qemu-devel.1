Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F58AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C040123D51
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZHDN8BfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C040123D51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpuJt-00007R-0P
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpuJ9-0007n7-8l; Mon, 29 Jun 2020 09:58:51 -0400
Received: from mail-vi1eur05on2094.outbound.protection.outlook.com
 ([40.107.21.94]:62177 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpuJ6-0002mk-OG; Mon, 29 Jun 2020 09:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrLaDM38qG9xlC7zduuP/UiFCBADIGSQrGIL27VCovMFj1XjjTk+ObpABoXuE5SrNzNSP4MAI03mn8kBKHSLR8+dDcUAzHaFCKGMJTBCBVKbhSQZN10vYnS/yPzhzb6ettI3cEc0WDYPBvR4SYXVIQc1g+X9jCutDP0689Y1yn06bXkxEEHwNmO/+sWj2pIA/cZjMbiMXcm49c7/tQmUMh40KDn7Mpj67E4OByh9hNn+JiKzGoLKs65QDXZ7ttGgydbF/12HHShJQv5uVwcSflJhEfbeW0rqVAdR+44bY1F23IB0renpQ/VgzrwtT8gjnyhWhgFA4t4WYGyvWI6iww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jKC4gOgdTe2719nh3jQgkJYGrWo0lbZmQecTLONB0o=;
 b=Dg1MGyMzXtDjXnc3GkwIHnn1UijuCzqZ8goepTTnMKedc5VflrjNj+/JxG1l5HGTSlIgQjMQ/B3cdZs7RO0BB79Xc8o4YymuSSmIm3RbwVUxEq4Y60MpA99Kg44ADBfn0d80F5MwE72pkaeRvO/gX5V8zGDkv0UtNkfkEkKUigXZjo7KQupklQhzD2BYEjodSe9YpCtgmn9ddIDLjEK8F8ZzdGrVsyYW9xroV/rZnVzocROfg/xccjd99zFl7+H3avyhWBiGJ74PUgZFX9HExvICu5sr3TavzzXwx9j4ZMxOQa6m1qqk6NvrRT7Yqejcz36eWX9phqQ+zbRoqz4EQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jKC4gOgdTe2719nh3jQgkJYGrWo0lbZmQecTLONB0o=;
 b=ZHDN8BfLUyItY2ToPZyOhdZqYuu9NyZZLMzEfSR/EPEbcQKRTIq3SdhaEA7mZAlXPX1FLO5ZmIv9MHYOnKADCW4MK+9UNwwPhrSTXic9nPrVXisGplU8F5SMGlmiZ4/TqHx8a4pI/7IEGXr7dhAQn9EWGq9mkikNEQUzijWLZp0=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4535.eurprd08.prod.outlook.com (2603:10a6:20b:74::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 13:58:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 13:58:44 +0000
Subject: Re: [PATCH 17/46] qemu-option: Smooth error checking with Coccinelle
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-18-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <141515b6-792e-1648-dd3d-4d83c8541d23@virtuozzo.com>
Date: Mon, 29 Jun 2020 16:58:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-18-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0701CA0029.eurprd07.prod.outlook.com
 (2603:10a6:200:42::39) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 AM4PR0701CA0029.eurprd07.prod.outlook.com (2603:10a6:200:42::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.10 via Frontend
 Transport; Mon, 29 Jun 2020 13:58:44 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15545d5c-26ac-484f-75d3-08d81c3489b2
X-MS-TrafficTypeDiagnostic: AM6PR08MB4535:
X-Microsoft-Antispam-PRVS: <AM6PR08MB453545AF0761697D432E787BC16E0@AM6PR08MB4535.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nw0MCt3QZf2U5eoF+ao8mVR5Xkgt0uAa8ri4vI37WDfofCiFwJvCXy3S5B1mc0ObdCQsA7fSEZs+uklwwhkwXaUx/X5wWt4eix8k5ynfrTs5kOMDgsp/G3952iqfIFTNDIjUZa5k0bNlz2BgmlMHOaEcSfN8X/Sm3AjMqPEjandZi+ReRZTaj6Pwhdg7cvIo8ECLics9KqTMcX+5xQPxObyW3ezYDyqqOpWFxKFVxQA/Kzp8ccTlXoD2ynkTATmQvboDDdM4KvNFKCCHcpet0/U27Kv4BYXWGCetZVliJCK6QYqcYcC9J32mGNinHthLqJjw8TSunPhm2T8oORPgxeqJuqtCUQhf9p83lB7sG2TbWlJ9g6Z8dg3/3J1vJzcr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39840400004)(2906002)(6486002)(16576012)(36756003)(4326008)(316002)(86362001)(478600001)(52116002)(956004)(66476007)(66556008)(2616005)(66946007)(186003)(26005)(16526019)(83380400001)(31696002)(5660300002)(31686004)(8676002)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vm8VCwtzC1Vv/1h49iJlcfbov5nQl877q+V4aAscwVKIG678FODSULNo7OiB8hgOc9pGGdJOFFcN2vj+jtb+UWc018UdOcMpwgzqlqMU6ot1WmEi81Q86pZg/+1Irod7xARGvKnwYLNceMpf8JjaBT7bX8+MSlOIXKTo5B11TQHbZtInN++Fv0SxibE6izQMOnuBRIrYTTPvLVFYNd48m98qC84hsY6ay+3WLAwjMyOALHIgHja4BVOoOharRiYDNjnOIvJG5VEtHH++4ZIduLJa02huerLFNLDJzsCho9ZDeaTf+hGje9ByUIsfPsbMTYoEiQMJBfRbkKAsTbNepefDrZPImOPgaLx5elUtSEifcV1qNLOX32+VM7EwADe+c9WbuZg1xZwH58GEo2o0rlhEeMzQtKlHyTMX6jxpy7TlvkykJ7woWTiT0BAUYtudIeYbIOB6KZUZFeTd135ynt7AWn8xvHTvDD8xfHtnDtAM80H9RI34e/4cVKu3HCXd
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15545d5c-26ac-484f-75d3-08d81c3489b2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 13:58:44.7992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMRQGK45NC7p3KNYs/81NmPHCs02gJb51Z8LXoE85oxtUOBSiQPQbyAWLJkU3sGDc57XCShKXVkn85BIjd0oViCxACJtP2KLHyLrQqgoEeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4535
Received-SPF: pass client-ip=40.107.21.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 09:58:45
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
> The previous commit enables conversion of
> 
>      foo(..., &err);
>      if (err) {
>          ...
>      }
> 
> to
> 
>      if (!foo(..., &err)) {
>          ...
>      }
> 
> for QemuOpts functions that now return true / false on success /
> error.  Coccinelle script:
> 
>      @@
>      identifier fun = {opts_do_parse, parse_option_bool, parse_option_number, parse_option_size, qemu_opt_parse, qemu_opt_rename, qemu_opt_set, qemu_opt_set_bool, qemu_opt_set_number, qemu_opts_absorb_qdict, qemu_opts_do_parse, qemu_opts_from_qdict_entry, qemu_opts_set, qemu_opts_validate};
>      expression list args, args2;
>      typedef Error;
>      Error *err;
>      identifier errp;
>      @@
>      -      fun(args, &err, args2);
>      -      if (err) {
>      +      if (!fun(args, errp, args2)) {
> 	       ... when != err
>      -	   error_propagate(errp, err);
> 	       ...
> 	   }
> 
>      @@
>      identifier fun = {opts_do_parse, parse_option_bool, parse_option_number, parse_option_size, qemu_opt_parse, qemu_opt_rename, qemu_opt_set, qemu_opt_set_bool, qemu_opt_set_number, qemu_opts_absorb_qdict, qemu_opts_do_parse, qemu_opts_from_qdict_entry, qemu_opts_set, qemu_opts_validate};
>      expression list args, args2;
>      typedef Error;
>      Error *err;
>      @@
>      -      fun(args, &err, args2);
>      -      if (err) {
>      +      if (!fun(args, &err, args2)) {
> 	       ...
> 	   }
> 
> Eliminate error_propagate() that are now unnecessary.  Delete @err
> that are now unused.  Tidy up line breaks and whitespace.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

