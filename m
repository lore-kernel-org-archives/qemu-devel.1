Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D63FC2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634EB206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRTZStv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634EB206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMra1-00030C-Jz
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 07:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMrZQ-0002aJ-OV
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 07:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMrZP-0005KD-1T
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 07:11:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54821
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMrZO-0005HC-U7
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 07:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586517093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgTYZTxE+j4KKX3tkfLZj2/rJwxDnF7COVKxhuR2NME=;
 b=CRTZStv0ov09b12h2pheDuyEA/C7QdoYgScp3u+rRBLpHwEevuDDFkrTX0yH6EooMMGjMz
 Pvh6tvUutg8ByjL511Tp0MI0KrndwbI+e9wdKvSaAvDWVBYdU6I+3qwbRiV9zkmnCeb13f
 8bK7HxEWOIe/j1FjFwJiHxgLFCl+mkM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-uwsQuFQHPk6YdW4TcGvSqA-1; Fri, 10 Apr 2020 07:11:32 -0400
X-MC-Unique: uwsQuFQHPk6YdW4TcGvSqA-1
Received: by mail-ed1-f71.google.com with SMTP id bm26so1810560edb.17
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 04:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=znsngmpaEKL492sEwLT7gY1lb9ak7IfVlw/eAuP6Zds=;
 b=f577odLnpUt3MeGEpSwyQbY0iRCTZflZhA+ZPH8uN+2h8NOvJTfshS2aKZ+ynCboMb
 5raKJj/Y3nC81TqB1dCkaUl4GEjPhaEe/sGcgz1372VJeMLfS2ycfrP/Jtub7jPtIuo1
 8TB39HPZ13RJ97PzmhVWiPmcaXXFyM3vfB4wUNIXTDPzISHuR8wiKd1yq3kRSz6Ow3Lg
 xzuq53KlFWE26021LOiqWK+ePiiqTaCfra3qovdaopwbiOzsgdp98DTdsZ1nwM9LF4ZQ
 HbYMabcyQeiWAAKg67p34SzmvlqNi4QP7lRPYMNDwU45v0UwtmnbY+nQRrVOveE6+aEz
 sdoQ==
X-Gm-Message-State: AGi0PubHLlhVzDhDx+NkLx6SY++z+/fFyMuVUKYyNVtteBnnDKzOSHZ5
 J2cN3J7Jwi6VcSjcQIbNXKUYhXwvsivp3mYUuKl+Qi9KfDSqb2q/qzCLOSsS0nie5AmzozsGZAd
 Fap/wi3DkdAPXhHA=
X-Received: by 2002:a50:e043:: with SMTP id g3mr4393900edl.220.1586517090984; 
 Fri, 10 Apr 2020 04:11:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypL9YKVn9vaLYxpuItSJRXIh71OiOEeclwUpeHLrxIKDpaSIflPVAZ5j9pOe1rXkSSrVm6AjzA==
X-Received: by 2002:a50:e043:: with SMTP id g3mr4393877edl.220.1586517090762; 
 Fri, 10 Apr 2020 04:11:30 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s4sm89233edw.19.2020.04.10.04.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 04:11:30 -0700 (PDT)
Subject: Re: [PATCH v1 10/11] linux-user: fix /proc/self/stat handling
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <88154583-5a03-a89c-f10e-06e6010abf95@redhat.com>
Date: Fri, 10 Apr 2020 13:11:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-11-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Ludovic Courtes <ludovic.courtes@inria.fr>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Brice Goglin <Brice.Goglin@inria.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Ludovic in case he can test with Guix-HPC.

On 4/9/20 11:15 PM, Alex Benn=C3=A9e wrote:
> In the original bug report long files names in Guix caused
> /proc/self/stat be truncated without the trailing ") " as specified in
> proc manpage which says:
>      (2) comm  %s
>             The  filename of the executable, in parentheses.  This
>             is visible whether or not the  executable  is  swapped
>             out.
>=20
> Additionally it should only be reporting the executable name rather
> than the full path. Fix both these failings while cleaning up the code
> to use GString to build up the reported values. As the whole function
> is cleaned up also adjust the white space to the current coding style.
>=20
> Message-ID: <fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr>
> Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
> Cc: Philippe_Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   linux-user/syscall.c | 43 +++++++++++++++++++------------------------
>   1 file changed, 19 insertions(+), 24 deletions(-)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 6495ddc4cda..674f70e70a5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7295,34 +7295,29 @@ static int open_self_stat(void *cpu_env, int fd)
>   {
>       CPUState *cpu =3D env_cpu((CPUArchState *)cpu_env);
>       TaskState *ts =3D cpu->opaque;
> -    abi_ulong start_stack =3D ts->info->start_stack;
> +    g_autoptr(GString) buf =3D g_string_new(NULL);
>       int i;
>  =20
>       for (i =3D 0; i < 44; i++) {
> -      char buf[128];
> -      int len;
> -      uint64_t val =3D 0;
> -
> -      if (i =3D=3D 0) {
> -        /* pid */
> -        val =3D getpid();
> -        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
> -      } else if (i =3D=3D 1) {
> -        /* app name */
> -        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
> -      } else if (i =3D=3D 27) {
> -        /* stack bottom */
> -        val =3D start_stack;
> -        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
> -      } else {
> -        /* for the rest, there is MasterCard */
> -        snprintf(buf, sizeof(buf), "0%c", i =3D=3D 43 ? '\n' : ' ');
> -      }
> +        if (i =3D=3D 0) {
> +            /* pid */
> +            g_string_printf(buf, FMT_pid " ", getpid());
> +        } else if (i =3D=3D 1) {
> +            /* app name */
> +            gchar *bin =3D g_strrstr(ts->bprm->argv[0], "/");
> +            bin =3D bin ? bin + 1 : ts->bprm->argv[0];
> +            g_string_printf(buf, "(%.15s) ", bin);

15 or 125? 15 seems short. From your previous test I understood it was=20
124, for=20
sizeof("cat_with9_123456789012345678901234567890123456789012345678901234567=
89012345678901234567890123456789012345678901234567890___40").

> +        } else if (i =3D=3D 27) {
> +            /* stack bottom */
> +            g_string_printf(buf, TARGET_ABI_FMT_ld " ", ts->info->start_=
stack);
> +        } else {
> +            /* for the rest, there is MasterCard */
> +            g_string_printf(buf, "0%c", i =3D=3D 43 ? '\n' : ' ');
> +        }
>  =20
> -      len =3D strlen(buf);
> -      if (write(fd, buf, len) !=3D len) {
> -          return -1;
> -      }
> +        if (write(fd, buf->str, buf->len) !=3D buf->len) {
> +            return -1;
> +        }
>       }
>  =20
>       return 0;
>=20


