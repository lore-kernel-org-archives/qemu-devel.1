Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443B2ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109EC20842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109EC20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIj8-0005tG-7q
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 10:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFIgE-0003hR-Hp
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFIgD-0004DY-IA
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:59:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFIgD-0004DA-CV
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:59:05 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8590981DE3
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 13:59:04 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k67so959360wmf.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sB1MAaJLKEy7AXTHvhiqNvwEzybNGPwXFhL3+lJ9xQE=;
 b=bOhVhigMcCVLHz0Tp111Lbzp0FDO8AWkVxfDNZcZ+nDhf/2Ies3ENFDQ8rxPoejHrj
 D6a7mq2defEkY1heXqRJHfk+GHa1oiZDPxKpEmJ/GmqBPw78vEYvMIIZ1yazdyT65eqT
 IwUFJGSNtmvyzBOMS5eGpWuZaYDATmeI3dtNHZr5wrVaDI5y0h+zqD8X8+F8OqfsrNs7
 Bi/C08Qr7CHIuWoXT+AbiSJHPt6BTVLK+CjJt1jN19AM7pRZlYtyrOjy4YrSWnjMaYYS
 0BhiIt7A/wGAvgewrORU9KM/diblIL16nvDg54GfLfJxGfh7NGOyTwqhkEaDirF1XDBi
 29hQ==
X-Gm-Message-State: APjAAAUv7tqsKoVPJnmxyHoBxaS7UZZuZxpO0DCXhdIxjixyIMr4jtlM
 MqNNppdQwb0dw/eEDOe9fj0WVOJDc3HoarbLmMRjXAM/HBS/3VnIFjTpllfYCKMNajUUo8kL5ow
 Z6bTrX+4DfcM6cPU=
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr3877905wmg.73.1569938343051; 
 Tue, 01 Oct 2019 06:59:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvhPsrn2V/cbNVsWzzQBw8Zw6sGiFmphs8CtN4aU+GCvUcQJj/P/owwlCDiuZTmBhoeCK+Wg==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr3877891wmg.73.1569938342868; 
 Tue, 01 Oct 2019 06:59:02 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id c10sm26378632wrf.58.2019.10.01.06.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:59:02 -0700 (PDT)
Subject: Re: [PATCH 8/8] docker: test-debug: disable LeakSanitizer
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
 <1569936988-635-9-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4f6b25f1-fff6-10bc-4089-26104ccec556@redhat.com>
Date: Tue, 1 Oct 2019 15:59:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1569936988-635-9-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 3:36 PM, Paolo Bonzini wrote:
> There are just too many leaks in device-introspect-test (especially for
> the plethora of arm and aarch64 boards) to make LeakSanitizer useful;
> disable it for now.
> 
> Whoever is interested in debugging leaks can also use valgrind like this:
> 
>     QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64 \
>     QTEST_QEMU_IMG=qemu-img \
>     valgrind --trace-children=yes --leak-check=full \
>     tests/device-introspect-test -p /aarch64/device/introspect/concrete/defaults/none
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/docker/test-debug | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/docker/test-debug b/tests/docker/test-debug
> index 137f4f2..c050fa0 100755
> --- a/tests/docker/test-debug
> +++ b/tests/docker/test-debug
> @@ -21,6 +21,7 @@ cd "$BUILD_DIR"
>   OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
>   OPTS="--enable-debug --enable-sanitizers $OPTS"
>   
> +export ASAN_OPTIONS=detect_leaks=0
>   build_qemu $OPTS
>   check_qemu check V=1
>   install_qemu
> 

Can we reduce it only for the arm/aarch64 targets?

