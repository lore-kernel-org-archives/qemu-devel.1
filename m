Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF177C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3682067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNU5Z6Fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3682067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4Fx-0003lp-NX
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv4E3-0008W2-UO
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:34:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv4E2-0008OM-D8
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:34:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id r12so17959571wrj.13
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QUwb+CcULRgt01uPt64VbH8CyEQOrMIa4AW37narjiE=;
 b=pNU5Z6Fl5d4ahxswWmANPXs6G2cYqSIcyUw4bSWXvesanwUcRBQ4f2tELfUOsvR+xt
 NZm8V7vziLtkp0C2stBYPmhWqGE6/wp8IeDUsYwSXjYCEB0bAOyv5/cMfUClVdfjXK1V
 Dm0efndLj/q30E3uXliztjsXPTtHpdwCJfslIBfcza6U4qRzY+1Km0ng2+purVltO39R
 zpm5M3flNI0BRXGok7+4ucUc6vPtikAA1D0PFvvds+TTTFGki4LoIQtwyOUiBOScuFET
 RJDz6BeTUWln/Hnn++OiLMn0qB0ybCb0xy2PAdO7mzzovEBwByMzygEkBi5qA1szgGia
 qgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QUwb+CcULRgt01uPt64VbH8CyEQOrMIa4AW37narjiE=;
 b=r8FTqeqIyEbgUMrkgNfmhsQ7riuDZxjwKA7c2hDdcTLMkFvReFEsNlLFsEpbOuW1LE
 UEPdqWBaPeeN7N90cGbj1wiRmzX8R38y0qWh66tnerSfC+dMFiwjEdCtBGhVxWJWYkBE
 89S6lORRQXBJuPEvwHo2pwNPwnSZ7j1RDScx7YJ/oYMBthsFXHK1cpmk9tQkbak6ivH8
 sslai41HPDb+V4nuuKs1uJGR7DU4pwNFAfQ6KMS7V4/tO6BSk8g5ks36qea9JsL160zB
 Vnf2Nq353yln2Zy03Xu+Y/s/SUz2LSsMKddRCWipROz/VIbOOw2MCmxgRohZx+r7G4VC
 t80g==
X-Gm-Message-State: AOAM532XzTCU0esRt5RSE8OB/CXXDzaRoU5IVkoWHclatdC4zXLLfE0w
 pc22q1roCo8WioU4E1wbw0A=
X-Google-Smtp-Source: ABdhPJwhWkr/N5sYj6U3rlddi8r5SqA323iVpNaBit7/JW2ALhLDHI3W4YdhbN0xcCjIkoDU9A07Sw==
X-Received: by 2002:adf:ec42:: with SMTP id w2mr1054684wrn.269.1594668893216; 
 Mon, 13 Jul 2020 12:34:53 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id h13sm810878wml.42.2020.07.13.12.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 12:34:52 -0700 (PDT)
Subject: Re: [RFC PATCH] tests/docker: Remove the libssh workaround from the
 ubuntu 20.04 image
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200713185237.9419-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4fa8d43c-602b-2112-ebd2-63422ab8451e@amsat.org>
Date: Mon, 13 Jul 2020 21:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713185237.9419-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 8:52 PM, Thomas Huth wrote:
> The libssh problem only exists in Ubuntu 18.04 - we can enable it
> in 20.04 again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/docker/dockerfiles/ubuntu2004.docker | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
> index f7aac840bf..8d10934a2a 100644
> --- a/tests/docker/dockerfiles/ubuntu2004.docker
> +++ b/tests/docker/dockerfiles/ubuntu2004.docker
> @@ -65,9 +65,6 @@ RUN apt-get update && \
>  RUN dpkg -l $PACKAGES | sort > /packages.txt
>  ENV FEATURES clang tsan pyyaml sdl2
>  
> -# https://bugs.launchpad.net/qemu/+bug/1838763
> -ENV QEMU_CONFIGURE_OPTS --disable-libssh
> -
>  # Apply patch https://reviews.llvm.org/D75820
>  # This is required for TSan in clang-10 to compile with QEMU.
>  RUN sed -i 's/^const/static const/g' /usr/lib/llvm-10/lib/clang/10.0.0/include/sanitizer/tsan_interface.h
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

