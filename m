Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763BAC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49972208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49972208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLr73-0004fx-IO
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:25:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr5u-000484-Ij
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr5p-0000vK-EN
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:24:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLr5o-0000uU-Sf
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:24:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id b67so4643482wmg.1
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=KmEsYrfEjl0ocBs3Sq2w59isDxD/ManTKjXSduTJFLc=;
	b=ciFTBsNhBu1lOGxsIYPXwv3Pi1HriVTsdQ9DnpwQyrD3vl7eV5lG3l/AD/eJDXuGxw
	ZqFDWbSt1BxYiEOR6zHl58JO4sxC43OtxtgQZFh255Ix1SXCa9k95Jq8q4p8rvWLCxZx
	2iwVgRb5QxeCshn/MKlQevKtq66MJpctuCoKOXUtKUrOg/FOhhgjW9/+4PbsTrvcYqok
	Dh8AnXWqYzRja349BuGUVwGJlJWNqxqWsA6a4+BVySCHPcUOFzMLhDe9NWa9xJhA9+9v
	2JrUgmn6gCTg6f+vhK3T/Y713uCYV45S40oeS+9vSHBEgjqnRjxVrU30HZo1VyyPVMug
	zijQ==
X-Gm-Message-State: APjAAAVbMrHuz02AcKmtNxeynRjH0givqlFT2FM7A3lCVvkDoWdgG2L7
	Y+bbDqG23ukx2sfLvbryCvzrxw==
X-Google-Smtp-Source: APXvYqxSbmB9F77WukEjEJW80aTHbKP8kfdzekvWZpTV6kS05Wb86qG4RHt+kRxvt4p0Zp7n4f+MPw==
X-Received: by 2002:a1c:a893:: with SMTP id r141mr6888842wme.7.1556724258777; 
	Wed, 01 May 2019 08:24:18 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	o16sm34704950wrw.10.2019.05.01.08.24.17
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 08:24:18 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
References: <20190501144646.4851-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cb43af48-c48b-74cf-6e83-982a310bf1d9@redhat.com>
Date: Wed, 1 May 2019 17:24:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501144646.4851-1-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: avoid string truncation
 warnings in uname field copying
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501152417.K-Oqo2-9Jy089gpXh5izUU8sBQyhbhorsP-dv-eQUXU@z>

On 5/1/19 4:46 PM, Daniel P. Berrangé wrote:
> In file included from /usr/include/string.h:494,
>                  from include/qemu/osdep.h:101,
>                  from linux-user/uname.c:20:
> In function ‘strncpy’,
>     inlined from ‘sys_uname’ at linux-user/uname.c:94:3:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ output may be truncated copying 64 bytes from a string of length 64 [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> We don't care where the NUL terminator in the original uname
> field was. It suffices to copy the entire original field and
> simply force a NUL terminator at the end of the new field.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Changed in v2:
> 
>  - Always use sizeof() in preference to __NEW_UTS_LEN
> 
>  linux-user/uname.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/uname.c b/linux-user/uname.c
> index 313b79dbad..1c05f95387 100644
> --- a/linux-user/uname.c
> +++ b/linux-user/uname.c
> @@ -72,9 +72,8 @@ const char *cpu_to_uname_machine(void *cpu_env)
>  
>  #define COPY_UTSNAME_FIELD(dest, src) \
>    do { \
> -      /* __NEW_UTS_LEN doesn't include terminating null */ \
> -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
> -      (dest)[__NEW_UTS_LEN] = '\0'; \
> +      memcpy((dest), (src), MIN(sizeof(src), sizeof(dest))); \
> +      (dest)[sizeof(dest) - 1] = '\0'; \
>    } while (0)
>  
>  int sys_uname(struct new_utsname *buf)
> 

