Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DABC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 12:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8EA20724
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 12:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0frRrXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8EA20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js3Km-0005PJ-8E
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 08:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1js3JF-0004Xt-TW
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 07:59:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1js3JE-0001xR-Fg
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 07:59:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id f18so38714482wml.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xip4iIWjy2tZTuHAP6nAVpp4WrUzttgBsvbXBRZwHqE=;
 b=k0frRrXGjFsArAJvpgEzMa8Ush18esxxro4vvBDeLLqEQ+xAaShGN7n3CSl6vs0AUe
 bDNPR0ulbmzt9iry68uTY/C422SbG0jPk1NyIq7kAQOwj+CbTbWHByOf+O/p0b1t5PHg
 1RTgICPRYSajSOFt0iNOds30EbXezi6B/4HPla3qdyxMsDqBdr29QC8SvkKUqYqyaPpg
 f2QFg831rZ/P7OAoMOr1xiVu8676hvAGIzS0ABPd5RT0GGS1OTb+lRsJWj+qGxwYao6C
 QiVtA/7PWnyT3wGYaZadfQTjLOQMRjzbXRxrDpM05moiVU0XFmAnXm8rTQBIp0iAhgIF
 E8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xip4iIWjy2tZTuHAP6nAVpp4WrUzttgBsvbXBRZwHqE=;
 b=KRGMR8hz+3YMEgDR728/1WZXn7qBUAO9QVgSZehDlwf/JIzEgL4ezY92AnjH+V+DDv
 S2p0zl06LoXFAp7sSP24cK+W9rdMFGp0VQL5WrhgrZMf0jbTGp5UOyfBIGZe2LsybJh8
 UjxUDYfgxWoHKBeJ7IHv2wDMddlacNEkSWUkoIivbDeUv5e+oP9nHTtk12S9of4ATLFy
 3A8+G6gnFMaE9Ov+VhT5w0KLG0mbFwHRMUlfkjdSlI2fvWtG2qy3HN5OfJJ/R/jCQqI8
 cTxZqCqoJQV+Ml1wBFh9Ej2sqrXPv2Nc8hIlpmVCZMsh4pQlYQAJc9OwbBot/CdRPeI1
 vfFQ==
X-Gm-Message-State: AOAM533ZOKSjGyZg2q2KdtaMSEJBG1Q0/aH+AHZzCnV9VwPU5p+2f108
 7AFw4PWLW2FMEuwlLwIjQKo=
X-Google-Smtp-Source: ABdhPJzxzGjTudkP1NuzuJ+YSRGZ72fICV+0TFE+tui4Wvcqxj5v3l3qPs+7inuTYviAbufv8pOOaA==
X-Received: by 2002:a1c:f714:: with SMTP id v20mr43388622wmh.81.1593950386960; 
 Sun, 05 Jul 2020 04:59:46 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j14sm19714552wrs.75.2020.07.05.04.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2020 04:59:46 -0700 (PDT)
Subject: Re: [PATCH] hw/core/qdev: Increase qdev_realize() kindness
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200620153837.14222-1-f4bug@amsat.org>
 <c0366cb5-fcb0-ff62-8ab5-92722a47d4e7@redhat.com>
 <65937a53-5430-e5df-a5f0-de93dad315f2@amsat.org>
 <CABgObfYbqHh6JZZ4z_KUovekUH2yac17oQr0WH6K9GkdEz6rkg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <70eaca09-a869-2c7b-a63f-a019f28baac9@amsat.org>
Date: Sun, 5 Jul 2020 13:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CABgObfYbqHh6JZZ4z_KUovekUH2yac17oQr0WH6K9GkdEz6rkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/20 1:14 PM, Paolo Bonzini wrote:
> Are we sure that qdev_realize is never called with user-provided input?

I am not sure, but ...

> If it's a programming error, the call chain will end up passing
> &error_abort anyway, won't it?

... this is a good point :)

> 
> Paolo
> 
> Il dom 5 lug 2020, 12:05 Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> ha scritto:
> 
>     On 7/5/20 7:46 AM, Paolo Bonzini wrote:
>     > On 20/06/20 17:38, Philippe Mathieu-Daudé wrote:
>     >> -    } else {
>     >> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
>     >> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
>     >> +        error_report("%s: Unexpected bus '%s' for device '%s'",
>     >> +                     __func__, DEVICE_GET_CLASS(dev)->bus_type,
>     >> +                     object_get_typename(OBJECT(dev)));
>     >> +        abort();
>     >>      }
>     >> 
>     >
>     > Since there is an errp, should we use it and be even kinder?
> 
>     This is a programming error, not an user triggerable condition,
>     so I'm not sure. IOW this must not happen, but if it does, then
>     the error message helps the developer to notice the problem without
>     having to use gdb.
> 

