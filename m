Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2427C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 18:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246B62376F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 18:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="s2Q3YsNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246B62376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmdu-0006Xm-5R
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 14:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kKmUN-0006Gz-L3; Tue, 22 Sep 2020 13:54:03 -0400
Received: from mail-am6eur05on2114.outbound.protection.outlook.com
 ([40.107.22.114]:54768 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kKmUL-00051A-2I; Tue, 22 Sep 2020 13:54:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUkBbCq5IgTYzBt0FtuRpCbQaOIzod9Vvbgof8RBeszeld7CnvBJiQiLQ28g0VZgJNxamn4D88bqfd3QdL+UazKZZJp6zrWWEK4SoRNGgN02dBhl0jC4vvMCnK5UfbPKN+bBbNii1KSGS3wpARHd2NfqWU/9EvGNTJx0DQoJVUTywukQeaRLLLEhciE8hL4HzuTjM0WQq5AZzWZgIyUpFd/79xK0tS9R4N0PTsNSY9+uzU20ERWrNLgJj04AkyMQ3I8YOy1fHmVdVnc4jkD4aH9ef5IcB1cqdsRae3uI/34xDSeJbXOFEZg4CIcK4YHANZcyon30ePXNupYlXuWh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlY+eCTBpDe/5MBpC4jZSRjnsjQvKTwy1VwyK+sX7yQ=;
 b=CIocxoBSPE8nTDgCGd37iLn3FF57wm9++nZeaZ6quvt+P1iZBgMYAIVAU09yFxanImm6JEE8wBW4DbWV6ZIz+/bMjs6f4mggVHJqJxK75dy1oxcrE1NfNk5RT4BN8BBg42Ihc+MyqqSzQRy2LNdlYuaHUcGcG7sjL86Fhk9AiEayWuoxYtKkpcnj3VSHt5HsAzmMLEdQYuxJ1+hV+tp2MwhDnlu6QJXatPGvGCMhbOmdadS4CzJUhqhVM2knXt8Fnk1I9dkqcHhJmkUubkBMVnvl/X7YgWUFkHLqq+N7HVzSN7Uv01dsrIRaYm1ymL7K97Pp5mSg21ij+m+gNyxLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlY+eCTBpDe/5MBpC4jZSRjnsjQvKTwy1VwyK+sX7yQ=;
 b=s2Q3YsNvG98/xF+zUtbg+k/IhJUYt9wpIIxmz5NVwLamDtopEUnzZFmJn7jsCVc47PxI/3fI0KKdF0mUsBEv17XpBrZt8QFdS3hHJQ+DppiesgZD3MD+JoHTp6OIYwGZSamUnnrVZeZlzYh+yl+jYx53nQQY7FODs8umMFvEig8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2451.eurprd08.prod.outlook.com (2603:10a6:203:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Tue, 22 Sep
 2020 17:53:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Tue, 22 Sep 2020
 17:53:58 +0000
Subject: Re: [PATCH v2 2/2] block: deprecate the sheepdog block driver
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>
References: <20200922161611.2049616-1-berrange@redhat.com>
 <20200922161611.2049616-3-berrange@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e5a9ef5c-711c-19d3-e314-2abdf604ba7c@virtuozzo.com>
Date: Tue, 22 Sep 2020 20:53:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200922161611.2049616-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:207:5::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM3PR03CA0058.eurprd03.prod.outlook.com (2603:10a6:207:5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 17:53:57 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dfcd7be-6aea-4bcd-371b-08d85f207ad9
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB24517CCF852A50701CCA89C3C13B0@AM5PR0802MB2451.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ot1LJpBIYn+7KSPbjhoJ6XOZ+1/YJIcy7yph1+b0xR4TXRvLSeEsN0u9ccdXh2WE7/UqRAepS4XL4jaVEoTKpi6baK7fLdwe11DVuytfdhbidhZ7ZXB9tkxom0vW61LzU4tMjZYpsyHcpBphOLtCXg3QlTyJ/G8HSiL/eZiIQZzRybqvaTp0LqYeCd38lBgn0F33zS4bTDCzQYUQukkbvcUoqodgK4TYw1SxZioo2iISNZTfLLCMr4MIxP5zWlAnF9o1EeVAqn8UemG5+prfkT7r26QFIEnSrKU/VEkmBu+VWdOi6nCK2V9fVjIyrEpCzE+j/3NEYtrAS4mWMBGXg30rCix/m+NhI6tndJLfZZP+zBEUbNgPkMC4LFJd7ndxyICYWIwYnxG4iE3yY0xVZIgtfJBBEqsbsca5erbkXEBMvrgllz/3ys/snL9vzsSZD+zysxQYUDcNsmzbfcTyl0EVyofHCuvn/5U2v6u8uAl54yvnErAg9k0+toodeIom
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(39830400003)(396003)(6486002)(31686004)(36756003)(2616005)(86362001)(8676002)(5660300002)(956004)(26005)(66556008)(66476007)(66946007)(52116002)(31696002)(16576012)(2906002)(4326008)(83380400001)(16526019)(966005)(8936002)(316002)(478600001)(186003)(7416002)(54906003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: c0JsNIxLFL4cQrAt+RB+L8vnpXBJovsfo5SFNm6G3xlkmogyi4xnmKaPoyt+thz37d95m8IPbByzr5vTo4homRE9x+Zm+qXmzjpLvxBqUMqLA4QLMy4IBellI88LCVIewjUxRFo4hc9Dn2BcgkqGvOpmL3GUD3qF5c6Iy0SzVn5Lu+zRyxZ67pYdIYdZ8YL26YT6sOFFVxWofvhEpSI0OVlo9sVNy2H4dP5HcKsNvRZFb6AgsSk6jU+F+nMfbcm7YjAyWvu0me+l+09ZblWpvK/WxJSe0mdwNb47rfQcvwWxPYD1sUwE2YdcE7LHs0EPu/h2/nYuUfOy85P1Gl3hImhO5L6gdaTLYbtgm6bWEWVKicCFf8JLMTsKQS812qvmg5fcqMOk1AbPgd3yOnABRc1yjFJNHQmiBzvvgC/8Ul39LhL95A3mIBuufUn9BygtI57q6vLlywpJPRJMC44qrKaQcaVqPd486fk4NeTWIDp4JDomzFtsQGfiH1+U3U15gllkxiIT8cY3p0fSeNEjSmTdxXTsiDKkt8MH7Ew7x9k8PUp+PNT9Vhx5DlQSkr7cewATTfi0rkvKNljoV5nAsNhEvuQ5GShblcTmBhNOHJGQ8Pr2sjTdBIC7ZhyTaJ0Kj7swkkyDJj5fV2/1q3Qexw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfcd7be-6aea-4bcd-371b-08d85f207ad9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 17:53:57.9464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VWRVYWfQ1/jy9p8FsbUykouMFRZ+wYVHl7wZNCYbkpVVmQBFXq8NPh6lKNQ0041KG+FrWwZYv3fbBH4UR1+WdvZIGnTIU5MxquyrafuX4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2451
Received-SPF: pass client-ip=40.107.22.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 13:53:58
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
> This thread from a little over a year ago:
> 
>    http://lists.wpkg.org/pipermail/sheepdog/2019-March/thread.html
> 
> states that sheepdog is no longer actively developed. The only mentioned
> users are some companies who are said to have it for legacy reasons with
> plans to replace it by Ceph. There is talk about cutting out existing
> features to turn it into a simple demo of how to write a distributed
> block service. There is no evidence of anyone working on that idea:
> 
>    https://github.com/sheepdog/sheepdog/commits/master
> 
> No real commits to git since Jan 2018, and before then just some minor
> technical debt cleanup..
> 
> There is essentially no activity on the mailing list aside from
> patches to QEMU that get CC'd due to our MAINTAINERS entry.
> 
> Fedora packages for sheepdog failed to build from upstream source
> because of the more strict linker that no longer merges duplicate
> global symbols. Fedora patches it to add the missing "extern"
> annotations and presumably other distros do to, but upstream source
> remains broken.
> 
> There is only basic compile testing, no functional testing of the
> driver.
> 
> Since there are no build pre-requisites the sheepdog driver is currently
> enabled unconditionally. This would result in configure issuing a
> deprecation warning by default for all users. Thus the configure default
> is changed to disable it, requiring users to pass --enable-sheepdog to
> build the driver.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

