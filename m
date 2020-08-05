Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49A6C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 07:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834462245C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 07:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="B0BeNef9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834462245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3E1I-0002uH-OP
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 03:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3E0h-0002QP-G8; Wed, 05 Aug 2020 03:38:51 -0400
Received: from mail-db8eur05on2098.outbound.protection.outlook.com
 ([40.107.20.98]:52080 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3E0e-0000kG-DK; Wed, 05 Aug 2020 03:38:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiTUB99sUU3rzvqnj0bBuxsiBL1Tntp0l8+W/0o1jFQ0w4vJZ06xnuumU44tuK1RYJyn1Du50AZpXL16PGr5kIbGL3lad820X9yVwx5avDkgXAV4j/NNag6qwLu/wDzFW4SCJ2G/59R8rYuLUiWN0gn2FePLXWlJHP7l1MAaJklByfbPSUYHZBt1Dh33jeS21KaAQfK6rztiiUKAS+I1mA81A2X6uZkrW91m4Uc/aX/zkTDr6KSG60tesNA6QNd5YSFJ5tbF20IxJY9MlugsvoKCsdVR46SULlpyo3Op65LVteHvP3Pxg+47wgLyLkIe3Z2qBRf0xGXKOh2Uh7TaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eYC75vXxJiC+SDeMsW5sdSz1u4nkrZ6iYHaeZheKIs=;
 b=m2nURM1Jyd7gu6upooLJ9w0jWLoc4jJeAh+nwi7XgU+TDqUKopW5MIW+/owgvQQxN2gJNNXXoCZiPnstybsMALcYf2pIRnxn4EgsF12wHX7j8Iuu4y46qrYyumJKY7/KOyQLmWIu99ptXJme2f9B5/7Ky3ApteNzHJbio4Gxf5q8eI07nt3+OLseGwi9yayJSG0OyIB5FUCzBWccQeRSdBFIIUKu7JQuLKq5gwJfuVRAnEUq7gnMnwFAPNs6U2Zrq5QYV+bkSMS63ikw7mq4xW4wH+dzXksKL0q+tD/lVl9VT0fMMKl1qFvxFHYNJtivJa7nMJJKwCvQMhN4S0Bi4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eYC75vXxJiC+SDeMsW5sdSz1u4nkrZ6iYHaeZheKIs=;
 b=B0BeNef98LGufDp2xi8oCAtzIADrRAixtX4hsmTtVYjdr57Ijip1Pd6oha9ol3auM6RcaxkrHWGqX8Yu2SQmWlvuxURhlBDOLbrZdKPQfdQyIbzzMwKXOe/tQQu0W15tS3EJD2Qi/CpxgN8+SUJycV+P3mNaLqYRH+Ei0L4GRzA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB2099.eurprd08.prod.outlook.com (2603:10a6:203:4d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 07:38:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 07:38:42 +0000
Subject: Re: [PATCH v2 2/4] iotests: Make qemu_nbd_popen() a contextmanager
To: Nir Soffer <nsoffer@redhat.com>
References: <20200727215846.395443-1-nsoffer@redhat.com>
 <20200727215846.395443-3-nsoffer@redhat.com>
 <ac8994e8-7f06-0710-78ce-0596e9538e7d@virtuozzo.com>
 <CAMRbyyuz5yfbuQHJDNXcdbW=pdyH8rSqM6um=XkaDtH1gpk9dg@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2095873f-7064-0805-673d-7ec04e0bcc6e@virtuozzo.com>
Date: Wed, 5 Aug 2020 10:38:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAMRbyyuz5yfbuQHJDNXcdbW=pdyH8rSqM6um=XkaDtH1gpk9dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.157) by
 AM4P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 07:38:41 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4236e2-7323-43e4-4dbf-08d83912939a
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2099:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB20995247ED8DA6E5652E7B4DC14B0@AM5PR0801MB2099.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l68IvbHRfBHBYYyMREfwAOBtwqAQMUIbAdEJB9qyCFk4fGD74EX8L0A7lI1Zy4m2416It+Rk6ph1KM4Q7sqOU89Ca11itkhJz/SqmFDwRh61aFsqGz8MW5/OtF9E6L11/zbgEMY+PKmurgKkdaWqiz4i3gT93ABouFp43El0E5pmwrubL1bcjtqLrQVVUcFPPaSiU0E0rfCl1cijRRNuDJ2efFPLJ63pxktt+visVeYYlJs0tD8hagWfARDhK2wcJ1ZP6hesfAACZ/i1pnOq0Ug+qWAUcl4I4pArXpHsIVYbYxnqOWs9mP6je0mhYAo9RouNANmpSEQyAIK5fq6MQLhXI0zMNux4yYXIfKVsvqh8ER1lGQ6Qj1OOa+MyiTJk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39840400004)(16526019)(6666004)(186003)(16576012)(2906002)(8676002)(53546011)(31686004)(86362001)(54906003)(52116002)(478600001)(31696002)(6486002)(66556008)(66946007)(66476007)(316002)(6916009)(83380400001)(2616005)(956004)(5660300002)(8936002)(26005)(4326008)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Gq7THzFqSoBv0zuCWUZ3zxwZWymh8ZzYtdOj3CulqeC0VxWuKVxHCCSppEGuxPlhMJyxBULwCr706F54vt7UDx+D1ZNjHM+5kgOEphpVxuuFrV6TU/6T9Xypv91Ug+gMFsr9P1xUb5CTuFeZT0RdHQYFXZLKPysCAoP7yIpIV9sc/ctlC3DFxvJDm66W1DYgjn8XFpl99mK+HpPrSScLfqev0i4QxmbqDW44GChR34EfvQWJCd1u9joY5Tw14PieGcTEXU7mEfABXmpwGFI3oD99qsErwaARGB2vUkenMpSYZek5hiE9nzZhETrZTw4y9VeE4ZnvwHchobkNXk5z8dIFE/jWD4NEPNv6LFVc7qnISjxD5ncwo/S9pssd1/cE+KZRFno2CVetePbG/o1DhsGJDohho+NgsfxklB6mnWbPvDN57V1SdcU7/sME7HivDFHgXRCHKfMBkKf4e3t5rBOH5eG7Io/grb/kAWAf4u/4zlWhnwQgIEbc0W1MD1nLMxDirr3vcI5mvBt9Fj6c7Y1K/BqboRTzGymIqyoukmrX2z0CE9U7/hAChuvrZHR5cq/FNKsWcWSlw4v7ecQLpTM9qjkECNbR7wxJ3eALAkFd3/Nubz9TnYmaYfZ5LPORAfs1pfeaQz3X7ja1FBqRQg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4236e2-7323-43e4-4dbf-08d83912939a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 07:38:42.2777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTSW9DCW9XBQxoSMMK0j3+8QmL/kKP4fcjw9/k2KwlgM6A4WRDuqv7KEp0I2HDvM4GexqvZA4Xova/BBpaOQG5Z05LEQ2WYHGJ3ObOrWZcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2099
Received-SPF: pass client-ip=40.107.20.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:38:44
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.07.2020 19:05, Nir Soffer wrote:
> On Tue, Jul 28, 2020 at 4:43 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@virtuozzo.com> wrote:
>>
>> 28.07.2020 00:58, Nir Soffer wrote:
>>> Instead of duplicating the code to wait until the server is ready and
>>> remember to terminate the server and wait for it, make it possible to
>>> use like this:
>>>
>>>       with qemu_nbd_popen('-k', sock, image):
>>>           # Access image via qemu-nbd socket...
>>>
>>> Only test 264 used this helper, but I had to modify the output since it
>>> did not consistently when starting and stopping qemu-nbd.
>>>
>>> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
>>> ---
>>>    tests/qemu-iotests/264        | 76 +++++++++++++----------------------
>>>    tests/qemu-iotests/264.out    |  2 +
>>>    tests/qemu-iotests/iotests.py | 28 ++++++++++++-
>>>    3 files changed, 56 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
>>> index 304a7443d7..666f164ed8 100755
>>> --- a/tests/qemu-iotests/264
>>> +++ b/tests/qemu-iotests/264
>>> @@ -36,48 +36,32 @@ wait_step = 0.2
>>>
>>>    qemu_img_create('-f', iotests.imgfmt, disk_a, str(size))
>>>    qemu_img_create('-f', iotests.imgfmt, disk_b, str(size))
>>> -srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
>>>
>>> -# Wait for NBD server availability
>>> -t = 0
>>> -ok = False
>>> -while t < wait_limit:
>>> -    ok = qemu_io_silent_check('-f', 'raw', '-c', 'read 0 512', nbd_uri)
>>> -    if ok:
>>> -        break
>>> -    time.sleep(wait_step)
>>> -    t += wait_step
>>> +with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
>>> +    vm = iotests.VM().add_drive(disk_a)
>>> +    vm.launch()
>>> +    vm.hmp_qemu_io('drive0', 'write 0 {}'.format(size))
>>> +
>>> +    vm.qmp_log('blockdev-add', filters=[iotests.filter_qmp_testfiles],
>>> +               **{'node_name': 'backup0',
>>> +                  'driver': 'raw',
>>> +                  'file': {'driver': 'nbd',
>>> +                           'server': {'type': 'unix', 'path': nbd_sock},
>>> +                           'reconnect-delay': 10}})
>>> +    vm.qmp_log('blockdev-backup', device='drive0', sync='full', target='backup0',
>>> +               speed=(1 * 1024 * 1024))
>>> +
>>> +    # Wait for some progress
>>> +    t = 0
>>> +    while t < wait_limit:
>>> +        jobs = vm.qmp('query-block-jobs')['return']
>>> +        if jobs and jobs[0]['offset'] > 0:
>>> +            break
>>> +        time.sleep(wait_step)
>>> +        t += wait_step
>>>
>>> -assert ok
>>> -
>>> -vm = iotests.VM().add_drive(disk_a)
>>> -vm.launch()
>>> -vm.hmp_qemu_io('drive0', 'write 0 {}'.format(size))
>>> -
>>> -vm.qmp_log('blockdev-add', filters=[iotests.filter_qmp_testfiles],
>>> -           **{'node_name': 'backup0',
>>> -              'driver': 'raw',
>>> -              'file': {'driver': 'nbd',
>>> -                       'server': {'type': 'unix', 'path': nbd_sock},
>>> -                       'reconnect-delay': 10}})
>>> -vm.qmp_log('blockdev-backup', device='drive0', sync='full', target='backup0',
>>> -           speed=(1 * 1024 * 1024))
>>> -
>>> -# Wait for some progress
>>> -t = 0
>>> -while t < wait_limit:
>>> -    jobs = vm.qmp('query-block-jobs')['return']
>>>        if jobs and jobs[0]['offset'] > 0:
>>> -        break
>>> -    time.sleep(wait_step)
>>> -    t += wait_step
>>> -
>>> -if jobs and jobs[0]['offset'] > 0:
>>> -    log('Backup job is started')
>>> -
>>> -log('Kill NBD server')
>>> -srv.kill()
>>> -srv.wait()
>>> +        log('Backup job is started')
>>>
>>>    jobs = vm.qmp('query-block-jobs')['return']
>>>    if jobs and jobs[0]['offset'] < jobs[0]['len']:
>>> @@ -88,12 +72,8 @@ vm.qmp_log('block-job-set-speed', device='drive0', speed=0)
>>>    # Emulate server down time for 1 second
>>>    time.sleep(1)
>>>
>>> -log('Start NBD server')
>>> -srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
>>> -
>>> -e = vm.event_wait('BLOCK_JOB_COMPLETED')
>>> -log('Backup completed: {}'.format(e['data']['offset']))
>>> -
>>> -vm.qmp_log('blockdev-del', node_name='backup0')
>>> -srv.kill()
>>> -vm.shutdown()
>>> +with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
>>> +    e = vm.event_wait('BLOCK_JOB_COMPLETED')
>>> +    log('Backup completed: {}'.format(e['data']['offset']))
>>> +    vm.qmp_log('blockdev-del', node_name='backup0')
>>> +    vm.shutdown()
>>> diff --git a/tests/qemu-iotests/264.out b/tests/qemu-iotests/264.out
>>> index 3000944b09..c45b1e81ef 100644
>>> --- a/tests/qemu-iotests/264.out
>>> +++ b/tests/qemu-iotests/264.out
>>> @@ -1,3 +1,4 @@
>>> +Start NBD server
>>>    {"execute": "blockdev-add", "arguments": {"driver": "raw", "file": {"driver": "nbd", "reconnect-delay": 10, "server": {"path": "TEST_DIR/PID-nbd-sock", "type": "unix"}}, "node-name": "backup0"}}
>>>    {"return": {}}
>>>    {"execute": "blockdev-backup", "arguments": {"device": "drive0", "speed": 1048576, "sync": "full", "target": "backup0"}}
>>> @@ -11,3 +12,4 @@ Start NBD server
>>>    Backup completed: 5242880
>>>    {"execute": "blockdev-del", "arguments": {"node-name": "backup0"}}
>>>    {"return": {}}
>>> +Kill NBD server
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>>> index 3590ed78a0..8f79668435 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -28,10 +28,13 @@ import signal
>>>    import struct
>>>    import subprocess
>>>    import sys
>>> +import time
>>>    from typing import (Any, Callable, Dict, Iterable,
>>>                        List, Optional, Sequence, Tuple, TypeVar)
>>>    import unittest
>>>
>>> +from contextlib import contextmanager
>>> +
>>>    # pylint: disable=import-error, wrong-import-position
>>>    sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
>>>    from qemu import qtest
>>> @@ -270,9 +273,30 @@ def qemu_nbd_early_pipe(*args):
>>>
>>>        return subp.returncode, output if subp.returncode else ''
>>>
>>> +@contextmanager
>>>    def qemu_nbd_popen(*args):
>>> -    '''Run qemu-nbd in daemon mode and return the parent's exit code'''
>>> -    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + list(args))
>>> +    '''Context manager running qemu-nbd within the context'''
>>
>> PEP8 (or some another PEP referenced in PEP8) asks to use """ for doc-strings
> 
> Both are valid, but I agree that """ is nicer.

