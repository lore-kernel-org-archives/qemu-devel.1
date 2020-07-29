Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A2EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5C3206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7+IBeJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5C3206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0shg-000153-Ub
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 16:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k0sgf-0000a6-U3
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 16:28:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:33187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k0sge-0003qF-9U
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 16:28:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id f18so2893558wmc.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ydkhojysSmdF6nzXLs/y+VwOMrY1rtpcsJiVA4yzz7w=;
 b=E7+IBeJksqwpCh21Sduj9ThJud0+tVkdrtdy0ALXIBJocB00bj6oWr1LOmK8E2tMs9
 MGTGSNjZR2PKnCoFvR+NFbQ5e+48mAVZPNV9cTEQy3UlsE+45MhndD8crfjx1o0sIoBo
 iBi1F+PTguIybfODqdA+GEh53sJX593oQmyWZsH5AOGkD2T1MVugDT0c/+4pOR9AtKGl
 +X20Awl5YuWgKUKEeYZq0HGf+Jbvliahy1YbUESsmMlbklSUYxueydRFVZOeBmdBvUGA
 XmwXZxf0c8xPTUCqsJuaGLu/o71Fvtkdo40TFOC2YYGiG80nebHr3qYf07dMlWrEDYy/
 +ZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ydkhojysSmdF6nzXLs/y+VwOMrY1rtpcsJiVA4yzz7w=;
 b=tJNrByXYSLK+GcS/cw4ZdjZYaUl1fJFH/eXlTn2vE3H4yHwfcYWahuCUFa7z6bWdPz
 a4PQEdWUXzny2OLSxfMqlu+8qM28ZdO11IQEuUmY5OIzEcJON2sTQN7NLLQ/OhiwrHc0
 j/Wyg17pLxnpJo2UFYebRIpQjVH8vy7BkADiigmcY4/F+DsHoZuZb1RJqdgueWikRTXs
 uFU5B9DeuymYJVFN56gQKLf7ofGsHXHDlrdW6jscooj2uaCmjB15F/MAL3QMSp1h3NhJ
 AkgH8ASuByriH3TLC1dQaccpo6Y1bJbVEmxOy7eJAHcGb9ev6Y53GR8q+FOtSWM73n/K
 91Mg==
X-Gm-Message-State: AOAM533l4ZqVZHQ6XKKIzoEe/jCzvFV70YGmy8pPlpO3v3WGgC7bwXDN
 S0v306sTNTtqCvCBqFLkp6F56abp
X-Google-Smtp-Source: ABdhPJzOutDjWOmUD0XFa3wEsf8rIt9C8CwJyK4v0Nlx2fusBax+m/U7O2l/WPXUqx/qpMks0aijuQ==
X-Received: by 2002:a1c:5986:: with SMTP id n128mr9662353wmb.112.1596054506189; 
 Wed, 29 Jul 2020 13:28:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6919:2bdc:27d1:5e7b?
 ([2001:b07:6468:f312:6919:2bdc:27d1:5e7b])
 by smtp.googlemail.com with ESMTPSA id d11sm781425wrw.77.2020.07.29.13.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 13:28:25 -0700 (PDT)
Subject: Re: qemu repo lockdown message for a WHPX PR
To: Sunil Muthuswamy <sunilmut@microsoft.com>
References: <SN4PR2101MB08805B8E85196354ACA49B54C0730@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: Paolo Bonzini <bonzini@gnu.org>
Autocrypt: addr=bonzini@gnu.org; prefer-encrypt=mutual; keydata=
 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
 10oh++mb6s1dGf3ADAaOTRf8
Message-ID: <c0ff07b6-87bb-f0da-d345-71e62e6c8ef6@gnu.org>
Date: Wed, 29 Jul 2020 22:28:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB08805B8E85196354ACA49B54C0730@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/07/20 21:19, Sunil Muthuswamy wrote:
> Hey Paolo,
> 
> Following your suggestion of creating PRs for WHPX changes, I tried creating a PR https://github.com/qemu/qemu/pull/95
> 
> But, I am getting repo-lockdown message. What do I need to do differently?

Hi,

I was not referring to github pull requests, but rather to a maintainer
pull request.  This is also sent to the mailing list.  There is no
QEMU-specific documentation since maintainers are generally experienced
enough to have observed how these are sent, but the Linux documentation
more or less applies:
https://www.kernel.org/doc/html/latest/maintainer/pull-requests.html

In any case, I suspect this misunderstanding is a sign that I should be
handling WHPX patches for some more time, which I will gladly do. :)

Thanks!

Paolo

