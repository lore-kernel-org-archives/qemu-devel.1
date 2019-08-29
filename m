Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0369C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A61820644
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A61820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Oct-0003wK-LE
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3Oc1-0003Hn-RN
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3Oc0-0006Y3-MB
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:53:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3Oc0-0006XW-GL
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:53:32 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB69A3D96D
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 17:53:30 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id a17so2487653wrr.10
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 10:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OqMTtERx0hfympLsc9/vXNzhGmht04yyCyEBJNDtZKE=;
 b=YkvZ3JuinNDc84SUzmZo9hcuRQyQGgxCFYAX/QbWFtQwx/hfA0/kw9RG3KsZdtWLzj
 YZdjkzRk+DSt1Y/kfA3bMR4OPUOhNstdyQaT90F8DXKnmKxlkQfZDMH/n6hQp4PK8J6C
 DG+yBwDov98jn8fJOYPgwnnoLa1ktqszXC3yfqLO+q55CYdIJy58PIYGEJvyuUnUsIyu
 HJqg5HMiWvqIEkfMQ2cnQRNsTIIs4PS2MqJV/7wcrogQSN2RLr5/gMr/A5hJFWaNrm56
 a4G3BVZLUEHibltZU2z1by+SsPa7ooWc6YeQPGXA9x3ERG7e8mel6W5nzr9oQYtHW0tA
 lpdQ==
X-Gm-Message-State: APjAAAXKbIHohc5w7pfDgOwtHAEZpUVvdtxuhlMBvx6M+tFrS+e9Dg9C
 +cyHGCtL3avJPI2SR+Otn91SqyHLtFUqCaKBngimEZdTAAsu7sKItaINOuZFZ95jtWk9IE+tPGq
 P4wImIAljsUACdp0=
X-Received: by 2002:adf:de8a:: with SMTP id w10mr2513393wrl.276.1567101209529; 
 Thu, 29 Aug 2019 10:53:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXc0pBI4fBHwjAXbSP8HJ8EEloUYk2ncjHbto5KAURIWwX/BV0Hfu0+zChyncee0YQABpLXw==
X-Received: by 2002:adf:de8a:: with SMTP id w10mr2513380wrl.276.1567101209382; 
 Thu, 29 Aug 2019 10:53:29 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g6sm1134506wrs.95.2019.08.29.10.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 10:53:28 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190827121931.26836-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <008c33ee-0fcc-7166-630d-cdeda75dc40d@redhat.com>
Date: Thu, 29 Aug 2019 19:53:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190827121931.26836-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] target/arm: Free TCG temps in
 trans_VMOV_64_sp()
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/19 2:19 PM, Peter Maydell wrote:
> The function neon_store_reg32() doesn't free the TCG temp that it
> is passed, so the caller must do that. We got this right in most
> places but forgot to free the TCG temps in trans_VMOV_64_sp().
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.=
inc.c
> index 3e8ea80493b..9ae980bef63 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -880,8 +880,10 @@ static bool trans_VMOV_64_sp(DisasContext *s, arg_=
VMOV_64_sp *a)
>          /* gpreg to fpreg */
>          tmp =3D load_reg(s, a->rt);
>          neon_store_reg32(tmp, a->vm);
> +        tcg_temp_free_i32(tmp);
>          tmp =3D load_reg(s, a->rt2);
>          neon_store_reg32(tmp, a->vm + 1);
> +        tcg_temp_free_i32(tmp);
>      }
> =20
>      return true;

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

