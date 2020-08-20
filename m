Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADAFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9358420674
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n6zoyzEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9358420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8qLi-0004OM-OP
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 15:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8qL0-0003m8-Oy; Thu, 20 Aug 2020 15:35:02 -0400
Received: from mail-vi1eur05on2125.outbound.protection.outlook.com
 ([40.107.21.125]:60417 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8qKw-0001rq-QL; Thu, 20 Aug 2020 15:35:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv635mugApWDKFTNb5TSo/d8voadRuK7vgN33jAn9bh/yjncgtbpjLAUr5Q8e0Qhd/7QlPeooLeZP0YzH08AMPja7W8p47CTL/bTvi4906lU1iMfqtgBj4dr1ddwag0eI4pgiEoVLAu61F/Yh+w5M1oGv4LJsarIbw6zaRq3c/IdnAosxnv7QSya2Z3CMDgiSxCyCIm/AzAmV4s+sJKR3/LrxCktujO6vKISogdKUzxmA8Kgtcg84nL1cZ5MAc3lBCIddFP0I8RcTDTVTQjpOVBM48BoXbDDbqueklSSCFh70a04vjz2P6GYdx2SxwZ440pZH+SVgZD+nlfd47YlZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3D1q7P4mxOFBUyFzTPTKjHfgcL9MWhTfBIQnrRjjXs=;
 b=GK/+Z1gQWG9SIZRqzzlBtjbOM9FuzYgef+6dXwe1M0jrbWMp5ZvoKkj+3qDRBcwaP1DBYw9IITzNVuTZwZa9c3ZmKB7x9YpecD2FB0RlpGW12Qp4TMxD5kcJdBEhPBPmFjlhz5GZ/NWA9wGfoIwZO/d80dKmgtgY28PszWzKTlbo6sWWWJ1lqsoJeuUmwm3gthSnH7e9MBSR/mCSfYMKXkDEwno0KrxBiJ3IEScUpcSzoqm6W5DFq4eTltYSrEVxgGnDjPTs/qP0g82gW3uehbD0biDgSQ67zhqlHydZu7cXXhjFBcR1ElIF2KzHXvACg+vhun9B1zTXOKX/cq5Jgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3D1q7P4mxOFBUyFzTPTKjHfgcL9MWhTfBIQnrRjjXs=;
 b=n6zoyzEegrUQyAL+k8vpv49tZwph4LTZNe1Ea6+8/Q0ajdWH8EjKYZvDBWJTGttjf8qhtehydKET7mEbrVU5wFQEHCfKt57O4Eb/qPaGy2GzWMv0odsye++WCE/ssdoVvOk4XCmo/+rdJmgIFSpGK56KOx80oIeRm2iKKmfCVf0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4721.eurprd08.prod.outlook.com (2603:10a6:20b:c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 20 Aug
 2020 19:34:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 19:34:53 +0000
Subject: Re: [PATCH v4 00/10] preallocate filter
To: qemu-devel@nongnu.org
References: <159795100412.10087.13324527849844486009@66eaa9a8a123>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5935199e-0b16-150c-e742-2366b185fc79@virtuozzo.com>
Date: Thu, 20 Aug 2020 22:34:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <159795100412.10087.13324527849844486009@66eaa9a8a123>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:205:1::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM4PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:205:1::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 19:34:52 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c71a1b8-c494-4321-f59e-08d845401c9b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47217CDF742680BA9090B479C15A0@AM6PR08MB4721.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjevIEBO7aMzOfirjlTcx1wiQYzYS7UeKD2FQq5jH99OqXv691KNh0xNV9EwVDOKCY3lr6MMM1JLdtdLjYWi7B21Brhnei63NDejdre6YQJWFOZqE1IUbNwjQWGcS+hx6zfvsaVMMGOmxbldMvElZU6Pqa9AgZps9l+5hPrM0kPbavqLV8Wa6a3Fm5VGRXNgO7hD2DzwyGmHYfioFzhqduDxTDMtZu1seoIxqeDruRM9O3G7gP9t/hZKtr7lZ3VbnetV33jArT1t2ZCquMmKgfvegiBX4M2azHuPXrBCmuMg3rnVXwpvGcuURMPzg6kX0i4R0hwLSC0Kunz5ML+A0aVY4HkROpNI3tUzb2IxB0Tgl38diBDlV3eE+tv5UELdCGNmR1cra7CmtENOAiDiBiUaHvDMKOMDgHGjyyRi7qIn5jo6s/pcmO3Sgwg9TFcFJ0qaY62icaad64ISN2GFGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39840400004)(396003)(107886003)(478600001)(36756003)(186003)(4326008)(6916009)(16526019)(26005)(5660300002)(52116002)(8936002)(8676002)(16576012)(31686004)(2616005)(956004)(316002)(966005)(83380400001)(66556008)(66946007)(66476007)(31696002)(6486002)(2906002)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8f32MV8n49jr2kPqz2NOYKy7CwoqQaD7IHi1+xy9F7JyLskPbSgGFsF3c6yPjrsh6Pw7mJeuUDJ/r9yMacexUcsd2pUNzOaDynZKsxP5qPFKF7EoubzOj7+8Vpqotp+f0WREqAq6D2vIlm7GmJWr9hnbz11/t/dHqJ9f1t0ZflX7F1rvhmBKOnqHgg9k4AhLFH489ZujEJ6wVVYuvSDAHE6vhy+wnHGGgvstijZZoy+U3liDwZPrWi8AoYx4d5h6zv6MX3mgwCABu9tDsRpokgTf1EuA0JbK6ArzonXfpvSwucwXGkM7tsdkM1O9ny3l5guU4GZ+yhnHg+PrxlazHfjdOlrrt2vRrAG5o0LNHWCK7SQ6g/NOrNUxFs1kx6zdEyYohvd0ntf9B08JGBM5mF3UK27DK09UEZqvraHgKF1OZKbAlDZcotuNVwOW+XsFUMeSszcfd0TQaVaIRKkqYy0wcgYaqDwRn/XcrOBhwxpI5cVJiRyerEeJUk+CF1cIahJQPEsmcmm+VZ6rvQdCeM68MGI2krgh9Haw/n4k5SSYyi0A/Y4axD1GGSoP1FDnT8B/NxOM15nJNLykv8b/RdkleNlXIvft1akzhRKJHx3XCv99DTSnt4TIkUdjOaHqezQ/YbFaTmLS6HjvCcwxQQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c71a1b8-c494-4321-f59e-08d845401c9b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 19:34:53.4684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLc+F/xNXvrZ+MO+c9W+H2zamvGL8aMdSvmTuSeCFeCtMFffVaab26weyspqEKub2GW88Ktxhs4gezmgdAvDA0SNauqJYX8P2Zk3UBAFwTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4721
Received-SPF: pass client-ip=40.107.21.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 15:34:55
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.08.2020 22:16, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200820183950.13109-1-vsementsov@virtuozzo.com/
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
>    TEST    check-unit: tests/test-char
> Unexpected error in object_property_try_add() at /tmp/qemu-test/src/qom/object.c:1181:
> attempt to add duplicate property 'serial-id' to object (type 'container')
> ERROR test-char - too few tests run (expected 38, got 9)
> make: *** [check-unit] Error 1
> make: *** Waiting for unfinished jobs....
>    TEST    iotest-qcow2: 018
>    TEST    iotest-qcow2: 019
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=a80f0516394e4d83b19a19e329899c17', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-n_a2v5bj/src/docker-src.2020-08-20-15.00.31.12987:/var/tmp/qemu:z,ro', 'qemu/centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=a80f0516394e4d83b19a19e329899c17
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-n_a2v5bj/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    16m13.105s
> user    0m8.886s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200820183950.13109-1-vsementsov@virtuozzo.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


Seems something unrelated

-- 
Best regards,
Vladimir

