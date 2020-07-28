Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46619C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE85220663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WMQYsVpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE85220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0PtY-0004tU-6o
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0Psn-0004F2-62; Tue, 28 Jul 2020 09:43:05 -0400
Received: from mail-eopbgr40103.outbound.protection.outlook.com
 ([40.107.4.103]:32129 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0Psj-00035h-9G; Tue, 28 Jul 2020 09:43:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRspDR5/Vqor1SynwJ25HoKvD/XEa4FxGnrWVkjLYDczYY7j5lZkACi571NZjVJCk+TIbOywGTmrmQlWEdwwSMd4heJg1CPAGHjMBSbrFpU91w4+CILZ+nAui4dSQL1oQoLuxyEG+O/KlSjWQPzMmbTrk5ZXS5mSRFLrfXsvgrzb2S3mv9wLSxH4sc6MAnpWjcfVexjCCexXNf9eweWC+omx2YTphuuufcRoLmsWLug7a1EhTHxuutXTwT+LHsEWrbvdQjXyYgWrECBC9kCQqF9IkZY8II5Cn7DnI0H/7fZdNMpf9mUcq0bAvNG7RQPU/p6JgsTQvFSHugu5nLLX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QJ7uiksf4wy+WAUd73gwD5Le/HZP7nteWn+HxObqM8=;
 b=lIdv56pmpvgsNNVmCTVc6rQDVSq0v7ZISJ/4miCWIRGgkZPXDl4lvMYU3p0bgaI8CsvcXL/V/2Onwr21Jr45e1iZRfiIEjhbYMFUyyEiv840O8Wd9QbyXxXwv4U2uaSnOLSE1erfB8Y9tRCyKTP93xNPvm85iJohxevLSCw1jNbq4xXGLaO6u9fOEV0LYlkXrKeg4BTlsjDjzXFjFeothYtkj1YArFfEAd0cEICoSUgorpnC3voQ00xiIYUcdFla8qlBspLvIoIz3yqHPwhfWjOdClr8zbyc2TIGm2ALirGSw2qDpUjLC2Inxvvxcoa2SbLNdkmaAACmwvzlNb5cHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QJ7uiksf4wy+WAUd73gwD5Le/HZP7nteWn+HxObqM8=;
 b=WMQYsVpymZnm8uWtiatCnkjGVykMnR/HxGJcJo71nOvo5eNEq0q3dKYT5xjDa6EmW7XAn5MdY7U0FBwFomfmmQ15y6TMlYm03GsjIQ1CbgckEbG4hCVnXyptiJUZLV2YgXcfJl4+ymX/hYZrk0rMIFOC2fLT0lGv3Keu8e29ocs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4021.eurprd08.prod.outlook.com (2603:10a6:20b:aa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 13:42:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 13:42:57 +0000
Subject: Re: [PATCH v2 2/4] iotests: Make qemu_nbd_popen() a contextmanager
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20200727215846.395443-1-nsoffer@redhat.com>
 <20200727215846.395443-3-nsoffer@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ac8994e8-7f06-0710-78ce-0596e9538e7d@virtuozzo.com>
Date: Tue, 28 Jul 2020 16:42:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727215846.395443-3-nsoffer@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0090.eurprd02.prod.outlook.com
 (2603:10a6:208:154::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR02CA0090.eurprd02.prod.outlook.com (2603:10a6:208:154::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend
 Transport; Tue, 28 Jul 2020 13:42:56 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f138e96c-ee2d-4628-d09c-08d832fc22ce
X-MS-TrafficTypeDiagnostic: AM6PR08MB4021:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4021DB23CA9985A975D532D3C1730@AM6PR08MB4021.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cr8juwXkkUkEQAfoVvGvbSzpvrkxdvzY501X4V9oP2gDCPfJOf0dTseGeVKeKXez6XFYw8rRzaAZmCMGiOobOU7dxG9dKa85r5hV4k4R7Xz29hmhEMaILwjzFKpZd7Mad3xwYiZvGEjClyVJepSE+82y4s+BT98hdAsN5NP4/mnunnfcu4IXfmDiTI0SHvt3qUu5nkSqwrPS8MW8Rim+joTuLchLM7cUFudZD/i0E6OIZ9z7qXukYgorSEvC/4epSAOij0qA7Oktj9BQXTjBvI+ML6aq0JfvsfsSfnMeFGiemxlGRcxR1b7y0iAdr6PfqWX0WaFwRBkOKaaNhsb0j+F+A88y3SB8mBNqVQgpOFayh0tD1S636g+ryHHcBtlN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39850400004)(376002)(136003)(396003)(52116002)(54906003)(8936002)(2616005)(31696002)(16576012)(66556008)(316002)(26005)(66476007)(86362001)(66946007)(186003)(8676002)(956004)(478600001)(6486002)(31686004)(5660300002)(16526019)(36756003)(4326008)(2906002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: S+MBI8ZNEOmS5g+zKiOpysHD89zpD6sA0zkyAF13HOclx7Ic59AYbqFSBeF2nwdRfN5SsyV5SoYLSks+XQgvG3+WT7pBsqS4eXvVJjA1KORftXQH6sZsbAnboHSUViT3Q2q8YBs50aVWDw4lShlofzwkOomaZiWYmMHZ82YZA/NGdq/4cousRrqqf0nUK7YFAiHgb1yqYYfk9p/bBYs9Y+JXJKz7LTX5NV9MJwcn0dUjvKhqCttdmushxvi7AbLQnIaF+EUr6cfYel7ryVmXTmsQ302HqHFIk1boSKOtz9C3iiwudRZFpSmEjXQuEbTomXdzZoKhFz/hURoK+ykhTnDLQlDXsDP9nOTW1dz+8Y0IFdf4L1ePoAonr6AYFnJE+M300E8YUVwAaYgCdvpn9HRrNVLnTPKUz9JCB2mw7P2pN8zRrDuNPdyPXoLPwRVXoPYsg9L10iXI3B0k3nXcQtHvLRy/Cn4MKCdbDA2bhhJC7wXNF4CwObr+iWGLgnLX
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f138e96c-ee2d-4628-d09c-08d832fc22ce
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 13:42:57.0927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCk5/jVE0OtBbxMAKzWNWP2wIz0GcfoKQLnaNHflFVdxnuE/0Vs0+haBewz8cpLtaq/q2SnQ7IO91gFaMC+rZomj8uFRX7UlmhOcKPa38RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4021
Received-SPF: pass client-ip=40.107.4.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 09:42:58
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.07.2020 00:58, Nir Soffer wrote:
> Instead of duplicating the code to wait until the server is ready and
> remember to terminate the server and wait for it, make it possible to
> use like this:
> 
>      with qemu_nbd_popen('-k', sock, image):
>          # Access image via qemu-nbd socket...
> 
> Only test 264 used this helper, but I had to modify the output since it
> did not consistently when starting and stopping qemu-nbd.
> 
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>   tests/qemu-iotests/264        | 76 +++++++++++++----------------------
>   tests/qemu-iotests/264.out    |  2 +
>   tests/qemu-iotests/iotests.py | 28 ++++++++++++-
>   3 files changed, 56 insertions(+), 50 deletions(-)
> 
> diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
> index 304a7443d7..666f164ed8 100755
> --- a/tests/qemu-iotests/264
> +++ b/tests/qemu-iotests/264
> @@ -36,48 +36,32 @@ wait_step = 0.2
>   
>   qemu_img_create('-f', iotests.imgfmt, disk_a, str(size))
>   qemu_img_create('-f', iotests.imgfmt, disk_b, str(size))
> -srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
>   
> -# Wait for NBD server availability
> -t = 0
> -ok = False
> -while t < wait_limit:
> -    ok = qemu_io_silent_check('-f', 'raw', '-c', 'read 0 512', nbd_uri)
> -    if ok:
> -        break
> -    time.sleep(wait_step)
> -    t += wait_step
> +with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
> +    vm = iotests.VM().add_drive(disk_a)
> +    vm.launch()
> +    vm.hmp_qemu_io('drive0', 'write 0 {}'.format(size))
> +
> +    vm.qmp_log('blockdev-add', filters=[iotests.filter_qmp_testfiles],
> +               **{'node_name': 'backup0',
> +                  'driver': 'raw',
> +                  'file': {'driver': 'nbd',
> +                           'server': {'type': 'unix', 'path': nbd_sock},
> +                           'reconnect-delay': 10}})
> +    vm.qmp_log('blockdev-backup', device='drive0', sync='full', target='backup0',
> +               speed=(1 * 1024 * 1024))
> +
> +    # Wait for some progress
> +    t = 0
> +    while t < wait_limit:
> +        jobs = vm.qmp('query-block-jobs')['return']
> +        if jobs and jobs[0]['offset'] > 0:
> +            break
> +        time.sleep(wait_step)
> +        t += wait_step
>   
> -assert ok
> -
> -vm = iotests.VM().add_drive(disk_a)
> -vm.launch()
> -vm.hmp_qemu_io('drive0', 'write 0 {}'.format(size))
> -
> -vm.qmp_log('blockdev-add', filters=[iotests.filter_qmp_testfiles],
> -           **{'node_name': 'backup0',
> -              'driver': 'raw',
> -              'file': {'driver': 'nbd',
> -                       'server': {'type': 'unix', 'path': nbd_sock},
> -                       'reconnect-delay': 10}})
> -vm.qmp_log('blockdev-backup', device='drive0', sync='full', target='backup0',
> -           speed=(1 * 1024 * 1024))
> -
> -# Wait for some progress
> -t = 0
> -while t < wait_limit:
> -    jobs = vm.qmp('query-block-jobs')['return']
>       if jobs and jobs[0]['offset'] > 0:
> -        break
> -    time.sleep(wait_step)
> -    t += wait_step
> -
> -if jobs and jobs[0]['offset'] > 0:
> -    log('Backup job is started')
> -
> -log('Kill NBD server')
> -srv.kill()
> -srv.wait()
> +        log('Backup job is started')
>   
>   jobs = vm.qmp('query-block-jobs')['return']
>   if jobs and jobs[0]['offset'] < jobs[0]['len']:
> @@ -88,12 +72,8 @@ vm.qmp_log('block-job-set-speed', device='drive0', speed=0)
>   # Emulate server down time for 1 second
>   time.sleep(1)
>   
> -log('Start NBD server')
> -srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
> -
> -e = vm.event_wait('BLOCK_JOB_COMPLETED')
> -log('Backup completed: {}'.format(e['data']['offset']))
> -
> -vm.qmp_log('blockdev-del', node_name='backup0')
> -srv.kill()
> -vm.shutdown()
> +with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
> +    e = vm.event_wait('BLOCK_JOB_COMPLETED')
> +    log('Backup completed: {}'.format(e['data']['offset']))
> +    vm.qmp_log('blockdev-del', node_name='backup0')
> +    vm.shutdown()
> diff --git a/tests/qemu-iotests/264.out b/tests/qemu-iotests/264.out
> index 3000944b09..c45b1e81ef 100644
> --- a/tests/qemu-iotests/264.out
> +++ b/tests/qemu-iotests/264.out
> @@ -1,3 +1,4 @@
> +Start NBD server
>   {"execute": "blockdev-add", "arguments": {"driver": "raw", "file": {"driver": "nbd", "reconnect-delay": 10, "server": {"path": "TEST_DIR/PID-nbd-sock", "type": "unix"}}, "node-name": "backup0"}}
>   {"return": {}}
>   {"execute": "blockdev-backup", "arguments": {"device": "drive0", "speed": 1048576, "sync": "full", "target": "backup0"}}
> @@ -11,3 +12,4 @@ Start NBD server
>   Backup completed: 5242880
>   {"execute": "blockdev-del", "arguments": {"node-name": "backup0"}}
>   {"return": {}}
> +Kill NBD server
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 3590ed78a0..8f79668435 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -28,10 +28,13 @@ import signal
>   import struct
>   import subprocess
>   import sys
> +import time
>   from typing import (Any, Callable, Dict, Iterable,
>                       List, Optional, Sequence, Tuple, TypeVar)
>   import unittest
>   
> +from contextlib import contextmanager
> +
>   # pylint: disable=import-error, wrong-import-position
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
>   from qemu import qtest
> @@ -270,9 +273,30 @@ def qemu_nbd_early_pipe(*args):
>   
>       return subp.returncode, output if subp.returncode else ''
>   
> +@contextmanager
>   def qemu_nbd_popen(*args):
> -    '''Run qemu-nbd in daemon mode and return the parent's exit code'''
> -    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + list(args))
> +    '''Context manager running qemu-nbd within the context'''

PEP8 (or some another PEP referenced in PEP8) asks to use """ for doc-strings

> +    pid_file = file_path("pid")
> +
> +    cmd = list(qemu_nbd_args)
> +    cmd.extend(('--persistent', '--pid-file', pid_file))
> +    cmd.extend(args)
> +
> +    log('Start NBD server')
> +    p = subprocess.Popen(cmd)
> +    try:
> +        while not os.path.exists(pid_file):
> +            if p.poll() is not None:
> +                raise RuntimeError(
> +                    "qemu-nbd terminated with exit code {}: {}"
> +                    .format(p.returncode, ' '.join(cmd)))
> +
> +            time.sleep(0.01)
> +        yield
> +    finally:
> +        log('Kill NBD server')
> +        p.kill()
> +        p.wait()

why do we need try-finally? I think, the only possible exception is your "raise RuntimeError", and in this case the process is alredy dead, no need to kill it (and print the log message)

>   
>   def compare_images(img1, img2, fmt1=imgfmt, fmt2=imgfmt):
>       '''Return True if two image files are identical'''
> 

anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

