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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DE7C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 13:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C08222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 13:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5l27iq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C08222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7fJh-0004s8-Jx
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 08:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7fIX-0004Kk-HK
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 08:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7fIV-0007Jj-UZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 08:03:21 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j7fIV-0007J7-OL; Fri, 28 Feb 2020 08:03:19 -0500
Received: by mail-ot1-x341.google.com with SMTP id w6so2498764otk.0;
 Fri, 28 Feb 2020 05:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1FWRmBPPeMuBUT+tde+BZzckIXQsIqTKBMXeF30keGQ=;
 b=G5l27iq8cuYygbZABzrEoOty8k8ObZeeWnH7c3b8+0JwaLWUIyXGlYPN1VlYMtAA0i
 7ld6ali7fiYE7mxYGklBQI7jE9xV5Zgp+IJxYeK35UKpesPYJPF6vJeBGrx2OZ7y3XeP
 KbtlPI8YCDg2522ApPF3C66OJoWXErJTl6LAmp3uaNtsdfPRsYPlqdi3Sipe2v9eqXvy
 Z3/WEG5EX3ehSKG4g2DVdq5VzrcxdZr4l0PNNtssB3dirdOe71cZUIEzV24qRvSIcPUM
 f6YA8AS44x1H1ulsaw2ta2y3SR3SRWGtqOTFxu/R99YDErDJxdpV6n/Gv/KdsJDjNb8i
 qwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1FWRmBPPeMuBUT+tde+BZzckIXQsIqTKBMXeF30keGQ=;
 b=q03vgVC7GAMAWNoDIgJ3GJuIRlLAe8aI6bQ3aROt/ljLVaiqTLDcBBts30Yl/uQObO
 ZCKoDPUrXdPzlKtczX8Jmy0/TjS7QhYiK4IRzdfKydykWRg17m9vM/rFIN6MuhFDTDpO
 WeJhZ0Pa+n/UcXwDw+c4f+BfPXSR/dAlyFtd5EWmBY63KwFine4imnJqI/5zX9+841bL
 57I96K1va2SHrGezf7zL4NaW0K/zERsQYWZhLKE7XislbrZs+H03brElb6F4CEcEQM6K
 dNuTjOFJgfG9tqIC5JMjPUOiTxZVPDLkGFFtWAlAIv3Meb0CTuViOT1h7SL6idD/z+gr
 1Djw==
X-Gm-Message-State: APjAAAXone/RHMaTRUnO/WA6tfsuba6ueQwwZFtIWYXC81qwFIbDA/R4
 6rsph8SFnV+GDt2nRK4deUZWNQBTHF+F1CLCdzk=
X-Google-Smtp-Source: APXvYqz1cYUN6h4V5iBIeRYCQ5jkzQYgJGY8q4qPmE8egwR3WTBWvoncCzp4DANLEFkfRRgxgbix+11l2fSuN8wbc08=
X-Received: by 2002:a9d:2184:: with SMTP id s4mr3007242otb.121.1582894998757; 
 Fri, 28 Feb 2020 05:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20200228071914.11746-1-vsementsov@virtuozzo.com>
 <20200228071914.11746-2-vsementsov@virtuozzo.com>
