Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819E1C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA28207DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="elx3sT5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA28207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ceb-0005oc-GF
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7cda-0004rA-Qi; Mon, 17 Aug 2020 06:45:10 -0400
Received: from mail-am6eur05on2108.outbound.protection.outlook.com
 ([40.107.22.108]:10592 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7cdX-0002H3-1E; Mon, 17 Aug 2020 06:45:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjLjBY1JELOrUaue8/EsvkDOu1hGLFes06i2ruxi7jDRAYZf2SkvWWlYTp0MRkPC9fdMQWc/RjvZF1T2+QCMcPbF8eABAlwgRZr2qlvomgAlYV0DZB4G9TV/36edJ3J1Ftih/K6f01FheJRv4Hn/jN2rwz5lPkXBAeRdMduYN4gFQg9yHyzuobNcxyWrGGXuRllsrp6qLG7OhTOxDZ/gRUiAxZQf48G8Q1JD0va0fsVctDd29KbR48Ueq4z0TvVdUnNj7lmdv6irg4vvzhZSbMK3pGQRSaUKFyQOeh19iLwGpp2vsXMbzyPvmCmOMDPbBWsh2wa+L4JLDvTs2rDBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6flosbFrOFrT+5WiNFL0lJnzDk0+xckDHbS9MQG6JA=;
 b=m0Klw1ISbFmZ5ptMRNlRhxt7euibgqOkeI6A97oI4WL+1gZt5ZjIwesxHVejasu4yv0e7GhMbFHn4Tbyr/UR3PGv+2qcdQH+fZnyMac6OglIkh2tZvX5XU6MbvOwrJDReASHQkPiMm9S+XJiuCyRgQSHJifKQ+phJ4vCQD1ewTZUPAnQLgIzmO5Ie1Twolw91axX2oYH9jM2NP88964ggKodVhMCg/0agZxevEgArFxVtqFHH5zHKXBgosVMcbTZ8x8cil925R7pFtTCFFXVfjUvAeCf/uPypZTBBy6iaTO0woAwTsBOq9Ujq4C6RRwFD1crZ0pct3BiDjLWA+Xofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6flosbFrOFrT+5WiNFL0lJnzDk0+xckDHbS9MQG6JA=;
 b=elx3sT5Sx1hJjIQx8WgUPcAyYEKT9N8WhhOWYqnzt/mI6uD73yT8uVFxSll+XFAjowv9NRg+MlzjynM4LFNuO7ulD6hFbyM9mdm25GV3Tuzv/9nL/FOHIa6b7X+DtUBRk0izKGp8RaPjHPP3lXZQiOpy914/gAAR8xc0Hb5DuWs=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Mon, 17 Aug
 2020 10:44:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 10:44:59 +0000
Subject: Re: [PATCH v3 00/12] preallocate filter
To: qemu-devel@nongnu.org
References: <159765753240.28013.15878373545034383880@66eaa9a8a123>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4f7c6d34-8beb-810e-130b-03cbb1e967df@virtuozzo.com>
Date: Mon, 17 Aug 2020 13:44:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <159765753240.28013.15878373545034383880@66eaa9a8a123>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.174) by
 FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.15 via Frontend Transport; Mon, 17 Aug 2020 10:44:58 +0000
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a43a55e-18bf-4263-3d12-08d8429a9692
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381D26C50871A5BD5DA4396C15F0@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKnc6p9hdH/eJtrcSIEZ4T7itNOXDE+hVTfHLiy6Wk1ohZKUTkSiSP501QnqBorGUIyfkR8EyezitVo/j8IHxsEHn8FBx2OFVmFfFV2NfGcv0qS7FkBp+oyoqpdfnGrf9yrPnnXpxTby5uLHkAG0r8BSgfSNedBcFlGn46jWYHD/CagqhjgvZ1kuwma5gRPXibEEaFHcv4WlKrkENiB4IKSZXLY/vE12oQCypuqYYSucXcXNxp0+yB48fQRVAx87oqlwXYnLXMol5OVAybBeEqDoSv8zbDFxi+fQlTE3Jl08gFyIOYZykakvdwFmsz7rJBdGtkMgTV3HKnz1FkWuWuctaOfgQ5fW69Rxo7layX8sYuYTLOkhnwGLY9kdftrUPggnolA05P/7gXtNXIO5y4bHXscyREfDLeViYJ/WI+NwpuW5b0XLEZSGUgXYEhw6z1n+BHavFS7r/5M6IxVpfen5+d6IsAkJT/JZdiswRcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(4326008)(86362001)(2906002)(966005)(26005)(36756003)(8936002)(956004)(186003)(498600001)(16526019)(52116002)(16576012)(6486002)(66556008)(66476007)(2616005)(31696002)(5660300002)(6916009)(107886003)(66946007)(83380400001)(8676002)(43740500002)(460985005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QDcXL8uyeHbe669adIjKB1ajXOcaaEik1ZXF25GQpMwCeiyUJIxhRyCm3kU+DnzFbcKvFIRywoWNY2ckZezURg1KijkThVfv+BRLIUUNRKRiri9thwtZyiXgOJ2ysVCk1frAUj9BGGsiiXtn2fmBDU3mfmpTK7AKax/YCoPDnEVwssNGnr/fUi8jcphEZxqpdr7CBTZ5aKhhCLYa1I/6G9e5kLd9Of2WWzs7XqWJmM3V0Jet8Mx2JDtkX7xcjFlAbbBxXausMsdZHgCCnx06+WBH5BXi14NoP4rI24sCvrgtMAaZpYOhgv5ITu5AweyQIG1UoXoi3DTq4o08aGYfXnafKISDa1MXWiq7q0nR/2TrCGltqmZ2h5TDDKTuqlHgrGGltpNAdrj7SRUcPbtiJ81p3xs7D7oEiPtmdDpyK2+TzwinVM3zhH9PHHuxgB9/4MlvImfhy8jkWW3MtycdzOJ+wxfHeMOIMGyj4tC72XrWFpcoaGz7jnI37+LxwJT9iXxInPHpvHQ3hu8kGGIeloPSzLLQc5X/uYFNiqDQflID/srw3uH8itHM1n0XfcFYEXFv51t3cB7NCedRQlPWmf3sA8zx5d1TsaxBM9qVH7n75AkpjgWdVkjmWHID47mF6MEoJoVLSoO2TyGJSA4zfQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a43a55e-18bf-4263-3d12-08d8429a9692
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 10:44:59.3001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0NXzmuRojqEOg5wtli7xIkFnolOKvNzelsXiof8/DFzGngvmocCSfCfbnN4qo3H/jQ5177ZmExdk1Zq4XiWIXTKwsAn2yWOqdBzUmYJiKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.22.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 06:45:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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

Aha, if we want commit 11, we'll need also a stub function for win32.

17.08.2020 12:45, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200817091553.283155-1-vsementsov@virtuozzo.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #! /bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-mingw@fedora J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>    LINK    qemu-edid.exe
> /usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bin/ld: block/qcow2.o: in function `qcow2_vz_insert_prealloc_filter':
> /tmp/qemu-test/src/block/qcow2.c:1878: undefined reference to `bdrv_is_file_on_fuse'
> collect2: error: ld returned 1 exit status
> make: *** [/tmp/qemu-test/src/rules.mak:124: qemu-io.exe] Error 1
> make: *** Waiting for unfinished jobs....
>    GEN     x86_64-softmmu/hmp-commands.h
>    GEN     x86_64-softmmu/hmp-commands-info.h
> ---
>    CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
> /usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bin/ld: ../block/qcow2.o: in function `qcow2_vz_insert_prealloc_filter':
> /tmp/qemu-test/src/block/qcow2.c:1878: undefined reference to `bdrv_is_file_on_fuse'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:219: qemu-system-x86_64w.exe] Error 1
> make: *** [Makefile:527: x86_64-softmmu/all] Error 2
>    CC      aarch64-softmmu/hw/arm/xlnx-zcu102.o
>    CC      aarch64-softmmu/hw/arm/xlnx-versal.o
>    CC      aarch64-softmmu/hw/arm/xlnx-versal-virt.o
> ---
>    LINK    aarch64-softmmu/qemu-system-aarch64w.exe
> /usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bin/ld: ../block/qcow2.o: in function `qcow2_vz_insert_prealloc_filter':
> /tmp/qemu-test/src/block/qcow2.c:1878: undefined reference to `bdrv_is_file_on_fuse'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:219: qemu-system-aarch64w.exe] Error 1
> make: *** [Makefile:527: aarch64-softmmu/all] Error 2
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 709, in <module>
>      sys.exit(main())
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=46c939bfc42848c6bf98acc32e769fb0', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-v9t81w9y/src/docker-src.2020-08-17-05.40.50.16028:/var/tmp/qemu:z,ro', 'qemu/fedora', '/var/tmp/qemu/run', 'test-mingw']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=46c939bfc42848c6bf98acc32e769fb0
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-v9t81w9y/src'
> make: *** [docker-run-test-mingw@fedora] Error 2
> 
> real    4m43.217s
> user    0m8.945s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200817091553.283155-1-vsementsov@virtuozzo.com/testing.docker-mingw@fedora/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


-- 
Best regards,
Vladimir

