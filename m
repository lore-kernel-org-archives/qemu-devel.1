Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAE1C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 11:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785F620707
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 11:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7a8Nnpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785F620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfMXC-0005tJ-NL
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 07:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfMWQ-0005SJ-MB
 for qemu-devel@nongnu.org; Sun, 31 May 2020 07:52:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfMWP-0008Js-7g
 for qemu-devel@nongnu.org; Sun, 31 May 2020 07:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590925975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YqJQzxlqkkuz7YybaBOHPT6RnbknrzI7aM5pUExwIbA=;
 b=U7a8NnptIrIjreQ0gqkagz4MYkW01zXZjRHIN79ZU1sVHt3MtWZ8dszNYYXNJqHctohK8Q
 vwc6J3A7xvUxAn10LmIHm/JoAx60DQHCzPvWI6a2OEJ86y+UVoujK3y9+pxpqkocmbiftP
 HM7kSWSx98DK49ae3U8YpltyL/sPyWQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-BjwpmRL3NHq6TQb7WJV-bA-1; Sun, 31 May 2020 07:52:50 -0400
X-MC-Unique: BjwpmRL3NHq6TQb7WJV-bA-1
Received: by mail-wm1-f71.google.com with SMTP id b65so1864076wmb.5
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 04:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=YqJQzxlqkkuz7YybaBOHPT6RnbknrzI7aM5pUExwIbA=;
 b=PXx13QzPArJ17vW2ANtmoMYbZQ7nVJTiNI3pawlyZGYrHFGjeJhLhzrfwyY2BhA3kP
 ofhZ1iWRFw8gNKqrHOxUxLIFJ5BEPyAvqWlgSAu8vuJiVpYnSI0ucG1c7kIRtlikwSQU
 ScgED5EoD03dMZdoInFIK86J+AkwFJYX23lrib5G9OgH/ie3Qm/PnPwtXgWQwoBMdzeW
 GLVoXpVIodyO0bmNhD1KrFz/L7TVP/tUgRFM61sjuedTlgDMxEYHjwKyN6DftGiXi9T3
 GLuePpMUWdSwetBcW16MqP69SwUl8UvRpW4bm46zFuFX2WGdVjms6mER9kRcJxDmvOX1
 rbUA==
X-Gm-Message-State: AOAM531QHLw7lAIYm3nTARGO9mndpUYbjL8F27mXcpJZKbyMiAtfUzHY
 LTLD4cM1b9c71VFDkJzxI7hyxUtOiiyNEOHDuNktzVsEzAXsDyGN488PpJDQh9XTkV+3FEuGAfZ
 bUxNqcwUW+9G3xz4=
X-Received: by 2002:a05:600c:22c1:: with SMTP id
 1mr17844666wmg.50.1590925969365; 
 Sun, 31 May 2020 04:52:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzypkmAhdBi+MXl3YO1KMoQoxLFVbq+3hay2jKgnIYs5g52hBrIYUXWtmuCAE06oH//jCrqwg==
X-Received: by 2002:a05:600c:22c1:: with SMTP id
 1mr17844658wmg.50.1590925969149; 
 Sun, 31 May 2020 04:52:49 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id b132sm7991155wmh.3.2020.05.31.04.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 04:52:48 -0700 (PDT)
Subject: Re: [PATCH v8 00/12] tests/vm: Add support for aarch64 VMs
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200529203458.1038-1-robert.foley@linaro.org>
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
Message-ID: <2d2b834c-ea10-befe-ebc1-92c95ef882ae@redhat.com>
Date: Sun, 31 May 2020 13:52:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529203458.1038-1-robert.foley@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 05:59:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 10:34 PM, Robert Foley wrote:
> This is version 8 of the patch series to
> add support for aarch64 VMs in the vm-build infrastructure.
>  - Ubuntu 18.04 aarch64 VM
>  - CentOS 8 aarch64 VM
> 
> v7: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05286.html
> 
> Changes in v8:
> - Added Ubuntu common module in tests/vm.
> - Changed ubuntu.i386 and ubuntu.aarch64 to use new common module.
> - Split out ConsoleSocket addition (python/qemu) to separate patch
>   from changes to use it in tests/vm.
> - Adjustments in configure when checking for aarch64 efi images.
> - Remove use of QEMU_LOCAL in basevm.py.  We will use the
>   presence of the --build-path argument instead.
> 
> Robert Foley (12):
>   tests/vm: pass args through to BaseVM's __init__
>   tests/vm: Add configuration to basevm.py
>   tests/vm: Added configuration file support
>   tests/vm: Pass --debug through for vm-boot-ssh.
>   tests/vm: Add ability to select QEMU from current build.
>   tests/vm: allow wait_ssh() to specify command
>   tests/vm: Add common Ubuntu python module
>   tests/vm: Added a new script for ubuntu.aarch64.
>   tests/vm: Added a new script for centos.aarch64.
>   tests/vm: change scripts to use self._config
>   python/qemu: Add ConsoleSocket for optional use in QEMUMachine
>   tests/vm: Add workaround to consume console

Thanks, patches 4/5/6 applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next

- tests/vm: Pass --debug through for vm-boot-ssh.
- tests/vm: Add ability to select QEMU from current build.
- tests/vm: allow wait_ssh() to specify command


