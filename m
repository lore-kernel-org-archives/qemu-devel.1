Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE86C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EB320850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EB320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39601 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEyqo-0001R0-1g
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 12:16:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEypL-0000iR-72
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEypI-0007wH-C8
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:14:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEypD-0007pd-99
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:14:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so11702209wmd.0
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 09:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=1lG74dZjfPjAmL917oQIgO9ITZi8Kx4xQg9IVIwK8XQ=;
	b=EWRa+cy9BAEaFUOuM0Yt9jne+mIN6MShSnp/s1l9C5Ynrt9tnqY41LT5q396V70ARJ
	JAonLQVKnLuWcxxogPijF5UicthnHpJ+1MXXZFxvG4Pkl7h4acjM/VebigyW0UBcs0cW
	DLYChwTSubJJE9of8YfaY/X5M2af2CrqU36IXGzy9hZKnszSdUHmNszLDWMgZhQoNPlR
	/2bj/B/PgUojr9SxD0UlRY82XMU9sn5JI+btwZZu+2ABePlUV1ECmw0rcI+U+Oi5aY4o
	q2zynE3WEQZt3Aggu9C71njt3H77s2cY1IZR9tglHm+sMwgy9pBBWZY+AbUKgRCeXPKK
	6LcA==
X-Gm-Message-State: APjAAAVFZGcBCiIHdMP74Jwwc+7ajgOhR8sR8+V0XDZ7gNwrUF+VKoht
	eKxry4vzsvKZXsZTCa/YdGRljw==
X-Google-Smtp-Source: APXvYqzZevbMPoqino71zCGFQN+jFkjtnNjqbBJJZoBbX4H+sTMPdoO1wOsIHY1eMMuUZFCehQXSYA==
X-Received: by 2002:a1c:7611:: with SMTP id r17mr11545200wmc.98.1555085679782; 
	Fri, 12 Apr 2019 09:14:39 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	61sm136421777wre.50.2019.04.12.09.14.38
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 09:14:39 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org
References: <20190412152713.16018-1-marcandre.lureau@redhat.com>
	<20190412152713.16018-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6cf497b7-ca7f-791b-2975-3cce6f53819d@redhat.com>
Date: Fri, 12 Apr 2019 18:14:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412152713.16018-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: constify VGAInterfaceInfo
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412161438.H4HdFJYMnJ-lmvdY7koZHx5ULPjS8xCV9LhHLJrZsCQ@z>

On 4/12/19 5:27 PM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  vl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index c696ad2a13..0a96232e95 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2026,7 +2026,7 @@ typedef struct VGAInterfaceInfo {
>      const char *class_names[2];
>  } VGAInterfaceInfo;
>  
> -static VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] = {
> +static const VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] = {
>      [VGA_NONE] = {
>          .opt_name = "none",
>      },
> @@ -2072,7 +2072,7 @@ static VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] = {
>  
>  static bool vga_interface_available(VGAInterfaceType t)
>  {
> -    VGAInterfaceInfo *ti = &vga_interfaces[t];
> +    const VGAInterfaceInfo *ti = &vga_interfaces[t];
>  
>      assert(t < VGA_TYPE_MAX);
>      return !ti->class_names[0] ||
> @@ -2087,7 +2087,7 @@ static void select_vgahw(const char *p)
>  
>      assert(vga_interface_type == VGA_NONE);
>      for (t = 0; t < VGA_TYPE_MAX; t++) {
> -        VGAInterfaceInfo *ti = &vga_interfaces[t];
> +        const VGAInterfaceInfo *ti = &vga_interfaces[t];
>          if (ti->opt_name && strstart(p, ti->opt_name, &opts)) {
>              if (!vga_interface_available(t)) {
>                  error_report("%s not available", ti->name);
> 

