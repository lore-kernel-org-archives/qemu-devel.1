Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50852C742D1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FF820665
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FF820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzQZ-0004OL-An
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38757)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlzQI-0003Wd-F4
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlzQH-0000GQ-E1
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:33:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlzQH-0000F7-7r
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:33:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so9667051wmg.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e+dXWq3ONmkFK+P7ld8FJJL5tnEMaftOWkJk0k1k+dw=;
 b=CBGFZv2mojx/KnKnWGQ55QEq60J5VSUW6H2kqT3jI/ARnMpM/3bO7CeuKCW9rTZUhC
 MWU+Yh7NQxd+UHuYNfpEHo+Ja2cnPxY85Z56wXV0z+g3fNYFVdRudI0kBIbvU3RgZu0Y
 Plr1s1hjQnr/Z+GvYBoyaL12S20p3gYIFYN23zUvtvMxKTKfcBgiYn7OsPVTGsynOqVx
 s/pOGePn5OQPACPv7nGuZCl0VepNAfVrA5i/ikirzQpQJ0ujuZPI1BtfXhzhJyFtzv6i
 g3aF5JThkbV94VsDV954xPOb9O5eXGDliMwcsDdvDFhNrRNAMwt9/OgMbtsdjTJU3jSU
 4CuQ==
X-Gm-Message-State: APjAAAXPKguS92RUay3O+WTtxbLQ8YG50Z3GCB6Bw1Dtx4TXqJwulPiP
 2iVDWzOlsEvFSCdszILc4wjXjv3q74Q=
X-Google-Smtp-Source: APXvYqz6plDFuXfKLLAC+rWqblgDImlYy3FATHK0O2nuIvcyNBR30yMfnFCzHE/oX+TUTIWulZqo9Q==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr8055986wmk.147.1562952808009; 
 Fri, 12 Jul 2019 10:33:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id b8sm8401535wrr.43.2019.07.12.10.33.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:33:27 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190712172743.17632-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b9d161b3-aee2-254f-b1cc-db1b72411ea3@redhat.com>
Date: Fri, 12 Jul 2019 19:33:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712172743.17632-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] build-sys: remove slirp cflags from
 main-loop.o
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

On 12/07/19 19:27, Marc-André Lureau wrote:
> Left over from c2d63650d962612cfa1b21302782d4cd12142c74.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  util/Makefile.objs | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 38178201ff..68af3cd5e9 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -3,7 +3,6 @@ util-obj-y += bufferiszero.o
>  util-obj-y += lockcnt.o
>  util-obj-y += aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
>  util-obj-y += main-loop.o iohandler.o
> -main-loop.o-cflags := $(SLIRP_CFLAGS)
>  util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
>  util-obj-$(CONFIG_POSIX) += aio-posix.o
>  util-obj-$(CONFIG_POSIX) += compatfd.o
> 

Queued, thanks.

Paolo

