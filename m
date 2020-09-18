Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF61C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7689823888
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iGBNnV9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7689823888
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJ0x-0006UX-Eo
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJIpT-0007zZ-UH; Fri, 18 Sep 2020 12:01:43 -0400
Received: from mail-eopbgr70121.outbound.protection.outlook.com
 ([40.107.7.121]:47878 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJIpQ-0001ft-HO; Fri, 18 Sep 2020 12:01:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZCTA4/zgQi+OTj9A/AZm9I8fqaYGoz4Tj5vxxKmFDJGIyW0LMHuS+W6BkGyVYkS0GEPBs3aHNEGNbWuIwJAW3Gf+je3ruFPtj1a21ROoQx7qhPeXke5226gtwjULbEY1uzxc0WCiyn4+sgy6/8v7GphV9JFlCEr0EyzDUh+HZkP/CwNsboj5K1I6RTdJkzzSOkPnc85Mp3DrbGTB3w395W6Qez01Pzf/EKnvEY1iZFy8CJLUupBeayP/O8RU/rWW7wKJJBOLZZ3WLfP+NBFdEcA2I3YuryuwfQ0Dmx8JhFh2FBJ+/x7CtbDB/peNXvOlIrHLAxHJkExFrK9C12a3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zGSXP805KOxfdazRFohkdtm707Fu8b5SlIwTf3cV0A=;
 b=jk7yEZ4XPXJsdA06R5Q3QU/JqEa1wZW04b8r0a2fXwBx1rAZpu+y5bUaW/cd1HYs0iun4GH/ruEVw/A/VIjvnzKpJFSxKnkP3aI6n9gfX08lvrlyqRh901QtKzN+IYeH0EhebIOxo7qkmwOuPaIc0QNy5RHWGPTYXo7mktIn0HvNDwWFkJ6t2L+waqkGVDYlsCFaGUMcuVdrEYqZGhWxXW22Woihc/x6s4QBnQ8LOdwWHi+Pr9CCmDA19v/ud/nNovVDk9OOgBdSB6oMTEgB2EkeU0VWg6bRXYZxHo7MyJgfSfiTHOExjqNDpNP+dGAqVssz37sSCFZV+6vBuuyAkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zGSXP805KOxfdazRFohkdtm707Fu8b5SlIwTf3cV0A=;
 b=iGBNnV9oz5njreC8od9IG8UR3X1irZ+TF80EF4SYM1luSvwcg1ZEQNaF2LjC1I+hq1wA49g+xyVd+54bOQFM4/bAfesdadiesWNJ83LdkffMUfsB4OpKtBp/08oXr+LvMBkHwUtIJ5LHIJYf72p6j+ktL1OQ8SonJ/M3lohie/s=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 16:01:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 16:01:36 +0000
Subject: Re: [PATCH v2 12/13] block/qcow2: simplify qcow2_co_invalidate_cache()
To: Alberto Garcia <berto@igalia.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, pavel.dovgaluk@ispras.ru, ari@tuxera.com,
 mreitz@redhat.com, kwolf@redhat.com
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
 <20200917195519.19589-13-vsementsov@virtuozzo.com>
 <20200918173006.5f49cb06@bahia.lan>
 <w51k0wr2id9.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a009147d-bc03-9549-3d95-1b58ea830099@virtuozzo.com>
Date: Fri, 18 Sep 2020 19:01:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <w51k0wr2id9.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.106) by
 FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.6 via Frontend Transport; Fri, 18 Sep 2020 16:01:35 +0000
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ab1d577-d328-4b9e-7178-08d85bec1ec2
X-MS-TrafficTypeDiagnostic: AM6PR08MB4070:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4070EFA269562FE4ADA5E0F6C13F0@AM6PR08MB4070.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgurKAVOX2dntTkqJPD11Z7f0GofaiUeZV2BrjmpI5cW3sSyvP0IlQJf7ZKVYsvbaFgf0ZOyvYVXNzqFe5Wt4lXJkZ69q6qC09CT887rRQIbgpQZOVEK+dkYpW72YwuZNRUutOzmBjD3XTGTkGFLKO7f/nH4A96w6BfslY1st24pmXQl6/AzOIfg+9xWr2vqqM9M5dPbQVewQnApS8YT87BT/+yCDUOBvWhda07GLymGVaid1citvBpae8r2P9lx2z6SXIBdFB9yhZ+0e5ht/Nmt0wElNH3d4HmqSpmycMNRwoDY+1Ab+zH7xmVHRQlVT/DWmQFxksRHf03MFoirRkkpQeIfvDhqKPR8mvfCTZq7LujRd7L9fiCget/nxpUt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(39840400004)(136003)(16576012)(52116002)(2616005)(8936002)(66556008)(66946007)(66476007)(6486002)(956004)(5660300002)(26005)(316002)(31686004)(4326008)(83380400001)(7416002)(8676002)(2906002)(16526019)(186003)(478600001)(36756003)(31696002)(86362001)(110136005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CWEaEJXHdb+5RiOFs+TkMNns4ZKBVogGnzsnfn7MepK6ukPxv4hg34KXysXsYXbY/9dCNcvaRXd1P8WawKz/rYdvtyTHi/lYZLT7Nb8GVnxHz639g2SYuAzkkWTSHW2wsWaY4MFWKeCqSH2uElV10yzWwqRXzUHvjh6j2WtoRWoIDE4lzVtJWTLE0XRgbje1VYvJQu3HVhTi++ACjLU9MAB4gZQCEPkFhvxxbQlWuL5pPNi2HrVwU9QFi2uQapdJGFyhgGRy3OJH2xKxiWmFEBtFx5QX6zX7bn6Z2qINyZyANmodcVIpERJpMKtGmfmSweFTC3BLOYKXt8qXgU6hGg0N6ukGMJaUQwufZFibW3UFqkq0C9gfdtvHoEhGxHXXk78o0K+slLf8D5v1bHp/C3jMrqcxaC1kph+X14A/+dT7q/pnh+xBbHB0wUhDych7mawHod4j3n5iTs6tqymXeHzXyPjLD4X4nJyU971GBZPAXi9SbJq//Je9IPZG+3omqXVSVwPlYzRDnHn/Io5SvMNOs8JmkiaJ7SSv79LLgVZ7gndaoBiKrxIKF6vmyyHvxWD5es0Lj4AJ6s3jOksXa4i2s/pFTaikSiSdeSzKBs+MEsxgZ0B908iqlNs5TuxzSjXYvtavU5ilXk8msKLR4g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab1d577-d328-4b9e-7178-08d85bec1ec2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 16:01:36.0429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hTZP4Q/30OCC3H3JqD2AR0FWCFmUOhJBtoOhDbi+J2TeBVS1y7TyV2+83qDFUF5cfBa11fVgElkCmQWhvnPXFpCj7aetIz57ASb//2wsbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4070
Received-SPF: pass client-ip=40.107.7.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 12:01:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_LOW=-0.7,
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

18.09.2020 18:51, Alberto Garcia wrote:
> On Fri 18 Sep 2020 05:30:06 PM CEST, Greg Kurz wrote:
>>> qcow2_do_open correctly sets errp on each failure path. So, we can
>>> simplify code in qcow2_co_invalidate_cache() and drop explicit error
>>> propagation. We should use ERRP_GUARD() (accordingly to comment in
>>> include/qapi/error.h) together with error_append() call which we add to
>>> avoid problems with error_fatal.
>>>
>>
>> The wording gives the impression that we add error_append() to avoid problems
>> with error_fatal which is certainly not true. Also it isn't _append() but
>> _prepend() :)
>>
>> What about ?
>>
>> "Add ERRP_GUARD() as mandated by the documentation in include/qapi/error.h
>>   to avoid problems with the error_prepend() call if errp is
>>   &error_fatal."

OK for me.

> 
> I had to go to the individual error functions to see what "it doesn't
> work with &error_fatal" actually means.
> 
> So in a case like qcow2_do_open() which has:
> 
>     error_setg(errp, ...)
>     error_append_hint(errp, ...)
> 
> As far as I can see this works just fine without ERRP_GUARD() and with
> error_fatal, the difference is that if we don't use the guard then the
> process exists during error_setg(), and if we use the guard it exists
> during the implicit error_propagate() call triggered by its destruction
> at the end of the function. In this latter case the printed error
> message would include the hint.
> 

Yes the only problem is that without ERRP_GUARD we lose the hint in case of error_fatal.

-- 
Best regards,
Vladimir

