Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D287C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31FE2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRZuA2DU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31FE2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZ0A-0005Zr-0a
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 08:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdYzd-0005B2-Qa
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:47:41 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:40318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdYzc-0005tT-EA
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:47:41 -0400
Received: by mail-ed1-x542.google.com with SMTP id l5so17530204edn.7
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 05:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/TXLj6zvco1PAq2kB2sFUegAJlTZU0Vz1bJHhkwyhbA=;
 b=RRZuA2DUIK+KtmHHyIKebHfaj76VWFQxvOK1v10Zh/73uS20qwJYgdEmmAmS2X8IHA
 7JlIEP2gsFOyzYYpaP07dOue8oCCc/w1nxPKDFIngW+5z/s/yh40ycrvo054ORyEMOYQ
 BEcdAov4P6e4RRIHJP3zO7OaaIKyJFRI22BgjVYXAVyVKMlaUaNHAQkGW565TI2q07vv
 rltdUq4jtDEjdUeMnti3atknUQ2BGo9nOjXOMTZ9R5XunykMltA2Fa6t8t7Gv18fZbto
 a3TLFGQkxGHF7kiBKlM/fgnOLYJVvTShpOAxMc6MubqTGMK/rdMUQ1dCNFmHgNab51W7
 bchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/TXLj6zvco1PAq2kB2sFUegAJlTZU0Vz1bJHhkwyhbA=;
 b=O9iPnrL3O3mwD26yUmNjRs0UWzPN3ud12Qu6VcKDrZ5gT63/SMXfLjEz58pv2WPK6V
 tfiBYCE2j8Zh81imtgFondBMaObB1hoJDZf/RRY8h4jRLVKWVDEBOpCIPF60KOc+goog
 7fFwB25O7NSy3NYAaAN0fpoTmTIup2uFaRw5dwUZKMOZVhVRJr8/SWN8PA8NIDMTrHhZ
 P72Coz+IF3iR7zN4ocjYwcbyihqoQU+X7s7zD3hi/B3tQdjLWbrr8OSjJKGXCXH3RFke
 8JisIz941tHoYazzSSeX257vQjGa5BgI6s1KmC7wB6XDRbWxZXHjjLn3iWIqGiGrKF/3
 O17A==
X-Gm-Message-State: AOAM533epkahPk/ImzsBm3Ke7L6gIJbO4LTQuPvnMQMyel4+UKQZf3dr
 WObSj5XoYU/FvOikmBh0MMA=
X-Google-Smtp-Source: ABdhPJx+Kj+HsXR1tJ6zoyMG2trQa7FXbqdINL8ZJc/MSI/M2hk0GMy/DgkqcsqX2EJ1PtaxoxHlzQ==
X-Received: by 2002:a50:9e48:: with SMTP id z66mr18979663ede.388.1590497258369; 
 Tue, 26 May 2020 05:47:38 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id wr20sm4273249ejb.27.2020.05.26.05.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 05:47:37 -0700 (PDT)
Subject: Re: [PATCH 10/14] hw/mips/fuloong2e: Fix typo in Fuloong machine name
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Peter Krempa <pkrempa@redhat.com>
References: <20200526104726.11273-1-f4bug@amsat.org>
 <20200526104726.11273-11-f4bug@amsat.org>
 <20200526115353.GN2995787@angien.pipo.sk>
 <CAHiYmc6csbt=fLhFtCMorCgbLd+kbBRoWO+gKdbDG_0x6NxyhA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eefb3633-cca0-29fa-0123-aa9ebbbc10ee@amsat.org>
Date: Tue, 26 May 2020 14:47:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc6csbt=fLhFtCMorCgbLd+kbBRoWO+gKdbDG_0x6NxyhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 2:37 PM, Aleksandar Markovic wrote:
>>>
>>> +mips ``fulong2e`` machine (since 5.1)
>>> +'''''''''''''''''''''''''''''''''''''
>>> +
>>> +This machine has been renamed ``fuloong2e``.
>>> +
>>
>> Libvirt doesn't have any special handling for this machine so this
>> shouldn't impact us.
>>
> 
> Well, Peter,
> 
> I was also wondering libvirt listed as a recipient, and I think it
> creates unneeded noise in your group, but Philippe uses some his
> system for automatic picking of recipients, and libivrt somehow
> appears there during that process. Philippe, either correct that
> detail in this particular component of your workflow, or change
> entirely your system for recipient choice - the current workflow
> creates incredible amount of noise, wasting time of many people.
> 
> This happened before in case of deprecating an ancient mips machine,
> that absolutely  doesn't have anything to do with linvirt.

See commit b02c9bc35a0:

    MAINTAINERS: New section "Incompatible changes", copy libvir-list

    Libvirt developers would like to be copied on patches to qemu-doc
    appendix "Deprecated features".  Do them the favor.

    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Reviewed-by: Thomas Huth <thuth@redhat.com>
    Reviewed-by: Cornelia Huck <cohuck@redhat.com>
    Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

What says Peter is as a libvirt maintainer he is fine with this
deprecation, as it doesn't have side effect on libvirt.

Similarly with the previous "ancient mips machine".

> 
> In some large companies, there where some analysis on how much is the
> cost of sending an e-mail to all people in the company, in terms of
> wasting time on reading or just seeing such email. The result was:
> such single e-mail costs the company $2000 - in wasted time of its
> employees.
> 
> Aleksanadar
> 

