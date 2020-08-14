Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6445C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECB720774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A9YLwV5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECB720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6gXp-00087N-Qx
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 16:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6gX3-0007gr-MW
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:42:33 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6gX1-0004hi-Dg
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:42:33 -0400
Received: by mail-pg1-x544.google.com with SMTP id o5so5093077pgb.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wWYeYYtJ4jfK/vsHtQ+6cQxEoPl0GC6p1GQd33GbqH8=;
 b=A9YLwV5ilEUBFF/RZYSYonGn7hjzayxJB1Qg+/YKTNXMpHGlQq9kyW3p1+BMhBDI5n
 pPLxO2C8PMk1jhxdiHXU6Bg+YAVh/r9d3V4kLz/JVXZuKMKzn976FtAead2X2CF2peIq
 ANc9Zah4PNG8WYhNZH6hqoGwhEsiGuoTM7vwD/Hp92JUhMCQycDVkPwVvQbWaKCOynTr
 one433ht5PkCSzZfF73vkwwLxw0RwBJULDrj11LjQ+g/dd0X8SXIPYso96HVJ2nw3pKk
 jdd5+w2UdNYfqvtE6GyJ/OBbRA0KritU0FFjJBsOOMl9OEwOOHdDhVktY6eOS5EERPH8
 ljQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wWYeYYtJ4jfK/vsHtQ+6cQxEoPl0GC6p1GQd33GbqH8=;
 b=i8ABE6NnQplDhdMfC4xwH4g4h+XRObNCz8GnT7RA5M2FzSC5BQxaeM/DLXJyNsDcn6
 bCzmtxKc72uhKppD9e6wH9I5C7Hf9BOB11gLcc415Tz4WFOiua8BrSodYnVUtIwmkvGu
 zdaLSujcHu8p+tXpvkbMNHFnOYY1Sk8/7Qn3tiJ0ctp5CbMwIl1YLTjKrYJKfAhYZ3tA
 81bvRfI2jmdalTsvO2MC9ViXyaxD9UpcQHWZM8zLvEEWQKdK8le4EyRuOf4dJMSnxAJX
 NpXwY9uVqqA5c3zpWs7ozGH2hemKSfWob+8JLZYRo1Do3qpxwYVH1BV6yuAOWFu04bzP
 Df8Q==
X-Gm-Message-State: AOAM530IPkh+1RUU9vdVKuamD2tAn0twzWfzaRJ1ijIhGefRRSs1bdLN
 B6y8usOn5zPEfG4jr8mma729kA==
X-Google-Smtp-Source: ABdhPJz0RADxkpjfvP1p+KRSlF7D3i+pwv+JA0paQ5NgjwM5V69SpnQzQkd1FLWDRp0z6BXF+7H1rw==
X-Received: by 2002:a63:b70c:: with SMTP id t12mr2834256pgf.178.1597437750088; 
 Fri, 14 Aug 2020 13:42:30 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q16sm10532536pfg.153.2020.08.14.13.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 13:42:29 -0700 (PDT)
Subject: Re: [PATCH v5 04/14] cpus: extract out qtest-specific code to
 accel/qtest
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-5-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2294076f-aed9-daa8-54e8-701993e32f09@linaro.org>
Date: Fri, 14 Aug 2020 13:42:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812183250.9221-5-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
> +CpusAccel qtest_cpus = {
> +    .create_vcpu_thread = qtest_start_vcpu_thread,
> +    .get_virtual_clock = qtest_get_virtual_clock,
> +};

const.

Do you need to fill in the other methods, even if they do nothing but
g_assert_not_reached()?


> -        qemu_dummy_start_vcpu(cpu);
> +        assert(0);

g_assert_not_reached();


r~

