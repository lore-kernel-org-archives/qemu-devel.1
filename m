Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CF1C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D145423101
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imDuAz+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D145423101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xrY-0003ZE-24
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xoF-0007M2-HM
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:09:27 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xoE-00086U-1E
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:09:27 -0400
Received: by mail-oi1-x244.google.com with SMTP id z22so10849427oid.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 08:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5T3vvH/LeqXm8DwXHoU8lE0ToBXpq9dGcDYSNnFUKmE=;
 b=imDuAz+VINPDTqxtRFNeWk2wUhDG8SBBd+ymndewh2LddV6a+gXMjiX3wzyDouoE32
 Zhmh4XqLsXaid392T2IEpNWqxagvJXq+c8Ch2SnWnlqAstSDTz+8G2u//JMqMdehe3f7
 +K9b04QufDlIGoXlMbivsYSn3VKd86tx+lU+kteUxzzXzn8DECUE2/jXKCr19Uf2BPtq
 NRA/j52dNbVETwyCnx3ai5+lB06oe8GQRqCRF+QDVuL+P3fLvC1a0j5Gh/PUXGl1bX0x
 rBTD61IVqHCHTcg//w6OMhimH9elR9AS9YZ/Z052zUfX60jm4aour/2f+eIkFRp1b69l
 bNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5T3vvH/LeqXm8DwXHoU8lE0ToBXpq9dGcDYSNnFUKmE=;
 b=aO65KSu/BLD3T5XToTOPMxpi8UGRB9Asa4QO8G490on8HURzsQeDf4c0INc/Lg19Ut
 Ztg4h2mLpDGk2hd7XB0Qnqd1bReqImAm2qBHx4t1rQ0N+yKs7RiyFpY2o0/vmlTX9vre
 bcEuxiyCnfNwiTYIM7cRXk/zIEf7g+7aQ7nT5HuY9CJqchy2q15EisZb6K5lke7u+7Xu
 OIDwxUukhXI45p42o55sHWYthveQ7yPAk8hipeoEOvuwSMuVH7v48ydzoEPXFWMfjQnN
 3unOgOFjsh/EhqO0qgEwbR4RJTaukvoJtYjYNlTgRsCkwyzwJMnyXENW7Wq4c7a1Kxqz
 nuGg==
X-Gm-Message-State: AOAM530PRMrtbBDvVvVjQC7Rc2TOEzbW92LFsJaBgyxy1KIyVRX90fpt
 OUkbZC5y8q7XFxc6NG89nWe7lXAlf6aeIg==
X-Google-Smtp-Source: ABdhPJyXOQrWwXUUS9JSv2KF7xvzMJR2gQpBvpIhEKhR3mhfWpcg5Jg9jr/ubjlLYFb98e4LmT37cg==
X-Received: by 2002:a17:90a:ce8c:: with SMTP id
 g12mr2466429pju.23.1597439022217; 
 Fri, 14 Aug 2020 14:03:42 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v128sm10445803pfc.14.2020.08.14.14.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 14:03:41 -0700 (PDT)
Subject: Re: [PATCH v5 12/14] whpx: remove whpx specific functions from global
 includes
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-13-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eec337ae-50a7-1c05-8bea-2089567223aa@linaro.org>
Date: Fri, 14 Aug 2020 14:03:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812183250.9221-13-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 11:32 AM, Claudio Fontana wrote:
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  accel/stubs/Makefile.objs |  1 -
>  accel/stubs/whpx-stub.c   | 47 -----------------------------------------------
>  include/sysemu/whpx.h     | 19 -------------------
>  target/i386/whpx-cpus.h   | 17 +++++++++++++++++
>  4 files changed, 17 insertions(+), 67 deletions(-)
>  delete mode 100644 accel/stubs/whpx-stub.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

