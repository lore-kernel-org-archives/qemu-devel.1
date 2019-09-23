Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B88AC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5EE20867
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5EE20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCOyN-0000dI-B1
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCOw6-00087s-Qa
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCOw4-0000xe-A2
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCOw2-0000w2-QN
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:03:27 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6B5762DD3B
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 14:03:24 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n18so4888049wro.11
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bdLGECz6UTASApait+2uuLepYLMmCoyTNfj+vR5SixE=;
 b=SNVKO/2WEvlIX6g98C4FJinYzKztzoGRxeTvKqCItmPsurGgvzBOqpaKMbVOoNUPhZ
 QOJ8ZcMggHEt5917+Aw+OEb4yv6Sm0MDwJ5tZR6Ap3su7z5n9fqU7/7opopUWj2n42VE
 OI5S64h5gGzxLr2usdxuqDdW01mUcIledbeIDtXKkoHJ7sshh0Y2IIXWcSTMIgGJigKA
 MVlkvzlVh1sFyO7ula4pfI24g0phS/s8K1/vv+rK64eyHo3FhtJOuD8j4dey0lSmrdT9
 wPD5S9AyMgsX9wBZJe/kMs2Ttd7LIlrouV3VTzXIOff64DCNGLrMiOfMO0DQ7s4mlZdP
 NJFg==
X-Gm-Message-State: APjAAAUus1i4WI/vh2NKsrq7rMuaLo1RA05O9WXDHQfbOyP9BOkPOo1Z
 ftwHojlAloM0aazytGmTJqWokorPHjh30rZjOaJAzJj2OMYz2KvyWADH/1EeKrKwyqFBRlrascX
 3kQtXrhMjAAMzyxI=
X-Received: by 2002:a5d:684a:: with SMTP id o10mr20364975wrw.23.1569247403020; 
 Mon, 23 Sep 2019 07:03:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyn0ItRAv+yr4hLHFmo/G4aX4KbBy8MoVr9/yXTlbcsZh8XmtAmoQmVPlPjBZt+HE/WZyYkuw==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr20364956wrw.23.1569247402722; 
 Mon, 23 Sep 2019 07:03:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id s12sm14324430wrn.90.2019.09.23.07.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 07:03:21 -0700 (PDT)
Subject: Re: [PATCH] Disallow colons in the parameter of "-accel"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190923121712.22971-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <41ed27d8-5494-28f0-2ca6-770f0969bc4d@redhat.com>
Date: Mon, 23 Sep 2019 16:03:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923121712.22971-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/19 14:17, Thomas Huth wrote:
> Everybody who used something like "-machine accel=kvm:tcg" in the past
> might be tempted to specify a similar list with the -accel parameter,
> too, for example "-accel kvm:tcg". However, this is not how this
> options is thought to be used, since each "-accel" should only take care
> of one specific accelerator.
> 
> In the long run, we really should rework the "-accel" code completely,
> so that it does not set "-machine accel=..." anymore internally, but
> is completely independent from "-machine". For the short run, let's
> make sure that users cannot use "-accel xyz:tcg", so that we avoid
> that we have to deal with such cases in the wild later.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  vl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/vl.c b/vl.c
> index 630f5c5e9c..68f47a9c25 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3554,6 +3554,11 @@ int main(int argc, char **argv, char **envp)
>                      g_slist_free(accel_list);
>                      exit(0);
>                  }
> +                if (optarg && strchr(optarg, ':')) {
> +                    error_report("Don't use ':' with -accel, "
> +                                 "use -M accel=... in this case instead");

s/in this case/for now/ or something like that?

Thanks,

Paolo

> +                    exit(1);
> +                }
>                  opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
>                                          false, &error_abort);
>                  qemu_opt_set(opts, "accel", optarg, &error_abort);
> 


