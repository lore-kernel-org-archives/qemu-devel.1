Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D4FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D078205CB
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D078205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE8K6-0002xZ-Ew
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 05:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kE8JO-00024E-5c
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 05:47:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kE8JM-0007ly-9X
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 05:47:13 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-dMCLCcSMOnm407TmTcqoKQ-1; Fri, 04 Sep 2020 05:47:10 -0400
X-MC-Unique: dMCLCcSMOnm407TmTcqoKQ-1
Received: by mail-wm1-f72.google.com with SMTP id m25so2018831wmi.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 02:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=7G7C7A+ggZkEPG+VGKTz/FiDCUH0UIocGyvpBIsBM5M=;
 b=tYfXyprbM/PR6it2qFPX1bgqOwe5VFImywaZvOZbRRzykQsn0PrEfu6MKcC5K7hG+x
 a2U7Tvt78nXaP/6tBME/99AGnc/bUzap33h9i8OfncQOVeZCVZTq+Faoe4I/KOND17uj
 9X5xF8ku5+SysAbo/PzXG9nJ20710okzm2Nwh3RDBhXpegZMvfRMYR7kTuiZILELkmJ6
 GSuBaAAPp8G9XYkLBQwwHiYajH3vDytVfEjRr4RjGFcew6xN87dxGtqRsetDYAe72AXX
 WSEbPy0C3W178fp22WOSnx6TKj+oLNB2MUqJqNbNg76u8d6hsmhivSWDFD/ROembNI3t
 0bFg==
X-Gm-Message-State: AOAM530dfQnjr1NfEby4rBCFzA4bO8zK9xxc7uMMIaGwvb0GWxPyLjsq
 umoU2N2w+OOR8xHKVW2xfZwTA/Ig5v3ETlPOT5o7VwUcJ4db95lgedjTAt9oCe4p0NCUTnSlg9W
 wwiDNYU3iVzbiBxE=
X-Received: by 2002:adf:c64e:: with SMTP id u14mr1013596wrg.373.1599212829431; 
 Fri, 04 Sep 2020 02:47:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfXGNqGSUI729EGKRNEkwCJfNSq9TYGnNE5HXEU9Qsrj0HtGsJWaq91ju8vL3n/Ru/vtkD/Q==
X-Received: by 2002:adf:c64e:: with SMTP id u14mr1013569wrg.373.1599212829211; 
 Fri, 04 Sep 2020 02:47:09 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id y6sm10271497wrt.80.2020.09.04.02.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 02:47:08 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
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
Message-ID: <fb53e38f-98cf-65e0-9592-5ef95d0de71b@redhat.com>
Date: Fri, 4 Sep 2020 11:47:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200709024657.2500558-3-crosa@redhat.com>
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 4:46 AM, Cleber Rosa wrote:
> This is a mapping of Peter's "remake-merge-builds" and
> "pull-buildtest" scripts, gone through some updates, adding some build
> option and removing others.
> 
> The jobs currently cover the machines that the QEMU project owns, and that
> are setup and ready to run jobs:
> 
>  - Ubuntu 18.04 on S390x
>  - Ubuntu 20.04 on aarch64
> 
> During the development of this set of jobs, the GitLab CI was tested
> with many other architectures, including ppc64, s390x and aarch64,
> along with the other OSs (not included here):
> 
>  - Fedora 30
>  - FreeBSD 12.1
> 
> More information can be found in the documentation itself.
[...]
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index c1ff24370b..f8dab788ea 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -1003,3 +1003,150 @@ exercise as many corner cases as possible. It is a useful test suite
>  to run to exercise QEMU's linux-user code::
>  
>    https://linux-test-project.github.io/
> +
> +CI
> +==
> +
> +QEMU has configurations enabled for a number of different CI services.
> +The most update information about them and their status can be found
> +at::
> +
> +   https://wiki.qemu.org/Testing/CI
> +
> +Gating CI
> +----------
> +
> +A Pull Requests will only to be merged if they successfully go through
> +a different set of CI jobs.  GitLab's CI is the service/framework used
> +for executing the gating jobs.
> +
> +The architecture of GitLab's CI service allows different machines to be
> +setup with GitLab's "agent", called gitlab-runner, which will take care
> +of running jobs created by events such as a push to a branch.

Now that GitLab announced the free tier time limit, it may be worth
mentioning (if set up) the CI pipeline can be skipped using:

  $ git push --push-option=ci.skip [...]


