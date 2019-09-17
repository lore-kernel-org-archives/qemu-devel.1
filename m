Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A858FC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818C721852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818C721852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAEuM-0005Nz-Ix
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 10:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iAEsz-00042a-IF
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iAEsy-0003hy-8D
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:55:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iAEsx-0003hp-W1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:55:20 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0AEF1796EE
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 14:55:19 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 4so974562wmj.6
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 07:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/2Shdsn099W/sEo3HTED06ZWSCUt8Vpi4IXtw4rjI8w=;
 b=fNLg07+H9F4B6pCsEg5tjeCxw2eGQpq441ZnysmCIJ8X4nIodxYbG3IG9WzCgiYw8L
 rSdQ+V814idKa/v/iA+RReg/lTG4rN4LULEWOqRKxD2k0qXKOoStA+4QHItWuckx+Iz6
 JoRihLNNgydZTmvMGw6fHg/r6DSlFffzjY72ignfZfaZP2AeDDBi1C0ZWvhb5jko0CjM
 IMyR4Nllh3VSfvUUdz0uw/fsQiDb4o8v/EIE8/LSgSaZD/KXvb5ppyxNZLMsVEVkANEQ
 aQ2it095mOlXxX29sblmND7d86QIazjyEFtZz3uAiSP4FObI4M0a1Sw+4iwsfGIPYRoY
 durA==
X-Gm-Message-State: APjAAAUrcHExKZtMNfiYCTTfKu/hxSaLI+RfUie2UI7ZBeylmq6SXewx
 rmi/mpysKQRdQzXUtcn98szlA3mKL/3s+B0YQ03MD0pFOWoymf9EOFVlpYPn42PHnQU5y7oxKCy
 dokV+FuIAqEqDvME=
X-Received: by 2002:a1c:7ecf:: with SMTP id z198mr3748845wmc.175.1568732117713; 
 Tue, 17 Sep 2019 07:55:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxCmwhyeGPxXe45kWIevj8Yj0vPVP//9ul3XWqyvAJfelRVYkkntwhK5H2iJYE/CP7hya0mzg==
X-Received: by 2002:a1c:7ecf:: with SMTP id z198mr3748832wmc.175.1568732117443; 
 Tue, 17 Sep 2019 07:55:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id l18sm2854844wrc.18.2019.09.17.07.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 07:55:16 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190911162900.8498-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d5f64427-9687-ae62-54b7-9548d2152acf@redhat.com>
Date: Tue, 17 Sep 2019 16:55:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911162900.8498-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Makefile: Remove generated files when
 doing 'distclean'
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/19 18:29, Thomas Huth wrote:
> When running "make distclean" we currently leave a lot of generated
> files in the build directory. Fix that.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Makefile               |  6 +++---
>  tests/Makefile.include | 12 +++++++++++-
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index ae17a83067..67e7e40e8c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -681,14 +681,14 @@ clean: recurse-clean
>  		-exec rm {} +
>  	rm -f $(edk2-decompressed)
>  	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
> -	rm -f fsdev/*.pod scsi/*.pod
> +	rm -f fsdev/*.pod scsi/*.pod docs/*.pod docs/*/*.pod docs/*/.buildinfo
>  	rm -f qemu-img-cmds.h
>  	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
>  	@# May not be present in generated-files-y
>  	rm -f trace/generated-tracers-dtrace.dtrace*
>  	rm -f trace/generated-tracers-dtrace.h*
>  	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
> -	rm -f qapi-gen-timestamp
> +	rm -f qapi-gen-timestamp vhost-user-input
>  	rm -rf qga/qapi-generated
>  	rm -f config-all-devices.mak
>  
> @@ -719,7 +719,7 @@ distclean: clean
>  	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
>  	rm -f config-all-devices.mak config-all-disas.mak config.status
>  	rm -f $(SUBDIR_DEVICES_MAK)
> -	rm -f po/*.mo tests/qemu-iotests/common.env
> +	rm -f po/*.mo
>  	rm -f roms/seabios/config.mak roms/vgabios/config.mak
>  	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
>  	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f5ac09549c..07f794b01f 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1174,11 +1174,21 @@ check: check-block check-qapi-schema check-unit check-softfloat check-qtest chec
>  check-clean:
>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
> -	rm -f tests/test-qapi-gen-timestamp
>  	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
> +	rm -f tests/qemu-iotests/common.env tests/qemu-iotests/check.*
> +	rm -f tests/test-qapi-gen-timestamp tests/qht-bench$(EXESUF) \
> +		tests/fp/fp-test tests/fp/*.out tests/qapi-schema/*.test.*
>  
>  clean: check-clean
>  
> +check-distclean:
> +	rm -f tests/test-qapi-types*.c tests/test-qapi-visit*.c \
> +		tests/test-qapi-commands*.c tests/test-qapi-events*.c \
> +		tests/test-qapi-emit-events.[ch] tests/test-qapi-introspect.c \
> +		tests/include/test-qapi-*.c
> +
> +distclean: check-distclean
> +
>  # Build the help program automatically
>  
>  all: $(QEMU_IOTESTS_HELPERS-y)
> 

Queued, thanks.

Paolo

