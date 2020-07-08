Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97BCC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3452206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJ3i6faQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3452206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIKJ-0002Iw-S9
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtHnX-0001Rg-BJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:40:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32759
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtHnV-0003Zt-Hr
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9kGGEuQBHeCaZhb52kxT7dh/zr77kzK8O2fi7hvNvBY=;
 b=dJ3i6faQozY3Kw9lg+CgHvLIh65mR5A9tCf7uEi6CopbJLJhQN1Y6PeLB77dvmNPp4qVJr
 iikMEXv2tnuVAHRWbvzQaZ710x1K+B/0BIMeKX+0cFIqa9lBqE6L2E7UCHrRUuBUhjp7eL
 nBoLp83bEumFoHdQoff1N40lrA0Olfk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-CaZCHI3IOJi4FZUzTXMF6Q-1; Wed, 08 Jul 2020 15:39:30 -0400
X-MC-Unique: CaZCHI3IOJi4FZUzTXMF6Q-1
Received: by mail-ej1-f72.google.com with SMTP id l18so36720189ejn.17
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 12:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=9kGGEuQBHeCaZhb52kxT7dh/zr77kzK8O2fi7hvNvBY=;
 b=ctuAMeBlBY9GTJudBtozT4wZDO5QZ0iaMzAmI4AcVQvvp7fSZmQ06ecFJxFTUlvIYs
 JO61qF1WZlaz0P1D5tMuYYZdtNhF+cXaOjPrJOYooO9UdaUdvHVssdpt5BLK+6tCtUWe
 JdI5h4AGxhElo5P51B0vB6xmcwpbj+Ft4hvkWgnjMmNYZJPWR4lvVTKAy6EdUcTrwVA1
 /Agt3ORrTNDzMMNSjRkUPdriD4tYlYO/3FsuXLo3Lu7Ffs9R5IwAIuHYRFwPoZYC7Eel
 b65GyObqKE4wsaF/s9wUY8859H3SVGHw4dZdJcNlOsfBIG7vBVYDAvrqaVvWdvSnwsTy
 Ukpg==
X-Gm-Message-State: AOAM530+5ffTFOLxShmBw3BVnOWmK5AQVdkGw40R+baeJeFfi61nMR43
 Fa2PEZzDA6Znl+1wwDNL5vfxfDgCdceikgnFzP4fvU2Iaa36D7BiJStRIiHLQlM4XDVNQc4kHQ6
 GlxRdQQDD5m/tASU=
X-Received: by 2002:a05:6402:3138:: with SMTP id
 dd24mr70042138edb.118.1594237168026; 
 Wed, 08 Jul 2020 12:39:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqAMj47ZQIMKXdIecFqaYniux9Rqt/Ye2twhX6Yvic9wpv4KUAMOZPEWgL80/GG7kaXdL2NQ==
X-Received: by 2002:a05:6402:3138:: with SMTP id
 dd24mr70042111edb.118.1594237167769; 
 Wed, 08 Jul 2020 12:39:27 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 23sm340063edx.75.2020.07.08.12.39.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 12:39:27 -0700 (PDT)
Subject: Re: build error of unused function as MACRO
 G_DEFINE_AUTOPTR_CLEANUP_FUNC expand
To: Alexander Bulekov <alxndr@bu.edu>
References: <5F05E942.FB9110.20278@mail-m971.mail.163.com>
 <b02161d0-a027-5018-af05-8ccbc5c90cc9@redhat.com>
 <20200708192339.ex4ygaebjekxk2qc@mozz.bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <cc2d0e7a-a708-fdbc-fe0e-d2656db3bfe0@redhat.com>
Date: Wed, 8 Jul 2020 21:39:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200708192339.ex4ygaebjekxk2qc@mozz.bu.edu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@163.com>, "liq3ea@gmail.com" <liq3ea@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 9:23 PM, Alexander Bulekov wrote:
> Hi Li,
> I usually build the fuzzer with "make i386-softmmu/fuzz", so I must have
> missed the nbd issue... I could not reproduce this locally since:
> 
> alxndr@mozz:qemu(master)$ dpkg -l "*glib2.0-bin*"
> Desired=Unknown/Install/Remove/Purge/Hold
> | Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
> |/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
> ||/ Name           Version      Architecture Description
> +++-==============-============-============-=================================
> ii  libglib2.0-bin 2.60.6-2     amd64        Programs for the GLib library
> 
>  The issue described in 9bda600b083 only shows up in versions older than
>  2.57.2... 
> 
> After some digging, in ./configure:
> ...
>   if test "$have_fuzzer" = "yes"; then
>     FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
>     FUZZ_CFLAGS=" -fsanitize=address,fuzzer"
>     CFLAGS=" -fsanitize=address,fuzzer-no-link"
> 
> Thats probably the issue. Should be
>     CFLAGS="$CFLAGS -fsanitize=address,fuzzer-no-link"

Oops, 3 reviewers missed that...

> 
> I'm also having trouble building, but for a different reason..
> 
> CC=clang-8 CXX=clang++-8  ./configure  --target-list="i386-softmmu" --enable-fuzzing
> ...
>   CC      i386-softmmu/tests/qtest/fuzz/qtest_wrappers.o
> /tmp/qemu/tests/qtest/fuzz/fuzz.c:215:5: error: implicit declaration of function 'rcu_enable_atfork' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>     rcu_enable_atfork();
>     ^
> 45222b9a9016488289a1938a528239c3b83eddb1 is the first bad commit
> commit 45222b9a9016488289a1938a528239c3b83eddb1
> Author: Alexander Bulekov <alxndr@bu.edu>
> Date:   Thu Jun 18 12:05:16 2020 -0400
> 
>     fuzz: fix broken qtest check at rcu_disable_atfork
> 
> Looks like I forgot a header... I'll send fixes for both of these
> issues.
> 
> Thank you
> -Alex


