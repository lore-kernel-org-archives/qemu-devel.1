Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2ACC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C6D2070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EN36SukX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C6D2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsLzJ-0004Dy-JC
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 03:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsLyT-0003FI-N1; Mon, 06 Jul 2020 03:55:37 -0400
Received: from mail-eopbgr140117.outbound.protection.outlook.com
 ([40.107.14.117]:37017 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsLyQ-0000m0-Lv; Mon, 06 Jul 2020 03:55:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgR+fe+AmtzhnxVCbvFi2L++DHx/za/86x5IVNyFkA8BqKs2JUsQBSIILCDjgzp5vI2QSUA8skoYzsXusvQhoxGT2dCCgLC0MvXQGer+OyXyxZlHgBOGKjbmktoeyUaail1sSbLJygSBGtpWBOIORL8/S+ylsVHdweT/6UdsefqHIWwcyU1qdDbbDQJEeEzo0/JeN42Scq1UyuxWs4qXerSQvPjS9FbTtllasreKMVj4bztznkA7MasroA0p9wned1D0RGAX2VmFcuiFcpAOJNZcUzHNyLeAeSDPAWUN4AZHBubpFlpzHjUbpYHmPyRRCDQEkyTyi75h6I4u/P7uUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S//TxT9x7uU5Xs1uhQ4nTZq8S4gzQYjvdmeX06IP9OI=;
 b=LJcBTC2EhzOmV267toCmAq8TrtYn7FZeUJuXkWbb4c7hCjcFrEBbfqHPo3QqOXk0CYybICXlAUvPl2H3rO0yTGUJYii46pgt5YjDDO70cxZQ5pxH76MhIz5s+yZBYJIezY3zTpIXYj2/B3qaYrX/S5RjdmyYmRNnLEiIRrIi4vTbjvRuA6SNHI6F2E0PSFcw2xbhHSivvZf6JjuEnxgBefbFqd+RQ+DrnPjuVD9xgNgV7Ywo4wiKVdjtJBgCn6LiOwd2/jBAwh3sPo/okxqBCRnRwv7JVeY1IlvlWGj3k3sAclIheD+5r5yznf1ItTjIlMJWmlwhyMcGG/SYHx+Xkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S//TxT9x7uU5Xs1uhQ4nTZq8S4gzQYjvdmeX06IP9OI=;
 b=EN36SukXAShOcdQZEJ4ZoNqNZLperACzvAhoXRvsPBXtclHjMLRj2uZCjbK4gpNulWLtgxOr2/PqBI7+PBOwiVg+lJoL2U+NDX5+3wjwtHzlT214lUoovH30drs5BGsDSMbmg8zp/leA97QDGObBAKOhj0PdvI1ZnW43N2oIzRM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5079.eurprd08.prod.outlook.com (2603:10a6:20b:e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Mon, 6 Jul
 2020 07:55:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 07:55:29 +0000
Subject: Re: [PATCH v11 8/8] xen: introduce ERRP_AUTO_PROPAGATE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200703090816.3295-1-vsementsov@virtuozzo.com>
 <20200703090816.3295-9-vsementsov@virtuozzo.com>
 <e2b4f10a-162c-ebb8-3232-381c4d820f9f@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <be7bd5ba-8cee-3b9c-7869-95cdd37bdb5f@virtuozzo.com>
Date: Mon, 6 Jul 2020 10:55:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e2b4f10a-162c-ebb8-3232-381c4d820f9f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0006.eurprd04.prod.outlook.com
 (2603:10a6:208:122::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.58) by
 AM0PR04CA0006.eurprd04.prod.outlook.com (2603:10a6:208:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Mon, 6 Jul 2020 07:55:28 +0000
X-Originating-IP: [185.215.60.58]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8dff763-d15c-42f5-0ba6-08d82181f3ba
X-MS-TrafficTypeDiagnostic: AM6PR08MB5079:
X-Microsoft-Antispam-PRVS: <AM6PR08MB50796BB580726F4BF2B27EDEC1690@AM6PR08MB5079.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Sn/oHz8fvlJAw4YJSvEq4xKcy/sJeolaYETy40Ug8p7amP29Wa48qC1Pv/mZCe05FSlu3SmKIsNr/Ykcw5ORd6hCtqOrOIhkRUkmU9Y5+lOW33F39rqWmvlp3TL4hiByOVhPCmh+8RDoE6GAU1uS5UeCLPWkOsB794EdFmVTjl2JcbTS2dfOXAz9rrON4HfK0bEr7Vf4sZS5i0k4ayl/n/vQiQwlXXu9tvkf/TypMWDhjlXc+PqnpT0hJj1/Ckskcy7s2JU9bTCvaC3m9hhqAQ9WoLkQGWUybLOYOGI37fx0I8ggH9ls2zUo9bLYFhMHLqGbfDI85pKyJUgUFctC+zTcNRPckd9mYskH/DwpWUY+Lu4WYdds0WtQpLOmwLE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39830400003)(366004)(5660300002)(8936002)(2616005)(956004)(316002)(16576012)(66946007)(31696002)(36756003)(86362001)(66476007)(66556008)(16526019)(6486002)(186003)(8676002)(2906002)(54906003)(478600001)(31686004)(83380400001)(52116002)(7416002)(53546011)(4326008)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lMRCyFxBJ5fLNkwNw6qTRlTU3porKgG81JM6/w4ArMLtTBvY1X7Nbr6grh3jnqj31K/aXw2aq4zZERIC3FNa9D+CnsudasA2k/8Ml5nlK+h02dy8mgjh7Tl6ErFr6dXxPmthUEDFX/VAETr5MAAigGknZ5ntpGWMSV7St7A+aOoMI9IkpaqSPVqsYrnt0uKTn4YZnvAY64yvW6C3GMxj7C8aIEdphMzdO+B7qg3HrdWMVX8ay3VtUv+27/ZmnE+QL3rjfq165bf11EpGAxoA9gOWizH77cj3KFbKpsuZ3wFEJ0LHc8iij81cP3AUyOn2NZFTBAQUXtwXiXEnfQn5GHBtKBipybAI+VGp35o6icxT+Z7sg1Ly00YzXvuj3C9sDbaX7CiGMVn+CIHRSOnqaZPgHnDvdILoDhI4GtUeRFLDQ1rELLhNU5S91IbOA9eW5ooJHyk2TN1NcIhKzMYtsghFR+jI4KvzKVbRGm0eBt0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dff763-d15c-42f5-0ba6-08d82181f3ba
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 07:55:29.8510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8GZ5M3N8ZrMTlKELjAyZZzzz3NVMz/Qu+dKaJdjWQbOyCP8O7rJX2B9UriIzABzYLus4YNQXDx5uaRgFEvhtMmA2XAYJU6sLY11/XWYGfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5079
Received-SPF: pass client-ip=40.107.14.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 03:55:30
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>, groug@kaod.org,
 armbru@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.07.2020 19:36, Philippe Mathieu-Daudé wrote:
> On 7/3/20 11:08 AM, Vladimir Sementsov-Ogievskiy wrote:
>> If we want to add some info to errp (by error_prepend() or
>> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
>> Otherwise, this info will not be added when errp == &error_fatal
>> (the program will exit prior to the error_append_hint() or
>> error_prepend() call).  Fix such cases.
>>
>> If we want to check error after errp-function call, we need to
>> introduce local_err and then propagate it to errp. Instead, use
>> ERRP_AUTO_PROPAGATE macro, benefits are:
>> 1. No need of explicit error_propagate call
>> 2. No need of explicit local_err variable: use errp directly
>> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>>     &error_fatal, this means that we don't break error_abort
>>     (we'll abort on error_set, not on error_propagate)
>>
>> This commit is generated by command
>>
>>      sed -n '/^X86 Xen CPUs$/,/^$/{s/^F: //p}' MAINTAINERS | \
>>      xargs git ls-files | grep '\.[hc]$' | \
>>      xargs spatch \
>>          --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>          --macro-file scripts/cocci-macro-file.h \
>>          --in-place --no-show-diff --max-width 80
>>
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Reported-by: Greg Kurz <groug@kaod.org>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   hw/block/dataplane/xen-block.c |  17 +++---
>>   hw/block/xen-block.c           | 102 ++++++++++++++-------------------
>>   hw/pci-host/xen_igd_pt.c       |   7 +--
>>   hw/xen/xen-backend.c           |   7 +--
>>   hw/xen/xen-bus.c               |  92 +++++++++++++----------------
>>   hw/xen/xen-host-pci-device.c   |  27 +++++----
>>   hw/xen/xen_pt.c                |  25 ++++----
>>   hw/xen/xen_pt_config_init.c    |  17 +++---
>>   8 files changed, 128 insertions(+), 166 deletions(-)
> 
> Without the description, this patch has 800 lines of diff...
> It killed me, I don't have the energy to review patch #7 of this
> series after that, sorry.

Sorry for that! I really understand you, take a look at Markus's
"[PATCH v2 00/44] Less clumsy error checking", which I'm trying to review
currently..

Still, the patch exists in such form since
"[RFC v5 000/126] error: auto propagated local_err", where it was reviewed
by Anthony, and I suggested to split it, but it was not needed.
Unfortunately, I've dropped r-bs due to changes..

> Consider splitting such mechanical patches next time. Here it
> could have been hw/block, hw/pci-host, hw/xen.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 

Thanks a lot!

-- 
Best regards,
Vladimir

