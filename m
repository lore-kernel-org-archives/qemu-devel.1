Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1F9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480E920760
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxDeJwwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480E920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUSw1-0006GL-3p
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUSuD-0005at-0i
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:00:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUSuB-0002fL-6O
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:00:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id h7so10913970wre.4
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JFNDduS/dhIP3PklVjR1vGIVrXkQwGl/ToogdmJMisQ=;
 b=KxDeJwwlTAfXm5fSgg6IdwO8OkdevGTWBwnO0fQrK2Jj+7sYxK/nL9fF4g1+3IQezO
 ileVci5p7KwIkznaI4qSInFHUUziLhO5YIOFHOso9fCZveQiZPC3wtgKKLM2867vgDgJ
 czHRCbFbRypVyr19pzi79mzWW0TraC4lgFoQrZyxv1OeRgjk7IcGkPZSJojjxo8AU06h
 2SYtDBcngo6Kegp4MR/rUe8N/9UN7v4tymCTmgsrnxwFEWdbLe+pfTSw+MBx1aYGZ1RB
 pZ1BuWlojVAm4CLcaWwo6DpFYeIXWRNgFx/Gr6r5MjzD7A8hJU5x818o+0zEiSUxyKmB
 k3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JFNDduS/dhIP3PklVjR1vGIVrXkQwGl/ToogdmJMisQ=;
 b=bIExOvbNRVFdFgsXKgDSFEoQ9stjqTyM7J7WEo4ZqXpB/ooeNJc3Eymgd2Zl/BbtQ9
 KWsIAZgadIaeRNEiQW6Ue+NCaTnior+EW2eF1mYihU2ZkzX/myx/FM0mHYk6B7LMCBbL
 UMWJ9M+rB20JRav9Ibepj1k2MImZEZ+wc+Wka/ch/G6qrO6bxghkj54em/K0xMIE0ksF
 kkOc4IINunVkSFzzAZ6bSj4goHTtpuBMA63M1DS2RcM/c8WJ48OqecOLKliaA6irnRK3
 Bd2k9AlEc1nDopq7LMmgikzl6bd2ukcyaE5oJcu32PDF3ICsgYQnHptX6ee2gLlBKxb0
 bprw==
X-Gm-Message-State: AOAM532xvqf9t3SMcoW10RgcF8pIYDr19xvngTMZoOc19KECYqXUnJZe
 km+1TFE2MD13CmtU11rIOj4=
X-Google-Smtp-Source: ABdhPJwp2wJbihBlbX6B46ooad2j3q97ciHy80hAJbgsFBnP/+9GMvua5he7AWe7i5DgyyXLGurnqw==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr19400021wrp.413.1603105240942; 
 Mon, 19 Oct 2020 04:00:40 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p9sm15530456wmm.4.2020.10.19.04.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 04:00:39 -0700 (PDT)
Subject: Re: [PATCH v2 5/8] qemu/bswap: Use compiler __builtin_bswap() on Haiku
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 David CARLIER <devnexen@gmail.com>
References: <20200928131934.739451-1-philmd@redhat.com>
 <20200928131934.739451-6-philmd@redhat.com>
 <CA+XhMqxdb9Y6HL_0Og4Px5OwdTqK5EKJcnKdafd790nJb8yYEQ@mail.gmail.com>
 <20200928141355.GI2230076@redhat.com>
 <9591c70b-68ff-bf02-5ee3-2d1969acd7f9@redhat.com>
Message-ID: <decf2103-374d-821e-fb7c-bf21db1d78b1@amsat.org>
Date: Mon, 19 Oct 2020 13:00:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <9591c70b-68ff-bf02-5ee3-2d1969acd7f9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Carlo Arenas <carenas@gmail.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 4:18 PM, Philippe Mathieu-Daudé wrote:
> On 9/28/20 4:13 PM, Daniel P. Berrangé wrote:
>> On Mon, Sep 28, 2020 at 03:09:01PM +0100, David CARLIER wrote:
>>> Unfortunately it breaks the build.
>>
>> Can you provide details of the errors seen and toolchain versions.
>>
>> I notice we don't have any CI support for Haiku right now, nor
>> any recipe in tests/vm/  for enabling users to setup a VM with
>> Haiku installed. This very much makes Haiku a second class
>> citizen right now in terms of QEMU's supported platforms, with
>> no expectation of whether it'll work at any point in time.
> 
> I provided the tests/vm/ build script from Alexander as patch 8/8
> of this series:
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg10022.html
> 
> This is what I used to test this patch/series.

I suppose the Haiku VM patch got lost, so I'll repost it separate.

Which tree should I Cc:? Ah, Alex testing tree :)

