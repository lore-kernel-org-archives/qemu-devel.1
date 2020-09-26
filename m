Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8BAC2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 20:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D9F21527
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 20:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM3o2NDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D9F21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMGna-0006Ph-MC
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 16:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMGmw-0005yW-Iu
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 16:27:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMGmu-0001U8-9u
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 16:27:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so7531570wrw.11
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9j8GMQiYIoPCiZdc/P7zJQ6iglgg4LfFJkc5FGTv8Z8=;
 b=FM3o2NDUCj1A4pqt8AByTM8RJPj9Ut3kRAfDuFliAqhol5Gsa9Ogm7LpZBn/t19arC
 OX9PshXrOwC64DO9C+gmQS/z5vjDdTKktHeUM6hQJ3vAtc2Y+wunHhLGJSDVMkilNVEi
 nqauAU8Y1N/cMMRIbGroFBLq+T3M0zdDO0ezgdyg1D7/4nbz2eQKNFNpw45k6X/g/dgN
 dWf7fQhSjvntdxWL5PnKqgi37MxD4enLNK/grtAUNrVsdscOO/JIXxlcc1u8g3tt9qbb
 Pvn2/65BzHl4WmwW4foyvPGa3pqHt/9WbutF2lP+z0FWcfsojB4fUc9X5xYWUzGF1gUn
 gX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9j8GMQiYIoPCiZdc/P7zJQ6iglgg4LfFJkc5FGTv8Z8=;
 b=l8T9b9fBQFzseE1YfuoSyij3DrOu9863lnduThmF+1BH8WQO4diGRNEY4uXXhfbZ59
 i5t1xcj5GyMIp6AuH93H5arURXMae4cOATiwBdvBv+vlITKz65BHkiDTUSqDsnpI4122
 gc48Y0/ry6N1j35ksVVatv0EAZ6Ke/9hD6OEjx4jD/wiG8aS3XABQ7Gv3k2zkUeHoJY6
 R9ekhZ1KuS1KkIo+Q/tpTfHQKkg6XBFob0wmgaojPPn1DHLkTqJW5dZYD/3gTnlX5IvA
 zRsM5LhUc219OMY5v4uO4/N456esmUcyH6/BEoU6Xu5n3ASNwgYSsQDjneiZxwPk88tz
 VnGg==
X-Gm-Message-State: AOAM530LIQhYC3lXU7eXFCJo91y44IWC+JEFEvEA5O5McvFiqGTWmhPm
 fCy8DsDNm5E3LfsCsxCz7lQ=
X-Google-Smtp-Source: ABdhPJxhlRv6m4SFyoe/Upnbuszt8P1UwfinLescZSQ/kUSOlQbYtDS8k0XVsG5Dsg6LerHwOCE23w==
X-Received: by 2002:adf:dd49:: with SMTP id u9mr11581879wrm.392.1601152038410; 
 Sat, 26 Sep 2020 13:27:18 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id f12sm3525307wmf.26.2020.09.26.13.27.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 13:27:17 -0700 (PDT)
Subject: Re: [PATCH 2/4] plugin: Fixes compiling errors on msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200926140415.1286-1-luoyonggang@gmail.com>
 <20200926140415.1286-3-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e70b6b35-e462-e51a-cead-0e2b77d409cd@amsat.org>
Date: Sat, 26 Sep 2020 22:27:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200926140415.1286-3-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.213,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/20 4:04 PM, Yonggang Luo wrote:
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  contrib/plugins/hotblocks.c | 2 +-
>  tests/plugin/bb.c           | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index 3942a2ca54..37435a3fc7 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -102,7 +102,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>  {
>      ExecCount *cnt;
>      uint64_t pc = qemu_plugin_tb_vaddr(tb);
> -    unsigned long insns = qemu_plugin_tb_n_insns(tb);
> +    size_t insns = qemu_plugin_tb_n_insns(tb);
>      uint64_t hash = pc ^ insns;
>  
>      g_mutex_lock(&lock);
> diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
> index e4cc7fdd6e..ef784be78f 100644
> --- a/tests/plugin/bb.c
> +++ b/tests/plugin/bb.c
> @@ -72,7 +72,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>      CPUCount *count = max_cpus ?
>          g_ptr_array_index(counts, cpu_index) : &inline_count;
>  
> -    unsigned long n_insns = (unsigned long)udata;
> +    uint64_t n_insns = (uint64_t)udata;
>      g_mutex_lock(&count->lock);
>      count->insn_count += n_insns;
>      count->bb_count++;
> @@ -81,7 +81,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>  
>  static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>  {
> -    unsigned long n_insns = qemu_plugin_tb_n_insns(tb);
> +    size_t n_insns = qemu_plugin_tb_n_insns(tb);
>  
>      if (do_inline) {
>          qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
> 


