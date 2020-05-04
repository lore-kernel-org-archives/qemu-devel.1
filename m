Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EA0C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21AA20663
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOYc0zXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21AA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVf6B-0006HR-TN
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVf59-0004yG-At
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:40:43 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVf58-0005Z2-FB
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:40:43 -0400
Received: by mail-pg1-x542.google.com with SMTP id l25so98764pgc.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pIm66RInHb+qZxnnCyf3TXTDG9MbmDn+wmNd/nOa+bI=;
 b=JOYc0zXcBxawgrB/+nxfnanoYg2M5U6+/8n/gcn6aRe8AJE0Ih8qmgxoXW5FzMlAw7
 CZFDLfjC+zZTiIpkG+mf0OnWAKfTmzKCUYLRS5UC4e0PZpl7qkDhsSdM7XXu/5S1inMD
 c/Aeg2Ra0mJHJ/SDqjWfGWMahPeBSAPVA7vqO18+3ww/xiryQz12x/JY9rrbEtXCGYT0
 4VmrMLov7NLA/7GZ1d2xYg3yTUMNorOGN+JQ1zVPUMb+r230K3uyVK1xhsGImMedPlAT
 QmBh2XEnKgyA3HecIRcSXVgIbyUsrnnfJTTrx/C3sRPB0ByYiLWGWC35wEDJwcaOSkmJ
 85vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pIm66RInHb+qZxnnCyf3TXTDG9MbmDn+wmNd/nOa+bI=;
 b=A7IWXin+4kldvcfRfOLCEJb4TOCt5Jp+GL/m+3M39nOKnitMCV6cc3+QaxBI8e98o1
 l1rCHd4EBI6EmLFhbmpMAX7vDJuBc7d81QZ8/jJIcpWTblfLKKUDRP86guAkPzgKL5Dq
 ezvjG/zFqBPiL41pp0YZR7KV1J85EaxZnmi579fKYlC99sEKfQ+7JUIbn3Ug5xX9ZSto
 cUGQObMOhZ6BmsYKznfDJy/4gjgesYK+qcxMDH0ta5Fl6vkvYKLP22eLZTSiTv51K5Jh
 iALgZKO3jS+Ey/UJFwtZoboFSfu8ZdksXKBqTYXHcqxLW0Ib55/p679WENO8D8YmYRER
 Jt4w==
X-Gm-Message-State: AGi0PuYSIIyPa3e18NiPj1Dsooqy63orNhB+SCziiMBur4lnpZdx7RWt
 BhpHLTqa+ugcRAOipxKw2K2AmQ==
X-Google-Smtp-Source: APiQypLSAWhC3Lz0WodJzRzAeX//re/UrzJPYMhhAG/morl7zPBHmuYRi/e+0mr7GCHRxzsph+OC/w==
X-Received: by 2002:aa7:9ae5:: with SMTP id y5mr18366187pfp.294.1588614039027; 
 Mon, 04 May 2020 10:40:39 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b73sm9379658pfb.52.2020.05.04.10.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 10:40:38 -0700 (PDT)
Subject: Re: [PATCH 1/3] qom/object: Move Object typedef to 'qemu/typedefs.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504084615.27642-1-f4bug@amsat.org>
 <20200504084615.27642-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a2da9461-b762-1757-3df3-e30a801b75bd@linaro.org>
Date: Mon, 4 May 2020 10:40:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504084615.27642-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 1:46 AM, Philippe Mathieu-Daudé wrote:
> We use the Object type all over the place.
> Forward declare it in "qemu/typedefs.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/qemu/typedefs.h   | 1 +
>  include/qom/object.h      | 2 --
>  include/qom/qom-qobject.h | 2 --
>  include/sysemu/sysemu.h   | 1 -
>  4 files changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


