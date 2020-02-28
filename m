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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F92C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 13:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FEE2469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 13:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCcp02c/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FEE2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7fgg-0005rX-4Q
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 08:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7fg2-0005Pn-Oo
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 08:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7fg1-0007Ae-Hm
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 08:27:38 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38293)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j7fg1-0007AH-D9; Fri, 28 Feb 2020 08:27:37 -0500
Received: by mail-oi1-x243.google.com with SMTP id 2so2832578oiz.5;
 Fri, 28 Feb 2020 05:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B5ZgAT0BWoFMir6/xYBVKdEvUS746yRFhzNJmazshMg=;
 b=YCcp02c/mV95uI4elDhJ3XgCTOzKZlWVl+4ynloLaIgXNDKvEOBd2L8lrKRaAfZDeC
 cCnd7BNDlIFUU55hw/hZQrQz7R+XUESl2HssGJjDkz8xnr41NegxWQbLZnTSry99F6rz
 dqinpoivJ7m8gMtMr1LwtBmwEh6k5PDId4QXAuK7eXpx2og2fXZeLT2x2s2Q46B/mFit
 e0o5F460joIliglFlO4F4TCMhW31kVdhQ9a5CG0GMosVyTd55qyrFBBSs5ABqTN8eMCd
 1QfMseKgwhQCw2XVbhhWNhAZiyCIORsaQgN0sGW2KkQDjswdy8psjSOA9bDM7I3GY4QN
 e+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B5ZgAT0BWoFMir6/xYBVKdEvUS746yRFhzNJmazshMg=;
 b=ToCPvLf9Hova2tUuePWwBnvw6KaWeO74WzSzYDDlCp6mbx/YAAiE/eygAUxtwq/jyi
 kiZPo6gO6q0GHG1xMCw3BH0vMAJYl/LszWDfA6q+u9ohMTqfAoxWxEcY1EOqMO/n9pNQ
 N/KyTe3T8iSOZ7GssSWI3WoD3D8HVfKIzoCQyrGkLRyzA868I2o6w5ZbO43Jq0+/r289
 u4RYg0q4ltfyk2KeVmL9P26H8+Vjal1tFA5+YfIT1F+Rvj9IhbDhd+RgKlppG/6Cv01z
 A2D53qo9eN+4V6pWfwXZTk79WMYVBIAM6GnHapaxeovFTyfSvxbbb3TEmkh7DRan+ISm
 XmHA==
X-Gm-Message-State: APjAAAV8cglW6msWfK145KTa5opRM5wse+1As61+6yOCzqEqo00BQe+F
 +GJGYLtoKAnbfI6sXV/gGIzgNMKRNs5FrKW4XZ0=
X-Google-Smtp-Source: APXvYqwE8wiDeINhnJaN6Xml3WYoSETKFqsRDdbZU49/AheXsXXwBhceAl2pcbWrD1dZxk6iFyRKsvAzI1vFrrtZEqs=
X-Received: by 2002:aca:5844:: with SMTP id m65mr3141081oib.136.1582896456504; 
 Fri, 28 Feb 2020 05:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20200228071914.11746-1-vsementsov@virtuozzo.com>
 <20200228071914.11746-4-vsementsov@virtuozzo.com>
In-Reply-To: <20200228071914.11746-4-vsementsov@virtuozzo.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 28 Feb 2020 14:27:25 +0100
Message-ID: <CAL1e-=gduVMa0YCutd5AeD8mdnnDTK00f-q1XBWYh3tNbmcixA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] scripts/simplebench: add example usage of
 simplebench
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Fri, Feb 28, 2020 at 8:21 AM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> This example may be used as a template for custom benchmark.
> It illustrates three things to prepare:
>  - define bench_func
>  - define test environments (columns)
>  - define test cases (rows)
> And final call of simplebench API.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

In future, it would be perhaps useful to add option to output results
in the format of csv (comma separated values) (or similar) - it would
simplify import to other data presentation tools. In any case:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  scripts/simplebench/bench-example.py | 80 ++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 scripts/simplebench/bench-example.py
>
> diff --git a/scripts/simplebench/bench-example.py b/scripts/simplebench/bench-example.py
> new file mode 100644
> index 0000000000..c642a5b891
> --- /dev/null
> +++ b/scripts/simplebench/bench-example.py
> @@ -0,0 +1,80 @@
> +#!/usr/bin/env python3
> +#
> +# Benchmark example
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
> +import simplebench
> +from bench_block_job import bench_block_copy, drv_file, drv_nbd
> +
> +
> +def bench_func(env, case):
> +    """ Handle one "cell" of benchmarking table. """
> +    return bench_block_copy(env['qemu_binary'], env['cmd'],
> +                            case['source'], case['target'])
> +
> +
> +# You may set the following five variables to correct values, to turn this
> +# example to real benchmark.
> +ssd_source = '/path-to-raw-source-image-at-ssd'
> +ssd_target = '/path-to-raw-target-image-at-ssd'
> +hdd_target = '/path-to-raw-source-image-at-hdd'
> +nbd_ip = 'nbd-ip-addr'
> +nbd_port = 'nbd-port-number'
> +
> +# Test-cases are "rows" in benchmark resulting table, 'id' is a caption for
> +# the row, other fields are handled by bench_func.
> +test_cases = [
> +    {
> +        'id': 'ssd -> ssd',
> +        'source': drv_file(ssd_source),
> +        'target': drv_file(ssd_target)
> +    },
> +    {
> +        'id': 'ssd -> hdd',
> +        'source': drv_file(ssd_source),
> +        'target': drv_file(hdd_target)
> +    },
> +    {
> +        'id': 'ssd -> nbd',
> +        'source': drv_file(ssd_source),
> +        'target': drv_nbd(nbd_ip, nbd_port)
> +    },
> +]
> +
> +# Test-envs are "columns" in benchmark resulting table, 'id is a caption for
> +# the column, other fields are handled by bench_func.
> +test_envs = [
> +    {
> +        'id': 'backup-1',
> +        'cmd': 'blockdev-backup',
> +        'qemu_binary': '/path-to-qemu-binary-1'
> +    },
> +    {
> +        'id': 'backup-2',
> +        'cmd': 'blockdev-backup',
> +        'qemu_binary': '/path-to-qemu-binary-2'
> +    },
> +    {
> +        'id': 'mirror',
> +        'cmd': 'blockdev-mirror',
> +        'qemu_binary': '/path-to-qemu-binary-1'
> +    }
> +]
> +
> +result = simplebench.bench(bench_func, test_envs, test_cases, count=3)
> +print(simplebench.ascii(result))
> --
> 2.21.0
>
>

