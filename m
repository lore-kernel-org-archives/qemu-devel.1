Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A344CC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D63208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ASzhOTkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D63208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLijz-0006r9-5w
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLiil-00060g-GU; Fri, 25 Sep 2020 04:04:47 -0400
Received: from mail-he1eur02on0702.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::702]:3459
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLiig-0007mq-Br; Fri, 25 Sep 2020 04:04:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKQ4l13eEBXLYplJ3aiNTRUlJ9mgQU6hj6vB9YwUz62EaduR39nRzc3EbRRJ09kXP8hpt2Ciz5IqTS9QqyTkVK8GEmTcSCO2wWJlCUWvKGi+ch7CLh//WIhO9QLebpIxkCjBopV2C0QFKrPtXR9WDeZBtxWakjooq97BJrtn1qFAbGO2IowGoWBd0aDU44wTyBnVLS7u6vcr7eDOSfwjio5ZcoTJECDcUhjjs3NInv/nAsV9v/deXzvuQEbLtjb2LzzNC7xVBTacOCd/kwlv1SRPkG5eQg+N3Yqil/nBkxiZdtgLxTQllxX7tsbhk8vPsusKXFH6R3tQFVmvmuWhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YY7odAfpmMP2Nla9hlrLASLaqag0k3uMERF2WiMVtJ0=;
 b=ZH+1pGFqWorI4dTWiRucn2N0xNMHQF56mUjhpZkky5C1l5YDtnTipjOPuLM514QL8ujUIOh3duJJmF5Ti+OHvsqY6XVcM/aSujeg3ZZ6HeEWWLs5togY4CfQ+rvx6D0XXN33CD8V4cELIvtFC70iHkXc3IvnF+Se3bPI+WIS5BjzV19nJhvhfVKCVsgTzejHw7zpTUpQOLgHigqDP2Jn/xGy6vb88sxEv7hn2Szm6ZkIp1j1lDNRpqS1CCExfHmDnQpg/N6ZoeC8l368xwChesA8geQPBYF3Iwg0Pc+OR4XtpDC46TsUUQ0S+TADLShmBr7MPj4tlCprQmm7bx898Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YY7odAfpmMP2Nla9hlrLASLaqag0k3uMERF2WiMVtJ0=;
 b=ASzhOTkbHKgtTemtVGXqBWZKDjTrOmhzUn2zu+B+AW+QY0zXu4yek0Plo5dm5NA9D2t15tDYUw7TuQkC5Ehj8kx+gYGbAJSmWPSJj3wBPGNfwDKIrmzN9O4+pntbynYB8va58QSoB6sLBzhUTFxHRXpmuLv/YSax2PL1zBJML0I=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5031.eurprd08.prod.outlook.com (2603:10a6:20b:ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 08:04:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Fri, 25 Sep 2020
 08:04:37 +0000
Subject: Re: [PATCH v9 0/7] coroutines: generate wrapper code
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com
References: <160097957795.12744.8809653264339815766@66eaa9a8a123>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <92b92954-201f-ae95-89db-7de650cd9a0b@virtuozzo.com>
Date: Fri, 25 Sep 2020 11:04:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <160097957795.12744.8809653264339815766@66eaa9a8a123>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::49) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM0PR10CA0096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22 via Frontend Transport; Fri, 25 Sep 2020 08:04:36 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6567111c-748f-46d8-b1c8-08d86129a59b
X-MS-TrafficTypeDiagnostic: AM6PR08MB5031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5031F7E5819619ED8AC62A5BC1360@AM6PR08MB5031.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYEk3rv4q8T2VX0AHzQx7BV+ZXIUvnyq7CmWXEXGjcLj/IIZYuVwOeAkg0dRhr0CwO1tbDXwNXp/Dq2141IGe3DyYb/4p1NCYTk7u9kvY5rD2ccKl0xB0V8Ya+76mHjPavLT2W/NExQIkvr8W3OaJzZgvY/vJsW9O5PCCVwmL8SWEVJCPWkux4MDvSRVg4mIvF5cGeK7HbwDw+bu5lwWcoNCJo3V315gH8wtbcRjc0cwdCq2FG1z4t5cOAYOWIA5f/OpaWYI2mqcyOJSKuHrPOI/EiIFziMmNu6XqaXYVd8VLA8dhAgHlBv9IpVa1nJRuU/4iZzDCmArhYGLLQRPNHC/pIGCRF9WFS1yxHtXeoN7Z5hpqF6WrIfQ1LMF1baZ/QD+wgFUhUzpuMjNpUPjw1bKFDK1ftDORdprjFtmgEYJqNFxeQTWc/qdTs6Lvnah102xDeugUHKvdUoUoWCbRXBya5202odfd/hqvmQqcEDfCzWTL6xB76phddUjsD/j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39850400004)(376002)(346002)(36756003)(478600001)(966005)(956004)(16526019)(26005)(2906002)(16576012)(186003)(52116002)(2616005)(6486002)(4326008)(316002)(8936002)(8676002)(31686004)(86362001)(5660300002)(66476007)(66946007)(31696002)(66556008)(83380400001)(6916009)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /3L8LdsKQ62lVBTnovQsuWqZ+gNrIKXTumRJweSZnmzjp9ZvEdJ50BAPcLdY0TbQryqaFBI+EKrqAMBH4RcLiny6uZsQbFnORV7pQlZPPkEAIyyRrlzSEbA3OZBBHAbsZyux2Fp+0DnsfTnen0jNl4zcB36u53r38Vz69T7ZKlwDqJh50MVW+8XgY4wBWwa7b/Gnb6RcYFaytxjqM0fz9jaWwBZpHpcWnqvbdc4/qQnV5h58yKSKDkIv7EpUbH8hpv1B24POtVK8R2fMbUdrMFrV4HNG7prT4/Mt0msXg0RcX3VXR5ZFMRz0/xArjJjoidf33dpN1PwEYRl3sdRhoC21GBbyGqRdyO7qMmK2PIOD3/ByxlBpsX5kZI/RRyR0X+khzU0i3J2W6fj4I71VuednI8C7CAoLJXcYZ0L04ZCVHUNpjKgNyynEZfjJOoCIyyb3hhJCtj3SereqS42iv6O0+k6oWZl2NX2VArFv6krgBUiWRl0ZGju2xwIDQeYW6AHwtiiCaSvUrKhrlODKtpDv7MxelCYuswgfdYzeewZ+AXMHYEXKjyF7qRUqjGdGFiKUyRZ+idVYtk76N+a9Xdwh+jmNNgrR0lk4+wFT81gCahP0POZIcEhmTgq+4Dak6EtZaLwOgyx+tnK/T998xw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6567111c-748f-46d8-b1c8-08d86129a59b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 08:04:37.4754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3tf5kLXtRwMRWcRRENzyKCMqg6IjHT5EnKNaoK3DI0X/h9tpgNahJ6ptjbWf/A5YfdWYaWafrE/YRP+Hz7PqLIfVpJT13jAjvySCbgEtK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5031
Received-SPF: pass client-ip=2a01:111:f400:fe05::702;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.214, SPF_HELO_PASS=-0.001,
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