In-Reply-To: <20200228071914.11746-2-vsementsov@virtuozzo.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 28 Feb 2020 14:03:08 +0100
Message-ID: <CAL1e-=hX=7OJP-Rpc5TtVQkftq_F3wrh-auYt7yjAe+2i3whHQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] scripts/simplebench: add simplebench.py
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
> Add simple benchmark table creator.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/simplebench/simplebench.py | 128 +++++++++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 scripts/simplebench/simplebench.py
>
> diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simplebench.py
> new file mode 100644
> index 0000000000..59e7314ff6
> --- /dev/null
> +++ b/scripts/simplebench/simplebench.py
> @@ -0,0 +1,128 @@
> +#!/usr/bin/env python
> +#
> +# Simple benchmarking framework
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
> +def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
> +    """Benchmark one test-case
> +
> +    test_func   -- benchmarking function with prototype
> +                   test_func(env, case), which takes test_env and test_case
> +                   arguments and returns {'seconds': int} (which is benchmark
> +                   result) on success and {'error': str} on error. Returned
> +                   dict may contain any other additional fields.
> +    test_env    -- test environment - opaque first argument for test_func
> +    test_case   -- test case - opaque second argument for test_func
> +    count       -- how many times to call test_func, to calculate average
> +    initial_run -- do initial run of test_func, which don't get into result
> +
> +    Returns dict with the following fields:
> +        'runs':     list of test_func results
> +        'average':  average seconds per run (exists only if at least one run
> +                    succeeded)
> +        'delta':    maximum delta between test_func result and the average
> +                    (exists only if at least one run succeeded)
> +        'n-failed': number of failed runs (exists only if at least one run
> +                    failed)
> +    """
> +    if initial_run:
> +        print('  #initial run:')
> +        print('   ', test_func(test_env, test_case))
> +
> +    runs = []
> +    for i in range(count):
> +        print('  #run {}'.format(i+1))
> +        res = test_func(test_env, test_case)
> +        print('   ', res)
> +        runs.append(res)
> +
> +    result = {'runs': runs}
> +
> +    successed = [r for r in runs if ('seconds' in r)]
> +    if successed:
> +        avg = sum(r['seconds'] for r in successed) / len(successed)
> +        result['average'] = avg
> +        result['delta'] = max(abs(r['seconds'] - avg) for r in successed)
> +
> +    if len(successed) < count:
> +        result['n-failed'] = count - len(successed)
> +
> +    return result
> +
> +
> +def ascii_one(result):
> +    """Return ASCII representation of bench_one() returned dict."""
> +    if 'average' in result:
> +        s = '{:.2f} +- {:.2f}'.format(result['average'], result['delta'])
> +        if 'n-failed' in result:
> +            s += '\n({} failed)'.format(result['n-failed'])
> +        return s
> +    else:
> +        return 'FAILED'

I think it would be visually clearer if "+-" was printed without any
space between it and the following number, using something
like this:

s = ' {:.2f} +-{:.2f}'.format(result['average'], result['delta'])

The resulting table would look like:

----------  -------------  -------------  -------------
            backup-1       backup-2       mirror
ssd -> ssd   0.43 +-0.00    4.48 +-0.06    4.38 +-0.02
ssd -> hdd   10.60 +-0.08   10.69 +-0.18   10.57 +-0.05
ssd -> nbd   33.81 +-0.37   10.67 +-0.17   10.07 +-0.07
----------  -------------  -------------  -------------

But, this is just cosmetics.

With or without the suggestion above:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> +
> +
> +def bench(test_func, test_envs, test_cases, *args, **vargs):
> +    """Fill benchmark table
> +
> +    test_func -- benchmarking function, see bench_one for description
> +    test_envs -- list of test environments, see bench_one
> +    test_cases -- list of test cases, see bench_one
> +    args, vargs -- additional arguments for bench_one
> +
> +    Returns dict with the following fields:
> +        'envs':  test_envs
> +        'cases': test_cases
> +        'tab':   filled 2D array, where cell [i][j] is bench_one result for
> +                 test_cases[i] for test_envs[j] (i.e., rows are test cases and
> +                 columns are test environments)
> +    """
> +    tab = {}
> +    results = {
> +        'envs': test_envs,
> +        'cases': test_cases,
> +        'tab': tab
> +    }
> +    n = 1
> +    n_tests = len(test_envs) * len(test_cases)
> +    for env in test_envs:
> +        for case in test_cases:
> +            print('Testing {}/{}: {} :: {}'.format(n, n_tests,
> +                                                   env['id'], case['id']))
> +            if case['id'] not in tab:
> +                tab[case['id']] = {}
> +            tab[case['id']][env['id']] = bench_one(test_func, env, case,
> +                                                   *args, **vargs)
> +            n += 1
> +
> +    print('Done')
> +    return results
> +
> +
> +def ascii(results):
> +    """Return ASCII representation of bench() returned dict."""
> +    from tabulate import tabulate
> +
> +    tab = [[""] + [c['id'] for c in results['envs']]]
> +    for case in results['cases']:
> +        row = [case['id']]
> +        for env in results['envs']:
> +            row.append(ascii_one(results['tab'][case['id']][env['id']]))
> +        tab.append(row)
> +
> +    return tabulate(tab)
> --
> 2.21.0
>
>

