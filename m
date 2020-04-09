Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A62DC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E522074F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t58lOH78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E522074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMZ6g-0008BM-FR
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 11:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMZ5u-0007RJ-Mv
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMZ5t-0000js-79
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:27:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMZ5s-0000ig-PB
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:27:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id p10so12373578wrt.6
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+I14NGFvQzepe7pJd+vCPxfGFMnDX3QH9l1rQ+LEbRQ=;
 b=t58lOH78MbafIflT7uVnQrpbPkLLRgEXeERUJF7kgOAW89LPnOI1kazzMxh4xdmeMU
 tboy3e9TXwuvGE4eDlpvAZ7/2osZrlFoEPO5iEQJcy+CFkXi3bChD0ml45LxaVU5fAIq
 W1fEnx0QBG+egnZcTfUWjYf+LRDrIJXQ/WUqwe82NV3TfZ8598TBAm+TpLXoFNp8QRNR
 hCt9lQwkzyNnsPLkG0o+7y8GEjOCBcPoVMdKbIN/8PIsU8gPBiQoUFgMdNy7fSjwp7pE
 L0koCwH5kqvSQ75DARQZy5RwdgneZ+fCYtCmApQl7s/XQYT47KjS89STEjp0c2t3+GPt
 Jhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+I14NGFvQzepe7pJd+vCPxfGFMnDX3QH9l1rQ+LEbRQ=;
 b=oeG6lMYdBfcWVHFocACGFbRGR3qQ3w1zNPxxKVvAD/GJFGAMb9jzhT3WlYz4024/AG
 SpzmT+Qb/d9Ej6y7+zhvSj65R2Y3/pprQ3jDX+bAGq1fTxyzY09WD5TRDgBy0Ryh+Pa4
 MF9j1zgf6T4cDFKlNmE0t5nW9kT+IV+qAy0cMbuTupIF+v8ECzjCqQVY5WFEpNeFjwwJ
 LsOzIYKdUSJ1c/Dk3WqLovuaYaveuzz+3qbpRdy2xm13Ba/CmBAcL90L1zUc8tZVZyGk
 LTydZkmGQrxtrJbiccZuJQAUjzZ4+pDgVdy2n+kc63XI7taJchcxhSKDOR0A/qvRTXID
 lG4A==
X-Gm-Message-State: AGi0PuZX6dn4R6rz7jQi2XfY4+tPnr+1J8psJNaSrN1YLIvFvDsVr0gb
 lgWqeMXdMfPQBOQDRM305XctPA==
X-Google-Smtp-Source: APiQypJlis410iFHKsMSkmLripsionstKUfZ20Zpgo4RQhRXNTQj3JGu8PJTHX3baerBZRDIiK9I7Q==
X-Received: by 2002:adf:fdc6:: with SMTP id i6mr15096460wrs.252.1586446071215; 
 Thu, 09 Apr 2020 08:27:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d133sm4413302wmc.27.2020.04.09.08.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 08:27:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C5D5B1FF7E;
 Thu,  9 Apr 2020 16:27:47 +0100 (BST)
References: <fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: linux-user: keep the name-ending parenthesis in /proc/self/stat
In-reply-to: <fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr>
Date: Thu, 09 Apr 2020 16:27:47 +0100
Message-ID: <87wo6oadcc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Brice Goglin <Brice.Goglin@inria.fr> writes:

> When the program name is very long, qemu-user may truncate it in
> /proc/self/stat. However the truncation must keep the ending ") "
> to conform to the proc manpage which says:
>     (2) comm  %s
>            The  filename of the executable, in parentheses.  This
>            is visible whether or not the  executable  is  swapped
>            out.
>
> To reproduce:
> $ ln -s /bin/cat <filenamewithmorethan128chars>
> $ qemu-x86_64 ./<filenamewithmorethan128chars> /proc/self/stat
>
> Before the patch, you get:
> 1134631 (<filenametruncated>0 0 0 0 0 0 0 0 ...
> After the patch:
> 1134631 (<filenametruncat>) 0 0 0 0 0 0 0 0 ...
>
> This fixes an issue with hwloc failing to parse /proc/self/stat
> when Ludovic Courtes was testing it in Guix over qemu-aarch64.
>
> Signed-off-by: Philippe_Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Brice Goglin <Brice.Goglin@inria.fr>
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7305,7 +7305,11 @@ static int open_self_stat(void *cpu_env, int fd)
>          snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
>        } else if (i =3D=3D 1) {
>          /* app name */
> -        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
> +        char *ptr =3D buf;
> +
> +        *ptr++ =3D '(';
> +        ptr =3D stpncpy(ptr, ts->bprm->argv[0], sizeof(buf) - 3);
> +        strcpy(ptr, ") ");

why not just use a format string:

  snprintf(buf, sizeof(buf), "(%.125s) ", ts->bprm->argv[0]);

although to be honest when ever I see a bunch of sizeof(buf) code for
strings I tend to re-write it to use the glib GString functions.

>        } else if (i =3D=3D 27) {
>          /* stack bottom */
>          val =3D start_stack;


--=20
Alex Benn=C3=A9e

