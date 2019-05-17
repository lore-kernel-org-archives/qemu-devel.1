Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE9DC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 20:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC37F2087B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 20:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdvPzeiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC37F2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53415 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRjVZ-0003Fn-5v
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 16:31:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hRjUR-0002sL-5A
	for qemu-devel@nongnu.org; Fri, 17 May 2019 16:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hRjUQ-00013P-3A
	for qemu-devel@nongnu.org; Fri, 17 May 2019 16:30:03 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hRjUP-00011h-Nw
	for qemu-devel@nongnu.org; Fri, 17 May 2019 16:30:01 -0400
Received: by mail-pg1-x541.google.com with SMTP id t1so2388139pgc.2
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=lUid6xXixsiSIDSBBVSP0rZqDaAKZutSiFp7iArxkIg=;
	b=QdvPzeiT/MKYn1c1F+aFqnooe51qsga+Hwd2OT1mv9eO4tbQV1nrweidNXGPHNIlUw
	ohJwLYXiZCgs1VLE3db4WUUL97Tir63IZRvZJYZTW1/hNiFFkIAYEiENe7fTMqslVBR1
	gCZTuump0Lt6z00IPXy3cdGxPlfv9FJikEUMKVCSiWcvqhYlhQSin3F24w63TcG8beWx
	4wNpBKD4c6BxMJJJBKLYwl6rMlC1fnVDgiEjzg+2oCmbLqsLhjXX/ET9dUhVDl7pe7W+
	2a54ZFcoyevNHK25M1R6dR9UpDxQBskRHCuliZHvlXhp2k6dkES5BYlU/ucBeJy48U6J
	KLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=lUid6xXixsiSIDSBBVSP0rZqDaAKZutSiFp7iArxkIg=;
	b=KhuH6wvbPA33JoggqaBxZMrj8GoLARjQ0IsJjWnl6WLbcT7EqOaMTLFz54sfpReYVP
	7/dkZ8YhRYn5UvLcDentJT6EWU2Og26M+gqngc/Ngvq1ufca3s9VjsWHvHYnFntRQ1cg
	uWrtp2WBuYLz8UOtnhN7f2JZl5wcA3Hhi3wdQcoQ8vWrmXc1A7dlWsDLX9Yu6V/nPrMj
	VrMfJ28cTP3B20vc/Kq0TJqigKoWNyua3TlN5Bs6FugvtvA6FdBi57F7PF9/HcB0JYOn
	4aE/pcIxuDB1XiuDjrS3SqMT+sbMZ540c2Pz7zBtmIqzymVCaNV13BjEMizMojQ0JElc
	VyZQ==
X-Gm-Message-State: APjAAAUQH4lm3mxCgb4cBffXtTVfBIzAAFn5aSOjq0t1Cmd3fAP5UgT8
	+df3dlxjgr61OkrAWSMAOr0=
X-Google-Smtp-Source: APXvYqxBKrXtINBvaz4C6U3okFSLu249FTT+y2PMPsoF9pwqUJ8VfAe3CmeqptopGTlcfIyVbjwEWA==
X-Received: by 2002:a65:5c41:: with SMTP id v1mr57205871pgr.20.1558124999943; 
	Fri, 17 May 2019 13:29:59 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.googlemail.com with ESMTPSA id
	h14sm10650063pgj.8.2019.05.17.13.29.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 13:29:58 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190517191332.23400-1-ehabkost@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
	mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
	n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
	rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
	Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
	n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
	AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
	CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
	cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
	Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
	eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
	LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
	Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
	94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
	86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
	I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
	VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
	+PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
	AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
	Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
	prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
	/E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
	jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
	VcROBqvtH3ecaIL9iw==
Message-ID: <f5078a33-4421-c494-7a8d-8c79e65f2e6b@twiddle.net>
Date: Fri, 17 May 2019 13:29:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517191332.23400-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v2] hppa: Delete unused hppa_cpu_list()
 function
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 12:13 PM, Eduardo Habkost wrote:
> hppa_cpu_list() is dead code and is never called.  Delete it.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Delete prototype at target/hppa/cpu.h as well
>   (Philippe Mathieu-Daudé)
> ---
>  target/hppa/cpu.h |  2 --
>  target/hppa/cpu.c | 17 -----------------
>  2 files changed, 19 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

