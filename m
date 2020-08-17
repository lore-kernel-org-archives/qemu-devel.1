Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D322C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1C220758
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C04CUSZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1C220758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7cgW-0007rB-2e
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7cfA-0006gd-H0; Mon, 17 Aug 2020 06:46:48 -0400
Received: from mail-am6eur05on2113.outbound.protection.outlook.com
 ([40.107.22.113]:6913 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7cf7-0002d1-8f; Mon, 17 Aug 2020 06:46:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0OMYPu6mpa7WAA3Z8g9HnDcRcb+BGvviQIfr79udKDHRqvXwgnIBDNHwFXFb+zDnJxu24h0pHkjTxXM66n46Ya7eSKn9qIJCCXlmaootCOMYDH64MWNxh+x2ldGxwSnOo26zkbypswlcTkMWvuo97/275R2KvmmezavdajIRcB5X2QwzpfZ3q9y654L1iXHKE8RWmGiWAyG4JFeWJXqtcnzHULUgEvYz+H3qyjnQ6dIRELysfbyuHOSav4fIRNJZwL/9A8rGFKUsHnLhnbskEwOrjkAJAj2FxTwyVrt7eH4R9lmD3/BOleVhKTcVkXZlJRR8fM3DAqcbf6FHcQYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soaFPSN0OrdHb44oFTJ5+iUoVJY7R3c48XdX/6zwt3c=;
 b=ZT4S4bmjN1f5ha6C9kcs0pxfdZigMbyErxgaA7uVtntuyvNNCoe/aqDJmjcRmqD25fZE+iFY9mbAjbt50tXPsqZbS4XedM6Hrvlhg4yEAk8CC/XWV6YrLSCef12zN28bwt30LFprpCNLkYIfXwlohR99R8qdYWWDQb/c+iuz0/A38kqh2OWWgu8fJmaGxkGj7KYjKKAKkM/L87hwrBzyCk3xJPgROEPVlztcNH5Ve+FfRcTyBdk/eA8gA5Ye5WPxaKu1Paba50LiMYmiXZ2WFqTy74XqrR5pwkxuLdjhTcFO1Ygxi+q3fKRaz+kim4eS9BGylBcR07dlJT3E88ocTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soaFPSN0OrdHb44oFTJ5+iUoVJY7R3c48XdX/6zwt3c=;
 b=C04CUSZMjA/e2GAz0YFCBUGa4En96mDPxbkC19TS+99HO7vsxg7vm7aZ4JelhJLzp219QAEQM3LEH+irKhytbs0tngmQ4tgQxQXGIRtx+pIFVYh2AkN3MdJK7oFOBES91fLrK4NpEndZzGt2mc14/TNHtflxP4k+9jHb8CgdWsI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3544.eurprd08.prod.outlook.com (2603:10a6:20b:4e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 10:46:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 10:46:33 +0000
Subject: Re: [PATCH v3 00/12] preallocate filter
To: qemu-devel@nongnu.org
References: <159765770605.28013.16393052332587484060@66eaa9a8a123>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <90cf961c-6723-83f3-d144-0044c3aadc51@virtuozzo.com>
Date: Mon, 17 Aug 2020 13:46:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <159765770605.28013.16393052332587484060@66eaa9a8a123>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.174) by
 FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Mon, 17 Aug 2020 10:46:32 +0000
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bab4c860-ee5c-4a7e-b625-08d8429ace80
X-MS-TrafficTypeDiagnostic: AM6PR08MB3544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB35442BC0B76FDD6F379208C3C15F0@AM6PR08MB3544.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6A6511RiH0Xd7Y8lW9QSGzsqOwpijVMDHWJCLsAKx2beHIqBg0I0dU4BPaYXUus/Q2fVSsSlcXuz42CkdRysoP9HhM5Ltp0Jm1lm+1wrSb4qhc2I8yYeqMK3jX+k+dCTghpJHAEWO/q0ktmlwz19er/jC1Y/d35NzoTBkkodmsLg78tx46brpQOu0lcy2hunydSCkdXLy8A8REth8Wd3WmffQZ7cmMYkUmpdiVMglhOn467lHsE3rQImoG9vDMz6acKDi9Jepw2tldUPbGNk6TJF9ZKuwqdYGTnpgwzd68AA8v7kFEFMA/wRBntR6cc/Y6dZljd8w6uzpkwdFs3OkaiOoqvbgYtls7tdcVawlg0IBRQEnYpG1rNGlvtKtFPiGRVHrmVEUij3f/NN+TN/zyTDlfkkWYRcbRPKJtAbwngE5/BLMl9Ha5oZTn9NHwQgo4KljkbTtcetx8Ro1jupw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(396003)(346002)(136003)(366004)(8936002)(86362001)(26005)(16526019)(5660300002)(8676002)(186003)(83380400001)(6916009)(4326008)(16576012)(31696002)(2616005)(2906002)(956004)(6486002)(36756003)(966005)(316002)(31686004)(52116002)(107886003)(66946007)(66476007)(66556008)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mnC779Jy9DdKOGSQ3TajmbmjkDUBe5lRuSn2gbYmWcujW4WAx7j4EAWDnrGPlyw20IPoh5DzdkkV3WGx1k1aWmT8yJO3A+tzDK3BvH1vlvlsuzI7OLx5ZBsUhQkiK3S5U2OZ/Zu8KKgRcPeJuUzXcFZPMAB+r0RJp86fVo+BussHo4nzdx/q8tc3a3BnWBvojrQm30Cs949/N3gjc4nVEUdrX7CkY2OGHgdzaY3usjQtH4Vj+7sncoNq1hMJEUpyzunWMNYmyROiOQ/gblH9LiBHdSKYhoIkb1ka1GoyDH0amW9wbEvfOuqYMSYOm5n53n7gN/c5emwu4MoTpN3vqb+nQrx5xzegCo6++zhn3BIevom0kozbDbES1jQZLQbOiCbKsnaTkXs+UO7MKElFGYucvcj2nFSLo1SqS4lxp//A06sM8gikueC1ZfJ46eexf9YhSnWUqHCmTvrhiDQ1oLNheZSN/loVH+Y2Uwv+cs/BLaOccmxnN/ojBd31Rv07nMO7ELNHMTyKgEjxj94O2L9D7HUEdWFRAkcFjQ23GjoFHDdr0Dlwd4vlmAZZS0K39qFfmElypSSm2cTYipgzJUm6aie5XO/oQF3HESdaS9L2KQmyw2dntFkXnqhEA5iKA724BBHWE0rfZ5O38wzGUA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab4c860-ee5c-4a7e-b625-08d8429ace80
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 10:46:33.1148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMrvv5BgV+oXgP+BCZKE0ojujzS3gP7+0ccMBWs/B3DxzY2DNzXzS+JFH5q7GZSfnPmdaCkkxQh8rYnclJWwzuYPqBHoyTpz36aItDwRRxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3544
Received-SPF: pass client-ip=40.107.22.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 06:46:42
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hmm strange. Probably need to check #ifdef FUSE_SUPER_MAGIC

But again, it's a problem of patch 12, which is just an rfc not to be merged.

17.08.2020 12:48, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200817091553.283155-1-vsementsov@virtuozzo.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>    CC      block/nvme.o
>    CC      block/nbd.o
> /tmp/qemu-test/src/block/file-posix.c: In function 'is_fuse':
> /tmp/qemu-test/src/block/file-posix.c:334:35: error: 'FUSE_SUPER_MAGIC' undeclared (first use in this function)
>       if (ret == 0 && buf.f_type == FUSE_SUPER_MAGIC) {
>                                     ^
> /tmp/qemu-test/src/block/file-posix.c:334:35: note: each undeclared identifier is reported only once for each function it appears in
>    CC      block/sheepdog.o
> make: *** [block/file-posix.o] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 709, in <module>
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=ee7ebe61e5fd4a018bbb2a16ec4a5a54', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-o73ap74n/src/docker-src.2020-08-17-05.46.38.25129:/var/tmp/qemu:z,ro', 'qemu/centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=ee7ebe61e5fd4a018bbb2a16ec4a5a54
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-o73ap74n/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    1m49.146s
> user    0m8.506s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200817091553.283155-1-vsementsov@virtuozzo.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


-- 
Best regards,
Vladimir

