Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A54FC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53DD22078C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0/y3czp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DD22078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxRZ-0000NV-ED
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVxQC-00071N-4n
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:15:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21940
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVxQ9-0007sb-TZ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588684536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6A9oexD7VCkOrspxBLYBg9s842fKQg8U+kl1G6xA+zs=;
 b=h0/y3czpu0qsLRZIKtYzgi7lAhzjawGIf3jD1fE+Y1hsLXMvF31w5PS+XlVr+NaoPbiT2r
 fn/tYzAuuiIxW+QXVGqFCBQ5pG8QqC+KZ2gz828s10d71pnK8CZssEX6qsPNKpOE4JHmcL
 Bycm9L89Oymw2JfB9NFy+YAcih9hoWA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-27Jk5iOHN7Wa8HL3K-5C1w-1; Tue, 05 May 2020 09:15:22 -0400
X-MC-Unique: 27Jk5iOHN7Wa8HL3K-5C1w-1
Received: by mail-wr1-f71.google.com with SMTP id s11so1181598wru.6
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6A9oexD7VCkOrspxBLYBg9s842fKQg8U+kl1G6xA+zs=;
 b=m4nghE7dgglEpuIWF8BEC3TDIQGouQQj4vXVcwxM0pIaN3wmHPo4M+iY11w9b90AuM
 b/djA5b2352CgGXvNN3lMwdOtw/3DA5L+WFCSnqZU1m3eFTFRIsle7f5ztx9rAI/0vTp
 PMzAt7zCs3cUoPgW2PzrF0W0JOoQWbJlLqA/tlYVdGL3pnFSzQYQNkxpfVKF459Ljtme
 bMIBmIp9awyOXaoDbnwqsbQYOCrDuIu2YZPAreAlttvLgWdUjBsyTBlbyTv9lRoB+nr8
 CymXvoq7XWS1l9VVJk21627mQPVzjHUf9ridu/A+XDu+fxYVbFw4rNytvUoCMtnHKgAa
 gtUw==
X-Gm-Message-State: AGi0PubX5Uz83zlecnfamxvbXnMxBJPMpXNsBoioyxmIP3AbBYYWEd+/
 TUE8yOELnqCneFyruslIa2KCN3w6dL9WFKdKDrL7lkVyQP8yfumRwUKQ55/J6JOlWzq8LM1r3r5
 EKieJnwy2dd7T8g0=
X-Received: by 2002:a05:600c:4112:: with SMTP id
 j18mr3229004wmi.69.1588684520997; 
 Tue, 05 May 2020 06:15:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypLRUT7xEgdOK6a6FdbunAaYVsKo4mnoJ/L6dEhasNj5DSJ68nfKfLboDWC/9I2e/ytDOewX4Q==
X-Received: by 2002:a05:600c:4112:: with SMTP id
 j18mr3228966wmi.69.1588684520730; 
 Tue, 05 May 2020 06:15:20 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id k6sm4047100wma.19.2020.05.05.06.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 06:15:20 -0700 (PDT)
Subject: Re: [PATCH 0/4] Add support for SafeStack
To: Daniele Buono <dbuono@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <51f28cf2-0f34-508f-96f8-02c02b3c8a85@redhat.com>
Date: Tue, 5 May 2020 15:15:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Alex & Daniel who keep track on CI stuff.

On 4/29/20 9:44 PM, Daniele Buono wrote:
> LLVM supports SafeStack instrumentation to protect against stack buffer
> overflows, since version 3.7
> 
>  From https://clang.llvm.org/docs/SafeStack.html:
> "It works by separating the program stack into two distinct regions: the
> safe stack and the unsafe stack. The safe stack stores return addresses,
> register spills, and local variables that are always accessed in a safe
> way, while the unsafe stack stores everything else. This separation
> ensures that buffer overflows on the unsafe stack cannot be used to
> overwrite anything on the safe stack."
> 
> Unfortunately, the use of two stack regions does not cope well with
> QEMU's coroutines. The second stack region is not properly set up with
> both ucontext and sigaltstack, so multiple coroutines end up sharing the
> same memory area for the unsafe stack, causing undefined behaviors at
> runtime (and most iochecks to fail).
> 
> This patch series fixes the implementation of the ucontext backend and
> make sure that sigaltstack is never used if the compiler is applying
> the SafeStack instrumentation. It also adds a configure flag to enable
> SafeStack, and enables iotests when SafeStack is used.
> 
> This is an RFC mainly because of the low-level use of the SafeStack
> runtime.
> When running swapcontext(), we have to manually set the unsafe stack
> pointer to the new area allocated for the coroutine. LLVM does not allow
> this by using builtin, so we have to use implementation details that may
> change in the future.
> This patch has been tested briefly ( make check on an x86 system ) with
> clang v3.9, v4.0, v5.0, v6.0
> Heavier testing, with make check-acceptance has been performed with
> clang v7.0

I noticed building using SafeStack is slower, and running with it is 
even sloooower. It makes sense to have this integrated if we use it 
regularly. Do you have plan for this? Using public CI doesn't seem 
reasonable.

> 
> Daniele Buono (4):
>    coroutine: support SafeStack in ucontext backend
>    coroutine: Add check for SafeStack in sigalstack
>    configure: add flag to enable SafeStack
>    check-block: Enable iotests with SafeStack
> 
>   configure                    | 29 +++++++++++++++++++++++++++++
>   include/qemu/coroutine_int.h |  6 ++++++
>   tests/check-block.sh         | 12 +++++++++++-
>   util/coroutine-sigaltstack.c |  4 ++++
>   util/coroutine-ucontext.c    | 25 +++++++++++++++++++++++++
>   5 files changed, 75 insertions(+), 1 deletion(-)
> 


