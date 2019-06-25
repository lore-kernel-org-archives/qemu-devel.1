Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90017C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1D42133F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuEwxq2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1D42133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32992 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnEE-0004Nw-H8
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56500)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hfn7Z-0002FA-L9
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hfn7Y-0002uc-Hy
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:12:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hfn7Y-0002iR-4C
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:12:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id f9so18285848wre.12
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Z74vgaw59eEylXze3EjYHN602U16U7SY7oGfBB0aiHs=;
 b=TuEwxq2ZrxnrczTh97KLembddX7IKEXar12Vrpdq8Ckx/vBY8YXEEGiJauFmAXq7ro
 3wgE1NY9iB8wPh3S900+DJzkzellgYa5ME21dFYB9MjGPAX0gppDml+iUEzNIbLkvoyh
 18aTsBHB9ikc7G9bC4bBhk7fuecTuy5vOgnZRNoXwMQFE7TGeD6gZaywyx2w6En4p4mM
 qpTUghdyg9xDCvD7IlYHKq+F08+Zni7ydw6Z19J7j2CK+z0W6eiooYjhMruer0UzS6Hy
 939P2ckDVG151jwSy/FSkThspIKuTbECFQJC4eSHpbSDLhXWo0drOsfAU+BVKzQZa8aP
 jw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z74vgaw59eEylXze3EjYHN602U16U7SY7oGfBB0aiHs=;
 b=TnzGkzJPLZLhWtiuVFuiJT6BDJh9XCYMWcbrxOQWu/y/XwqUoKsuPNOyc8caZDE8hw
 XN2+BJNIjiDq75ylDX4Cm2xP8VE3iMbuDGC/k4RuNoUaZ0XZMRd4dHdeKON1GiDW5OTX
 eHRU8+Q6vOK9xcWq+G1ca9i38TsTVIa78nDXwgakZDHMyy/I8wBpVL0eBPQY+U13wx9m
 1+Ev5+mjNzdtWJoS4POHI8ZpCDTlIfFQ1qHxhZh2Z8mEAyKbAC+JTQCaGPblMR/1qpAI
 4gG5WrxQHLLu65AuY0FrnmJcqgvdBoi71ys7j2shRrfe7M7+Fb7xb4RedgvPPQm5A1/g
 Wf7A==
X-Gm-Message-State: APjAAAXo8s67dVZTEynqIwnhb+WMWQt9B600jQoSQ14XRVA+SlzHeYuy
 DHX1yygGDqJ4JqT77D/+0Quf+g==
X-Google-Smtp-Source: APXvYqwjTPp4aoeX14e4LQcT0giwQyjQYmQVjiKwrfdQAkPLau3p3XM6i+ahhYyFDnVrfAZpBZPdrA==
X-Received: by 2002:a5d:6449:: with SMTP id d9mr58704070wrw.192.1561475535487; 
 Tue, 25 Jun 2019 08:12:15 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id a7sm14997071wrs.94.2019.06.25.08.12.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 08:12:14 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1561116534-21814-1-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c7affa1f-2945-765c-6c54-ed1a26ab8798@linaro.org>
Date: Tue, 25 Jun 2019 17:12:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561116534-21814-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH RFC] checkpatch: do not warn for multiline
 parenthesized returned value
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 1:28 PM, Paolo Bonzini wrote:
> While indeed we do not want to have
> 
>     return (a);
> 
> it is less clear that this applies to
> 
>     return (a &&
>             b);
> 
> Some editors indent more nicely if you have parentheses, and some people's
> eyes may appreciate that as well.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, I do this semi-regularly.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


