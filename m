Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4875AC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197B422B47
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oe6A92mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197B422B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBD6W-0002lQ-Ad
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBD5Z-0001WS-Ol
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:16:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBD5V-0003g3-Vt
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598516205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhHT6xbFzLQppajI/CTroeGcSwFpHPnZ0hv5Me43Rxw=;
 b=Oe6A92mF4wTZBS//7V4nutfN/+Md1xThVXxDbr/jIPmrPYn59OJeHXpfM5Z6DGmXPbWox7
 Ey5bUgM8jikPxDIK+H+CSD0DKGLcBCD7Jk2K+tI0Gy4C0K9kw/FFlEgILanbJD2A5WeJcw
 nlfbuRd+emkJGNaTJ6C2I0/HA4KR/yI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-xBY8GAAKPRWYDfgwSkQuCw-1; Thu, 27 Aug 2020 04:16:39 -0400
X-MC-Unique: xBY8GAAKPRWYDfgwSkQuCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BA57E75D;
 Thu, 27 Aug 2020 08:16:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 774365C1C2;
 Thu, 27 Aug 2020 08:16:34 +0000 (UTC)
Subject: Re: Meson build on macOS: undefined symbol treatment
To: Emmanuel Blot <eblot.ml@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <E79B1486-1C3C-4271-9B76-62B2C4B8BCA7@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <24ac4d35-ff2b-4381-ab1b-1a8f31ba36fb@redhat.com>
Date: Thu, 27 Aug 2020 10:16:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <E79B1486-1C3C-4271-9B76-62B2C4B8BCA7@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/08/2020 15.11, Emmanuel Blot wrote:
> Hi,
> 
> I’ve noticed that since meson builds have been enabled, on macOS, the
> build outcome with undefined symbols has changed:
> 
> - prior to meson introduction (v5.1.0):
>   * referencing an undeclared symbol in source code led to a warning at
> compile stage
>   * referencing an undeclared symbol at link stage led to a fatal build
> error (as usually expected)
> 
> - since meson introduction
>   * same behavior at compile stage
>   * however, the linker does silently generate an application - which
> fails at launch since the symbol is undefined.
> 
> Step to reproduce:
> 
>   from softmmu/main.c, replace for example call to qemu_init() with
> qemu_init2();
> 
> - v5.1.0:
>   softmmu/main.c:48:5: warning: implicit declaration of function
> 'qemu_init2' is invalid in C99 [-Wimplicit-function-declaration]
>     qemu_init2(argc, argv, envp);
>       LINK    riscv64-softmmu/qemu-system-riscv64
>   Undefined symbols for architecture x86_64:
>     "_qemu_init2", referenced from:
>         _qemu_main in main.o
>   ld: symbol(s) not found for architecture x86_64
>   clang: error: linker command failed with exit code 1 (use -v to see
> invocation)
>   make[1]: *** [qemu-system-riscv64] Error 1
> 
> - current master:
>   softmmu/main.c:49:5: warning: implicit declaration of function
> 'qemu_init2' is invalid in C99 [-Wimplicit-function-declaration]
>     qemu_init2(argc, argv, envp);
>     ^
>   1 warning generated.
>   [3/3] Linking target qemu-system-riscv64
> 
>  > riscv64-softmmu/qemu-system-riscv64
>   dyld: lazy symbol binding failed: Symbol not found: _qemu_init2
>     Referenced from:
> /Users/eblot/Sources/Git/github.com/QEMU/upstream/build/riscv64-softmmu/qemu-system-riscv64
> 
>     Expected in: flat namespace
> 
>     'riscv64-softmmu/qemu-system-ris…' terminated by signal SIGABRT (Abort)
> 
> 
> This new behavior is likely to come from the linker flag:
> 
>    -Wl,-undefined,dynamic_lookup
> 
> I’m not sure whether it is a new feature or a bug, but if the former
> stands true, is there a way to disable this feature?

Seems like this is added by meson itself (see
meson/mesonbuild/linkers.py), not by our meson.build files ... Paolo,
any idea why this happens?

 Thomas



