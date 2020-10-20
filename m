Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EE9C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C65422242
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kt9BeNEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C65422242
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUr3i-0001ev-85
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 08:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUr2P-00015R-UZ; Tue, 20 Oct 2020 08:46:49 -0400
Received: from mail-eopbgr80114.outbound.protection.outlook.com
 ([40.107.8.114]:10791 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUr2K-0003aL-G6; Tue, 20 Oct 2020 08:46:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW218+hmed+Ey0fpAkyA2dUVgjioJNi2Wdi57+c2/PBY1kxu7InT9ecd9VznjiecRAI56+xUCll6rHKbM+OofaYSJoF8DG3FxxtxixeWZ934rJSJsPUb2+wDtYKlBLGKt6Fi50DSFHsqCtJbsGrKWtz25nDA5qtWNNfD8bNfHtqGiYYWgcApXqDS/YkcDfg/jaPRbeAuKhJREd24tIbIvvjC5BkpcXnjMd7YwIjfDm3owdf+js2X6pT1akaEJLprHQAPtFd5HylF2vdbU2tiTKblWx7+HkI5U1bz/mjG42BySDtahSQhW8ZSlAfQ4C1l2oiTnPIpXdwP1Two3Qff6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhefq5v5xIW7rt5mnYcFqGD4y0EY+7GMN28dCrD93Vg=;
 b=jEOPvazUMcqMhcwpP98XxpZwecN8myon5oVSSpOEGmaWV63fyo02dKqH4WEQz/MWn+wZ45MjbWEFNAtUa9hZX/tHDy2YxvNj7cdjFkJzwsZFqu0vpGNmrqclMRgXCdbK1bIcDWztDqvo2ENV1/zCY8MYr2aZYZPaVvZWvk1PuU7o/mHfiYfGcZY+xO9odxxBDBDE6ro0TqiTYbGWAlEke0AZ7w/c97SiRtweT01BRrjjzVw/ZEbF3B660OyTuXUtThGGIgaNzHq+SL3E0GfN2YYGgN5EuhSMyhWUslcc6F1vCwiF4TbVH1nGnO0GRMcZugm+g/XFpoXJeCq8sMqIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhefq5v5xIW7rt5mnYcFqGD4y0EY+7GMN28dCrD93Vg=;
 b=kt9BeNEXj9fYyfG4EbsJdJwV4nqfsptds0dstbdRwF2g/4drFG5uoLxqI9vs1PO0qrWM5R/0M+q42kl80SdrDcujFOTbDXcS5X+ir9eY5kU5On7AElJtN78UefcwttxnhAm9C9tLSc+nZyFRPUBkMG+m/Ya29z9IoD3E1KIUEY0=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3959.eurprd08.prod.outlook.com (2603:10a6:20b:aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 12:46:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 12:46:38 +0000
Subject: Re: [PATCH v3 12/13] block/qcow2: simplify qcow2_co_invalidate_cache()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 berto@igalia.com, eblake@redhat.com, jsnow@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, pavel.dovgaluk@ispras.ru, ari@tuxera.com,
 mreitz@redhat.com, den@openvz.org, Greg Kurz <groug@kaod.org>
References: <20201016171057.6182-1-vsementsov@virtuozzo.com>
 <20201016171057.6182-13-vsementsov@virtuozzo.com>
 <20201019130602.GE6508@merkur.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8372ced0-d43b-8ac0-7008-f5b72b1270b3@virtuozzo.com>
Date: Tue, 20 Oct 2020 15:46:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <20201019130602.GE6508@merkur.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: AM0PR03CA0099.eurprd03.prod.outlook.com
 (2603:10a6:208:69::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.66) by
 AM0PR03CA0099.eurprd03.prod.outlook.com (2603:10a6:208:69::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 20 Oct 2020 12:46:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f358c08-3edc-4473-1094-08d874f62fb7
X-MS-TrafficTypeDiagnostic: AM6PR08MB3959:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB39593A731989228AE067F32AC11F0@AM6PR08MB3959.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1ALxKHIkuZPbtVbd0FgZs48jHAOnwsBGEYD/eIXWhKFbZvW7Ai6VfaepKbb8WLaUL5o+BoDM6wYID3OFmUDfcg/4ey25iLiWDNDaNR8bto90eNpHKh2z7JkFjcG7uJ+c4MdbtRrHBY1YZctutL8YSaJtEH3aBYvR4YPTfXzS3jCh+ak0fja+C4dI51HIEbViO/lbXKEY6R9P4ssRUjiwEayOwHwPZE++hECJ1w1+rRDR5bfnIcLN5fkjZC4ceVgcJMycyTsf2vxL4S0eLAG5ZsyT4Va6Drj5Hv+5HUgvfFAQbhbU7fBMklOKhYq2rjduKRRcxGDEeU42SXmISp37Hl3SiFaPvZH3yazHQAFMhvdf/quZnFBgNc7ek+LDh6X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39840400004)(366004)(16576012)(8936002)(66556008)(5660300002)(66946007)(26005)(66476007)(316002)(31696002)(6486002)(6916009)(52116002)(7416002)(16526019)(83380400001)(86362001)(4326008)(4744005)(186003)(8676002)(31686004)(2616005)(478600001)(956004)(36756003)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Y+QTxbIR3VaGncL8HR+v0zRLRQyhwCYNoIXFtbqlA92xneVS+AjVRlBc9BxEfkv7oa9xYumlHzRAYnMR3O3+4NIbvLme33qz9E76RYN7i5z319j0MEbj73JKqvVwry1q8BNguJTYOEH2jfcapTppksAF3XTKHO6CUH4fC/VG9X0mVRtbPA9CREalvYOSGsbjIJ1iOCAqKMVFyIMGi4IMl9+V6CCLLvzdFAKK087sTFcoxJ8A24wNblzWYabDQ7ehB6D4FrMZYrAZLQMpL5qVNDjMtcF/ogCCnQhlKGBgFhR3aUkkE9nJJ5eS/QvmUdpFLLLwbbSxod6GOodlTLQ2RLWeqEigibp4rkmScktBiOHe1QJAr3ytu30aBLT6qMJh/u+2jjQww8tCoTy+WF3FFbjjHNEuXa09xUkVzDS+wDw5LsyEcrgeXerSWqSgoHslVEAcUuwUtTYsebP5Lb/PKR5lcvcXSGJ6YJjH03n/ecs3CXRwlTlf9ym3CE4KaTW6WJxuUa+BRTPP5hSYissWx9i+jHYoc+/789OSE2lTvMo+7Dc7kxtc2Md1im8Gt5GDDiCxYAXwZnFfo2jLBZOgdjJlPZP3NGKDHmhZwt4eWAudqdiuQOck0w3SdCU4TIs0Mv7Q/vqaCVvxQ+vhabfPuA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f358c08-3edc-4473-1094-08d874f62fb7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 12:46:38.6518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUKEiyEEkJPPBysrF8smfLEf7GkQ+SeCwfkRjyOEz4/PbOXryNc2CXinv8521dzWKGt9c+s9G9KvS+cce+nqsICL1wG0uvv6NP3HCyS8mrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3959
Received-SPF: pass client-ip=40.107.8.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 08:46:40
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

19.10.2020 16:06, Kevin Wolf wrote:
> Am 16.10.2020 um 19:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> qcow2_do_open correctly sets errp on each failure path. So, we can
>> simplify code in qcow2_co_invalidate_cache() and drop explicit error
>> propagation.
> 
> qcow2_update_options_prepare() can return -EINVAL without setting errp:
> 
>      if (s->crypt_method_header != QCOW_CRYPT_NONE && !r->crypto_opts) {
>          ret = -EINVAL;
>          goto fail;
>      }
> 

Actually, it's set in previous "switch", either in "default:" branch or if block_crypto_open_opts_init() failed.. But the code pattern is far from being obvious, I'll add a patch to refactor.


-- 
Best regards,
Vladimir

