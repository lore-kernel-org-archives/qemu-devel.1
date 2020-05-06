Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A6DC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D19206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f4hwDpnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D19206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWDkA-000390-C4
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 02:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWDiw-0001kc-EF; Wed, 06 May 2020 02:40:07 -0400
Received: from mail-eopbgr00100.outbound.protection.outlook.com
 ([40.107.0.100]:2500 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWDis-0007MB-HW; Wed, 06 May 2020 02:40:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJxrKOux1ykUWesMewUNy/VOBDYiQYKyfbbRp6nkadmK+A+35UZfQYQPlYVXXa2B0cqWJMAunrT5vqvyMY9Dl3Ue4EC1//npNcCXNlpK2YSTnjEpm6gMltnbaV01Yy5QIGA/QCoLD/cgRu2HJ4JnKKh1RY/8Vljg/PdJfC3Utv8ccDfHadhRU94V1sDtnMXB+ba98usT77OUICUa03bCTDsOERbekNKIPlB0VCCmByasCoXFfawYHj1LTdvoItoSKwZXASnGvQ9ULJIT2Q6qadA+m66AvfXMtnArVjm8+fFlwnNB3Ni5uOmChb398oBoCmQiIBFVluZWDhvc/tQodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t//OienPBkTvGnL9ZzsehGz3AaGBr9Jy4qnMClSejn8=;
 b=BsQh5G0XF1Pm1cNBscnEYXy+/xEcWgD1Cjm2eFWrRlv2BdR27GsQfRE3jG0m+SxRrlazLm8rZQ/PLjyOCe1cc79lULi2mhYQJqM+zjk8l+U+oI+Z1E2ncd+t6pm61uv3+JSPpdAbWlKlwXq+jokdJPF2ydDJfxX39MYFhX5gh9Og9HLV3+BvXB2o3LMQDdg8aXbqx1ZFTXeajZGXDMrW2rCsJZQemt+ILIyBt511fQtiAp79j1IWP7tJIDfLWp62HzFseWV4RBY0Vg56F6BedtBS0i89rsraGWChTt3O4+wOxhgfCz2MO0+BPcsrEb5uA29tDjaKXAgAShS8Vxcq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t//OienPBkTvGnL9ZzsehGz3AaGBr9Jy4qnMClSejn8=;
 b=f4hwDpnhimLU6yrPNjKwK0El6LyAje+CahcGi7NUpcAgcj6q0WhqAxKZ6W5i2Jygp5z3tzDlko1UlVdHLf+gwmP+R+JUsx2N3goeMl8MAPD/z4aHNTVNX6ANwBz7kLKGcSLzefsM4/tHoWMw8y0TEnBTlbcRDg/T9UA+tyVtacI=
Authentication-Results: tuxera.com; dkim=none (message not signed)
 header.d=none;tuxera.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Wed, 6 May
 2020 06:39:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 06:39:57 +0000
Subject: Re: [PATCH v3 00/17] 64bit block-layer
To: qemu-devel@nongnu.org
References: <158827987994.4471.17266156514265064982@45ef0f9c86ae>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506093954894
Message-ID: <cb9895cc-27da-e298-eb56-29c045e723c5@virtuozzo.com>
Date: Wed, 6 May 2020 09:39:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <158827987994.4471.17266156514265064982@45ef0f9c86ae>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM4PR0101CA0045.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Wed, 6 May 2020 06:39:56 +0000
X-Tagtoolbar-Keys: D20200506093954894
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0153213-ad90-47eb-0ce2-08d7f1884af3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336AEC48E6D4498018A076BC1A40@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Ckr9nX6AGRId/a3LerzKvC4Ojvku30yALnENZGeVH98UqmEuESci9aHD6Q1Y5KHiLzuLilXcesCEWWUwDsfRfcHkH2JgCM3rQb28i2axany66nt+kV75Cmw42daCYUcPbjVawqGQGVM3Ez6lLI1wy9YKATAvDKpVqZlg6+GjDfAlCBhKK2dv0496zxLRCnPpu2csckYNiVayOwhCOScF7lFdl1FJKecD7pPEPcPPPub/RtfS2173aJg6NI4RX0ph8iuqHnFTte1iPOLymXWXakzE5MmvvbAFD4h1hiCIY87LupzjJnLH/KK0GI464l80Wue4dmtdGWea+f632tPjBlq9MyKdwHDTfWqnXaJ3wiOu0RLSeM6mh94EaBvVEReE85B7DRE6Qz0CLqzOZfVQtscQjOfqmP+uTzdB1pjYK5TeuhZVrfVouAz83N9MQwmx/Dk4uH8nEtTBluS6OjkQBGFYEvkKX8d9KO2NXI61kRVO/HOkuYIawX3luzROp6J48exjiVkYbgYc1Atv0d1T82WNWGMR0FiVVjAo4yjXofX/W+nmPp/8TCnIYLgJiqxCH/3jIdMeuY4WU89jPwPYwhqblew07azW9cb3r6SjfgEnF8WrgQerhdKifAs+OS+xMvCGt2ZRclPPHmhAiFQnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39840400004)(136003)(33430700001)(316002)(66556008)(66946007)(478600001)(66476007)(2906002)(8676002)(16576012)(956004)(8936002)(36756003)(2616005)(7416002)(6916009)(4326008)(26005)(5660300002)(6486002)(966005)(31686004)(86362001)(52116002)(16526019)(31696002)(33440700001)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JtKp8ziipCpwbbIrsJSGR4MwkyL1iWkKeA83BQxjiyOKPnLJsztnIf6mERf8uChlySJ56dXahK/PSvPGLI3WpZueB+S/WBIC643w9qbMihCYyjQUdgfr6jDz1nUg1NXAXV1HED/tbPNnk6tGa/HlHFWLxVTeJ2uGeTQm4kXK1YWGKfiCEfwtBoKj3+sVSwDKljCAy5rJRiuLtFBC/XftaeHifDnz/MOFOCGBKBrYNNOylRz5EH/myL81/wunJK5tXHahBRwYOHyW3RsG+wgUhcaYpHWiEYYoD4dNTEHe68MUcREytNsUj68Oiek22TwLBprcuw/c6HA4poUbbeRgD7iZnh89vsT4o42YEr0D1jKFFRiHA4QQsbWvZo97dBzZyp314H2A/K+OPnt32c7rHb78EhkDSxGZiFechJj3vRW1IgScNNTqZU5FkHr6QhB0qEMNyWSeDz+QG4Lyh6yXHlqT0w+PNKZssk99ZRBww+jLv7Ek6npbuTUPQgn1gWE5mvFJGQS5CcEkkkSZK3s01a8ZEfS5Qy1yQ2yOUuinYNwvK9l62jYhsk8xjekBteZH8lmnz9wwxl+J4FBe8cXouJnVdGDA3/DU4iLEFDipH0OdlYT/MG+cfqm+kMAB9G0M17CT6bkYRD1OaPj+sHfzHmVyCdELc9p9UhaHdd0fdClqtPy6Q5lm+WsQLPuwwopkx+nOuAsPPeA5prGgarxsP7IeIAV5Aq0VQe/KNqEGYca5WUUN19ngIgAvlBjyz7/CEcRH6NvOTmqGGoBy1XzsdW+bT9LRq8GlcHFv+Hvyfoc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0153213-ad90-47eb-0ce2-08d7f1884af3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 06:39:57.2867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wySs4W1lKW9ytXblYxlVRw/NMRz5izLL1DAIHt2kgV7KUsyrEB6SRVHg3EYbu2Fsn6+5wUCYANtSSWxgDtm+YTD62w8euqlrMbBq3b1ndMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.0.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:58
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 ronniesahlberg@gmail.com, qemu-block@nongnu.org, sw@weilnetz.de, pl@kamp.de,
 stefanha@redhat.com, mreitz@redhat.com, jsnow@redhat.com,
 sheepdog@lists.wpkg.org, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 namei.unix@gmail.com, den@openvz.org, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.04.2020 23:51, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200430111033.29980-1-vsementsov@virtuozzo.com/
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
>    CC      tests/test-timed-average.o
>    CC      tests/test-util-filemonitor.o
>    CC      tests/test-util-sockets.o
> /tmp/qemu-test/src/tests/test-block-iothread.c:79:5: error: initialization from incompatible pointer type [-Werror]
>       .bdrv_co_pdiscard       = bdrv_test_co_pdiscard,
>       ^

Oh yes. Shows me didn't run make check :(

> /tmp/qemu-test/src/tests/test-block-iothread.c:79:5: error: (near initialization for 'bdrv_test.bdrv_co_pdiscard') [-Werror]
> cc1: all warnings being treated as errors
>    CC      tests/test-authz-simple.o
> make: *** [tests/test-block-iothread.o] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 664, in <module>
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=42df3799b5074b82a8a4b696cb76547f', '-u', '1001', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-t9q8cenf/src/docker-src.2020-04-30-16.47.42.6034:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=42df3799b5074b82a8a4b696cb76547f
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-t9q8cenf/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    3m38.963s
> user    0m9.441s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200430111033.29980-1-vsementsov@virtuozzo.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


-- 
Best regards,
Vladimir

