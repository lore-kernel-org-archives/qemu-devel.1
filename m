Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE10C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32DE2089E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32DE2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7FI-0006JZ-7t
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53037)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw7ES-0005jP-4V
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw7ER-0007vq-1d
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:55:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw7EQ-0007vS-Rs
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:55:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id k2so12844744wrq.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bjHtJqzKgHsQ9Ob1fbe39AeDGoVz5PdL9eW6CHRMggg=;
 b=LdIbTaDE+8OjG99tho6APq4BBvOjK0uDxpDOfosXNnn1h/ZNQZyWhCztDq2HbPb9Xo
 JIth1W+TFK4vJN5tBtkYlkwgejL8YHmMsXdc8NGXYgIn1HxEMnbRgEFCZrCMey+pJ/Oe
 VXiOY7AoqBF7yN0RN3hcQ/bePjsZ7A1DhWxionALC/8/JTiarUkobgKZBXcQq2wa/ayF
 y4aFmM8iWzex15tfruy36IZJ3DRfrsqwW3U82NgIpGz2fuv4CB7d1OuuePonniNt2w2Q
 zYzw3fqLVqXnBJ13UWSlgovsHYcfG8+9zW7bwW9uuuxdQ82rcSJhfw0rgplpS56mFVb0
 SyCA==
X-Gm-Message-State: APjAAAWSge+6VTdH6KOnef6xk/BhoMl8d6EUJ3aDPYrhbalQ2sCzBanq
 1gD/f+bIV/iJH6JfOLkBj4mKPA==
X-Google-Smtp-Source: APXvYqyKFSJYYLKI+0DkJu2uDFl/BHuZ2y0BUW7ljf4pLU7uYxjendWkHt9cUNRyik126KwFpw5x1w==
X-Received: by 2002:a5d:6901:: with SMTP id t1mr4564977wru.45.1565366105887;
 Fri, 09 Aug 2019 08:55:05 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id a11sm661099wrx.59.2019.08.09.08.55.05
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 08:55:05 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190809155047.24526-1-alex.bennee@linaro.org>
 <20190809155047.24526-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <58800f80-5508-f75b-bc3a-36c36e2e0a16@redhat.com>
Date: Fri, 9 Aug 2019 17:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809155047.24526-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v1 1/2] tests/docker: move DEF_TARGET_LIST
 setting to common.rc
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
Cc: Fam Zheng <fam@euphon.net>, armbru@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 5:50 PM, Alex Bennée wrote:
> We might as well not repeat ourselves. At the same time allow it to be
> overridden which we will use later from docker targets.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/docker/common.rc  | 4 ++++
>  tests/docker/test-build | 1 -
>  tests/docker/test-mingw | 1 -
>  tests/docker/test-quick | 1 -
>  4 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 4011561587a..512202b0a19 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -11,6 +11,10 @@
>  # or (at your option) any later version. See the COPYING file in
>  # the top-level directory.
>  
> +# This might be set by ENV of a docker container... it is always
> +# overriden by TARGET_LIST if the user sets it.
> +DEF_TARGET_LIST=${DEF_TARGET_LIST:-"x86_64-softmmu,aarch64-softmmu"}
> +
>  requires()
>  {
>      for c in $@; do
> diff --git a/tests/docker/test-build b/tests/docker/test-build
> index 22766cfacc0..2b2a7832f15 100755
> --- a/tests/docker/test-build
> +++ b/tests/docker/test-build
> @@ -15,7 +15,6 @@
>  
>  cd "$BUILD_DIR"
>  
> -DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
>  TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
>  build_qemu
>  install_qemu
> diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
> index fdb1c2c879d..c30eb654eb7 100755
> --- a/tests/docker/test-mingw
> +++ b/tests/docker/test-mingw
> @@ -16,7 +16,6 @@
>  requires mingw dtc
>  
>  cd "$BUILD_DIR"
> -DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
>  
>  for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
>      TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
> diff --git a/tests/docker/test-quick b/tests/docker/test-quick
> index eee59c55fba..feee44b2476 100755
> --- a/tests/docker/test-quick
> +++ b/tests/docker/test-quick
> @@ -15,7 +15,6 @@
>  
>  cd "$BUILD_DIR"
>  
> -DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
>  TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
>  build_qemu
>  check_qemu
> 

