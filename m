Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E97C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 10:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EF02075B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 10:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EF02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57071 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEARa-0003Rz-TQ
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 06:27:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEAQp-00034I-EC
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEAQo-0000Pk-Eb
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:26:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEAQo-0000OB-4u
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:26:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so2012946wma.2
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 03:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=dONBnitlFeJc9Nq1n6NU2XuaqovJRXgIgDsJJ50YwNs=;
	b=fyevnhrBPHqCeaHkU47vxhkdjmd8/DhYBirvPq7lCD/EFfuwlR8yeNJMoykN0BXNDA
	eCN4UQIjiecrJO2gkpVLlOLCvtF3QEz06wOB2zF3kuIJZq5FJbGTwFeEOhUP7g2Ld4JL
	qx9ZsA2K9+GkvVt4XAKPV4T1XqT+vWssUbtb1QHshGeCBjBreKAPze2L47sbEt06tpdA
	yjWT+3EfS0HDjTivmwANyxW94OCTHjO7CHWE2vP4eUJIDh8wFhu/y3uoBEUr/ZXTPEsB
	FJhRWj5KjTCEFfIjzy9PQnQQQe4yjwkijriyU0pd3gOLIPzgaLfhxxGhlvw/Jhl5E/dr
	RITA==
X-Gm-Message-State: APjAAAUYUha8F1EgdHX0Fin4hs8af+dHGyH8TAzB0PrgpZ2OTrpfdK8B
	M/8yiVUDQsuYWPDti6+drCXdF16jryE=
X-Google-Smtp-Source: APXvYqx5Nrwpl0Mw1XVfM6bPUleKlQ0jdxx4gRCYl0ExVGkHDBKnE2dpgpW1jm/kOyRi+DOEJPHKAA==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr2158896wmq.96.1554891972984; 
	Wed, 10 Apr 2019 03:26:12 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	j3sm84182301wre.51.2019.04.10.03.26.11
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Apr 2019 03:26:12 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, eblake@redhat.com, 
	f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com,
	mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org,
	qemu-devel@nongnu.org
References: <20190409230022.6462-1-lersek@redhat.com>
	<20190409230022.6462-11-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <061dcac9-82a2-8a48-3c7f-8c8375d81abe@redhat.com>
Date: Wed, 10 Apr 2019 12:26:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409230022.6462-11-lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH for-4.1 v4 10/12] tests: add missing
 dependency to build QTEST_QEMU_BINARY, round 2
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410102610.2N2F9nTSI1wRc79xzAStdvvXPFVOqCdZ-LZAe8Oe_dE@z>

On 4/10/19 1:00 AM, Laszlo Ersek wrote:
> In commit b94b330e2333 ("tests: add missing dependency to build
> QTEST_QEMU_BINARY", 2017-07-31), Phil fixed the dependency list of make
> target "check-qtest-%". Namely, the recipe would set QTEST_QEMU_BINARY to
> the softmmu emulator for the emulation target, but the prerequisites
> didn't include the emulator.
> 
> The same issue affects the "check-report-qtest-%.tap" make target, which
> is the other make target whose recipe sets QTEST_QEMU_BINARY:
> 
>> $ make -j4 check-report-qtest-aarch64.tap
>>   TAP     check-report-qtest-aarch64.tap
>> sh: /.../aarch64-softmmu/qemu-system-aarch64: No such file or directory
> 
> Apply Phil's fix to this make target too.
> 
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
> Tested-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Notes:
>     v4:
>     
>     - no change
>     
>     v3:
>     
>     - pick up Michal's R-b
>     
>     - pick up Igor's T-b
>     
>     - pick up Michael's R-b
>     
>     v2:
>     
>     - new patch, relied upon by the next patch
> 
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 36fc73fef55a..e2432d5e7712 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -912,7 +912,7 @@ check-speed: $(check-speed-y)
>  
>  # gtester tests with TAP output
>  
> -$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qtest-%.tap: $(check-qtest-y)
> +$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qtest-%.tap: subdir-%-softmmu $(check-qtest-y)
>  	$(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y), \
>  	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
>  	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
> 

