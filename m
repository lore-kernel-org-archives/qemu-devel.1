Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74F5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB87F21BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB87F21BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvL7b-0001Rc-UW
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 08:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44034)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvL6C-0000oC-5x
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvL6B-0000lA-7F
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:31:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvL6B-0000kc-1Y
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:31:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so81657644wma.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 05:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wef9Cho6voF7jTewj98hXJnveYnWrf8EHOB8cLsZF2o=;
 b=Bm8bR9t92Ra5CkhCAGf78kQ03L+MOJXrCpF2RI9JV3tQfyTzdDBTdIqRsmESOOzOAM
 X/wTXm5LqeKHf9vxqrM/Zsu7/blZS/HniQy97orZuxVDiB9GInsFS0GpORwgjvHtOLl6
 RMy3eEYR/xKQg4W+CjQ+YWVelkTdrjddq0pfmkphlvt1g1vbWh2BbtadCSsPxJGcv2je
 0BWpYvJ6hrkKcwOyYxL373xEVpKwl8P0laVqkYXBs+5fP0JywhqttGeT1091qSJH1yv7
 5MPu6gNq6OsDP96YTVmh6PLOFwdpOKztI++t5qsRFarTIX1r/LR5Pxu1AZh1qhBHYsiD
 hF3w==
X-Gm-Message-State: APjAAAUVRC8bQxQAIBIm7VKlwSqbMa9iyzFQKROJj65f+1G1Pnoh95Jj
 OaJ3ft1B/Ymgza6Bero9Ofkvxvlt6bo=
X-Google-Smtp-Source: APXvYqwIEVZpeAizJgVK2rC4GGzNOD9aE5n217PQ7UHtGd0YiPNqWjuMAWVU1llOTsRBlfRHxyck5Q==
X-Received: by 2002:a1c:6686:: with SMTP id
 a128mr10701054wmc.149.1565181081832; 
 Wed, 07 Aug 2019 05:31:21 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id x6sm97604816wrt.63.2019.08.07.05.31.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 05:31:21 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-12-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <32ac8ce0-1a3b-e2d7-585c-47192b813d2c@redhat.com>
Date: Wed, 7 Aug 2019 14:31:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-12-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 11/29] typedefs: Separate incomplete
 types and function types
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

On 8/6/19 5:14 PM, Markus Armbruster wrote:
> While there, drop the obsolete file comment.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/qemu/typedefs.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index fcdaae58c4..29346648d4 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -1,10 +1,10 @@
>  #ifndef QEMU_TYPEDEFS_H
>  #define QEMU_TYPEDEFS_H
>  
> -/* A load of opaque types so that device init declarations don't have to
> -   pull in all the real definitions.  */
> -
> -/* Please keep this list in case-insensitive alphabetical order */
> +/*
> + * Incomplete struct types
> + * Please keep this list in case-insensitive alphabetical order.
> + */
>  typedef struct AdapterInfo AdapterInfo;
>  typedef struct AddressSpace AddressSpace;
>  typedef struct AioContext AioContext;
> @@ -101,6 +101,10 @@ typedef struct SHPCDevice SHPCDevice;
>  typedef struct SSIBus SSIBus;
>  typedef struct VirtIODevice VirtIODevice;
>  typedef struct Visitor Visitor;
> +
> +/*
> + * Function types
> + */
>  typedef void SaveStateHandler(QEMUFile *f, void *opaque);
>  typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
>  
> 

