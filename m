Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A46C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36672087E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3LklnZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36672087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htDbk-0006EV-49
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 12:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47734)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htDTj-0001hl-FU
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htDTZ-0008LQ-Am
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:58:47 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htDTK-00087x-Sd
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:58:33 -0400
Received: by mail-pf1-x444.google.com with SMTP id 19so34311783pfa.4
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VVEOZYLjuYh6qrB0dHxUeeHt7/3pdn7NKlFvOCgwsic=;
 b=T3LklnZjyOHPOIvNVYnvklm4SvRrMtSJRTHAACVviVri3+me9mbGp6+apzFM8jDr2x
 //eX2hcKqo2qdJT9foOM51rLGOjCt8Kwn97oa/hItd+vwqA72ipM7nlAhpAbRz1nKBzU
 ehM7Ngqed86jAVmtDnp3aH+2fdJJ2YJyD52E6YCNfZCJ4OudXIb/udzjj3ISHBQ7lapy
 y6rsa1yLIFMFyASuUEahmuRikYa9aLKGQh/gO6EZcvRgEmZSXmxQ6v7IvAG9kWg5alTD
 UXgz37w5MQBZfCpWUgEESryyOyazNoctc3M5XjDjnDQGSnPPLpRWT7JBQfZj15bs5Dag
 w5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VVEOZYLjuYh6qrB0dHxUeeHt7/3pdn7NKlFvOCgwsic=;
 b=qjrZUgufXx4amxJ813BJ9nSOYh2u1ZY2ItdlV4J3Jc4MAXoCUgd6Nj2cGXRXysWAVz
 GvrGtDu5iutr2EPSKQZNQokxO8l9U4ZQ1ikHneXFqm5P/61qCqOVmCR9v+W/3bR4rf7P
 58My4X3lxoHwP6IUBu2jPCquRbLB9mgtdjFhgeYndoUunyroYTbCUB/H/8B8U2T4CpVK
 VriAPAQZ+At7JF7inKI8iGuqzAoU2leFCAAPZ9MOsxjjSLoxlDoBSIdDEX4NwlQblN0s
 GugjhdCPlqIX1NGIZo9jWAMpSoqRJ/WryXctOuamE1KutbKy0b1muJQStPTvmtnHKeyM
 1XPw==
X-Gm-Message-State: APjAAAU9ZKCzc9m9vdfU2iKKy5Bz37SXM6BvCskIF/XAQExerzs297Ju
 0M764+9Xwb0REWvpcWyA0kySiQ==
X-Google-Smtp-Source: APXvYqzzG1K5fUMmXpAoelkjnDHhxXVvz2JZXcjsTIT+H8KG+mSRQHzwIkfkqoUY4PUwyPIIWP4eDA==
X-Received: by 2002:a63:e70f:: with SMTP id
 b15mr120282426pgi.152.1564675101161; 
 Thu, 01 Aug 2019 08:58:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 125sm97430953pfg.23.2019.08.01.08.58.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 08:58:20 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <40a29b2d-41aa-a034-895c-920f6ceecda8@linaro.org>
Date: Thu, 1 Aug 2019 08:58:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v4 14/54] plugin: add core code
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 Eduardo Habkost <ehabkost@redhat.com>, bobby.prani@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> +static inline struct qemu_plugin_insn * qemu_plugin_insn_alloc(void)
> +{
> +    int i, j;
> +    struct qemu_plugin_insn *insn = g_new0(struct qemu_plugin_insn, 1);
> +    insn->data = g_byte_array_sized_new(4);
> +
> +    for (i = 0; i < PLUGIN_N_CB_TYPES; i++) {
> +        for (j = 0; j < PLUGIN_N_CB_SUBTYPES; j++) {
> +            insn->cbs[i][j] = g_array_new(false, false,
> +                                          sizeof(struct qemu_plugin_dyn_cb));
> +        }
> +    }
> +    return insn;
> +}
> +
> +struct qemu_plugin_tb {
> +    GPtrArray *insns;
> +    size_t n;
> +    uint64_t vaddr;
> +    uint64_t vaddr2;
> +    void *haddr1;
> +    void *haddr2;
> +    GArray *cbs[PLUGIN_N_CB_SUBTYPES];
> +};
> +
> +/**
> + * qemu_plugin_tb_insn_get(): get next plugin record for translation.
> + *
> + */
> +static inline
> +struct qemu_plugin_insn *qemu_plugin_tb_insn_get(struct qemu_plugin_tb *tb)
> +{
> +    struct qemu_plugin_insn *insn;
> +    int i, j;
> +
> +    if (unlikely(tb->n == tb->insns->len)) {
> +        struct qemu_plugin_insn *new_insn = qemu_plugin_insn_alloc();
> +        g_ptr_array_add(tb->insns, new_insn);
> +    }
> +    insn = g_ptr_array_index(tb->insns, tb->n++);
> +    g_byte_array_set_size(insn->data, 0);
> +    insn->calls_helpers = false;
> +    insn->mem_helper = false;
> +
> +    for (i = 0; i < PLUGIN_N_CB_TYPES; i++) {
> +        for (j = 0; j < PLUGIN_N_CB_SUBTYPES; j++) {
> +            g_array_set_size(insn->cbs[i][j], 0);
> +        }
> +    }
> +
> +    return insn;
> +}

Why are these inlines in the header?
They seem to be used only once in patch 20.
It seems like these should be local to plugin-gen.c.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

