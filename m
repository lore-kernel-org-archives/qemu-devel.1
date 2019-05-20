Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8127C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB8620644
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB8620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSgTo-0008JT-W9
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 07:29:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSgSt-0007ul-PU
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSgSs-0001Qn-RS
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:28:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSgSs-0001QH-Kc
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:28:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so12235119wmk.4
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 04:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8ID+Crhd01CRfQKaPeYbUbIbIdZ0sDX8xr2rkZFWDJU=;
	b=sGE0zpJMw/OlT9fWnwgADSGgrcHqqf8dl4tQWpbKT1CeCZLJFxx7QaF+oMjkoeoJb5
	51OFnqDyViaThiccdaKc+izgxu3A1sRpUx59f8EFBPga6E2sBTlVKYKK+x60xomuDeWL
	t1LFi+b8G0k0jIjKdhfr/x54ZHjQWkwU50byEbmVy6qxhOlCynhZWtQ69ln4ehfw3/W6
	RWdjan95zczYD+1jWaaGcixUlcKk4oNTdCU19ih3N5tIYHYDeJpGwP4d9D5RVCN0+aM3
	vvTwef3O8wV3OlvMM2DVJUnfMoXpX4mEG//J96JVRDM6dYTaRdY3wnuyBWKl60bsfhVB
	4Rwg==
X-Gm-Message-State: APjAAAVaihlyYc3kEyc7HXVPoH1CboZfFcMExLPPu8rC2UrBHbtORpL/
	fcTrKrHvPBsAgMDEQEK0IaSawg==
X-Google-Smtp-Source: APXvYqwmTwziUj7UzdlWSdoUPRzg2U3ZJTd4I3W6+h3pFsRkSHXS4QzUdGgP7oAQUKkQBYzyjwgA2A==
X-Received: by 2002:a1c:98d0:: with SMTP id
	a199mr11001348wme.140.1558351701502; 
	Mon, 20 May 2019 04:28:21 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id 74sm2890335wma.7.2019.05.20.04.28.20
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 04:28:21 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190520081805.15019-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6f4bcfe3-66b6-8c2b-e56b-d90c7c5bcfb1@redhat.com>
Date: Mon, 20 May 2019 13:28:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520081805.15019-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] usb-tablet: fix serial compat property
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
Cc: qemu-stable@nongnu.org, dgilbert@redhat.com,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/19 10:18 AM, Gerd Hoffmann wrote:
> s/kbd/tablet/, fixes cut+paste bug.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/core/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 5d046a43e3d2..eb34f53a85b0 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -36,7 +36,7 @@ GlobalProperty hw_compat_3_1[] = {
>      { "tpm-tis", "ppi", "false" },
>      { "usb-kbd", "serial", "42" },
>      { "usb-mouse", "serial", "42" },
> -    { "usb-kbd", "serial", "42" },
> +    { "usb-tablet", "serial", "42" },

Ah! Now commit b63e10508be makes sense.

Fixes: b63e10508be
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>      { "virtio-blk-device", "discard", "false" },
>      { "virtio-blk-device", "write-zeroes", "false" },
>  };
> 

