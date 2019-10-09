Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D43ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293252190F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293252190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIH6Q-0001KF-GM
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iICTA-0006na-Et
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iICT9-00005V-8i
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:57:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iICT8-000050-3E
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:57:34 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4F8172A09AC
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 13:57:28 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n3so1162117wrt.9
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 06:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VEpP8x7TFu4zP1c2jew+2HOIFIunAuDcnvKZ+NVAen4=;
 b=gYHxj6rpn9mSX8bueVw5S1HioYHCHWucDIR0acXifLOYAqwKmGslXkVGFOxfFoWYnF
 3bAqtTIgjXu+ovMncA1JWQCI/Vk0NBZqSifW82a47EQJRLCYKs/aJSKDu8Dwo4sz+5qH
 mW7mIuTzy8Sb6YNEkw+nBbF70RmhFhh/19cNflBJ2HvZlKCdRWMYFibxdc0zeCCsy0Yx
 /buEhx8nlLsaaaE7xTvHjJS4MEJDy7GRNrETMYH0IGTIc9GOaRcIrmmg52dacGFZsIwD
 4IPsMa2yxNtPBoa22hTVoZSvUEnoKnlaXdSaltHUvzVccawpgGgWsCNDuXvkEWAor5bm
 7zWw==
X-Gm-Message-State: APjAAAU1vziX7Bh7WKlmOXKi1417+jbDeQaZXv+x7DtYZGuNZ7pH8CM1
 PVeJrDIkohcFLeUPeQE5Sc+fHavM1zEqvTvdSA5u5WPvti8XdG8KFol8ix3LMm+h6AUiy/nSqsE
 tOzh1b3M10Np0R9Q=
X-Received: by 2002:a5d:4885:: with SMTP id g5mr3360183wrq.219.1570629447033; 
 Wed, 09 Oct 2019 06:57:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyblzbF+UppeJDj4VQFLqut7lvjNymZdtYmaf9TtSttg/xH3nf/nkUFi/Kxyug/MaLfu3B1Hg==
X-Received: by 2002:a5d:4885:: with SMTP id g5mr3360174wrq.219.1570629446856; 
 Wed, 09 Oct 2019 06:57:26 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id y5sm2388529wma.14.2019.10.09.06.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 06:57:26 -0700 (PDT)
Subject: Re: [PATCH] trace: add --group=all to tracing.txt
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191009135154.10970-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <089aa905-948d-fdb1-d9e3-43768a1c3bc8@redhat.com>
Date: Wed, 9 Oct 2019 15:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009135154.10970-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/19 3:51 PM, Stefan Hajnoczi wrote:
> tracetool needs to know the group name ("all", "root", or a specific
> subdirectory).  Also remove the stdin redirection because tracetool.py
> needs the path to the trace-events file.  Update the documentation.

Thanks!

>=20
> Fixes: 2098c56a9bc5901e145fa5d4759f075808811685
>         ("trace: move setting of group name into Makefiles")
> Launchpad: https://bugs.launchpad.net/bugs/1844814
> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   docs/devel/tracing.txt | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
> index 8231bbf5d1..8c0376fefa 100644
> --- a/docs/devel/tracing.txt
> +++ b/docs/devel/tracing.txt
> @@ -317,7 +317,8 @@ probes:
>                            --binary path/to/qemu-binary \
>                            --target-type system \
>                            --target-name x86_64 \
> -                         <trace-events-all >qemu.stp
> +                         --group=3Dall \
> +                         trace-events-all >qemu.stp
>  =20
>   To facilitate simple usage of systemtap where there merely needs to b=
e printf
>   logging of certain probes, a helper script "qemu-trace-stap" is provi=
ded.
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

