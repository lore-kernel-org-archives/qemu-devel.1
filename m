Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542D3C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E13220657
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E13220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQXyi-0003cS-4O
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQXwX-0002PO-B9
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:34:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:51942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQXwV-0008TA-JC
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:34:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 52778AE0C;
 Thu,  8 Oct 2020 15:34:53 +0000 (UTC)
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Paolo Bonzini <pbonzini@redhat.com>
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <e6300199-39e3-4f11-d97e-e2e7d9a9e8ef@suse.de>
Date: Thu, 8 Oct 2020 17:34:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 23:49:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.214,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alex Bennee <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 5:02 PM, Paolo Bonzini wrote:
> On 08/10/20 16:48, Claudio Fontana wrote:
>> on master, a build without tcg like:
>>
>> exec '../configure' '--disable-tcg' '--enable-kvm' '--enable-hax' "$@"
>>
>> make -j120 check
>> Generating qemu-version.h with a meson_exe.py custom command
>> make: *** No rule to make target 'qemu-system-aarch64', needed by 'check-block'.  Stop.
>> make: *** Waiting for unfinished jobs....
>>
>> qemu-system-aarch64 is required for check-block now?
> 
> No, it's not, it's an unnecessary dependency.  This will fix it:
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 5aca98e60c..1ca70d88ce 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -140,7 +140,7 @@ QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXE
>  check: check-block
>  check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
>  		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
> -		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
> +		qemu-system-$(patsubst ppc64%,ppc64, $(shell uname -m))
>  	@$<
>  endif
>  
> 
> 

thanks this works!

>> If I run without -j:
>>
>> Running test qtest-i386: qmp-cmd-test
>> Broken pipe
>> ../tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
>> ERROR qtest-i386: qmp-cmd-test - too few tests run (expected 53, got 45)
>> make: *** [Makefile.mtest:1074: run-test-151] Error 1
> 
> This one is different and I've never seen it.

This one seems an additional, non-tcg build only error, will update when I have more details.

> 
> Paolo
> 

Ciao,

Claudio

