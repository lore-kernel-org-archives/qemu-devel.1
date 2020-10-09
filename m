Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E555CC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9640D22276
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOPrQ+D1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9640D22276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvCO-0005Rf-Nr
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQuza-0007J5-9D
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:11:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQuzW-0002RC-AE
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:11:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id n6so10571862wrm.13
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mqxFxVOr8tdiQL7hqF7/ddTzf0u7nrTMIJtH/RfDeYA=;
 b=AOPrQ+D1H/ZPWq26dfVdNpd6ZyItHmuGPEuiezkwZKIF3ULGrOkmUp0G/3SGOT/x/u
 AGsqid/KAdfaHCOhFPhTcD6FS5xo/answkzcBC99UAbzg3QF2QipjXez1eCOYbTRBbGd
 /dE6ir4G9X6WaEMcgyk8xgD7hQCi3MslWUENav/JV6neOO4B2GwOqtbaJbdZCu57GFed
 RhPWXDmk/zQPtqa0N8ricTk013wrpR4iDaUikJJWbfYoQdA5GSoGLPhLHV2v/6cyrw5g
 mslKkyEtPU4dpfgx5ZjCyiAk+p99ewAQwCpCi5p8jqVWK0LjkHByQ3JuPY3qGdJ6w6Bm
 9Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mqxFxVOr8tdiQL7hqF7/ddTzf0u7nrTMIJtH/RfDeYA=;
 b=E2G0pngMAGrfW8MwKj/UgiZamrAhD3KSLkjNSEB2FfYYkVC0dhMp4WwFLj4zvH5d+u
 ibh029Mg+MAeyXEv2o5s5q4qQSAZGPrbMGvJ3pkc57aC3sfNh21CwSrU0a7gvpseKmfZ
 mL36PIu7fP3muo2E0lxwz9lQp+wRLHGQB7UGXojjfaSsLOrx4Kj4b2DQxofO/ckYOKym
 uY6CK948si7Boe1T7eFCznrMHcskllIqMmk/44TY20Pcl6UahBQDHMMAsZBtFFVuDTLq
 ruSxz4rQOfWXixJzXGSzlfcSQb3AaUAAZhHXgKFkqmisht4cW9T61iME4pXdPbltpinD
 +KLQ==
X-Gm-Message-State: AOAM533mHw9DhrvhzFmisRH4TzhGUqsJ6q2q4rJi77ZaOK9fuzftNcNM
 tN/A8iR4c6IFOBO59+XHY0A=
X-Google-Smtp-Source: ABdhPJxx9g4DOUVdQ5oMOyVRLKwZP3EbSX+yado16ePf5Ea/zdWWp93NazgJKBvxSPQKWvcQwhWSFA==
X-Received: by 2002:adf:f989:: with SMTP id f9mr2655271wrr.22.1602259892784;
 Fri, 09 Oct 2020 09:11:32 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d30sm13767406wrc.19.2020.10.09.09.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 09:11:32 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] hw/mips: remove exit(1) in case of missing ROM
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <159531210010.24117.10018704762356020189.stgit@pasha-ThinkPad-X280>
 <159531210571.24117.231100997794891819.stgit@pasha-ThinkPad-X280>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <83988fc1-2d25-7064-0d6f-25179f94b449@amsat.org>
Date: Fri, 9 Oct 2020 18:11:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <159531210571.24117.231100997794891819.stgit@pasha-ThinkPad-X280>
Content-Type: text/plain; charset=utf-8; format=flowed
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
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com,
 antonynpavlov@gmail.com, aurelien@aurel32.net, chenhc@lemote.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 8:15 AM, Pavel Dovgalyuk wrote:
> This patch updates MIPS-based machines to allow starting them without ROM.
> In this case CPU starts to execute instructions from the empty memory,
> but QEMU allows introspecting the machine configuration.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> ---
>   hw/mips/fuloong2e.c |    8 +++-----
>   hw/mips/jazz.c      |    8 +++-----
>   hw/mips/malta.c     |   11 ++++-------
>   hw/mips/mipssim.c   |   10 +++-------
>   4 files changed, 13 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

And added to mips-next, thanks.

