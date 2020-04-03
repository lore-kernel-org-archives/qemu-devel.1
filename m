Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D791C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 05:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0364E20787
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 05:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nihk50Vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0364E20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKEdi-0007xP-VW
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 01:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jKEd5-0007OR-78
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 01:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jKEd3-0002AL-Tw
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 01:12:31 -0400
Received: from mail-eopbgr130119.outbound.protection.outlook.com
 ([40.107.13.119]:32322 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jKEcz-0001uC-Ct; Fri, 03 Apr 2020 01:12:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDeXK0kfTCudZDnjD/MwPHlrF/rqihbE9+DexkHniV2tvEtYe6ZKUCVJlutvG7iO5oBFw30wNkF/BLQmqc+gQjFRjLnByVEnASMQYSnFn7S15Fw84kZFQRiMEEuqOEu9fO1FGLhS/5WhNxYkqmQD4RmQQSYmmkRoSPpsX70JO3WSufLFUnNGNdJVRIS+0tvyv29RfCDBcAMxuEf5oFRXybqBlo1M2IlHGSirjyDskZHBNDsXvXgjqvPEWegs9Zat5Ct9BN/fMfARoPl+9PLtUKmt0N4a70qLTarSsK84nr4+sF8P1gnagr25oBhGZ+fQID7cotSE/zE8/7YJkucXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACEHy7R2E01/svlfAmO/wHa2sJBX9rOOgijcpxRVt34=;
 b=Y1V3CBIm1Rr+kdZR+Szk233qVLay+/Jz58haH1Hzk0iC3LCQB9T51/XBkB3WAE4jO0jUAwCcFeipH4cVX85NzrzMKOYZG7okcod6V9ccsK1Ss70hFwySoplXSs8nzM3AIpWjDaUeZIvjh41HfVY9FbafIM5iqLzR2832fN2FhoGILaUJYJQVEcEADHp2C/lTpUjurAyb8D1LG57kc00hyy0ID3GVguvfKtkzJnS0UyAsm400DObuUF0lLY7HEJlub0UWObkdLwXNr65lT2r5/T+pRRJpeRkjDTZCDFuGA4Pgz28kwAZFu82xjc1g5lTjKuRwEw67a7T48o6PtLFicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACEHy7R2E01/svlfAmO/wHa2sJBX9rOOgijcpxRVt34=;
 b=nihk50VpBq1dFFrIRyeGE/49JR1kr564QkEDzsxeV5sZtmQOHivSqLJyulpLndDo2+BKoqwNRRl0pUlLBEZDwPNtrL4MsGyfYsBKzavrZ0TIACHHOYuGXL7t0B+LZK9QifIid/iw8bAhYGOTn738s1gJqxMQSMoMXAzIH+/gHfk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5462.eurprd08.prod.outlook.com (10.141.173.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Fri, 3 Apr 2020 05:12:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.016; Fri, 3 Apr 2020
 05:12:23 +0000
Subject: Re: [PATCH v2 0/6] nbd: reduce max_block restrictions
To: qemu-devel@nongnu.org
References: <158575992796.20436.13965435168851617205@39012742ff91>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200403081220937
Message-ID: <6278787c-ab21-699e-7390-5c963776ea58@virtuozzo.com>
Date: Fri, 3 Apr 2020 08:12:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <158575992796.20436.13965435168851617205@39012742ff91>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0008.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.3) by
 AM0PR06CA0008.eurprd06.prod.outlook.com (2603:10a6:208:ab::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16 via Frontend Transport; Fri, 3 Apr 2020 05:12:21 +0000
X-Tagtoolbar-Keys: D20200403081220937
X-Originating-IP: [185.215.60.3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dab854d5-da89-43de-f388-08d7d78d973b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5462A3615105BAD16224C647C1C70@AM7PR08MB5462.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(346002)(396003)(136003)(39840400004)(366004)(31696002)(6916009)(16526019)(8676002)(86362001)(36756003)(4326008)(107886003)(81166006)(316002)(6486002)(16576012)(8936002)(81156014)(66476007)(186003)(26005)(478600001)(5660300002)(2906002)(66946007)(31686004)(52116002)(2616005)(66556008)(966005)(956004)(21314003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XG51IKET1FNeHQjU3vzYFnLH+Dm0Wv/BFRv3lHbzt1SJLGJiSqJv3P4sP+kPTlqos8BzoTB3yWC/UohCMsChc9uQVkqAuZIkrGXTevmhFu1MUCnOq46ltLeCCU4+GptxohhzjHNioMLqh9JeRh1KXV63PS5uGVn8O8eNY8L5Gfpv0Fp6fZvL0DMukydAB98945P15u1h0HQezIED2+1kAzV1IxsqPsujXD0EY3t3Ij/VFiWkjoQ1hWjDb20liPzI+VFvcZK+qvYPbqRHuwVlUaLP1sgTHEeZZZIGilJ4PNENpPyO13ByHPB8r3Ut0jX20m7SoZz2y8GLy8MsDo4k0NMdxV7vRpDymToBT9zSbubRRcIoH30FCBeE/WUjGgEHYqlMzmheh31LmLc6VcTXh68iQMK6RTYWp546Zuq+cr6MB6WBp5FS0AQTk8nDLQQ1wJDt7OZPkc8WTGAmYk5zhWKe/HBpn4pnMQToH3Nx3xAYckI+C/2Hz2nzM6P8BGrWPWnjibL7pvYZBOZUUcq4SCIqBylKU/xxQloT5faDPAKHS+MJUmiK2W/IzMI3ZsM
X-MS-Exchange-AntiSpam-MessageData: 4X7KZ/ZrTKiQQgM3qfbRbqJg27Mj/AnQ8BYE9ZNxE4zYUfUtv2Tq7Dur5bExQcWpRuPbe4MRbGZoRlWSG55zVR0VU6Oxij+vqFFJH8S6p9QP+zgTpU2TS+URFmw+2J5N83zeC6FYthznqqUM9Tbg1w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab854d5-da89-43de-f388-08d7d78d973b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 05:12:22.9907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gdxuqnuk+ordihlHsqLKrGatFk82gxMv1HOtRA26lDCJcLPWgj53XXe5tpgz4t88vIhG1otZXu72HqgVpyO0IQ1N1ab16jdUJloFhLkPRYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.119
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.04.2020 19:52, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200401150112.9557-1-vsementsov@virtuozzo.com/
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
> --- /tmp/qemu-test/src/tests/qemu-iotests/251.out       2020-04-01 15:01:19.000000000 +0000
> +++ /tmp/qemu-test/build/tests/qemu-iotests/251.out.bad 2020-04-01 16:49:36.542097534 +0000
> @@ -18,26 +18,16 @@
>   qemu-img: warning: error while reading offset read_fail_offset_8: Input/output error
>   qemu-img: warning: error while reading offset read_fail_offset_9: Input/output error
>   
> -wrote 512/512 bytes at offset read_fail_offset_0
> -512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> ---
> Not run: 259
> Failures: 033 034 154 177 251

Strange, all five passed for me.

Several writes just failed as not supported.. Strange.


> Failed 5 of 116 iotests
> make: *** [check-tests/check-block.sh] Error 1
> make: *** Waiting for unfinished jobs....
>    TEST    check-qtest-aarch64: tests/qtest/test-hmp
>    TEST    check-qtest-aarch64: tests/qtest/qos-test
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=067a8c1d1d00403ba8447315095d6388', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-7rgy2yf_/src/docker-src.2020-04-01-12.37.18.28490:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=067a8c1d1d00403ba8447315095d6388
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-7rgy2yf_/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    14m49.328s
> user    0m7.899s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200401150112.9557-1-vsementsov@virtuozzo.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


-- 
Best regards,
Vladimir

