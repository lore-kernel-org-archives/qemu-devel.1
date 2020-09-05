Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC638C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 14:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D053206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 14:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3/PEUhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D053206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEZDn-0005Ks-4a
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 10:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEZDB-0004cQ-L3
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 10:30:37 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:43254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEZD9-0004fd-UD
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 10:30:37 -0400
Received: by mail-ed1-x533.google.com with SMTP id n13so8651351edo.10
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mUx6hmGOhzZUsxiXbe0e4AqLCAV0FaQM4wDy4j4P0aI=;
 b=d3/PEUhx5EdFu0UJMsI+SpBy81WEd95OswsmDsq1u9ez1nC3kFD4K3ekOGH/W2KicG
 PpjvgxKok9HQATOm84UhBlhWFYRyo4rmt9Uo5fTGJMdVgYl1eAIdsThGbztqxikDZ3e3
 pR0/WN4KyciUfn5b8dUAeI0j+mTHv7t5Quqhzasd9jxpaRQX4sntykRM+piuemd7E/zE
 S80DD1Hx9jRo6CqXB/gDO1b9Wu+oB2L+gHIF6rqWvWYs2LnUKCusJNWu81+IAVa1ayFx
 7YPDgjeqoEBQkHa5TZzuR6sjaDDDHkgrUDF8uyzUYbaRE3wyUApD2V3QgaxZ+Bw2KAWA
 NFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mUx6hmGOhzZUsxiXbe0e4AqLCAV0FaQM4wDy4j4P0aI=;
 b=diIrELT6QtiPbg766rzMWtpBIXndFAdln/XQ+kPIOnyBQHwcAy+C7hUf9jezaweH6j
 r0bkEdOntDaFr4NbTlhvu+rSCLUJgPSVfJc/ouk6UNKmQXjVBG5gDia7qTJjV47Xa9BZ
 gpFhXiKvtAkNRSMeq66Awz9eV2JCX6awghGeIDBTBcodO5GRHl3Qt1d9zz6eXitAviVA
 FCODwFkx3bbroWWTL+Y8kHVnB98yLKobphtUxlKzghOfWZaF0vhJSH7piF5jsE/celqi
 mAHZkg7g5e4D0dFhWBNlzPaYAExNFGeumZYPbe/rl99bpRmBErxsMYTfjzxWaxxUiauj
 SY8Q==
X-Gm-Message-State: AOAM53065IjZwnndefn9PkC9eONVcYoNljEHoQJbbXWL/EhNLJZAUlc9
 dZCurTvq1K4IpGwT+gENQF17A/dv9IpvUcA9zIg7+A==
X-Google-Smtp-Source: ABdhPJynSEzmBKaZtarbyXf/JFcNj0iLkiGpFsfRWzM/gagL3fW31xRL1I8cZbVUepfCzUfziL6mVqXZbLwH+ct/yeM=
X-Received: by 2002:a05:6402:1495:: with SMTP id
 e21mr13303235edv.146.1599316234241; 
 Sat, 05 Sep 2020 07:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200903205247.1667472-1-ehabkost@redhat.com>
In-Reply-To: <20200903205247.1667472-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Sep 2020 15:30:23 +0100
Message-ID: <CAFEAcA8jPy1+=12sQ_wGjUUDBd0VxC_dxrCA1B_B_6rK=mA4Mg@mail.gmail.com>
Subject: Re: [PULL 00/27] QOM boilerplate cleanup
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Sep 2020 at 21:52, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 67a7bfe560a1bba59efab085cb3430f45176d382:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09=
> -03' into staging (2020-09-03 16:58:25 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 7fcf3f084f15005dddd2124b7b18de7647e67538:
>
>   tusb6010: Rename TUSB to TUSB6010 (2020-09-03 16:43:49 -0400)
>
> ----------------------------------------------------------------
> QOM boilerplate cleanup
>
> QOM cleanups:
> * Rename QOM macros for consistency between
>   TYPE_* and type checking constants (Eduardo Habkost)
>
> QOM new macros:
> * OBJECT_DECLARE_* and OBJECT_DEFINE_* macros (Daniel P. Berrang=C3=A9)
> * DECLARE_*_CHECKER macros (Eduardo Habkost)
>
> Automated QOM boilerplate changes:
> * Automated changes to use DECLARE_*_CHECKER (Eduardo Habkost
> * Automated changes to use OBJECT_DECLARE* (Eduardo Habkost)

Build failure trying to build the docs:

Running Sphinx v1.6.7
loading pickled environment... done
building [mo]: targets for 0 po files that are out of date
building [html]: targets for 0 source files that are out of date
updating environment: 0 added, 1 changed, 0 removed
reading sources... [100%] memory

/home/petmay01/linaro/qemu-for-merges/docs/../include/exec/memory.h:353:
warning: Function parameter or member 'parent_class' not described in
'IOMMUMemoryRegionClass'
/home/petmay01/linaro/qemu-for-merges/docs/../include/exec/memory.h:353:
warning: Function parameter or member 'translate' not described in
'IOMMUMemoryRegionClass'
/home/petmay01/linaro/qemu-for-merges/docs/../include/exec/memory.h:353:
warning: Function parameter or member 'get_min_page_size' not
described in 'IOMMUMemoryRegionClass'
/home/petmay01/linaro/qemu-for-merges/docs/../include/exec/memory.h:353:
warning: Function parameter or member 'notify_flag_changed' not
described in 'IOMMUMemoryRegionClass'
/home/petmay01/linaro/qemu-for-merges/docs/../include/exec/memory.h:353:
warning: Function parameter or member 'replay' not described in
'IOMMUMemoryRegionClass'
/home/petmay01/linaro/qemu-for-merges/docs/../include/exec/memory.h:353:
warning: Function parameter or member 'get_attr' not described in
'IOMMUMemoryRegionClass'
/home/petmay01/linaro/qemu-for-merges/docs/../include/exec/memory.h:353:
warning: Function parameter or member 'attrs_to_index' not described
in 'IOMMUMemoryRegionClass'
/home/petmay01/linaro/qemu-for-merges/docs/../include/exec/memory.h:353:
warning: Function parameter or member 'num_indexes' not described in
'IOMMUMemoryRegionClass'

Warning, treated as error:
/home/petmay01/linaro/qemu-for-merges/docs/../include/exec/memory.h:231:Unexpected
indentation.
Makefile.ninja:8771: recipe for target 'docs/devel.stamp' failed
make: *** [docs/devel.stamp] Error 1

thanks
-- PMM

