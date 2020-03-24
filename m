Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD69C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 08:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E16206F8
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 08:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rnuoCMBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E16206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGeZO-0000A8-U2
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 04:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGeYc-00082t-KL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 04:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGeYb-0004PP-Cg
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 04:05:06 -0400
Received: from mail-eopbgr00128.outbound.protection.outlook.com
 ([40.107.0.128]:26950 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGeYX-0004NB-0J; Tue, 24 Mar 2020 04:05:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSHm4EGZ4x9asi6SATbPulpX/b+gunvfiIct9uWCT3n4y6JcOlDcHYOMUF17/9tEF5L+g3OhIWfq/XqW7OwPT64NuqEHGzl6Vuw2tg/uerJOeuhhhQ3zaheLrp9nlPajGlKo/ljCWWOqxD+AVD6bp4Qf+lxPz5yBaaQ0ZQPA7Mu7wz1xKCZxeLZ7hz97P9/Pq6NP6hl9ja+SZP53vmq9iciwIJ57aWLGDQVm7bcTTxXi36wLwAUPYcsWc2pgua7uKuvGIeHrpwU3ofJu39qzC9aJsZsr/OEaLMcsB2XXJ0+roVWrdLD/zIzCfru4t3cbLSR0FNILJllVXMJUa4R81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox67p3SGl/d4RUgsn9DvmeuYJY9EQKt0bkAWo9pvEPc=;
 b=f0bwdtwJz65KcmjO88gs0/GVYYzO6eKNatsNTi8JS6+D1HXmw9Za4un4gfbz9uIhMlzyAhrsC8LGoCJJCjaJvVYsu3uKJmdiOv0j9uj8PQYo/BxEwpiPBw5f5+VtGl8ATUIEc06iEosKLLsK7vHNxzV4RCQ7OS3Typ6FLR1slxD98KDJgvmkICaJ2zMZjOd9Nf8s2I7egjA4UK7Wc3XaXvYkrHitIdxHJPbkX250u1Tz6r/xHG1HMM22sleBBmBxZljH38Drl+ZG3TvllIuKMnKgk+VN3Wqzg9Ayy688eKNZg8q5Z/RMOaHAlD14aEqmL3uN4TfeS9GbKxebRLy7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox67p3SGl/d4RUgsn9DvmeuYJY9EQKt0bkAWo9pvEPc=;
 b=rnuoCMBDNDfgoJLz7jlS5XGAeNaLDRMoyWB5OvioYrW6vbMS1+LPAPAqQMYuxM759dC049DM+5Nq4KP8MVhKH36rt3WLQTy//6CzDX5TIxZEddFQKjK31Wc9YBXrONp4l6HO6wccN7iHiKWJBvbh9X5Paagd0KwUCiTRWtwYfEU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5381.eurprd08.prod.outlook.com (10.141.172.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 08:04:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 08:04:54 +0000
Subject: Re: [PATCH] iotests: drop group file
To: qemu-devel@nongnu.org
References: <158503665946.9334.11711683169078173597@39012742ff91>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200324110451846
Message-ID: <c07814da-5f03-ea89-c639-c8482757f7bd@virtuozzo.com>
Date: Tue, 24 Mar 2020 11:04:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <158503665946.9334.11711683169078173597@39012742ff91>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0245.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 HE1PR05CA0245.eurprd05.prod.outlook.com (2603:10a6:3:fb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15 via Frontend Transport; Tue, 24 Mar 2020 08:04:53 +0000
X-Tagtoolbar-Keys: D20200324110451846
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7d7328f-eede-444e-71c7-08d7cfca096f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538177C1D339995E35091389C1F10@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(39850400004)(346002)(376002)(396003)(366004)(31686004)(186003)(316002)(478600001)(956004)(2616005)(66476007)(107886003)(8936002)(66556008)(19627235002)(81156014)(2906002)(6486002)(81166006)(5660300002)(66946007)(8676002)(26005)(6916009)(31696002)(16576012)(36756003)(16526019)(52116002)(4326008)(86362001)(966005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5381;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adEPtnEejeEfjpejdZHM5DtV3BpuXOAU+zIIiYAaaPZAA4fULPaEZ0Golb3QsBI8+knY6m+4zLgd++g5xRbCH2MKnpD7JaoQ6lp1MvgU/LxAIK/8Y3x3vbrODKVeHSrrSvd4XAY8Lytqexz+K9PczfRQrwC53uPOiAbU6NYe84xk2MkMvctaNS0qxhDAtFzNXi6Gh36sCt45sOA1Q8+b95RhTuGoqLryMk0HLgOWYpewQC44AlbEPvhBeqHoou7ei/ZlvLb/tqe+CpA/qkuuBg79X4L9WuXSnQ0Fq/sVQpWhyzYLb4GOaAois9npIeOeViZ9VyDAxEg82zEHQ+GI2+O+JKvqjHC/pIknbjtVOft28hPqaam/gr4FdLj/VDEclc3cVKAwxGkuyHnGyHM//PrcKFE0CxWlkCkNuCJd+A6l4UvHy4ba93dyBFqwKlqP7XoDPd5SX0YDKktazEg/jQyesY/WHQ7+h4OtIVQPydoAR3y+TMXGQw/+SFVSBpKSFURPvPSboQziItUCVoRPJQ==
X-MS-Exchange-AntiSpam-MessageData: WJFkcc3EhMVqLVKgQkT3/V6BhrumBtaiR3aMuqtVHDEwdodvte7LM7dTivViEmmUAQf7J2xgjdhOSTTUZ5BEBPJgHcDq5+QJnYG1VNpFRInaB3c0hSGKtyIL+0La1mxoBBGe43SbkIVOnauX6an/Aw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d7328f-eede-444e-71c7-08d7cfca096f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 08:04:54.5991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcdPL8J7W69O0g1o/HnhhUaPVSddvM6APAd/xEjVMAbqulGoOOqhJs6aAY5zB4M2GixqcFEAt4tuus7QpIRSYZSfk4wCKC7aMG4HDgVsyRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.128
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.03.2020 10:57, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200324074156.5330-1-vsementsov@virtuozzo.com/
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
>    CC      s_normRoundPackToF64.o
>    CC      s_addMagsF64.o
>    CC      s_subMagsF64.o
> make: *** [check-tests/check-block.sh] Error 1
> make: *** Waiting for unfinished jobs....
>    CC      s_mulAddF64.o
>    CC      s_normSubnormalExtF80Sig.o
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=2b582229add741f387fcf0a88ff2a3ff', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-ot7uydwt/src/docker-src.2020-03-24-03.54.58.28935:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=2b582229add741f387fcf0a88ff2a3ff
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-ot7uydwt/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    2m41.224s
> user    0m7.941s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200324074156.5330-1-vsementsov@virtuozzo.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


Doesn't look as something related to my patch.


-- 
Best regards,
Vladimir

