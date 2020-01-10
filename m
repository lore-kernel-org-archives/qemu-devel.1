Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02694C33CA5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 14:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D096820838
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 14:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D096820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iputs-0002pz-Vd
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 09:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iput4-00022L-B2
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iput3-0001Ew-63
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:03:42 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:49577)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iput2-00017b-Sr
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:03:41 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MOi1H-1j2vza2E99-00Q8bj; Fri, 10 Jan 2020 15:03:29 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200109153939.27173-1-philmd@redhat.com>
 <d94666ae-df03-0162-e3d0-e0038b68da83@vivier.eu>
 <CAAdtpL69XLuoZNEank0dC9M-tWCKhJqFKO46u5jjeLpf4TF=Pg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 0/4] buildsys: Build quicker (mostly tools and linux-user)
Message-ID: <d7e57fe9-9c0f-10bf-dfd2-c1832d34cada@vivier.eu>
Date: Fri, 10 Jan 2020 15:03:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAAdtpL69XLuoZNEank0dC9M-tWCKhJqFKO46u5jjeLpf4TF=Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vpEqSR9f0OaquC9SxnvnlsRKwyZ7m3uolLFS7tLMJwa74aPR/Ki
 OTmfOECHQ05phtR0ojkt6KH7XrV24QduVCn6sbxRXUaKrFk1DWnwLSLgaB1ZLpuadq9jRfD
 mfC4cq6sCClZ1I8ZMQJ+Lz+Y1KmXl/OEHTaB9Gg/wROLoqwxTv3Wurg07v3o880QpEG9k4i
 f/H5Ex42a4dbmYERTtGgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gspSleCXpP4=:janECLProsXwGGvAs2sIk+
 82C/xSCpD7JSfWzqC6otmm6T3YfqQ3A51iLf1hxl0cuee40j9cEl2bD6nvOcPdwzAJtF4g6VW
 cGoStlTwkpgPywITuTrCpIIh+AzgnRLgDk9HyYqUkLlsH4wF9CnTXPwjdcQbThZZu29Cy7F4G
 TDXtmK4wSxEQRjxi09lpSweanh9QMsfRU4UCNXXpzbXjutMktFXgBpVFIwm8u5ajFPRm8k29V
 bVHEqd5hDtUCYXsICufDHWlt+VhuKuTfRjz+Kz8EtN9IjthL5s2qNFRjVncmCbE/bd04ccw55
 K7TZaycAdBNZYfdx+VSRdgfayNKSmG9qdi+xCYzNp2TEMF/a0YYBWw576Zvs7DOGmnJvv6rsH
 SQ5FF85Rb/gQ/2hpVXK+fDX1cwobUAhlMMxPQWAnnA/ZXv5h3+jj7chGUC9j7/EhFdSjf4wR+
 oz4g+BMg8K3KZQN+mUIqA8eNFTkDW/zscBv853ND9xIqYQewEsB9drmwgl+9PWoyJCzuRYyep
 ArTLl/GIHIsRMzNKz8EwiJPgD0zn3HyW53fWDax+nrkInD1HEgIYtRzb2PvlopoB4b3AxhPqj
 JlLj+JytYCubJClW34HjHmkn9ViN2KuJFpUshAuHIzbjY/sCHTnPOzhLnOez2kiNEeBmCwoLi
 P8s9zci8DEeRDoEjMox/riCpkFkfyKSriHaJQIQniojlai9kBttutfk77hjrSRADOl+bVFxjw
 ECEf8FRwJs+dL867uO2OsxeAAeE+OsQm0Qh3dsrIGQ4f8pNGVyh9y7QVqgOCzAVwYY8n2XUM0
 W5rP52zR03dDruebAv4jITmgZMhrP5KTAtH0a72nv9eiZNgvtTHApFK0i46l2/qx9jedWZhNP
 mWGDo/sX7JDSln8zt4RRCP+LPVNJheUfCJ4LaR+NI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/01/2020 à 10:17, Philippe Mathieu-Daudé a écrit :
> Le ven. 10 janv. 2020 09:36, Laurent Vivier <laurent@vivier.eu
> <mailto:laurent@vivier.eu>> a écrit :
> 
>     Le 09/01/2020 à 16:39, Philippe Mathieu-Daudé a écrit :
>     > In some configuration (linux-user, tools) we can ignore building
>     > various objects (and the libfdt).
>     >
>     > Philippe Mathieu-Daudé (4):
>     >   configure: Do not build libfdt is not required
>     >   Makefile: Clarify all the codebase requires qom/ objects
>     >   Makefile: Restrict system emulation and tools objects
>     >   Makefile: Remove unhelpful comment
>     >
>     >  configure     |  2 ++
>     >  Makefile.objs | 31 ++++++++++---------------------
>     >  2 files changed, 12 insertions(+), 21 deletions(-)
>     >
> 
>     Did you test this with all the combinations of --[enable|disable]-tools,
>     --[enable|disable]-user and --[enable|disable]-system
> 
> 
> I tested 12 of 27 because I thought some sets might overlap but I might
> have missed something, what combination is giving you problem? 
> 

I didn't test your series, but I did this kind of change in the past and
sometime enabling tools without enabling softmmu can show missing
objects at build time, or you can also see if tools are built with
softmmu while tools are disabled.

I used to test with something like

for user in enable disable; do
    for tools in enable disable; do
        for system in enable disable; do
            rm -fr build
            mkdir build && \
            (cd build && \
             ../configure --$user-user \
                          --$system-system \
                          --$tools-tools && \
             make || exit)
        done
    done
done

Thanks,
Laurent

