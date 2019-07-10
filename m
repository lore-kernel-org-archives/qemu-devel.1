Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E09C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF9E20861
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF9E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlA4c-0002mN-Tq
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 06:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48347)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlA2Q-0001dP-G8
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlA2P-0001mG-1n
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:41:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlA2O-0001kk-3X
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:41:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so1892855wrl.7
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 03:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bikpCkm7t8bGzapIgCxmtWgANhQEbQ0YH3XGd5eUdek=;
 b=tSa9fU19DVZCB9MBC35N8pwvPBhEwDjToAsXNNzNgfrDSXHPKz9JGQZdUw/fn85QxS
 kLKDv8NcpZDDlOtXQTIptcfkrE05yZZnkrLhYk0girlJw4C/m95I2QiyRJUnoJGSQIVY
 XGoq6iCVXoZAGB+HYIdyautR+wWKDbWVXPRz7q46dro7wabavyiitbBaEY3D+da7h1vW
 mw92C8gnd0YdINUkfdGJQE+hMwwZcTQkDOhGipeS9/PLd8M04EpyclvpcbClpe+Dcl5s
 /1wBoK2VpBPVhZsrt/i41NQaKDlokopi4BvJnN/TiJIIu8AD2z9gVA16cig3avT4yR4v
 oHRg==
X-Gm-Message-State: APjAAAXzv9KfaPyLaIHPxOgOLHvH6K+ukQm+jm7PC1TcLtZfg60RSFjy
 xSfOs+iwWCkIA3X1qKZB4gdEiA==
X-Google-Smtp-Source: APXvYqyJdSFRu81RB9HMQUu54MV0VqESbKlUFPLMJjIwGb4aDSSnggDJ3uJcjLKdgGPWECHjG7e57w==
X-Received: by 2002:adf:eb86:: with SMTP id t6mr2360129wrn.96.1562755282632;
 Wed, 10 Jul 2019 03:41:22 -0700 (PDT)
Received: from [10.32.224.100] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
 [159.63.51.90])
 by smtp.gmail.com with ESMTPSA id b15sm2305028wrt.77.2019.07.10.03.41.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 03:41:22 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190705160421.19015-1-alex.bennee@linaro.org>
 <20190705160421.19015-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <af417ca3-248a-d1a8-51c4-46676b6d9d4a@redhat.com>
Date: Wed, 10 Jul 2019 12:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190705160421.19015-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v1 2/5] tests/tcg: fix up
 test-i386-fprem.ref generation
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Jan Bobek <jan.bobek@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/19 6:04 PM, Alex Bennée wrote:
> We never shipped the reference data in the source tree because it was
> quite big (64M). As a result the only option is to generate it

Can we fetch it (with hash verification) or store it compressed?

$ du -ch pc-bios/edk2-*bz2
1.2M    pc-bios/edk2-aarch64-code.fd.bz2
1.2M    pc-bios/edk2-arm-code.fd.bz2
4.0K    pc-bios/edk2-arm-vars.fd.bz2
1.7M    pc-bios/edk2-i386-code.fd.bz2
1.9M    pc-bios/edk2-i386-secure-code.fd.bz2
4.0K    pc-bios/edk2-i386-vars.fd.bz2
1.7M    pc-bios/edk2-x86_64-code.fd.bz2
1.9M    pc-bios/edk2-x86_64-secure-code.fd.bz2
9.3M    total

> locally. Although we have a rule to generate the reference file we
> missed the dependency and location changes, probably because it is
> only run for SLOW test runs.
> 
> The test still fails with mostly incorrect flags and different than
> expected NaNs. I'll leave that for the x86 experts to look at.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Jan Bobek <jan.bobek@gmail.com>
> ---
>  tests/tcg/i386/Makefile.target | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
> index b4033ba3d1..d0eb7023e5 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -35,9 +35,9 @@ test-i386-fprem.ref: test-i386-fprem
>  	$(call quiet-command, ./$< > $@,"GENREF","generating $@")
>  
>  run-test-i386-fprem: TIMEOUT=60
> -run-test-i386-fprem: test-i386-fprem
> +run-test-i386-fprem: test-i386-fprem test-i386-fprem.ref
>  	$(call run-test,test-i386-fprem, $(QEMU) $<,"$< on $(TARGET_NAME)")
> -	$(call diff-out,test-i386-fprem, $(I386_SRC)/$<.ref)
> +	$(call diff-out,test-i386-fprem, test-i386-fprem.ref)
>  else
>  run-test-i386-fprem: test-i386-fprem
>  	$(call skip-test, $<, "SLOW")
> 

