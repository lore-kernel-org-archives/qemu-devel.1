Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E02C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8605E2068E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8SI5SS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8605E2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkjbj-0005kw-QE
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 03:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkjaU-0004qO-56
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:31:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkjaR-0005OP-Pv
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592206278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ILKFV2Yk7Mzw0jMo5iNYewk0oFVVMMpjfpVtd+QvOmY=;
 b=O8SI5SS5/tTbXXeG0PfRy144cEG5fX1bm19Ck3LdzHZGz9b2w00yQxHP1KZwAkuDLjcBYe
 COMAQPimB7JWNS/GXQkbHWvxoxfuGE5K1CCv1oC8yvYxtSoKet1e8efvxUEN6ez4AJrdLl
 vRbLeojJHHv7UE/lN2n2UIKDSvfuUE4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-XosySceXOkyz_vYEvxD9dQ-1; Mon, 15 Jun 2020 03:31:14 -0400
X-MC-Unique: XosySceXOkyz_vYEvxD9dQ-1
Received: by mail-wr1-f70.google.com with SMTP id s7so6698693wrm.16
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 00:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ILKFV2Yk7Mzw0jMo5iNYewk0oFVVMMpjfpVtd+QvOmY=;
 b=NBgdYZJc8nbAupMsCt2HuAeUIK/+w9RxJ6h99Ghs76rFqViQ6mHT5CcyQP0O1ngZhh
 eLT40h1GCd1wAYFX8MhEHhbVCOwxV0UbVIJbKbBvWCPAxvMPUnMl6OTPDjlUpKIZ7+94
 2Z5h4H1x3p2ARNo/msBEC9YjYUNhn9OLkNWUyJ1plJ3V0qmvYEREFn3mcqTBXUByRz2W
 73TmRFaepOAwYMKNi5OuXSboextby/6BYSYVyIu3bcdBurifrIpjp6pA+M1y5NCnVKN1
 1gcj1AgbgHkb4KQkURsPhrFh6lBiWCyZZZU6dpt5bGuwijDUL4zg1HSglGXd89UbZNDT
 Awvw==
X-Gm-Message-State: AOAM532Oki05ltrjMRlqz9rWqUy4GfP1UsE5ZWushXX/is/FytxdYm18
 RMbL7u8Wfy/aBs8RVrga2K3KFd2ZSqD4bI3u417uZhfJM7lXsd5p9OvVKDBSn4R78dzC0lTAkpm
 DxnDRp74BhlOv9ow=
X-Received: by 2002:adf:f6ce:: with SMTP id y14mr28401714wrp.90.1592206273517; 
 Mon, 15 Jun 2020 00:31:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2iIRdUl+1TDkEbqhJ66iH0yVcEAQMfuGcEPKd55k6K55WHCIZUvG5Pfh6FA/Uw6nccjK9RA==
X-Received: by 2002:adf:f6ce:: with SMTP id y14mr28401692wrp.90.1592206273298; 
 Mon, 15 Jun 2020 00:31:13 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c70sm20519032wme.32.2020.06.15.00.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 00:31:12 -0700 (PDT)
Subject: Re: [PATCH v8 00/10] accel: Allow targets to use Kconfig
To: qemu-devel@nongnu.org
References: <20200608163823.8890-1-philmd@redhat.com>
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
Message-ID: <c1fb7749-6f76-c1ca-b67c-c4df4cfa481a@redhat.com>
Date: Mon, 15 Jun 2020 09:31:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200608163823.8890-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

FYI this series applies cleanly on current master
(7d3660e798 merging your for-upstream 3575b0aea9).

On 6/8/20 6:38 PM, Philippe Mathieu-Daudé wrote:
> Missing review:
> - 03/10 MAINTAINERS: Cover the HAX accelerator stub
> - 04/10 configure: Generate rule to calculate base arch of target
> 
> This series include generic patches I took of the KVM/ARM
> specific series which will follow.
> 
> - Update accelerators in MAINTAINERS
> - Add accel/Kconfig
> - Allow targets to use their how Kconfig
> 
> Since v7:
> - Generate base-arch() (Alex)
> - Do not deprecate HAXM
> 
> Since v6:
> - Fixed typo 'startwith' -> 'startswith' (armbru)
> 
> Since v5:
> - Fixed typo in patch #4 subject
> - Added David R-b tag
> - Stripped --- comments
> 
> Since v4:
> - Addressed rth review comments in rules.mak
> 
> Since v3:
> - Fixed base-arch() rule (rth)
> - Dropped 'semihosting: Make the feature depend of TCG'
> 
> Since v2:
> - Addressed Thomas review comments
> - Fixed problem when including TARGET instead of BASE_TARGET
> 
> Since v1:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg689024.html
> - Drop HVF MAINTAINERS patch (merged elsewhere)
> - Kconfig-select SEMIHOSTING (bonzini)
> - Drop user-mode selection patches
> - consider m68k/nios2/xtensa/riscv (pm215)
> - reword Kconfig SEMIHOSTING description (pm215)
> - reset some of rth R-b tags
> 
> Previous RFC for semihosting posted earlier:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg631218.html
> 
> Alex Bennée (1):
>   configure: Generate rule to calculate the base architecture of a
>     target
> 
> Philippe Mathieu-Daudé (9):
>   MAINTAINERS: Fix KVM path expansion glob
>   MAINTAINERS: Add an 'overall' entry for accelerators
>   MAINTAINERS: Cover the HAX accelerator stub
>   Makefile: Remove dangerous EOL trailing backslash
>   Makefile: Write MINIKCONF variables as one entry per line
>   accel/Kconfig: Extract accel selectors into their own config
>   accel/Kconfig: Add the TCG selector
>   Makefile: Allow target-specific optional Kconfig
>   accel/tcg: Add stub for probe_access()
> 
>  configure              | 19 +++++++++++++++++++
>  Makefile               | 15 +++++++++++----
>  accel/stubs/tcg-stub.c |  7 +++++++
>  Kconfig.host           |  7 -------
>  MAINTAINERS            | 14 +++++++++++++-
>  accel/Kconfig          |  9 +++++++++
>  6 files changed, 59 insertions(+), 12 deletions(-)
>  create mode 100644 accel/Kconfig
> 


