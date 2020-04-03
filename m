Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B2EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 20:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FB1207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 20:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAy+cXst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FB1207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKT8D-0008RQ-QP
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 16:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKT6m-0007on-JN
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 16:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKT6k-0005m1-DR
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 16:40:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKT6k-0005iT-3z
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 16:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585946405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fCwL5UGRxirWMJAyxl8IQ720bqbrq1qlcUmoZxs9f1U=;
 b=fAy+cXst52d0TZsDO49tg7upAh6iECsZtVDg9bnoDg6v3WcGBBY3E82+kZHK2CL8VECpsr
 eWY3QghcDzv4JZTEeLLvnH5/Xuxdf47vlCjEV4/kA7CTFafbfPWN4Kr055YrGFwZ5UehQu
 JPpOZNO0FsUtdfI8IpTT4Mk4LHXbjhE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-q46eBUHROp6YfDnH5lV9xA-1; Fri, 03 Apr 2020 16:39:59 -0400
X-MC-Unique: q46eBUHROp6YfDnH5lV9xA-1
Received: by mail-wm1-f69.google.com with SMTP id 2so3318732wmf.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 13:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k5VPogT4d1yb7Bu8EbYFVw4i6MZaE+cuiYcRgEwgv1M=;
 b=Vzhf++4tZniF0t29d9x4aTJ/RLXaMsZWL5yii63v74LV5NqUtvSo2glSxq2Wb8MWsh
 cbcqFZ3lswHabv7YQ2+lu9YBgNkEIPgl7zIxmwIPCe9/ZX8UiHc53bAp5ROShv9tJGKY
 oKzXCmZUjfvKayL7w9Slp1SEziLE4xO2ThIjRbY3xMnNJvIg6YYUQoIUSZ9YgslOpCPf
 mjgyQUwSUP7TUSaiHPQPpadXx+0oJbn2lznSis7W4n4/glksGFGDdfflnPEZRvgB2Vk8
 SQY6gUOI4gNctwJmK4g+L8kJ4naU3xwZhTUV4NBls5Hs3q6Kc/raiqJmgbAIb86fuPAy
 dMUA==
X-Gm-Message-State: AGi0PuZUCB0JdneOd+ruM8LjGZ4nHOqi4os3OXjHoflN75GCYmyMYQqC
 3md7b+jlB0mnsd/x4GKyh0oCUSYgZLUEcD0s4wh6ekygaxnUz7Cy5/deiWvyk2qADkD09AWUgni
 3fNHCu27FCBdw01g=
X-Received: by 2002:a5d:4acd:: with SMTP id y13mr10925952wrs.61.1585946398600; 
 Fri, 03 Apr 2020 13:39:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypLdSuR+vJDWLXzTloyQjkrT0b/+GTdA34UBAetkj4Yt81tD5Z08pb3hYRzczFBbDjuaLcbZVg==
X-Received: by 2002:a5d:4acd:: with SMTP id y13mr10925930wrs.61.1585946398380; 
 Fri, 03 Apr 2020 13:39:58 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b67sm12912908wmh.29.2020.04.03.13.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 13:39:57 -0700 (PDT)
Subject: Re: [PATCH v3 04/12] linux-user: more debug for init_guest_space
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200403191150.863-1-alex.bennee@linaro.org>
 <20200403191150.863-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <df6ebd03-cac2-70cc-7cb9-3753e30f9e45@redhat.com>
Date: Fri, 3 Apr 2020 22:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403191150.863-5-alex.bennee@linaro.org>
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 9:11 PM, Alex Benn=C3=A9e wrote:
> Searching for memory space can cause problems so lets extend the
> CPU_LOG_PAGE output so you can watch init_guest_space fail to
> allocate memory. A more involved fix is actually required to make this
> function play nicely with the large guard pages the sanitiser likes to

TIL "in an effort to differentiate British English from American, many=20
British publishers have begun giving -ise endings even to words that=20
have always been spelled -ize."

https://grammarist.com/spelling/sanitise-sanitize/

> use.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   linux-user/elfload.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 8198be04460..619c054cc48 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2172,6 +2172,8 @@ unsigned long init_guest_space(unsigned long host_s=
tart,
>  =20
>           /* Check to see if the address is valid.  */
>           if (host_start && real_start !=3D current_start) {
> +            qemu_log_mask(CPU_LOG_PAGE, "invalid %lx && %lx !=3D %lx\n",
> +                          host_start, real_start, current_start);
>               goto try_again;
>           }
>  =20
> @@ -2240,7 +2242,11 @@ unsigned long init_guest_space(unsigned long host_=
start,
>            * probably a bad strategy if not, which means we got here
>            * because of trouble with ARM commpage setup.
>            */
> -        munmap((void *)real_start, real_size);
> +        if (munmap((void *)real_start, real_size) !=3D 0) {
> +            error_report("%s: failed to unmap %lx:%lx (%s)", __func__,
> +                         real_start, real_size, strerror(errno));
> +            abort();
> +        }
>           current_start +=3D align;
>           if (host_start =3D=3D current_start) {
>               /* Theoretically possible if host doesn't have any suitably
>=20


