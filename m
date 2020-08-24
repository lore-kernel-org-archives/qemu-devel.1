Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1ECC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DBA1206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="tXGvFHfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBA1206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA8Mw-0006UP-Pu
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1kA8Lz-0005xL-J3; Mon, 24 Aug 2020 05:01:23 -0400
Received: from mail-am6eur05on2106.outbound.protection.outlook.com
 ([40.107.22.106]:59744 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1kA8Lu-0007Y1-EZ; Mon, 24 Aug 2020 05:01:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkRYzIdiWNGLyMsEa++UwHf1X9gyaI5BLeGNjhWLhaJkffYrDzmDRSZAww6btQYtQTzdXo99vDC/LTH7PBFhNmFVpRVE9D/H5FHEb/zRmaAi/eLgGMO+hwmbmD+yY2K73edvNJcJ9FrteBG2eV2Qd5ztvH5jUUgOrsFzzlMgkh1r1zcZFGJMhmu+DCqy8trIHaE+uGI9rbUKjtPbw022f8ztfQk/sCmYEe+LwiKndnFh7/w68gkN6Ga7DM80T4CA9t9i6IwQbweAQSYHwoPLbtg2yGmejS920wLZqoVHxduUA6qopKZ+/yTIkeaKo7/5zooI/jILn1pBV5X/9K/2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSs0+t1Oom71RqGt17rnLEKhLrZhQa5x1iZ/4qea46U=;
 b=Kjy4kl/mx3vDOGSRXJkHuMxe6qCmi5A6Hd7L6BaREkTQ92tjgxLLWA7/CzgSc3rAoEghbTftPRo00iGQGrqv5OOI6suuN44leWlMwoJk7F+EpvTUyzx+RK0zqj98okqp/bJs9s4DD8Hw99yWSPLTRAeCoyjjLUzXWlp6iUHPM2eW/fF4qDJE9numC+VpjyK4Ddp/drOHMnB0KKBLTk2/om9xAOsZMJhKHGeGQktpAcdoTTl6O5fBI79d8/EbFPTJqZ/vFQtFo6dWZCa0THGrakMxAMuv+VcuhpjSTY8wHSzB2wbkw9o00FlPsuH46lEblmGdlUgcpk8fMb3N78Lecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSs0+t1Oom71RqGt17rnLEKhLrZhQa5x1iZ/4qea46U=;
 b=tXGvFHfzQ8ccicgp8mnxQ67FC61rpblx4KVhi7cW86DFHel6UXDaXDXeNnMy4Z7RvbBDk2SOxtxEZXrQLYU/Ter0ERWEzcGXA6/knlQCyWhWAHNa1YJ1kD4SOZ8LhAjxbDiu3xCxjuN23xK+x67dV/q7nnTOOoClusoypZoYtm4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM5PR0802MB2531.eurprd08.prod.outlook.com (2603:10a6:203:a0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 09:01:13 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 09:01:13 +0000
Subject: Re: [PATCH 2/3] block: add logging facility for long standing IO
 requests
To: David Edmondson <dme@dme.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200810101447.7380-1-den@openvz.org>
 <20200810101447.7380-3-den@openvz.org> <m2tuwx217r.fsf@dme.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <1e1c37ee-2e7f-278c-c8eb-741a62acae2c@openvz.org>
Date: Mon, 24 Aug 2020 12:01:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <m2tuwx217r.fsf@dme.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:205::25)
 To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 AM4PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:205::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 09:01:12 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a2cbd24-a82a-4db0-85eb-08d8480c4054
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2531:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2531B974A63C2349F9BC86D4B6560@AM5PR0802MB2531.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjstAchfsVcoWh8bMB9Y37uOH6U4M9Jk5Z6tucHA5uuG8BL6EwTrIUrsmrJPSclisVeTS8IasqRrJ/d6gvWbTIrEo6hJtNH4GxRO253wRwFgJf9Lk26sJcpNkO7KcKQCt6XyB2XyPyY3l30lBkiXhcRw07pIP8QS8S1pj4SRovT9XYBtw475ZMc+EMKXrmuwvlfpgUBuHXaMaJGBDvsY1a1R5rXJkHckI6pcXw7Jz13NMVFypcwGx3/eq+V44ZZsiXlURh4IKFWowANTJux19j8sRXWn9b5nnezKZBY/qvbg+lvVgIk6qyU5INMW1RHGGkTUdNlSQHDFHgCl9e8ppBg8qdUOdcFp8ZsGVo9KDrXEQfhtlhK79D9qjX3oT0MY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39840400004)(376002)(346002)(136003)(8676002)(31686004)(66476007)(66946007)(66556008)(478600001)(2906002)(36756003)(42882007)(83380400001)(4744005)(16576012)(6486002)(31696002)(26005)(16526019)(53546011)(956004)(52116002)(8936002)(54906003)(83170400001)(4326008)(5660300002)(316002)(2616005)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: K51lxW743of4Z10L/gyxLL1+5QuvH9AMTLTEzr3G21qcSMv0P653+MmUdbJvAdiAsSstouMBi01d2zSAVOq4Yy4cbLeaton/lafT+dXnTGQ/Ex7/QO6BNXeJgDYNso8YHoA+pXJx+7ZRj0taXg2D3RJ1vlRjRhyor1fwZE0/E+wC2duMKEazmS9wEp5W5lbSaAXb8B/ihBlZ2yPL0eGb9JPOWr+RVqtFW9oEUXKMD3bMsY3zt/2WgZORvYJP6ku6faCvBeuLZeWlJwPw7IpK58/7s1VhviyYBRxWW3a5KUht/t6cmoAAEYkta+3CN4uHjTrBh+JJxfLlyzQ9mYDvJribAsLIbx7nMjGXKUjyiWItMgKyYIntRoQubW/mMM3GGwAudW/eo2qoaSFZ+etPpPxTAI9AEbwt/VRUCD1pq1X1g3/3NgtiRxK2rM3JCPyk/ebCEXt0ZqmLILkW3PZiOv4zh7jv+fWXS2SJIANPslmvfKuTdfYGfT9VUoAjE/iHZeBuq2o7n6O1Zq5y18y7j/w1vFd53Q9by5Fylo/rFsKAgHdOuFomyh2ueYPVK5ZI6RBUUu7nALQxpINWXbK6G03DgWvVDmhuE9GcswrUZBIA5a5wK5lwYxHuGxvgut6e4KnD5+1xp+QAQEP8Z8GxQA==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2cbd24-a82a-4db0-85eb-08d8480c4054
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 09:01:13.3721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH+fiQaiT7n758nZ0AjilRY2xleDArDWauBa4s4OiUevsjEgvN8rfXtrJtzaNY7hOQMN83ioIgxwuOWAItbpGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2531
Received-SPF: pass client-ip=40.107.22.106; envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 05:01:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.381, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 11:03 AM, David Edmondson wrote:
> On Monday, 2020-08-10 at 13:14:46 +03, Denis V. Lunev wrote:
>
>> +    strftime(buf, sizeof(buf), "%m-%d %H:%M:%S",
> "%F %T" would include the year, which can be useful.
ok

>
>> +             localtime_r(&start_time_host_s, &t));
>> +
>> +    bs = blk_bs(blk_stats2blk(stats));
>> +    qemu_log("long %s[%ld] IO request: %d.03%d since %s.%03d bs: %s(%s, %s)\n",
>> +             block_account_type(cookie->type), cookie->bytes,
>> +             (int)(latency_ms / 1000), (int)(latency_ms % 1000), buf,
>> +             (int)((cookie->start_time_ns / 1000000) % 1000),
> Is there a reason not to use %u rather than casting?
no, we could use unsigned.

Will resend shortly.

