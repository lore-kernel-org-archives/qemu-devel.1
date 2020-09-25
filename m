Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B51BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884D1208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LEqRjwLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884D1208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjHD-0001bA-FC
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLjG1-0000Ux-Sw; Fri, 25 Sep 2020 04:39:11 -0400
Received: from mail-eopbgr80107.outbound.protection.outlook.com
 ([40.107.8.107]:20290 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLjFs-0003gK-JI; Fri, 25 Sep 2020 04:39:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnZlPgtiM2IRxr8vbOidDYyiKAdIQZRGfRgzhupsE0rjWdeuB5+PYtA08xd0H+fslvqcRXO+o551Hr8rxwqRH2JX+OfTeQT5FVyPb8uII3ru78nRmC2K6QOuvz99mDC+mSyfpsz8q+leciM84KbeKc7188xtXZFxpwy044YPV8ouHKPiju4a0/xftXmCwTf3ilwec/HAmemTaJXXX6w+Nj36zEuVponqcRYCneJdPDiLcR8SWE4WVCGQ4eLluiqWL6rBuSQR99vtC/snUXK4446Z81gsPaBPAPvMr5PtolSWbSQHBdHQtGCSeTKMQuzZSxu7tHpCHloJyM3A1P4eoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxtF5FEH05zDIHEZ9RGyLR2aluBUetV0fZDVsrj2OMc=;
 b=M36PP5KMQlD0Ev5I0gnbiHIpnw/wZOa8/0BxUjcX16bhAlLXR6c8EUNB3cV7QSpojEJ5S2VfcfccFLzc28C6u1mJRA3ThWlpicm5PdOszsCoFdh5y1goNpC2oO6ap4HU8b/MbkCdRz98E2xoUPeiaSFytGcCLCpAXbu5aopt7m5pFKrO0ZDNP/9IyAdVUaRcfUCpUzDz4xXqiFgJLhXges7rzG7Im96wvpXQ90hhgr8nwlBNhSHstqysNT9HmWW5CQcyzI8eNNvVl07lEYtMKBPDVpcAGmm+6q9W/EXR6Qu6DGmeSrLu6LiNWQ9n+InoCx6EWy0IWDDgWfozaRtBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxtF5FEH05zDIHEZ9RGyLR2aluBUetV0fZDVsrj2OMc=;
 b=LEqRjwLtHPdh4oSzqxU1ScCBY8acIAM24MpRNn510Vw7w40tY+xWOdNy7KffXbMljE0WgmWPF/7gLtEU3k8YFcZqEMeEw45xua27JtMJ54hX5c6rJc+tvDPoL4qERTFMsp0Y9viKBfDG7kpjcs4OFzhyyfoYwRmSXj2Yy8gv7hE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1972.eurprd08.prod.outlook.com (2603:10a6:203:4b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 25 Sep
 2020 08:38:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Fri, 25 Sep 2020
 08:38:57 +0000
Subject: Re: [PATCH v7 0/5] fix & merge block_status_above and
 is_allocated_above
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com
References: <160098392391.12744.907656205367112899@66eaa9a8a123>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c63d576f-193a-e489-d870-54fc9abb9326@virtuozzo.com>
Date: Fri, 25 Sep 2020 11:38:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <160098392391.12744.907656205367112899@66eaa9a8a123>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0046.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM0PR10CA0046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23 via Frontend
 Transport; Fri, 25 Sep 2020 08:38:56 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e88c8f62-fa76-4fe8-f426-08d8612e7142
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1972D06A5A815BAD4C9267C5C1360@AM5PR0801MB1972.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5sQiBaGQPg/60FIjg7bdOx6hr1NWQY9Z/L16ydORHxFv00C9PzM2XN8JkULOIQMUkUpKq8AhVLBApKHUsctmej/FfGmDPe0UpViZ7XPUr8tcuuKIA4liaJSoQWYN/dvDvk2Hsx0cAm/KeyQJ8CjpclKlrJdQd8iUiLzRkTVBVPUCdcu432U2f+tBDYyXQidTTHOFTdpZmlSim7XDgyjBwB1dss0Nz6mBPzA8SWD4Ul6GkoXXcOJncINg3CnOgRO/+78XopVfbKzrTlynkUM6lLWbJw8jfMNvrVAg1KTOK+KDkOh4rp7LvlC1b3pHrcpNSVnm1oSoz8gg42APsPL3zXUVmXUPYoWBM/ST8iEtIIZE04i/Zz6qj8z0p/CgEScFNv4nX7T9zN1VoH69LT74yzmM3nI68ZbVSZPOuKY99+Pq1Ha2ngZp5EPNXqIQxgpT0Nq5SJ5YcU+7iDpgjbsCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(39840400004)(396003)(83380400001)(66556008)(26005)(16526019)(966005)(186003)(6916009)(36756003)(8676002)(2906002)(8936002)(16576012)(31686004)(316002)(5660300002)(52116002)(66476007)(956004)(66946007)(2616005)(4326008)(86362001)(478600001)(6486002)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YFYVOyC6ooXCHxILBdhsNRLtmxR7Puq8U1eSqGbjPHzbjOhrDzJNKZqgmhW/4FtTJLWPDs88foCScZX/DGDJ+FKa53WREtEs06eKAUbhmteNBfHAcKsIzm3xuioV349L9vBH4RLBmdYTtDeeDtoT6FoBB8mMuey27MoPtHe1+N8bTHc0cDDwsLV1p0d7gzmYcnYx4ZGem0PXlwcogA3rakzwVRk4WG1Hfe0Nf+a3DPRfPnqy2+tM9q5LjLfVS37ni+yn1YuVhlcP64oRqMe2Sym1gzrJHyI/W/VffY5a2ugY27I4Xe7EUmxIFm2n98XkGWgKDt8UE2NFvrmP4UrzAdqyvpwD7sfrzciq5/q/nUgXIWij4AEI5ttzqsZebziOH0B6XEKYQswfMVRK81L8a0/KHV5AGlsh+prwnNfppXce3eoDZ7Si8hRoyPj2Yd/Y5o74fCXHkJVz3F89vIUD+lfZkxCTkfV5RbBaPXty/rlT/BQFn9LfOZB4Aq7sHGK8l3spPxAnuB/EBCtETecExs/rEsbsweFO5bbHbcYiRMhBq+2hM1r0gJ0fIQTUV8hnBKQtdOR/4b1NzFG2/mJIbsDPVopypiymz5o4tMGx2WDxbj7k3miF2oKV0YOwOvOiN6wtE6HsaIr+e1/JPGJX6A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88c8f62-fa76-4fe8-f426-08d8612e7142
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 08:38:57.0842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQ3Wl1udX+b0E/P2KJMqGE5WgYnEQCIP0VJlX9N2gN7HT3zBTcnaue/5o8zRvu3o8QALe63LHXT5z/nxg8d3/WDD5xUisjfhJES9I8kwt1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1972
Received-SPF: pass client-ip=40.107.8.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 04:38:58
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001,
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

It's all because underlying "[PATCH v9 0/7] coroutines: generate wrapper code" series, I've answered in "[PATCH v9 0/7] coroutines: generate wrapper code" thread.

25.09.2020 00:45, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200924194003.22080-1-vsementsov@virtuozzo.com/
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
> C linker for the host machine: cc ld.bfd 2.27-43
> Host machine cpu family: x86_64
> Host machine cpu: x86_64
> ../src/meson.build:10: WARNING: Module unstable-keyval has no backwards or forwards compatibility and might not exist in future releases.
> Program sh found: YES
> Program python3 found: YES (/usr/bin/python3)
> Configuring ninjatool using configuration
> ---
>      return codecs.ascii_decode(input, self.errors)[0]
> UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 11406: ordinal not in range(128)
> Generating 'libqemu-aarch64-softmmu.fa.p/decode-neon-shared.c.inc'.
> make: *** [block/block-gen.c.stamp] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 709, in <module>
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--rm', '--label', 'com.qemu.instance.uuid=528b329e049d459c994676e3ba6dc69a', '-u', '1003', '--security-opt', 'seccomp=unconfined', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-e72243g9/src/docker-src.2020-09-24-17.42.11.20907:/var/tmp/qemu:z,ro', 'qemu/centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=528b329e049d459c994676e3ba6dc69a
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-e72243g9/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    3m12.373s
> user    0m16.084s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200924194003.22080-1-vsementsov@virtuozzo.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


-- 
Best regards,
Vladimir

