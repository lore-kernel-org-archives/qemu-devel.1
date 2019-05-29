Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B1CC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A487920644
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A487920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVxKr-00079I-R6
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 08:05:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVxK2-0006nq-P1
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVxK1-00058t-Kc
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:04:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVxK1-000588-FX
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:04:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so1435001wmi.0
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 05:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=L6GQImMVJUIOaAMLIb8/JtGAjfJQhuKpHGjjSzHqijo=;
	b=lkjKnoF1J+d2sqYLc6o3/3gLLSUZnTHLDFKEWH7zLNmty9BxEPrFeteAXt/xMlPt3v
	80NpHrS4LVxKDF95akGx0VZTHXLle+Sv5KbxObL5lGm9TtJqbjokcHs63sT6oIrf65V0
	Sw4L35+ttpZO+GFA3KircxALGmVy6wC9saaeeZPNiE6icJ+ITY6HXPGuxn2MWj+PLyOa
	ywl+DcRl/HIJTfnh/ZxVuwdEcFKA95QdwWdwgbDcT+WhBb0whstJ0KxQ5DlvV8b79XpU
	qaA4Zk3kUAJ3Jwo8Ebxn4XaOlOkPONcyeVe8OQujhy2tj3fi3yz8aClcP5Q6liPHdL6x
	Op5w==
X-Gm-Message-State: APjAAAWMp9DFblvAQgbSRKNOtpsKgEMQjNgr2REwi1vq0NTvmKG8Iv8N
	FvKgss0kcdVHnN+5SoX6cgzfhA==
X-Google-Smtp-Source: APXvYqz+Lrw0+kBSfcQooqUULaSOq7i10U5uldOnJgtxr11llR3l+bCW9Yz/OH9eJMSZ7v/gohQJUw==
X-Received: by 2002:a7b:cc72:: with SMTP id n18mr6885368wmj.129.1559131484405; 
	Wed, 29 May 2019 05:04:44 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	o21sm5752174wmc.46.2019.05.29.05.04.43
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 05:04:43 -0700 (PDT)
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2859970f-a68a-08eb-b148-76bc8866d3c3@redhat.com>
Date: Wed, 29 May 2019 14:04:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Change maintership of Xen
 code under hw/9pfs
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Paul Durrant <paul.durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/19 12:24 PM, Greg Kurz wrote:
> Xen folks are the actual maintainers for this.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  MAINTAINERS |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f5f8b7a2c37..d00380641796 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -411,7 +411,7 @@ M: Paul Durrant <paul.durrant@citrix.com>
>  L: xen-devel@lists.xenproject.org
>  S: Supported
>  F: */xen*
> -F: hw/9pfs/xen-9p-backend.c
> +F: hw/9pfs/xen-9p*
>  F: hw/char/xen_console.c
>  F: hw/display/xenfb.c
>  F: hw/net/xen_nic.c
> @@ -1505,6 +1505,7 @@ virtio-9p
>  M: Greg Kurz <groug@kaod.org>
>  S: Supported
>  F: hw/9pfs/
> +X: hw/9pfs/xen-9p*
>  F: fsdev/
>  F: tests/virtio-9p-test.c
>  T: git https://github.com/gkurz/qemu.git 9p-next
> 
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

