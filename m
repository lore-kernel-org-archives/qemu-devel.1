Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99359C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626B620735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4A2KVYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626B620735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDPo-0008EB-ID
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jEDOW-0006x5-7w
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jEDOU-0004ZB-NN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:40:36 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jEDOU-0004Py-Fe; Tue, 17 Mar 2020 10:40:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id k26so21918642otr.2;
 Tue, 17 Mar 2020 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IXo+53GAmIKD6wXgvb7WvhNswm2qw2hdjO0GagCEkbw=;
 b=q4A2KVYDGqwcfmuS5mj2I+GbyDveBJVJ7F6Ba1VjYF+YnSGtE5e0i7nPy/7YlcnWFh
 Q2T8YjRG+VOwO2FmxYSUnjTX1Fjg1Ky56QgwBJnJu3TM9UD0GM0XoP1XRbSjwiG+YXJF
 TjfnsaVN6OIlksMhVyCodEyvBEcPor+9Db6jR3zHhuoNbMkpvij8nZdfrmY5F5yzQy6T
 xL5B/LUy++dGnaStgRfeTGopM5Rhj8l0xiJDkyWyJo9QKlXvsDKoV2e5uTyxDNjP5QQn
 RE9ZboqXjWxQqlFNIBdGNGfSUULIQKMPFRL41q3+XMPBvyi9A/Y6LpnWFYR5XXOg19MB
 5Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IXo+53GAmIKD6wXgvb7WvhNswm2qw2hdjO0GagCEkbw=;
 b=YLt7m9zTLhm7HeHe67X7y4zm/NEXqWOGebgyYGzMK5lZWot4X4Ky+7nIQ3Cze7aRoM
 0ldrgP0wDGzwtJT6cQCzcfdq2V1tb7vbS+e+bK1Y+jUU21FYrpIw0cbX3Sf7Ql6HnYMg
 o9+/0Xc4oxuCijNulZGJdiODpKYdZzj0zTPJj22mSC8ubr9Z9zLQD+RrL7u5DWRBdwx+
 sQTAkVm22WAgUCNSElG64SmfPI8yEh0U6fORAiopBZrlmzQrrtzjiFmRdoJng7LZmyFl
 s86/W9NdztU4rov8rhNLtGfv9q3cE9YbUaWAU0svSNsq2kVBh/yZGGiNp+odrfO9ZfSS
 vaBA==
X-Gm-Message-State: ANhLgQ2AuDvw8dJ7mRp6bJURtHYlM+4s9SrqRd6FKldrBNYlVW/JUV1F
 8SYYKXRDd3KhEgo1/qwJDxeGc0n76Ai2VCkoI28=
X-Google-Smtp-Source: ADFU+vvihKMdA5HKbpCsPGXDU39kcTFis3ijVuXQrqQPxlNTZIgCmdX6vOJ7XNaep1IZ2Wme8dgpaMZsaOJDpsNMzsE=
X-Received: by 2002:a9d:7a47:: with SMTP id z7mr4128533otm.341.1584456033478; 
 Tue, 17 Mar 2020 07:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200228071914.11746-1-vsementsov@virtuozzo.com>
 <20200228071914.11746-2-vsementsov@virtuozzo.com>
 <CAL1e-=hX=7OJP-Rpc5TtVQkftq_F3wrh-auYt7yjAe+2i3whHQ@mail.gmail.com>
 <75b4d5ad-f95f-dab2-1b53-5e654c29015e@virtuozzo.com>
 <CAL1e-=gkw9_UJ-0zYx_qUYfRpGmpi-otXf2VnR=5SYDhm=RCGw@mail.gmail.com>
In-Reply-To: <CAL1e-=gkw9_UJ-0zYx_qUYfRpGmpi-otXf2VnR=5SYDhm=RCGw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 17 Mar 2020 15:40:22 +0100
Message-ID: <CAL1e-=gcf5DY_mCFoQ-0pVJp7jG6w5eQimk7+W5=MTgZ9Emb-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] scripts/simplebench: add simplebench.py
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

