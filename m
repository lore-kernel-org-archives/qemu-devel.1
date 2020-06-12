Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9AFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA0B207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA0B207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfni-0000zh-32
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 05:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jjfmv-0008Ip-AA; Fri, 12 Jun 2020 05:15:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:49171)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jjfms-0002aH-Mt; Fri, 12 Jun 2020 05:15:49 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MY6TD-1jQgXw0WGT-00YV5G; Fri, 12 Jun 2020 11:15:41 +0200
Subject: Re: [PATCH 1/1] util/getauxval: Porting to FreeBSD getauxval feature
To: David CARLIER <devnexen@gmail.com>
References: <CA+XhMqwHSBd_TSFqipO6bn=hVSV8+Mdm3y=_i6gQoGBxRsjS0g@mail.gmail.com>
 <e7df4877-7700-ea36-ceb0-3bf84fec8df8@vivier.eu>
 <CA+XhMqxTU6PUSQBpbA9VrS1QZfqgrCAKUCtUF-x2aF=fCMTDOw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <19aba519-8174-8951-a712-d970239d04f1@vivier.eu>
Date: Fri, 12 Jun 2020 11:15:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CA+XhMqxTU6PUSQBpbA9VrS1QZfqgrCAKUCtUF-x2aF=fCMTDOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7fj7LSbFdH8WSWBr/Ch6Hp9e2AGODhB8Ka12VFJaXKaRQRtitQd
 Sl20D/0Xt4b0Hr4Js96jKzkTsNntAI8+22w1x+OFGP2zo6qzp7xwsqLKQq26XleuUzHEZ9k
 kPTx+x3ROHhjZN7Hbb6TaHgJ/qMf4iZDguWs1hfyBaYrWXf0WEg4SomfNcgFvtlCnzdcbv6
 9A7CdjeM2zdicPjrV8+xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nbJ8NaNbPes=:JfOzC3+2MNvyBG5CpJOcfE
 Z0zJhC90X34Ikg/n0u1Y8tds5gUoK/ul6gFMNojF9iGQElSIMTIX7TyHj7hmIKKiUizrQGO9h
 jDPqjsXPAC7ahgc/HA3RE2KTR68PQhCNnlXaZb5sxIxr/VbCi4l+k2qQZXlyvOvCphQOaX3B7
 QWYq8lcI9mZNt9wwiNezfLaaQgg6EhheBNSFrxZlP+p4NuyfvEEr0qGX7sS4lYJmlsc1SJkIm
 oF+Kvqr7L8aijREy2YaCW+so3pAJZe06WHhDC6wKaAT/US7F8R0Q/Yy3ejIngBGpqwubMgq6U
 Po3BJRta+UM4jceaUHgE7UdtRSQnjdMAffYTIrHwYxflm7mTLi33EKh/qNcBmOO5Q7J1MAQSE
 pt9nT3C5OgXpTgTiwf84dJ5THJb0SBPKclpSbRiN1lFg8gxybmYtUZpDX02fF+U+ARfTyLYh/
 2Xce2WFZzR7px1wtELwjK5Yzb9+dqVSxQt6kP/1wSKJQO73cPwjlnIqDlKnA/rblV8AwtRKyB
 0ZiJaUOb2pPEGfFj3p5cnxkDmgzqWp6PN9yRzsJ+DYsIVBCacDnrQ3Krs+XqaiiVAtiRTcvEI
 hA+1bev3TmMWIwNoMVYqqK+9Ot3F/P9jlCtIEq8Lg31LDjYzO+aX/jt/0Uc0pSEB/E7pyrUW9
 TS3avsXrVdQevDMVXS6hFAEZ5DNuP4WxqUGzTl/2VWLrnj91K/5HgVudjMg/mWYFR7LE33CvG
 caDBZ2kK6EhaWf93pj3QyXqBBlAqaGnLZc4KCNR1V24BSU3vtrZHEDuBkuHMiKn8udOvjUC2i
 Pw64i6Wh1AkdcW8HV5EzUnmfRa/6uiOPSzGWSxhncx1AX+zuE6ub+HF3nt6mPQu643NYsdr
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 05:15:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/06/2020 à 10:46, David CARLIER a écrit :
> From d7f9d40777d1ed7c9450b0be4f957da2993dfc72 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Fri, 12 Jun 2020 09:39:17 +0100
> Subject: [PATCH] util/getauxval: Porting to FreeBSD getauxval feature
> 
> FreeBSD has a similar API for auxiliary vector.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  util/getauxval.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/util/getauxval.c b/util/getauxval.c
> index 36afdfb9e6..b124107d61 100644
> --- a/util/getauxval.c
> +++ b/util/getauxval.c
> @@ -98,6 +98,16 @@ unsigned long qemu_getauxval(unsigned long type)
>      return 0;
>  }
> 
> +#elif defined(__FreeBSD__)
> +#include <sys/auxv.h>
> +
> +unsigned long qemu_getauxval(unsigned long type)
> +{
> +    unsigned long aux = 0;
> +    elf_aux_info(type, &aux, sizeof(aux));
> +    return aux;
> +}
> +
>  #else
> 
>  unsigned long qemu_getauxval(unsigned long type)
> 

When you send a new version of a patch, add the version number in the
subject ("[PATCH v2]") and don't reply to the previous one.

https://wiki.qemu.org/Contribute/SubmitAPatch#When_resending_patches_add_a_version_tag

Anyway:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

