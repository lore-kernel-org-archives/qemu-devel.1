Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B70C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05CE520739
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwmbjaT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CE520739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZcJ-0007Nf-OG
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZaG-0006VV-TV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:43:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZaF-0008Pf-Ag
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:43:40 -0400
Received: by mail-wr1-x429.google.com with SMTP id t10so1245092wrv.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 03:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TpotcGrISQdj83vmRJwr5BHVpkaT6sdjjN6u4XZxfNA=;
 b=OwmbjaT94Udtk2PBhwOh7jtGIFF1bFsOWn+B76U795yPB4xkQNv4vpAJL8fQyE68eQ
 sps0COD5YnN9rx/CkeoSjL1JVPBUjYkKbBBF3bsObthJ5u1D1L0ooPLGgrA+lYmEK+fg
 4iJdlc/IiZTmhBBIuSK+KrRdX4wyOgrrHmcf7lxxxanhr6gB9Xl6DbLy6eoZWELlgCei
 sFRcGSup2I9v07iW4iYK+686hhLwHwRWUMNvV5RYpN1tdIqyy7yvGZX3b4m2ZZnvyUP7
 ksijSPpJjfCh0orlpDLRAFqm0lTtm5QAhX0AT5aO/FyzAFx5DwDNhoYJzO4BRZCmG1Fv
 51Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TpotcGrISQdj83vmRJwr5BHVpkaT6sdjjN6u4XZxfNA=;
 b=RJiO9vceEB0gCB8uvU7EAq5uyRtnUjaShGxJRgR7gdobudzIxSqDs7N2N2a6JTQPmR
 P3KNN72yxF9lfKjmj2uMGTktMHv4DwersakD7RIQQjmMue9Y4HLfOjEPpRYgHSp955o8
 h4hscunUQWIjEFMooNpeJR94zvSiXML8DqUCJg9M8iwP5j4NF04reF9u8MxDw+VVwt/k
 gMUFjGLKKD/fGfYIXi5K5o/8LXj7BDqsHSg6siRjssmob5QxzRLO8tl4Klswy+214gGK
 +ar7Q59Krfx0uR/UbSNIduNCJt8LBLuzRDVqLAMQAEBXOjeAhIuTif8npvnutuZLXBIr
 /Lpw==
X-Gm-Message-State: AOAM532L9Wc790tIWxNfv7ThoUTajLK0+0ZUOK4Tlh9XJ/yWpEJh3iKT
 WzKrsuhtCzqsno3U8etkOMs=
X-Google-Smtp-Source: ABdhPJxwzFcoBwz47grhgS7Oq1LMIBWb3QGfWa0LHPmJd1uSlJpyYkCF3LbZflbXgLjwMXocyJ2/Vw==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr2605988wrt.166.1601462617716; 
 Wed, 30 Sep 2020 03:43:37 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id k8sm2135741wrl.42.2020.09.30.03.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:43:37 -0700 (PDT)
Subject: Re: use of 'apt' in scripting in our dockerfiles provokes warnings
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-wMzZhO-9EdYhPC3aoPatQ-JEtBJ2nSjGepRbLs-5AdA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
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
Message-ID: <e0a62d48-62dd-992d-6ca4-25587217966c@amsat.org>
Date: Wed, 30 Sep 2020 12:43:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wMzZhO-9EdYhPC3aoPatQ-JEtBJ2nSjGepRbLs-5AdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 12:33 PM, Peter Maydell wrote:
> While processing a recent pullreq which updated the dockerfile
> dependencies and thus provoked a rebuild, I noticed that we
> use the 'apt' command in ways that provoke a warning:
> 
> #7 0.789 WARNING: apt does not have a stable CLI interface. Use with
> caution in scripts.
> 
> The apt(8) manpage says:
> 
> SCRIPT USAGE AND DIFFERENCES FROM OTHER APT TOOLS
>        The apt(8) commandline is designed as an end-user tool and it may
>        change behavior between versions. While it tries not to break backward
>        compatibility this is not guaranteed either if a change seems
>        beneficial for interactive use.
> 
>        All features of apt(8) are available in dedicated APT tools like apt-
>        get(8) and apt-cache(8) as well.  apt(8) just changes the default value
>        of some options (see apt.conf(5) and specifically the Binary scope). So
>        you should prefer using these commands (potentially with some
>        additional options enabled) in your scripts as they keep backward
>        compatibility as much as possible.
> 
> That suggests that we should probably be using apt-get instead
> of apt in our dockerfiles...

I concur.

> 
> Also, any idea what this error is about?
> 
> #4 importing cache manifest from registry.gitlab.com/qemu-project/qemu/qemu...
> #4       digest:
> sha256:815fb44b573ac7520d148d9b2510c00f31846ca6fa55127d322bc8db3c5d0ec0
> #4         name: "importing cache manifest from
> registry.gitlab.com/qemu-project/qemu/qemu/debian-alpha-cross:latest"
> #4      started: 2020-09-29 22:57:54.371490684 +0000 UTC
> #4    completed: 2020-09-29 22:57:55.064468936 +0000 UTC
> #4     duration: 692.978252ms
> #4        error: "invalid build cache from
> {MediaType:application/vnd.docker.distribution.manifest.v2+json
> Digest:sha256:a1e8a5830bb19b7cddda64872c5d71a0337d4b98bed30fd7684d20467adcd289
> Size:1161 URLs:[] Annotations:map[] Platform:<nil>}"
> 
> It didn't seemt to have an adverse effect...

It seems to come from '--cache-from' from commit e6f1306b10,
there is some DOCKER_BUILDKIT black magic involved.

What is your 'docker version' output please?

> 
> thanks
> -- PMM
> 