On Mon, Mar 2, 2020 at 10:05 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
>
>
> > >> +
> > >> +
> > >> +def ascii_one(result):
> > >> +    """Return ASCII representation of bench_one() returned dict."""
> > >> +    if 'average' in result:
> > >> +        s = '{:.2f} +- {:.2f}'.format(result['average'], result['delta'])
> > >> +        if 'n-failed' in result:
> > >> +            s += '\n({} failed)'.format(result['n-failed'])
> > >> +        return s
> > >> +    else:
> > >> +        return 'FAILED'
> > >
> > > I think it would be visually clearer if "+-" was printed without any
> > > space between it and the following number, using something
> > > like this:
> > >
> > > s = ' {:.2f} +-{:.2f}'.format(result['average'], result['delta'])
> > >
> > > The resulting table would look like:
> > >
> > > ----------  -------------  -------------  -------------
> > >              backup-1       backup-2       mirror
> > > ssd -> ssd   0.43 +-0.00    4.48 +-0.06    4.38 +-0.02
> > > ssd -> hdd   10.60 +-0.08   10.69 +-0.18   10.57 +-0.05
> > > ssd -> nbd   33.81 +-0.37   10.67 +-0.17   10.07 +-0.07
> > > ----------  -------------  -------------  -------------
> > >
> > > But, this is just cosmetics.
> > >
> > > With or without the suggestion above:
> > >
> > > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Thanks for reviewing!
> >
> > Agree with this change, but I don't think it worth to resend the series for this one space)
> > Hope it may be applied with pull request..
> >
>
> I am an occasional Python programmer, and I felt comfortable
> reviewing your series, but I am not a maintainer of this directory,
> and I believe Eduardo or Cleber or other more active Python
> contributors would be better choice for selecting this series in
> their pull request.
>
> So, I can't send this series to Peter - Cleber, Eduardo, please
> see to it.
>

Eduardo, can you perhaps consider this series for selecting
into your pull request?

Thanks,
Aleksandar

> Yours,
> Aleksandar
>
> > >
> > >> +
> > >> +
> > >> +def bench(test_func, test_envs, test_cases, *args, **vargs):
> > >> +    """Fill benchmark table
> > >> +
> > >> +    test_func -- benchmarking function, see bench_one for description
> > >> +    test_envs -- list of test environments, see bench_one
> > >> +    test_cases -- list of test cases, see bench_one
> > >> +    args, vargs -- additional arguments for bench_one
> > >> +
> > >> +    Returns dict with the following fields:
> > >> +        'envs':  test_envs
> > >> +        'cases': test_cases
> > >> +        'tab':   filled 2D array, where cell [i][j] is bench_one result for
> > >> +                 test_cases[i] for test_envs[j] (i.e., rows are test cases and
> > >> +                 columns are test environments)
> > >> +    """
> > >> +    tab = {}
> > >> +    results = {
> > >> +        'envs': test_envs,
> > >> +        'cases': test_cases,
> > >> +        'tab': tab
> > >> +    }
> > >> +    n = 1
> > >> +    n_tests = len(test_envs) * len(test_cases)
> > >> +    for env in test_envs:
> > >> +        for case in test_cases:
> > >> +            print('Testing {}/{}: {} :: {}'.format(n, n_tests,
> > >> +                                                   env['id'], case['id']))
> > >> +            if case['id'] not in tab:
> > >> +                tab[case['id']] = {}
> > >> +            tab[case['id']][env['id']] = bench_one(test_func, env, case,
> > >> +                                                   *args, **vargs)
> > >> +            n += 1
> > >> +
> > >> +    print('Done')
> > >> +    return results
> > >> +
> > >> +
> > >> +def ascii(results):
> > >> +    """Return ASCII representation of bench() returned dict."""
> > >> +    from tabulate import tabulate
> > >> +
> > >> +    tab = [[""] + [c['id'] for c in results['envs']]]
> > >> +    for case in results['cases']:
> > >> +        row = [case['id']]
> > >> +        for env in results['envs']:
> > >> +            row.append(ascii_one(results['tab'][case['id']][env['id']]))
> > >> +        tab.append(row)
> > >> +
> > >> +    return tabulate(tab)
> > >> --
> > >> 2.21.0
> > >>
> > >>
> >
> >
> > --
> > Best regards,
> > Vladimir

