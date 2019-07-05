Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360CDC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 12:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5E621850
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 12:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5E621850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjNSU-0000ty-Oj
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 08:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54106)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjNOC-0008FL-PG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjNO9-0006j6-IY
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:32:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjNO9-0006eX-AI
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:32:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so9754731wrm.8
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 05:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EPs6pnCG+3EGoIiNOTse+98zx5zAH0i5xLUtSjPQv0s=;
 b=iG0oPpbCwvGWrR9J17n6YPhomBWF7rF4shdFghoG5MG5UvI6NI+Jt4u5tHoueECOld
 /3Z5+FUL10edWY6XBjHHUuMRj8LEsD/YYP7kHr9CPC1R8UcW8R827vzgyDHvfuOu/hMe
 rGmYrsiS7algtxlRa54/IkKpuPx++VQAlloO7YW/DX3UJqMBskiXlSJWpW1rwIR2LoSq
 /RmyTIFNTRiYZLnZOcIAjGneLJQ4QYEJ54SBDKH01/Npa4q+rLn1hNhCixoAXQkZ9yiX
 vqsH9R18I36txX0RMv+UusblhQG9MbySPGW4mI27XXFqQhWWtH6v3OFmFDdHEIFXh19w
 uffg==
X-Gm-Message-State: APjAAAWZaYmlEUqb60eUtkEQ2pt5ceSmH1L9cqEJFcxM1MvFOppkJF6d
 sjeZbfOy0VZwTKBLKFc/HK6d6A==
X-Google-Smtp-Source: APXvYqy5fCzD+An/9hkm9j5DQ3KxPG9eloj+dLIetGtnGzWAhqIbh+cp1tiNF5mlj7bu27mTTH1o3Q==
X-Received: by 2002:adf:aad1:: with SMTP id i17mr4279502wrc.63.1562329948001; 
 Fri, 05 Jul 2019 05:32:28 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id h19sm19519148wrb.81.2019.07.05.05.32.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 05:32:27 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190702113414.6896-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <89290c81-ea80-a84d-fced-86764cab23ff@redhat.com>
Date: Fri, 5 Jul 2019 14:32:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190702113414.6896-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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

Hi Markus,

On 7/2/19 1:34 PM, Markus Armbruster wrote:
> The following changes since commit ab200dafc0e8a9925bb0ad0be478621f5f117c95:
> 
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-07-02 10:17:54 +0100)
> 
> are available in the Git repository at:
> 
>   git://repo.or.cz/qemu/armbru.git tags/pull-build-2019-07-02
> 
> for you to fetch changes up to b7f9b1b7fc9a00ab6e5f46555e87166533292576:
> 
>   Makefile: Reuse all's recursion machinery for clean and install (2019-07-02 12:48:40 +0200)
> 
> ----------------------------------------------------------------
> Build system patches for 2019-07-02
> 
> ----------------------------------------------------------------
> Markus Armbruster (4):
>       Makefile: Remove code to smooth transition to config.status
>       Makefile: Drop bogus cleaning of $(ALL_SUBDIRS)/qemu-options.def
>       Makefile: Rename targets for make recursion
>       Makefile: Reuse all's recursion machinery for clean and install

I wonder if some rule is missing, I did:

$ mkdir build
$ cd build
$ ../configure --python=python3 \
  --disable-tools \
  --enable-trace-backends=log \
  --extra-cflags=-ggdb --enable-debug \
  --target-list=arm-softmmu
$ make check-tcg
[...]
  CC      arm-softmmu/target/arm/iwmmxt_helper.o
  CC      arm-softmmu/target/arm/vec_helper.o
  CC      arm-softmmu/target/arm/neon_helper.o
  CC      arm-softmmu/target/arm/m_helper.o
  CC      arm-softmmu/target/arm/psci.o
  GEN     trace/generated-helpers.c
make[1]: *** No rule to make target '../blockdev.o', needed by
'qemu-system-arm'.  Stop.
make[1]: *** Waiting for unfinished jobs....
  CC      arm-softmmu/trace/control-target.o
make: *** [tests/Makefile.include:1073: run-tcg-tests-arm-softmmu] Error 2
$ make arm-softmmu/all
  CC      authz/base.o
  CC      authz/simple.o
  CC      authz/list.o
  CC      authz/listfile.o
  CC      authz/pamacct.o
  CC      block.o
  CC      blockjob.o
  CC      job.o
  CC      qemu-io-cmds.o
  CC      replication.o
  CC      block/raw-format.o
  CC      block/vmdk.o
  CC      block/vpc.o
  CC      block/qcow.o
  CC      block/vdi.o
  CC      block/cloop.o
  CC      block/bochs.o
^C
$ make check-tcg
  BUILD   debian9
  BUILD   debian-armhf-cross
  BUILD   TCG tests for arm-softmmu
  CHECK   debian9
  CHECK   debian-armhf-cross
  BUILD   arm guest-tests with docker qemu:debian-armhf-cross
  RUN     TCG tests for arm-softmmu
  CHECK   debian9
  CC      arm-softmmu/gdbstub-xml.o
  CC      arm-softmmu/target/arm/vfp_helper.o
  CC      arm-softmmu/target/arm/translate.o
make[1]: *** No rule to make target '../hw/net/e1000.o', needed by
'qemu-system-arm'.  Stop.
make[1]: *** Waiting for unfinished jobs....
make: *** [tests/Makefile.include:1073: run-tcg-tests-arm-softmmu] Error 2

Any idea?

