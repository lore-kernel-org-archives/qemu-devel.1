Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54CCC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8025320851
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8025320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbjXX-0003RQ-MR
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 06:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52760)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbjO0-0005S5-5W
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbjG0-0004wz-Tc
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:16:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbjFy-0004t4-Uw
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:16:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so1742593wmm.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 03:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fPF0SSzky/fNKGIezXEhI0dMIqYeERQQMLqMei5JmGM=;
 b=IYj+4IdHskZgIa9mBKw5yxgzO0Ng4GZiqdZw7A9Y/12TgdJRUB4/Cgrm2M8qbSlnYX
 ny2YnD7m8LIAEM4owRF6BBVOZNPLbUwpKh9LN0MbXvW/Zk4KEiJ/YRhufhsLrTR8+M0r
 KmsFL0umsnEuhfTAELGC7ViTiF2z39rlAuaOK952jRUc5EOggZM/eDL6wj6oYB8SWZdw
 qwfXqTuJ2Q3GFw/vNDoE3e2jSkj/G448eoZPKLcsWtzvchj1xnCaP0l0UMYSIquDdp35
 4AvZ+T012YLJG3wQhnuEeExgDZjnWhOl3e9rJN+2BGr43d89vaF5497psrTGr98tzm9T
 AUIQ==
X-Gm-Message-State: APjAAAVlV3ySA8P9ftwoui2C0F/cMA+Iw8B6rEMpA7hTrVN42cO/deTu
 8eaxvQqERPeSE9cbFe5zEfXMKA==
X-Google-Smtp-Source: APXvYqwSuHQbaCoGs2CtjNiyvWm+RP/3F9ZfXstAhHUFozELORENIXNxvseybsZlO7ZiSmbNyocQwg==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr7042407wmc.33.1560507377300; 
 Fri, 14 Jun 2019 03:16:17 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id b5sm2284260wru.69.2019.06.14.03.16.16
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 03:16:16 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190613175435.6575-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7c44bcb6-1c72-e327-9091-394e6abfb51e@redhat.com>
Date: Fri, 14 Jun 2019 12:16:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613175435.6575-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] roms/edk2-build.sh: Allow to run
 edk2-build.sh from command line
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
Cc: Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Eric :)

On 6/13/19 7:54 PM, Philippe Mathieu-Daudé wrote:
> The edk2-build.sh script set the 'nounset' option:
> 
>   BASH(1)
> 
>   set [arg ...]
> 
>       -u   Treat unset variables and parameters other than the
>            special parameters "@" and "*" as an error when
>            performing parameter expansion.  If expansion is
>            attempted on an unset variable or parameter, the shell
>            prints an error message, and, if not interactive,
>            exits with a non-zero status.
> 
> When running this script out of 'make', we get:
> 
>   $ cd roms
>   $ ./edk2-build.sh aarch64 --arch=AARCH64 --platform=ArmVirtPkg/ArmVirtQemu.dsc > /dev/null
>   ./edk2-build.sh: line 46: MAKEFLAGS: unbound variable
> 
> Fix this by checking the variable is defined before using it,
> else use a default value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  roms/edk2-build.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/roms/edk2-build.sh b/roms/edk2-build.sh
> index 4f46f8a6a2..5390228b4e 100755
> --- a/roms/edk2-build.sh
> +++ b/roms/edk2-build.sh
> @@ -43,7 +43,13 @@ fi
>  # any), for the edk2 "build" utility.
>  source ../edk2-funcs.sh
>  edk2_toolchain=$(qemu_edk2_get_toolchain "$emulation_target")
> -edk2_thread_count=$(qemu_edk2_get_thread_count "$MAKEFLAGS")
> +if [ -v MAKEFLAGS ]; then
> +  edk2_thread_count=$(qemu_edk2_get_thread_count "$MAKEFLAGS")
> +else
> +  # We are not running within 'make', let the edk2 "build" utility to fetch
> +  # the logical CPU count with Python's multiprocessing.cpu_count() method.
> +  edk2_thread_count=0
> +fi
>  qemu_edk2_set_cross_env "$emulation_target"
>  
>  # Build the platform firmware.
> 

