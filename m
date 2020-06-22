Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68037C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330142071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFD6Eq1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330142071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNjC-00049K-EO
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnNhu-0002Ul-DT
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:45:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnNhs-0007pg-Go
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:45:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id f18so3461756wml.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EdJDuWqQXGwEAHQPLGL4WH48KopQDwxHpzkNxqBMbac=;
 b=fFD6Eq1fXSUMRCJAc/BoAJclZYzIgfs+EcBXsFlRHnHgqc7K8uYCKLcjIqkGQHTDy/
 74b2aG7mZsCmyC7v80yv4VAjTgQ3ZAtB/4T38DqxUVx/TJxxaieWgGWvtVY2TykKm4Ep
 3Yy0BnLgf5e0rC0mXUkL4tmgaSivexycGysFCcDvZx32arPKIb2kaYVo1JBd62wMXBxC
 TkYv9OR2f2mITcloN159XthcLb/p4t5v++cYs60fQxgfNvH2ZuOO63YjxmQxS7pKSR1O
 56yhSxnUIzIZD0oE22iKLDsJ2V1oC+Tktg5GsyYOuGj1euQBuZK+PcjbEM0AQfXJ7tLC
 w6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EdJDuWqQXGwEAHQPLGL4WH48KopQDwxHpzkNxqBMbac=;
 b=bYqBqo14ggNuJSr7o1bwGz/eoJyTRQncyUL/uRn0cPfbE4OOy2k7mkV/KipztxyDPZ
 vrG8ijAMSUracWeitk47Jzw/q5rRmjtV+v6oKVXizyTfGQPV4MRwxY/ajc0guWN9oufb
 0/wMI9hv4DtOjWVHveK+JLl6ra4/IDB4GIZk2X3xbflEmzhHfSEtQLEmJ8QOeDyCHMyq
 m2trVHpgzXzqWDBlKhB/6kA1o7cH+7ZI2ObCaB3GokmxTOhm+YprGRrbUm+aOpgVdftr
 ukW7ieGRli8XDwHj1+H47H/Gbf8Qqa2qH54lyFRwvi8crxd+kAvWgVtbTpvEFpUz/WmU
 OIbA==
X-Gm-Message-State: AOAM533PFQnNrX1qkoKCKWyDz0eSa0r25c0+R5hLeHYP0Z3JDcf0S8tg
 rSwY+ho31WMmGqKrm9tH+ts=
X-Google-Smtp-Source: ABdhPJx5TdcAJoJDZtUA56NQaEWEYp9Ku0SG12XAAPtDke3uxijyz78EmhUejTHxnQHZsGwsS/lwcA==
X-Received: by 2002:a7b:c013:: with SMTP id c19mr3754512wmb.158.1592837154847; 
 Mon, 22 Jun 2020 07:45:54 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id k11sm15434177wrd.23.2020.06.22.07.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 07:45:54 -0700 (PDT)
Subject: Re: [PATCH v1 18/18] .gitlab: add avocado asset caching
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200622143204.12921-1-alex.bennee@linaro.org>
 <20200622143204.12921-19-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <23c688d2-8cc0-0e6e-6f92-b9c91205e218@amsat.org>
Date: Mon, 22 Jun 2020 16:45:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200622143204.12921-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 4:32 PM, Alex Bennée wrote:
> These can be quite big so lets cache them. I couldn't find any nots on

typo "notes"?

> ccache in the gitlab docs so I've just ignored it for now.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  .gitlab-ci.yml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 7816f1434c3..693ecad770f 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -14,6 +14,12 @@ include:
>    - local: '/.gitlab-ci.d/edk2.yml'
>    - local: '/.gitlab-ci.d/opensbi.yml'
>  
> +# We assume GitLab has it's own caching set up for RPM/APT repositories so we
> +# just take care of avocado assets here.
> +cache:
> +  paths:
> +    - $HOME/avocado/data/cache
> +
>  .update_apt_template: &before_script_apt
>   before_script:
>    - apt-get update -qq
> 

