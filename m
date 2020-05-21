Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCCFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724B92072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLwdIBXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724B92072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmpJ-0003OP-Ky
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmom-0002xs-K8
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:09:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26396
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmol-0007ht-TE
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590073746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zyjfyXT7K8479zjqqGZm9G8RcbVfG7qnCINZEZgQ4M=;
 b=hLwdIBXWKmxUF+71SjDMMaCWsDDu5lcWhIPqn5I1m0wqtINRCzB3/KNhu6nxTZ6Vfbf3Xy
 r7n1iTmjAmqzfQN0A+MJsrzwc4JJr/eB3ixzkzWbaZAAa21NHEUhRAO5V24bgDzC+Arlji
 oqVHKcbGVqRb4DoY6i/MLiw+w1KM/mo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-m8lpokmuOK-8Oe3M2b2Xpw-1; Thu, 21 May 2020 11:09:03 -0400
X-MC-Unique: m8lpokmuOK-8Oe3M2b2Xpw-1
Received: by mail-wr1-f70.google.com with SMTP id r14so3036599wrw.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8zyjfyXT7K8479zjqqGZm9G8RcbVfG7qnCINZEZgQ4M=;
 b=oRv+XNpy079JN8Mc2t6acuodvuvYPF0bs+PZCt0U3So1eQ2rV6iP8HYG5+Bp020wgr
 T3+dljgVuDLxdOGh812IXHFHN1tGCPLkmLvFsXOqn7i8ni6qXvOUn+APVnJBCjeowxKX
 ZMWyb3YKW2fSLHCCJq7yiAY76Vw4O7D21oiLHYOY5PtZIdn+ZOPIh0YUWr3nYLiDoRC2
 qONyfjt6663SmCx2SGC/wVi2zvGHQRKRBUfwNcRlQgG269BDe9O4vkSIZY5GHlF+foYv
 Y605nKgAuZ1CC9cclCgSOEIkAMvptMt8IEy74rhOBpIAnkxU+FM4gwltTY0BcUFBdS1H
 W3fQ==
X-Gm-Message-State: AOAM531NvktcybRGxWZZfIDXYMR7DV5xjUnAXhNjRdVzMz8cQABgn2Cx
 Nm/hKMtgyFR15b609ttNzXJft6gr71IACj7TPzupqdYMrpo6WOrypFOLm2z7yirqDHABTTNqxTJ
 aFF2TGo5rUQJYcSQ=
X-Received: by 2002:a05:600c:2257:: with SMTP id
 a23mr9943101wmm.13.1590073741902; 
 Thu, 21 May 2020 08:09:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmvD1Ravrcn+f6oOYJxvwEZpK8+Lg9SAXpUepqfdglxzJDEF3lp+3raLgyhw3QcG7ClLzs0w==
X-Received: by 2002:a05:600c:2257:: with SMTP id
 a23mr9943073wmm.13.1590073741673; 
 Thu, 21 May 2020 08:09:01 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id z11sm2144287wrw.67.2020.05.21.08.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:09:01 -0700 (PDT)
Subject: Re: [PATCH v2] cpus: Fix botched configure_icount() error API
 violation fix
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200515042231.18201-1-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9adf045-3f36-06d5-f385-0c0a3659be95@redhat.com>
Date: Thu, 21 May 2020 17:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200515042231.18201-1-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/05/20 06:22, Markus Armbruster wrote:
> Before recent commit abc9bf69a66, configure_icount() returned early
> when option "shift" was absent: succeed when option "align" was also
> absent, else fail.
> 
> Since then, it still errors out when only "align" is present, but
> continues when both are absent.  Crashes when examining the value of
> "shift" further.  Reproducer: -icount "".
> 
> Revert this erroneous part of the commit.
> 
> Fixes: abc9bf69a66a11499a801ff545b8fe7adbb3a04c
> Fixes: Coverity CID 1428754
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  cpus.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 5670c96bcf..ee906dd08f 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -803,8 +803,10 @@ void configure_icount(QemuOpts *opts, Error **errp)
>      bool align = qemu_opt_get_bool(opts, "align", false);
>      long time_shift = -1;
>  
> -    if (!option && qemu_opt_get(opts, "align")) {
> -        error_setg(errp, "Please specify shift option when using align");
> +    if (!option) {
> +        if (qemu_opt_get(opts, "align") != NULL) {
> +            error_setg(errp, "Please specify shift option when using align");
> +        }
>          return;
>      }
>  
> 

Got the nicer commit message, too.

Paolo


