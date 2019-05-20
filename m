Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6678C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5A3206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5A3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSfzo-0000lO-H3
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 06:58:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSfyx-0000UY-Sa
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSfyx-0006pj-0E
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:57:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSfyw-0006i8-QS
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:57:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id w13so3311887wru.11
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 03:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vCEMYlMqxnsCTxUKBdq4/nOne+VCV6vL2W9JlQp9Bho=;
	b=WenaBaz/o6lt2wePvdPiNODjGvxX+vXu3KzRidzI7Nluhrs0agh8KyUA1g+rnbYO7V
	eBx28vHor9A4pA66Yo1VIGS0BGB8SmZVWJnNPW/wZyNnDsti1dkmwjAAJH35Mj1yM6vv
	eRk1sVztOLZNksknpvHU9mOQf5cOh7LduTST8/0HQl/ZtKLirSGxbT49ZdZx1ZcYGjUr
	kaOR5lC2n5fKLVI7Oo88CR+Up9alkNUEVgNbOalW/DNZ0nPgm8NlGtLIbOpQfW4KcTZa
	SjXjD0vKsQqZ6ejCdvJhIyGbb1pWK4L6MrJ04Wh7JjhlSqLBFzavKePxByTGtMwarSyc
	Qgaw==
X-Gm-Message-State: APjAAAW66g492Nqm6jM89czHoOQpJASZefqmFdldROMUpOxXclU0j6Xj
	9VtPPq24rnhGCCZP78pgTQIBsQ==
X-Google-Smtp-Source: APXvYqyh1vZr2gWONJigtwcychXBgK3fHD0dKBM/dBuk2Uk5XBpv0fL64jvPOx8sk6n2apnkwi96EA==
X-Received: by 2002:adf:e70f:: with SMTP id c15mr29253614wrm.311.1558349841754;
	Mon, 20 May 2019 03:57:21 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	x68sm13968552wmf.13.2019.05.20.03.57.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 03:57:21 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190517133149.19593-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1977c2b8-d950-9272-a56b-6d9a737536db@redhat.com>
Date: Mon, 20 May 2019 12:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517133149.19593-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Add pseudo /proc/hardware and
 /proc/cpuinfo
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 3:31 PM, Laurent Vivier wrote:
> They are used by some package setup scripts to set the default configuration.
> 
> v2: rebase
> 
> Laurent Vivier (2):
>   linux-user: add pseudo /proc/cpuinfo for sparc
>   linux-user: add pseudo /proc/hardware for m68k
> 
>  linux-user/syscall.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

