Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2521CC28E83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9B7206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9B7206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBeY-0004ra-3h
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEBds-0004NM-Ot
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:20:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44869
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEBdp-0003Qf-PY
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:20:36 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-qWUJR8e5Ngqjot1dJ2-tog-1; Fri, 04 Sep 2020 09:20:31 -0400
X-MC-Unique: qWUJR8e5Ngqjot1dJ2-tog-1
Received: by mail-wm1-f69.google.com with SMTP id a5so1712752wmj.5
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 06:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=RQhK68/qSBe6rngNRFSiTGE9FWSqzwHVFzCVYwfxT9Q=;
 b=kFwZm7pnJgaZZ/Yl3mDonCtSgO8KqmWCfNTPOEfySVtIOZCu214x38tM3MUZsCzlsu
 37L/OBhIpJ3ERdPgkEwxjPt+9TgJqqYN7y8Gw4Ypt+fJlm+tFlLYUOL100a6sxKtutjw
 BLNZz7hx0+YW/MZ7LxN+YE46Js8VgTJMC9GUfy17lJ1QkH27WMEu/0rpVC8tfklIv+VQ
 WDMSsg7UdJlMvjJ5/z1nbW/XybAZCgdsZ1DV25ErtLeQAU8DSl+QFBJWIXKLdXZrWLy8
 Ffj3Gg2AWkc+zUfGzoOyWx9vSgMPY6rjVS2IBO/5p28bwT3Lz3Zw0GNDkiO+88hkiA9M
 Ndtg==
X-Gm-Message-State: AOAM532eSI9CxVYgNCQkrWmWUJOUMd7Bl87Cuk+NGD7IJBOuUP9Mbefy
 +W7F+UXKQXzgaetIKMAfrZItN0tbxC0JWi+LcdzNzlAE07SuRwycdcR8PaonNLJgPINRgXMM9Pj
 CbPNCUkwCAmZvTUs=
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr7487683wrw.51.1599225630530; 
 Fri, 04 Sep 2020 06:20:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ95j7ZQupYvvPBHTd5jkHXExloe4wbmkzJkdHS7mi8GuQr1dYssqSdF0Gk1WoU/5V/NvNIw==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr7487653wrw.51.1599225630240; 
 Fri, 04 Sep 2020 06:20:30 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id w7sm11320269wrm.92.2020.09.04.06.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 06:20:29 -0700 (PDT)
Subject: Re: [PATCH] target/i386/cpu: add return value verification and ignore
 Error objects
To: Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org
References: <20200904134529.1317-1-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <10efea6a-b3a8-3e37-47d1-640f5a9ef9c9@redhat.com>
Date: Fri, 4 Sep 2020 15:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904134529.1317-1-pannengyuan@huawei.com>
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kuhn.chenqun@huawei.com, rth@twiddle.net, zhang.zhanghailiang@huawei.com,
 ehabkost@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 3:45 PM, Pan Nengyuan wrote:
> 'err' is unnecessary in x86_cpu_class_check_missing_features(), we can change x86_cpu_expand_features()
> to return true on success, false on failure, then pass NULL here to remove it.
> 
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/i386/cpu.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 49d8958528..c3d3766133 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4883,7 +4883,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
>      }
>  }
>  
> -static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
> +static bool x86_cpu_expand_features(X86CPU *cpu, Error **errp);
>  static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
>  
>  /* Build a list with the name of all features on a feature word array */
> @@ -4925,7 +4925,6 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>                                                   strList **missing_feats)
>  {
>      X86CPU *xc;
> -    Error *err = NULL;
>      strList **next = missing_feats;
>  
>      if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
> @@ -4937,8 +4936,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>  
>      xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
>  
> -    x86_cpu_expand_features(xc, &err);
> -    if (err) {
> +    if (!x86_cpu_expand_features(xc, NULL)) {
>          /* Errors at x86_cpu_expand_features should never happen,
>           * but in case it does, just report the model as not
>           * runnable at all using the "type" property.
> @@ -4947,7 +4945,6 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>          new->value = g_strdup("type");
>          *next = new;
>          next = &new->next;
> -        error_free(err);
>      }
>  
>      x86_cpu_filter_features(xc, false);
> @@ -6426,7 +6423,7 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>  /* Expand CPU configuration data, based on configured features
>   * and host/accelerator capabilities when appropriate.
>   */
> -static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
> +static bool x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>  {
>      CPUX86State *env = &cpu->env;
>      FeatureWord w;
> @@ -6436,14 +6433,14 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>      for (l = plus_features; l; l = l->next) {
>          const char *prop = l->data;
>          if (!object_property_set_bool(OBJECT(cpu), prop, true, errp)) {
> -            return;
> +            return false;
>          }
>      }
>  
>      for (l = minus_features; l; l = l->next) {
>          const char *prop = l->data;
>          if (!object_property_set_bool(OBJECT(cpu), prop, false, errp)) {
> -            return;
> +            return false;
>          }
>      }
>  
> @@ -6540,6 +6537,8 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>      if (env->cpuid_xlevel2 == UINT32_MAX) {
>          env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
>      }
> +
> +    return true;
>  }
>  
>  /*
> 


