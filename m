Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A6C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 13:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66FF924691
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 13:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5FltFhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FF924691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7fL6-0006Gk-IK
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 08:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7fJq-00054Y-0I
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 08:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7fJo-0008VC-Hp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 08:04:41 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:39372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j7fJo-0008UL-Co; Fri, 28 Feb 2020 08:04:40 -0500
Received: by mail-oi1-x22f.google.com with SMTP id r16so2749259oie.6;
 Fri, 28 Feb 2020 05:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pCmx0Y/lFE0DIa+ObVuJO1MRhFyxlv93fmi4ROz+eqs=;
 b=g5FltFhPKk6bprTPiwdlhmYyB8DK8Cwb33EbjDqhIhvIaXBvi3/k6SWlZAcTY+Jp3u
 pRDZUITXBmsMVanmo6KbK7JOwkpNrI3LqFOcjo7qqojnpFKXv9mOjT+18Nw3AL1ztgKI
 6xeYUgDTkoDtUrDtbViIHgbvT+uWwKhgjZQUmmuvhFt4J2yf/npFL/4lkv0AETdPkAIc
 goq/K4qGsBqm3kPsNTHfbKg58WCwXumOTR5dZwV7n+rVPvtdMiUGRGvHBKTy52T9V3Rg
 BFfpJJlv1OvdLL3Cuq/2Dy5mjaZpCw0l9UQHRZs7yaI9mIuuVJS33lBXNV2xTe3kYB4A
 LrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pCmx0Y/lFE0DIa+ObVuJO1MRhFyxlv93fmi4ROz+eqs=;
 b=iNmOI6QvctZMwXnzbbteiCGJ9ABU5eVEDMCrS3ycSFg4vpnsCc5O6VRniDhiI2Jqx8
 vCqK5U10AFTNMb/m3uuQKxd++2MxIqhre+JQQQw6f48sXg35DVFEUsORwlHDShcbr7rg
 VI7nnWm8UpazVkv2f8/Bq110ORje85DNXJl8SnNkefjCeSaqzFpGuxmUKzQ1AOYhdMZU
 uLncPBtkbg3CteF3/XR5I66OJS9NXH+HrR5H+jBSouSPkuly4aRDdS0nwOQqUqgc5PEu
 3CF9S/YLNBhzxR4x6J8sBh1y7fSssihVYqKVDo5iGXcpvDGFBW01w38FDaFChZPDZG0I
 KAxA==
X-Gm-Message-State: APjAAAUYG+ddB5QfRK968OhQwR5Sp19WcRLYKsS3iU8ZPJjrLLQ4f+Yj
 mizjhzJtellSh6snwN7SXQqj7diWNG9vBxrVGDU=
X-Google-Smtp-Source: APXvYqxEtJ8fqcA4NAvqHMmPZpAVp0UjdnOFaAHfVppoTfQg0TjoXwYDVb5Pd8LCqnLK7KG/k2Lj9GBjLt034Xgnbuo=
X-Received: by 2002:aca:c5ca:: with SMTP id v193mr55409oif.62.1582895077755;
 Fri, 28 Feb 2020 05:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20200228071914.11746-1-vsementsov@virtuozzo.com>
 <20200228071914.11746-3-vsementsov@virtuozzo.com>
