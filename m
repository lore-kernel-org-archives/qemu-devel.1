Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D92C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91474218B8
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91474218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hptcW-0003kG-Q4
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 08:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36613)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hptcM-0003GZ-3u
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hptcL-0004F1-6H
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:10:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hptcL-0004EZ-0R
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:10:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so42928958wrr.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 05:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Fs+L3zQ36qNQqurrKY8Sw6wxRxzt6se4+Z7sHZi4OM=;
 b=EdNrikhIklkXOUkUuZKXQC5/yTA1s0c5uNy69nXFmZMAdw3VJgmwVsp2tvVV24Y/Fo
 H7WGaPoGl4Rx1FJ+i8Ff+jpjE3LhJiZ7XzQBZnYTXgIq5chSOYXJc91OPJUzt9oS77jW
 nhyqCMgwZmVWJa2JSuMq2xIFL6TZ1GuZicdUDxHWhkFAnS1TlPdog3QXKIzh3lzmnTYX
 bpFdWF2kj9Dm98mftLjz8LzgSGkI35bI4UQCM4O5a0tTH9vue+Uwlq2tfQ63ALWF/Nyq
 QCluTkIZCCm/ovAqa/wk5qX5/4HWpShcBdQbIXYcORc+7rxqABzAHw7nt3q7ZjCXqG/5
 U9AQ==
X-Gm-Message-State: APjAAAWoUskVgGusyVCBzHTFiN5orYXyAcboDCdhWhOuwOFGpoqCW9e8
 h6yG3cEnrsRmxGk8Q8mzVLtfuQ==
X-Google-Smtp-Source: APXvYqzb8b9nD5hlHPjnkzQMKwZEHF8/5qoICM9Wcbu19tjOLPD1rXqOXKWE9txEFPyBK/sNBLHSaA==
X-Received: by 2002:a05:6000:4b:: with SMTP id
 k11mr78311930wrx.82.1563883803965; 
 Tue, 23 Jul 2019 05:10:03 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id e3sm38653999wrt.93.2019.07.23.05.10.03
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 05:10:03 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190723120804.29565-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <56e9a1bd-33f5-ce22-1aef-bbd49e4252ed@redhat.com>
Date: Tue, 23 Jul 2019 14:10:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190723120804.29565-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] docs: correct kconfig option
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/19 2:08 PM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/kconfig.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
> index d6f8eb0977..b7bca44704 100644
> --- a/docs/devel/kconfig.rst
> +++ b/docs/devel/kconfig.rst
> @@ -267,7 +267,7 @@ the default configuration by uncommenting lines in the first group,
>  or commenting out lines in the second group.
>  
>  It is also possible to run QEMU's configure script with the
> -``--with-default-devices`` option.  When this is done, everything defaults
> +``--without-default-devices`` option.  When this is done, everything defaults
>  to ``n`` unless it is ``select``ed or explicitly switched on in the
>  ``.mak`` files.  In other words, ``default`` and ``imply`` directives
>  are disabled.  When QEMU is built with this option, the user will probably
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

