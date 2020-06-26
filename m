Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CCCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD682078D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmZVhD0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD682078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonk4-0006jB-IB
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jonhh-0003yx-0E; Fri, 26 Jun 2020 08:43:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jonhf-00039J-6R; Fri, 26 Jun 2020 08:43:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id o11so9359026wrv.9;
 Fri, 26 Jun 2020 05:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XzN3Ti3jHfNmLU0iM6qTN7hq5zwOtVlTg0MQpquiIh4=;
 b=HmZVhD0uZhTwBYTcY8EBspJu3leYInkXXS4EJ+v/22IBVSMDCm9QqUVqQeHLRgRgTI
 LmUNcEShZJNrmUlzertzjmuoQRRqLGIP7NSObbudoqU2aLyEoNLL7JxPa77NLgiFt8w1
 TnxX+INle9jiXXiXPZgP7fs15LXNMLjzl+L5YzCQWOhuTsbsxYeMNJWFUk1EwQOAABMz
 cQIoCFVX/JCEIHCE3ilvkocDy8AMqTx4+qy9yQ1LISz+pFy++7BBA/BzTg/29WHmROdm
 pWziHRFYLeUcwTFqswcOAdG6iNO3Jc93el9jVpSiVTx2agj9WcaTFDKjwK07veo6ug94
 E5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XzN3Ti3jHfNmLU0iM6qTN7hq5zwOtVlTg0MQpquiIh4=;
 b=PzQiK6Lp0uABnJm98bUG+Orq8EWJUS5IRRE2FrvpL7zBSVmdQAs6kqL79mg4kr+4wD
 f8SVueC2edpCji8mnkz7lkHf+lFOuZZrz6R+fJirDq/m7LYV3S+zF6dXjBEM2bJoguzc
 3HJr4jLEdUFVNnRRoTm3axXsa1n9ivxVLP0+cFEIMfX/a/XYUx1xg3DD2iRAUXVyfxuM
 iOd3eHMUUafShOjalT4PrLWPdnqlHR0UUOWxFFKkTna97VCuA+WtDxTEfH4vyXRgN95Y
 rNv5fOI+RAiBOin+q8JYqRH0/z4mFIQsEIIfSmUpQH6kswPes7L7sRyLI0Tul0422fuM
 xxQw==
X-Gm-Message-State: AOAM531M/rq431BE9fN+69V5r04KXCaiTofTUZ+I1d1Uk0M9eG26IqPA
 CDI2MdNka9iV4IKtsulxNw4=
X-Google-Smtp-Source: ABdhPJwQzI2PTp2/+k/Mk5Yabq06+MAFZg73qzyqHuT3iz+LtdD4ysG6C5j+NeY6tMuy9nIrxi6XSw==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr3589795wrw.197.1593175413139; 
 Fri, 26 Jun 2020 05:43:33 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f2sm16388159wmj.39.2020.06.26.05.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 05:43:32 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Use object_get_canonical_path_component to get
 child description
To: qemu-devel@nongnu.org
References: <159316787115.28361.2817459306009703594@d1fd068a5071>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0d066fa5-5d3b-5439-5f90-35ff099d5678@amsat.org>
Date: Fri, 26 Jun 2020 14:43:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159316787115.28361.2817459306009703594@d1fd068a5071>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: patchew-devel@redhat.com, cminyard@mvista.com, aleksandar.rikalo@syrmia.com,
 armbru@redhat.com, jiaxun.yang@flygoat.com, aleksandar.qemu.devel@gmail.com,
 qemu-ppc@nongnu.org, clg@kaod.org, chenhc@lemote.com, philmd@redhat.com,
 aurelien@aurel32.net, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 12:37 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200626102744.15053-1-f4bug@amsat.org/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>   CC      aarch64-softmmu/hw/arm/gumstix.o
>   CC      aarch64-softmmu/hw/arm/spitz.o
> /tmp/qemu-test/src/hw/i386/pc_q35.c: In function 'pc_q35_init':
> /tmp/qemu-test/src/hw/i386/pc_q35.c:310:9: error: passing argument 1 of 'smbus_eeprom_init' from incompatible pointer type [-Werror]
>          smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
>          ^

This was announced in the patch.

Is there a way to give patchew a hint that it is pointless to build
a patch/series? Other CI services provides a such feature, i.e.
Travis-CI skips if a patch description contains '[ci skip]', we could
simply reuse that for patchew.