24.09.2020 23:32, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200924185414.28642-1-vsementsov@virtuozzo.com/
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
> Generating 'libqemu-aarch64-softmmu.fa.p/decode-vfp-uncond.c.inc'.
> make: *** [block/block-gen.c.stamp] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 709, in <module>
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--rm', '--label', 'com.qemu.instance.uuid=ea922a0a6ce34dfc90f59bf1b059b9d5', '-u', '1001', '--security-opt', 'seccomp=unconfined', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-rctf_xsm/src/docker-src.2020-09-24-16.29.53.14429:/var/tmp/qemu:z,ro', 'qemu/centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=ea922a0a6ce34dfc90f59bf1b059b9d5
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-rctf_xsm/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    3m4.047s
> user    0m21.648s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200924185414.28642-1-vsementsov@virtuozzo.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 

Generating 'libqemu-aarch64-softmmu.fa.p/decode-vfp.c.inc'.
Traceback (most recent call last):
   File "/tmp/qemu-test/src/block/../scripts/block-coroutine-wrapper.py", line 187, in <module>
     f_out.write(gen_wrappers(f_in.read()))
   File "/usr/lib64/python3.6/encodings/ascii.py", line 26, in decode
     return codecs.ascii_decode(input, self.errors)[0]
UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 11406: ordinal not in range(128)


Interesting:

[root@kvm up-coroutine-wrapper]# grep --color='auto' -P -n '[^\x00-\x7F]' include/block/block.h
307:     * Child from which to read all data that isn’t allocated in the
                                                      ^

The file really contains one non-ascii symbol. I think it worth a separate patch. Still, it shouldn't break build process. On my system it works as is, probably unicode is default for me.

Aha, from "open" specification:

    if encoding is not specified the encoding used is platform dependent: locale.getpreferredencoding(False) is called to get the current locale encoding.



Is it ok, that utf-8 is not default on test system?

So, possible solutions are:

1. Enforce utf-8 io in scripts/block-coroutine-wrapper.py (patch 4)
2. Drop non-ascii quotation mark from block.h
3. Fix the test system default to be utf-8

Do we want them all?

-- 
Best regards,
Vladimir

