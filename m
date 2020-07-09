Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9CCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972382077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="N8/esuUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972382077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jta9L-00011m-U6
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 13:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jta8U-0008Jd-Vz
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:15:03 -0400
Received: from mail-eopbgr130093.outbound.protection.outlook.com
 ([40.107.13.93]:48282 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jta8P-0003yc-L0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:15:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIoIKjeunssT2yccxlrvaNFdV8XF3nkknq6RHROi2hQuFgI94rhohtbxWe53A3kDqYyfllK/OSA+qyIBxh0Wu47hT1QxvL4TggOwJ1fQzqWLyDtQelv5vUxq6BxRJDRNsUOlXWiML89HUA9dsGUoEr8TnQmXngrhTYgJu0lwPh7RUGAZnEx2GCqxV07Kn9vRzcmqQcR58CwOd7bPWEKn4vGrKp1QdQF6Z3izPhBwjU3usCRlPCe5Ra3hzOSPWE97If4qUzOCgUA5VxsVZHirRoMX7xmGGFXsWuRib6LfHP/BOTCez66uMpRYWAGQJQD4H0AZ8A7jV2IPawxvFWrKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVoMtPWiinm6KUopFcJPA9WqxlihcpwCa58qNDTUKq8=;
 b=bTi2CZ+Zlck1sHoSPVa2EGFxt9C3g/Wn882W84xdj+s/iZ4F/3KXHHeIum+k1yjjYwPJIyxAk2XW580bf4kp4AXnbs3CQlZAGYDm5IMGSj1plSanwnSbkugT1igrD1Tijfl5WL3juFHHhu7TNMZHBa0jcCLWwTqnqFwwqb0lvdvIxGGrpkct+hPFs7fkF7TUhTRB44tFg9auARo0mty2qmoWymQQjXm8bywfuE2IzpCKvRR7eVQBYaQvUUfIw4bGO7hum7dUGiNwmWBVcjgqd4gZ+ZZ3pPPHMmY838w3yIECqGW87nHG1A96JTbtBgFo2AUoFmclw27HDhsZbs1XgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVoMtPWiinm6KUopFcJPA9WqxlihcpwCa58qNDTUKq8=;
 b=N8/esuUX9wXG1wQM3rkel0F06EFAmzEQCPHi522hzgJ7Jfkuij+Z0NlSSlOUjE/1MK30zi410WNkV7940aRffA6aRBeo6J6ekumdyuk230LtHv9q9JkdOQ3ggh5ON9ZOjpgvaUKXaInOoKtMTjOe3LPLAbqQEGvWTu18I5rtG2M=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3960.eurprd08.prod.outlook.com (2603:10a6:20b:ad::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 9 Jul
 2020 17:14:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 17:14:54 +0000
Subject: Re: [PATCH 0/2] keepalive default
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200708191540.28455-1-vsementsov@virtuozzo.com>
 <20200709083510.GF3753300@redhat.com>
 <daa7864d-8979-1987-caf7-cca3cb9849ca@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <436ac597-c25d-16a8-31bc-a895938af807@virtuozzo.com>
Date: Thu, 9 Jul 2020 20:14:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <daa7864d-8979-1987-caf7-cca3cb9849ca@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0902CA0018.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.189) by
 AM4PR0902CA0018.eurprd09.prod.outlook.com (2603:10a6:200:9b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Thu, 9 Jul 2020 17:14:53 +0000
X-Originating-IP: [185.215.60.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ee0421c-685e-460a-ce82-08d8242b98d3
X-MS-TrafficTypeDiagnostic: AM6PR08MB3960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB396077E3D384E1434A17C89BC1640@AM6PR08MB3960.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-Forefront-PRVS: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKUo2YmfWTcRJgmdjKZDk6JKaXeR3CPKM3BcS55iBMp4oKBr2IJPmFIj+JW8WmZlL9CyNcqWXtqMvenOHgB4GP8pr8XNWNZQxIc3QahFNmBAHEIiKXXkmxCOAfsqRZO25W8R9I8ukDZu6L34vVcwsiNp8z8wOveQkt/qzTohwDcvJ87R66d5cRehFSmoZgEYUj1+7EnfmwFu5f1cQZi4bQbWgplIzvJzgzDf9OU/qkP5PHCxVUAsEDuSjbC9FKI5aAvB7vj8ThPCx2zONzws2YoOBKnZmGhjt/fhV7iarH9YlWRPZp1/ykA04MApkhrgMQiPs6o6OR19NlX2NQGtV5Ctzx2bGgdKREt3Xt0poD6wwzpwd/DY48jwwyZCuY9L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(136003)(396003)(346002)(376002)(956004)(31696002)(36756003)(31686004)(6486002)(107886003)(2906002)(2616005)(66946007)(66476007)(52116002)(5660300002)(66556008)(16576012)(86362001)(186003)(8936002)(16526019)(26005)(316002)(4326008)(478600001)(83380400001)(8676002)(110136005)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: B7Ud2dMS3ellSbO0Ws/128PBa4kbjsR95eWS6EY2BnQGAsJC8ssILWkCWJ0PWzh4nBDa0O72yt1w2YAYSsva7qobWUMNiKuJU6BYMrkkCdkZprPrhp54EpQqNkoBN1SLxXqwVzFa1bVpNYWRN5brP+McU7/Gd9OeIqoJrEaU4BVtuSrXuqqkmVsqHgXqFKjF5S5mg4PEPAhOD6tS1NquyjCoh6Lddtf6RMqElHhhJ1zyBHQn5qchWUduVHlDCElhOf9dYJr8ZeJjXtC00whaq9s/h5o0GWA4GoJs4+bIlnGSvdvwGVCGDQ1T1Tc00ZypYxTccNaUHTQhbUimD3gQmm6vem4ROR7UfimdHAQu2thUwZEU9VNuR8uCRv/Bahgh0I2fm1DkadAOeskuSrbleyI2ZxL34kAnOjJnH+hjoGKcOB0n1VSWqf3ULfoeeaHVVTm/o0+PgC31r+Kf+XOXgKmHjlfo2zx1WlhmsD0dEnb+eN7/ZAOlx194eHu9V6Oi
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee0421c-685e-460a-ce82-08d8242b98d3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 17:14:54.0460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyF5eSEShGcz7hbfr4YD40eCoD4HnqapaRAeF4O+y4lrcham5/yHJmfaylY6vo8mANRE/EsYngm0853BJXBI3x9A0jhnS34kZY+vUPiJwrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3960
Received-SPF: pass client-ip=40.107.13.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 13:14:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: den@openvz.org, kraxel@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.07.2020 18:34, Eric Blake wrote:
> On 7/9/20 3:35 AM, Daniel P. Berrangé wrote:
>> On Wed, Jul 08, 2020 at 10:15:37PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> We understood, that keepalive is almost superfluous with default 2 hours
>>> in /proc/tcp_keepalive_time. Forcing user to setup keepalive for the
>>> whole system doesn't seem right, better setup it per-socket.
>>
>> Adding the ability to explicitly configure the keepalive settings makes
>> sense for QEMU. Completely ignoring system defaults when no explicit
>> settings are given though is not valid IMHO.
> 
> We already have the ability to add per-socket keepalive (see commit aec21d3175, in 4.2).  I guess what you are trying to further do is determine whether the default value for that field, when not explicitly specified by the user, can have saner semantics (default off for chardev sockets, default on for nbd clients where retry was enabled).  But since you already have to explicitly opt-in to nbd retry, what's so hard about opting in to keepalive at the same time, other than more typing?  Given that the easiest way to do this is via a machine-coded generation of the command line or QMP command, it doesn't seem that hard to just keep things as they are with explicit opt-in to per-socket keepalive.
> 

Hmm. Looking at the code, I remember that reconnect is not optional, it works by default now. The option we have is "reconnect-delay" which only specify, after how much seconds we'll automatically fail the requests, not retrying them (0 seconds by default). Still, NBD tries to reconnect in background anyway.

In our downstream we have now old version of nbd-reconnect interface and enabled non-zero "delay" by default.

-- 
Best regards,
Vladimir

