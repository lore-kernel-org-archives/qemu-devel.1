Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB88C73C41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 12:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75AE9214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 12:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AE9214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkpCw-0000ZG-J8
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 08:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57667)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hkpAn-0007tG-Ik
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hkpAm-0007cA-5E
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:24:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hkpAl-0007be-VR
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:24:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so2305151wmd.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 05:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G/LGEPRQgH4lmQSAYt2Bh01khWyAsFvJNi4XQsB/mgA=;
 b=oFAaVFuJHnBFQHuOkcRTk0xFKQQCL49RAkN/6/bqUADqk3vHHsyYN/z7XFafxRXS+Q
 XvjaiP2fun+pHIIrDxHvREOeSysPXYKiUBAr3D9lVt2O03UYgqOkMeko1P+IUbt2aaRj
 6r0MARY9At7eOe3nFo0YIxb5LKKDiHnvMbWrkBudtFLwN4sXWcrMEujOgF5K5AtNxJEJ
 QRG/kbh6527/dHYaMuliWhWL5ghD5B+/v2txRfTYCOwLP6Nc2gDpzKLCyKjd0is9u2K5
 U2/oL44Oib0AHzQY5FVPYikvBaKx1RTXPXkW/PCbOn/Zk1j9mGureOepZ3XJRzO7FBle
 xe5Q==
X-Gm-Message-State: APjAAAWcD22VOZtlqqkQ9T2m1UJpLhkvyMGhVXZstBJwD+phYXBMVCHO
 l+5RYC/sEAsI3ZxfXFdAiNtvqg==
X-Google-Smtp-Source: APXvYqytDza1Ef8KQmr58WOJOBOBoypt+5uIgvSLgQDPF73hcntWAutNcaO7XDZ3EaiWREyNSSqcZw==
X-Received: by 2002:a1c:be19:: with SMTP id o25mr21394137wmf.54.1562675078582; 
 Tue, 09 Jul 2019 05:24:38 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id r5sm2900380wmh.35.2019.07.09.05.24.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 05:24:38 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190702113414.6896-1-armbru@redhat.com>
 <89290c81-ea80-a84d-fced-86764cab23ff@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c6461870-1e9a-54a4-3d9f-dfde8014251b@redhat.com>
Date: Tue, 9 Jul 2019 14:24:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <89290c81-ea80-a84d-fced-86764cab23ff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PULL 0/4] Build system patches for 2019-07-02
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/19 2:32 PM, Philippe Mathieu-Daudé wrote:
> Hi Markus,
> 
> On 7/2/19 1:34 PM, Markus Armbruster wrote:
>> The following changes since commit ab200dafc0e8a9925bb0ad0be478621f5f117c95:
>>
>>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-07-02 10:17:54 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-build-2019-07-02
>>
>> for you to fetch changes up to b7f9b1b7fc9a00ab6e5f46555e87166533292576:
>>
>>   Makefile: Reuse all's recursion machinery for clean and install (2019-07-02 12:48:40 +0200)
>>
>> ----------------------------------------------------------------
>> Build system patches for 2019-07-02
>>
>> ----------------------------------------------------------------
>> Markus Armbruster (4):
>>       Makefile: Remove code to smooth transition to config.status
>>       Makefile: Drop bogus cleaning of $(ALL_SUBDIRS)/qemu-options.def
>>       Makefile: Rename targets for make recursion
>>       Makefile: Reuse all's recursion machinery for clean and install
> 
> I wonder if some rule is missing, I did:
> 
> $ mkdir build
> $ cd build
> $ ../configure --python=python3 \
>   --disable-tools \
>   --enable-trace-backends=log \
>   --extra-cflags=-ggdb --enable-debug \
>   --target-list=arm-softmmu
> $ make check-tcg
> [...]
>   CC      arm-softmmu/target/arm/iwmmxt_helper.o
>   CC      arm-softmmu/target/arm/vec_helper.o
>   CC      arm-softmmu/target/arm/neon_helper.o
>   CC      arm-softmmu/target/arm/m_helper.o
>   CC      arm-softmmu/target/arm/psci.o
>   GEN     trace/generated-helpers.c
> make[1]: *** No rule to make target '../blockdev.o', needed by
> 'qemu-system-arm'.  Stop.
> make[1]: *** Waiting for unfinished jobs....
>   CC      arm-softmmu/trace/control-target.o
> make: *** [tests/Makefile.include:1073: run-tcg-tests-arm-softmmu] Error 2
> $ make arm-softmmu/all
>   CC      authz/base.o
>   CC      authz/simple.o
>   CC      authz/list.o
>   CC      authz/listfile.o
>   CC      authz/pamacct.o
>   CC      block.o
>   CC      blockjob.o
>   CC      job.o
>   CC      qemu-io-cmds.o
>   CC      replication.o
>   CC      block/raw-format.o
>   CC      block/vmdk.o
>   CC      block/vpc.o
>   CC      block/qcow.o
>   CC      block/vdi.o
>   CC      block/cloop.o
>   CC      block/bochs.o
> ^C
> $ make check-tcg
>   BUILD   debian9
>   BUILD   debian-armhf-cross
>   BUILD   TCG tests for arm-softmmu
>   CHECK   debian9
>   CHECK   debian-armhf-cross
>   BUILD   arm guest-tests with docker qemu:debian-armhf-cross
>   RUN     TCG tests for arm-softmmu
>   CHECK   debian9
>   CC      arm-softmmu/gdbstub-xml.o
>   CC      arm-softmmu/target/arm/vfp_helper.o
>   CC      arm-softmmu/target/arm/translate.o
> make[1]: *** No rule to make target '../hw/net/e1000.o', needed by
> 'qemu-system-arm'.  Stop.
> make[1]: *** Waiting for unfinished jobs....
> make: *** [tests/Makefile.include:1073: run-tcg-tests-arm-softmmu] Error 2

I forgot to tell, since I'm using a 4 cores (x2 threads) host CPU, I
added this to my ~/.bash_aliases:

alias make='make -j8 -l7.5'

> Any idea?
> 