PEP 8:

     For triple-quoted strings, always use double quote characters to be consistent with the docstring convention in PEP 257

PEP 257:

     For consistency, always use """triple double quotes""" around docstrings

> 
> This module needs more work:
> 
> $ flake8 --statistics --quiet tests/qemu-iotests/iotests.py
> tests/qemu-iotests/iotests.py
> 1     E261 at least two spaces before inline comment
> 3     E301 expected 1 blank line, found 0
> 64    E302 expected 2 blank lines, found 1
> 1     E303 too many blank lines (2)
> 5     E305 expected 2 blank lines after class or function definition, found 1
> 2     E402 module level import not at top of file
> 
>>> +    pid_file = file_path("pid")
>>> +
>>> +    cmd = list(qemu_nbd_args)
>>> +    cmd.extend(('--persistent', '--pid-file', pid_file))
>>> +    cmd.extend(args)
>>> +
>>> +    log('Start NBD server')
>>> +    p = subprocess.Popen(cmd)
>>> +    try:
>>> +        while not os.path.exists(pid_file):
>>> +            if p.poll() is not None:
>>> +                raise RuntimeError(
>>> +                    "qemu-nbd terminated with exit code {}: {}"
>>> +                    .format(p.returncode, ' '.join(cmd)))
>>> +
>>> +            time.sleep(0.01)
>>> +        yield
>>> +    finally:
>>> +        log('Kill NBD server')
>>> +        p.kill()
>>> +        p.wait()
>>
>> why do we need try-finally? I think, the only possible exception is your "raise RuntimeError", and in this case the process is alredy dead, no need to kill it (and print the log message)
> 
> The try-finally is needed for errors in user code like:
> 
>      with qemu_nbd_popen():
>           assert 0
> 

Ahh, so this "finally" will work, on some exception during yield? OK then.

> Without try-finally qemu-nbd will continue to run after the assert
> fails, which may
> cause trouble, depending on the test.
> 
> In the case of the RuntimeError inside the try, the cleanup in finally is
> not needed but harmless.
> 
> Looking in python source:
> 
>          def send_signal(self, sig):
>              """Send a signal to the process."""
>              # Skip signalling a process that we know has already died.
>              if self.returncode is None:
>                  os.kill(self.pid, sig)
> 
>          def kill(self):
>              """Kill the process with SIGKILL
>              """
>              self.send_signal(signal.SIGKILL)
> 
> So the kill() will do nothing, and wait() will return immediately.
> 
>>>    def compare_images(img1, img2, fmt1=imgfmt, fmt2=imgfmt):
>>>        '''Return True if two image files are identical'''
>>>
>>
>> anyway:
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> --
>> Best regards,
>> Vladimir
>>
> 


-- 
Best regards,
Vladimir