In-Reply-To: <20200228071914.11746-3-vsementsov@virtuozzo.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 28 Feb 2020 14:04:26 +0100
Message-ID: <CAL1e-=hdM5XWUU5SMCs9L4t3mM6ybBbgEnRUadq2YgLZn_027w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] scripts/simplebench: add qemu/bench_block_job.py
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "open list:bochs" <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 28, 2020 at 8:19 AM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> Add block-job benchmarking helper functions.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  scripts/simplebench/bench_block_job.py | 119 +++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100755 scripts/simplebench/bench_block_job.py
>
> diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/bench_block_job.py
> new file mode 100755
> index 0000000000..9808d696cf
> --- /dev/null
> +++ b/scripts/simplebench/bench_block_job.py
> @@ -0,0 +1,119 @@
> +#!/usr/bin/env python
> +#
> +# Benchmark block jobs
> +#
> +# Copyright (c) 2019 Virtuozzo International GmbH.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +
> +import sys
> +import os
> +import socket
> +import json
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
> +from qemu.machine import QEMUMachine
> +from qemu.qmp import QMPConnectError
> +
> +
> +def bench_block_job(cmd, cmd_args, qemu_args):
> +    """Benchmark block-job
> +
> +    cmd       -- qmp command to run block-job (like blockdev-backup)
> +    cmd_args  -- dict of qmp command arguments
> +    qemu_args -- list of Qemu command line arguments, including path to Qemu
> +                 binary
> +
> +    Returns {'seconds': int} on success and {'error': str} on failure, dict may
> +    contain addional 'vm-log' field. Return value is compatible with
> +    simplebench lib.
> +    """
> +
> +    vm = QEMUMachine(qemu_args[0], args=qemu_args[1:])
> +
> +    try:
> +        vm.launch()
> +    except OSError as e:
> +        return {'error': 'popen failed: ' + str(e)}
> +    except (QMPConnectError, socket.timeout):
> +        return {'error': 'qemu failed: ' + str(vm.get_log())}
> +
> +    try:
> +        res = vm.qmp(cmd, **cmd_args)
> +        if res != {'return': {}}:
> +            vm.shutdown()
> +            return {'error': '"{}" command failed: {}'.format(cmd, str(res))}
> +
> +        e = vm.event_wait('JOB_STATUS_CHANGE')
> +        assert e['data']['status'] == 'created'
> +        start_ms = e['timestamp']['seconds'] * 1000000 + \
> +            e['timestamp']['microseconds']
> +
> +        e = vm.events_wait((('BLOCK_JOB_READY', None),
> +                            ('BLOCK_JOB_COMPLETED', None),
> +                            ('BLOCK_JOB_FAILED', None)), timeout=True)
> +        if e['event'] not in ('BLOCK_JOB_READY', 'BLOCK_JOB_COMPLETED'):
> +            vm.shutdown()
> +            return {'error': 'block-job failed: ' + str(e),
> +                    'vm-log': vm.get_log()}
> +        end_ms = e['timestamp']['seconds'] * 1000000 + \
> +            e['timestamp']['microseconds']
> +    finally:
> +        vm.shutdown()
> +
> +    return {'seconds': (end_ms - start_ms) / 1000000.0}
> +
> +
> +# Bench backup or mirror
> +def bench_block_copy(qemu_binary, cmd, source, target):
> +    """Helper to run bench_block_job() for mirror or backup"""
> +    assert cmd in ('blockdev-backup', 'blockdev-mirror')
> +
> +    source['node-name'] = 'source'
> +    target['node-name'] = 'target'
> +
> +    return bench_block_job(cmd,
> +                           {'job-id': 'job0', 'device': 'source',
> +                            'target': 'target', 'sync': 'full'},
> +                           [qemu_binary,
> +                            '-blockdev', json.dumps(source),
> +                            '-blockdev', json.dumps(target)])
> +
> +
> +def drv_file(filename):
> +    return {'driver': 'file', 'filename': filename,
> +            'cache': {'direct': True}, 'aio': 'native'}
> +
> +
> +def drv_nbd(host, port):
> +    return {'driver': 'nbd',
> +            'server': {'type': 'inet', 'host': host, 'port': port}}
> +
> +
> +if __name__ == '__main__':
> +    import sys
> +
> +    if len(sys.argv) < 4:
> +        print('USAGE: {} <qmp block-job command name> '
> +              '<json string of arguments for the command> '
> +              '<qemu binary path and arguments>'.format(sys.argv[0]))
> +        exit(1)
> +
> +    res = bench_block_job(sys.argv[1], json.loads(sys.argv[2]), sys.argv[3:])
> +    if 'seconds' in res:
> +        print('{:.2f}'.format(res['seconds']))
> +    else:
> +        print(res)
> --
> 2.21.0
>
>

