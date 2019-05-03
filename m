Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C226FC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8512075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8512075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36915 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMU9t-00043v-T3
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 05:07:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMU95-0003nD-NK
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMU94-000600-ON
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:06:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMU94-0005zB-I4
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:06:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id p21so6159001wmc.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 02:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ThRXsEGot+PxyXMdTsuJhN/N0B4zFQaXtsDgkuiPEgo=;
	b=csxd7zEJ0QHdzuKXQDBDm2bFrx3eNaHbTaa+M3+/USUajyRj7SkS+Y/QdOOIrXWtoY
	JSusUF3qFZC+phvGbbvC9jJXj82caRbQay+jgpviazQ+s307IxpcsXE7x1mMOBJY37nr
	fDyjvW7DYs3xN38vfanjAz07K8ST15O5pxoquKlhL/oy8UZA5VyLDVVt5L9rkqaup6UP
	f+qKVuaQddS2sgolidSJYCHzYsabDQzZ6Cb4vdS+3SZMzxQS2oKb0PSV7GoPd15HLbzC
	w1ChK/tsFR3702iDm/mBV1JQ9m5F6Sz8OAbp/CgBMR7Goj/fKo+LdNc7mYNdwzxr8G6c
	daog==
X-Gm-Message-State: APjAAAWwni0szE1RygNIj8FetREelH7s4Q4dv1fVi6bkdYwvHhnBzDcc
	9y+RJgxKWaAE1vHJw5lg8GgiEnG7Csc=
X-Google-Smtp-Source: APXvYqy1aGeTba6NYfddIbzdNCMT1vSOwh2aAct/Csey4SPxjptLnj1wnyBJdhZYADjHUoCWwGcLTA==
X-Received: by 2002:a1c:1d96:: with SMTP id d144mr4949600wmd.29.1556874377216; 
	Fri, 03 May 2019 02:06:17 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	h131sm2686689wmh.44.2019.05.03.02.06.16
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 02:06:16 -0700 (PDT)
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
References: <20190503002258.9799-1-driver1998@foxmail.com>
	<20190503002930.9991-1-driver1998@foxmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1d1f8690-518b-dd06-c7e1-b1d88b2d1f5d@redhat.com>
Date: Fri, 3 May 2019 11:06:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503002930.9991-1-driver1998@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3 3/4] util/cacheinfo: Use uint64_t on
 LLP64 model to satisfy Windows ARM64
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503090615.oxVVXn8hMtDOBUsTHmAkDeIinl2-wrh-Ye8wA4JIn4w@z>

On 5/3/19 2:29 AM, Cao Jiaxi wrote:
> Windows ARM64 uses LLP64 model, which breaks current assumptions.
> 
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
> ---
>  util/cacheinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> index 3cd080b83d..eebe1ce9c5 100644
> --- a/util/cacheinfo.c
> +++ b/util/cacheinfo.c
> @@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
>  static void arch_cache_info(int *isize, int *dsize)
>  {
>      if (*isize == 0 || *dsize == 0) {
> -        unsigned long ctr;
> +        uint64_t ctr;
>  
>          /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_EL1,
>             but (at least under Linux) these are marked protected by the
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

