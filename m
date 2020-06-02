Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BBCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3354B20734
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="V0jP3wiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3354B20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg2BM-00032o-FK
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 04:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jg2AC-00027c-No; Tue, 02 Jun 2020 04:20:48 -0400
Received: from mail-eopbgr80119.outbound.protection.outlook.com
 ([40.107.8.119]:38244 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jg2AB-0008TD-FD; Tue, 02 Jun 2020 04:20:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKCxcFU6qD3X+Za+nROFtzCnoH0LmUU0lTySrDdK8Jj2AwFnhtSDYgX3bCh2VuhC9TdId2Okp6h/IbZsOJPiqX77X8dGrZ6TjhP9fJEIQ+spxIn3cF3B72nSeONYtBawC8HcjfCKnJANo+2WDqiNayr+BrsKE1QL53KztQii5wi1XqBEGstHdHEPreWvkumtYNulw/OjN4XU/U4i2jXYYCsLKqGIrV3Wgw1A2uxbJ6FRGSJbHMoIsGTDZ3KGPz78qKEUKH79ZyfpCh5X7uwjzCwgGjwRkf6GiDMtHs1rbThacx8NbveqbovlTBVj/PE0XwD8bOBrYS+tEP3CKpk09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cymemczLr0avLhXkwGqUxIV5aetG1ikBZGvyGG4fnw=;
 b=l/RRwgxILFMreYVPNWltZsBPbnkiVdvGZ5R1u5+LhDgQTX0oC9Qrk6AFo8KEkl6xLSexfG8v7qvgIDnotMKYGb3+S9HAkpvzdjtwpCn++aEfV8ee8a0Ql+GqFm5uwpNhmx91q8GwNx6UJD+owctIfFVUuie2cToS6n8z+m6wOZAVfAPxwEmeu+Nj0PP8bc11oTwacvVic9nHrym1D6fpjG+41wd0+QaelLnKLFFUL4DBFo1t4VpnzlJ/MhEhVNJF2nofDt6ZchniEjabrCzgFbwBPEB6kWQclikIZM2D/Jf5UQIVH5K9x++u0OUuRdgtWzeZgG/TNrR1oQN6wmiKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cymemczLr0avLhXkwGqUxIV5aetG1ikBZGvyGG4fnw=;
 b=V0jP3wiTcUTwT7pQyE7m7K9QJrJ5QAP2p0bsA+f63vnEvI18JiAiw4Gw0y6kPW+2ycpbF8HPslR/5Y9NG3c7aRUSix1MfqH9qBJcoXJEb2oE+RFwhM3myubYUHJ/tYzs9cHTAqivhleiXx8Jtfhp9+gAGakwKpSiVmaouf/VSHg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5511.eurprd08.prod.outlook.com (2603:10a6:20b:10d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 08:20:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 08:20:44 +0000
Subject: Re: [PATCH v2 00/20] backup performance: block_status + async
To: qemu-devel@nongnu.org
References: <159103794462.14492.17250035651193114253@45ef0f9c86ae>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <096c046e-4336-30c0-c924-a5d1816b714b@virtuozzo.com>
Date: Tue, 2 Jun 2020 11:20:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <159103794462.14492.17250035651193114253@45ef0f9c86ae>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0058.eurprd04.prod.outlook.com
 (2603:10a6:208:1::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.153) by
 AM0PR04CA0058.eurprd04.prod.outlook.com (2603:10a6:208:1::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 08:20:44 +0000
X-Originating-IP: [185.215.60.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70de7fa8-53cb-4332-4846-08d806cdd8b8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5511AFA88AAD05BBB293FCD1C18B0@AM7PR08MB5511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXqONNO6O7TqY8l4mScCm5xrDjEDiU28kam9mbTPj9OnGMbHlxaOwQpHbQyJb9+atrjYo6YL67+2FB7BgNfigN9DlV806cYDE3U5Ln1VsD0P4sfJxhmpn7ccJ5NCcDkvb4Ui/zyK8FJ9DQD4ceS4h4UOS0ttw1dL9MRdOOEm1t0VHWlKzdS1qdElXe1eQpAEmh5tR017Jy6Hw/r9KBzz0aJmRBFJFNSr0gTk/azCCkcuGHVP9bgxmvkCgWUkxCC/1To0mPgL9Ii29YdRdU7w/xy0K2FzoBOHZKjJViH9ygTW/7Ms2n6C7hsAJjJvN5N/bx/Byla8ZRo8sFmh5GsKc7SuHVsGEY0UeA+qvFeupVPw1pbbQ9uPRtM2STvoqgenuWK3EmBbl3PYe5ztnO8LwX5JNu9BWcprYhKu645bu2QClkaehjjfBTHdT5O/QLsH3vKbbe/LKlyRPSUwr7MMiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(366004)(83380400001)(478600001)(52116002)(966005)(6486002)(4326008)(86362001)(186003)(31686004)(16526019)(26005)(8676002)(16576012)(2906002)(66476007)(66556008)(8936002)(36756003)(5660300002)(6916009)(316002)(31696002)(2616005)(956004)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aRdnaoeIaLFI9JGNd6iEXkU7VC7Dr+2vIb690LcLtgB9+zAfXU4cyMGIadJIdHusocWEv/WFICnxj5ZLL2UVKEKZCoD+ahW512ShccpdCg+YnAHXgTzZr4y21/CpRsHH4P9oPG1tkUbOPNlURUWeKPtx2iGLe7vZJoNjqCYJxdKjP0G6icjC1RO5VAgI/vPKbsgMowDD8fvz8tgbu5kkFTKdSiQoIpuhPs3FlT9EHAnwfmNepdgBTcHgH9AdvzgvQ6nP9jv567F093Bi7VXixoeD+nZ/CPjBAvNbQuzu9ZcO+nVSDrijbnBbK49fmjxVg5H7uhaKmJN65nIi35ALEQRCIQMIo53QP6wqoySISzXt8fh9bX+ubevd3jTM67wL20BV8Xc3p7O6YJ17U+VP1QWcsujS28j1oVaeeXvnfstYGbHus6OeA/eChvanwqnwiSi3avRexPTcMTxFECVd4vl5Ij1Ipb5tp3NL/K/fTxVi5h2fksUkpix5L44BePPN
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70de7fa8-53cb-4332-4846-08d806cdd8b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 08:20:44.7734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tE+lhfEu5cBPzlyvv2GyfRyRw1J40OFQsV4iDWv3TYw8C4uH60y+dp9Nymisl972Y/uz0bpmjRjjy8ylP5/IMDEFLfJ7U5ZcYPStSff4MAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5511
Received-SPF: pass client-ip=40.107.8.119;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 04:20:45
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.06.2020 21:59, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200601181118.579-1-vsementsov@virtuozzo.com/
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
>    TEST    check-unit: tests/test-logging
>    TEST    check-unit: tests/test-replication
> **
> ERROR:/tmp/qemu-test/src/tests/test-replication.c:428:test_secondary_start: assertion failed: (!local_err)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/test-replication.c:428:test_secondary_start: assertion failed: (!local_err)

bug in patch 11, we need to set up 1 backup worker in block/repliction, not zero.

> make: *** [check-unit] Error 1
> make: *** Waiting for unfinished jobs....
>    TEST    check-qtest-x86_64: tests/qtest/boot-order-test
>    TEST    check-qtest-x86_64: tests/qtest/bios-tables-test
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=73ef29198bda41a1bce9aa3697266e4c', '-u', '1001', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-j0ydkht8/src/docker-src.2020-06-01-14.44.54.8388:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=73ef29198bda41a1bce9aa3697266e4c
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-j0ydkht8/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    14m11.116s
> user    0m9.306s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200601181118.579-1-vsementsov@virtuozzo.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


-- 
Best regards,
Vladimir

