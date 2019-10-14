Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43536C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09292207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09292207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJwMN-0001R3-6z
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 05:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJwLB-0000RA-R4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJwL9-00047N-D8
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:08:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJwL8-00043r-Uu
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:08:31 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DABB81DF2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:08:28 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id n3so6870281wmf.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 02:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o4zAq5Hcuhg8iavEWco8aOBvR12XLLITv4FGGrP0r9Q=;
 b=auFcDYtpxr4iGBYxTWk7oihdErDec5ZAbycSUrmoLTuXA3jfPmUOoVyS3U4b2ltR+O
 tB54w9Kf95aU36WEkcCccSG9pSyyqi27CqL/X5VJdsSYv+P91bUZP2O7x4R4aRtbz0w6
 uKRdbenDMD3OigYo0ztjpjSB+LvR9sLsoexqsrtwNbdpWc3/7fm3iIQvU70pungMLFt0
 8JC5Z3y1eGEfQJYLfg4wO2UAPigHxJlyE5SJYbUzff1PzNwEu3VAgA9FyYFjMR+MLsbM
 jx9gVboUhuUQmGowlU71Q0KJsrDBnboEC40Js7hF7UYeklNMRHVEh4wqaRO7Lpku2XxE
 aLMA==
X-Gm-Message-State: APjAAAU8lrlRQ06qSoI3BRB+Fw6adLJ5ZXgmIh0Jl6KMn/zA3q9Me+Lq
 B7/kXbFmUm2QD7yIOayG3PeWt4rDrO+r2goKXCL+45lLYp1fFlp/dWPMOfzZSM93smUhVs7soGf
 FyoaXcqkidxyED2A=
X-Received: by 2002:a05:600c:22d7:: with SMTP id
 23mr13796498wmg.31.1571044107017; 
 Mon, 14 Oct 2019 02:08:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5vPKf5bd4mZSRERVKwztc4x1B8L9sitGQp4cDuqc/61Wtxwtw1BIMsvFNHediYtJBpK98/A==
X-Received: by 2002:a05:600c:22d7:: with SMTP id
 23mr13796480wmg.31.1571044106794; 
 Mon, 14 Oct 2019 02:08:26 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id v8sm22827200wra.79.2019.10.14.02.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2019 02:08:26 -0700 (PDT)
Subject: Re: [PULL 1/2] trace: add --group=all to tracing.txt
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20191014085709.26812-1-stefanha@redhat.com>
 <20191014085709.26812-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b1cbc282-7ad2-e542-c573-3f5e115b5ab5@redhat.com>
Date: Mon, 14 Oct 2019 11:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191014085709.26812-2-stefanha@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 10/14/19 10:57 AM, Stefan Hajnoczi wrote:
> tracetool needs to know the group name ("all", "root", or a specific
> subdirectory).  Also remove the stdin redirection because tracetool.py
> needs the path to the trace-events file.  Update the documentation.
>=20
> Fixes: 2098c56a9bc5901e145fa5d4759f075808811685
>         ("trace: move setting of group name into Makefiles")
> Launchpad: https://bugs.launchpad.net/bugs/1844814

Sorry I didn't noticed that earlier, but on=20
https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_m=
essage=20
we recommend using the 'Buglink' tag.
Not sure it's worth resending another pull request...

> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-Id: <20191009135154.10970-1-stefanha@redhat.com>
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

