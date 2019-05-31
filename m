Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87D7C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0595266FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0595266FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39205 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWe0f-0001Fx-RR
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 05:39:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hWdzx-0000ww-1C
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hWdzw-0002Ql-4j
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:38:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hWdzv-000297-UR
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:38:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so5483689wmo.2
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 02:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=YbvwlkzNR1i7UC74xckLQ4uyepqQeuSEWCNfYj50iuU=;
	b=ie6SwnfGMVYWAPJNRZZZMHGoTPeOLLjQgn8k53VtGiqNUVMrHx0dzTkV2Kc53OwX3L
	quie/c5ri+UMjH7mZkqQ42t7zp7OZjS+CDVeIKAFu5T7I1x5UCrFq8BAzc95mUz5AguM
	njuOlWwgGI5uB1y0+HSZrXGV64F7l7Fd+OxNqRfFD4gdIaBG3b3qqihbadjQcJcZpkS3
	ShN9bfXpzz1vQQypbJsrEnGjXa4Yap1C++Xit65h6qgcjAdX1cx6wsICR08bplF2EhX9
	zFHzK/wtprfqxyRAAbBZJXVMjlDLp++o8q9bJzMWoEZQye1tQDHwSQKo1UOFAg/bI2eB
	Y/eQ==
X-Gm-Message-State: APjAAAX3f6zHrrIRldOv5nC4lTs8BIcFQH8RnUS5KWryih+uCxktf00o
	uB9lDcoHkNCLWZjcNit95saqYw==
X-Google-Smtp-Source: APXvYqyYXFAqRTktKComYqxAlSd9RGfP3WxxxBe1C3tFo55dCxbxuvaAtN2KDuKooflF80qx/LhSxw==
X-Received: by 2002:a1c:dc45:: with SMTP id t66mr5251011wmg.63.1559295519351; 
	Fri, 31 May 2019 02:38:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3da1:318a:275c:408?
	([2001:b07:6468:f312:3da1:318a:275c:408])
	by smtp.gmail.com with ESMTPSA id
	y132sm8075754wmd.35.2019.05.31.02.38.38
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 02:38:38 -0700 (PDT)
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20190530215755.328-1-wainersm@redhat.com>
	<20190530215755.328-2-wainersm@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ed9a908-bfde-255a-f0de-b977c5f71db6@redhat.com>
Date: Fri, 31 May 2019 11:38:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530215755.328-2-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 1/1] vl: make -accel help to list enabled
 accelerators only
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/05/19 23:57, Wainer dos Santos Moschetta wrote:
> Currently, -accel help shows all possible accelerators regardless
> if they are enabled in the binary or not. That is a different
> semantic from -cpu and -machine helps, for example. So this change
> makes it to list only the accelerators which support is compiled
> in the binary target.
> 
> Note that it does not check if the accelerator is enabled in the
> host, so the help message's header was rewritten to emphasize
> that. Also qtest is not displayed given that it is used for
> internal testing purpose only.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  vl.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/vl.c b/vl.c
> index 2e69c9fef2..e5d40c01f8 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3575,7 +3575,23 @@ int main(int argc, char **argv, char **envp)
>                                                       optarg, true);
>                  optarg = qemu_opt_get(accel_opts, "accel");
>                  if (!optarg || is_help_option(optarg)) {
> -                    printf("Possible accelerators: kvm, xen, hax, tcg\n");
> +                    printf("Accelerators supported in QEMU binary:\n");
> +                    GSList *el, *accel_list = object_class_get_list(TYPE_ACCEL,
> +                                                                    false);
> +                    for (el = accel_list; el; el = el->next) {
> +                        gchar *typename = g_strdup(object_class_get_name(
> +                                                   OBJECT_CLASS(el->data)));
> +                        /* omit qtest which is used for tests only */
> +                        if (g_strcmp0(typename, ACCEL_CLASS_NAME("qtest")) &&
> +                            g_str_has_suffix(typename, ACCEL_CLASS_SUFFIX)) {
> +                            gchar **optname = g_strsplit(typename,
> +                                                         ACCEL_CLASS_SUFFIX, 0);
> +                            printf("%s\n", optname[0]);
> +                            g_free(optname);
> +                        }
> +                        g_free(typename);
> +                    }
> +                    g_slist_free(accel_list);
>                      exit(0);
>                  }
>                  opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
> 

Queued, thanks!

Paolo

