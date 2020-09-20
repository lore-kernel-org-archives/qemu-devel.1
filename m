Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EB6C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 22:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1463720809
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 22:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDnRqAgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1463720809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK8GX-00045k-Or
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 18:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK8Ff-0003dj-Kj
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 18:56:11 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK8Fd-00042f-TE
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 18:56:11 -0400
Received: by mail-pg1-x544.google.com with SMTP id g29so7240510pgl.2
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 15:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0cXQG9o2GcHMOn8RkT2ARkw1I1bF8kleiMVr4nRZYMs=;
 b=EDnRqAgZzWWNmzBAIIecWpSYw8k3qxOC8/eEQGLKn7HQGeTRrapiny/wIlxvNrvP4L
 8unQXlvd8JanwaMx8/n3RgIkd8RiDZr1FZ3ChAAEm4uRGYDHI0SFscHju0g7WRvS8p5H
 HI4XGgi1FAaIaFsu8Q99I9sm+zJG6SOahph5zeJIAPcTyEnWYvVhDaPsv6uY6MrZ900+
 xnestqg69/Eww7sEoX5sw7AGPwy4c3Pm0G3ZhdvKs4fEf70tyYMbLy6KM9Pgp0k+WAvq
 7NB5lqMjDfzSwOeOZb63BhWD+4q+KmMkjyjM4AmEZitugPm+DzpFrvz3oUTSRUS9VN+R
 aa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0cXQG9o2GcHMOn8RkT2ARkw1I1bF8kleiMVr4nRZYMs=;
 b=fKcpDlfNJBd0S9utrsxVGd2zAIYoxdjSPFewRHcMI0ZAuTV0ep27lhgNTtzdolW2eR
 i3hlau0k6ERSTei4H9RuPHTJG4/V/s9YxhJil+mEZr5jwhL5LcvA06ockGXBmN30Itop
 OymRGgfyIq0QU78u1Lt9+33jZCTy5g4JbQNc0kqDKGrTR3BbcBwEyzOJe4roRQwxWjLI
 fBQkqcZPmYlJQ/x7nK9FlJgpBFeVayQbRK29q5sFvH2eciwdCDdmCwL9LYaq9JTsJGlr
 1StjFTQQUKK4vKgu4Vx6ZSfFChlofGZxro6j2IriyQXd5/1X577wav79l+68IIYNX8aU
 zjTw==
X-Gm-Message-State: AOAM533xLLv5+WcZhm7GYo+m7sZGenfmpm15ylq+lfidUlZS+Nr9xnSw
 8kEI3cb7ykfqrzl35GDgzb9Uiw==
X-Google-Smtp-Source: ABdhPJzb8+gUfaJ64aI2itWPiPG1IOEJQwu5SoQqOg0zpebFfehKDLi3OsgWIBkIkGxxp2VJtuFr0g==
X-Received: by 2002:a05:6a00:1b:b029:13e:d13d:a101 with SMTP id
 h27-20020a056a00001bb029013ed13da101mr40056631pfk.29.1600642567552; 
 Sun, 20 Sep 2020 15:56:07 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 64sm9937860pgi.90.2020.09.20.15.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 15:56:06 -0700 (PDT)
Subject: Re: [PATCH 0/2] qdev: Let BusRealize() return a boolean value to
 indicate error
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200920114416.353277-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f8ae3d44-24c3-4e89-3181-27eb759e3e78@linaro.org>
Date: Sun, 20 Sep 2020 15:56:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200920114416.353277-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/20 4:44 AM, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (2):
>   qdev: Document qbus_realize() and qbus_unrealize()
>   qdev: Let BusRealize() return a boolean value to indicate error

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

