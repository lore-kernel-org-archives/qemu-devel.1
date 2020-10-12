Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D030C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007CD2076C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="si1I40rg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007CD2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxb4-000172-0V
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 09:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kRxZx-0000dR-Lf
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:09:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kRxZv-0003WI-JW
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:09:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id s9so7029888wro.8
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 06:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VCaHynkeEnGYRThYlGdgDH6k9OtcF7IMEUQF2knYGUo=;
 b=si1I40rgAlH11iIXa14sqL71KgC87gP8P8O9RppRbFuWGfNc57EeWvvI9WxbuRGv+i
 TWl8CDq1hu6Q07RmiwyWID4lx6/5HyOgJG4uJqTeiz3KB691SPNZfNsqAxSZOjhSVs2N
 WUoR4EVIPj9mfLbeNsG3TWyrHOjy+nEcTTpuQesHAOAGPsACKkkB+Sfkdbumu+OSJU47
 WYMI4lTrk4rjT925kVqi4cixGTDqRV6/9We4ISVDMSeAsCA+9vIICFeDyJvxk3BFljk9
 Nq8DXVG8tKe5fPokZ47NSsWz5MqVYKfH6gMHJloBzzgYJEkEoMMyQCDQ6IK4FGq5vBum
 qpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VCaHynkeEnGYRThYlGdgDH6k9OtcF7IMEUQF2knYGUo=;
 b=Nj55wtPOjwJV+6RXpFALMsZOFolgu/TjMA5hNFE8ydT1i4vkhIVwZjkuXVq1ISAI4P
 125llr42PS2lYWaNLX1JaaL3E8KFgXvq5iOBYTViGWzlsWm3i67jeyA+fOprmRaJbmkW
 aBwpLPzroGCM0QjSQhO1vkoqJ8af/Sd798JffU8sRTghzDSL41S6L54gu6GZuGEP2dlj
 5fL/OSpQVz/Vz5GWMdTP3l7nLVOiE+cKF7g3hAyLGeXl417LSKZqTJNbfkTWZtyqYwl7
 B0HMGV2n9tATWB7J4VGmPok0xez874si4BUY7GLh10wi/ot/fgVzTYHrBlccDsZnF/V6
 4e6Q==
X-Gm-Message-State: AOAM531qn52yDz7Kcu9FNRiWMshFwFD80T0nl/XTKXlpFFiXPrELi95a
 RdovKQR07aSkkke6PwHWgC+KJYWI920hKw==
X-Google-Smtp-Source: ABdhPJyd8uJcsglZ9PGYmfb+3Qmvp+sG960urtPzSBuL6flYsd6TJpikbeUoQO8NON1Y6rRKNgvdGA==
X-Received: by 2002:adf:f504:: with SMTP id q4mr29761410wro.353.1602508164505; 
 Mon, 12 Oct 2020 06:09:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 24sm22668068wmg.8.2020.10.12.06.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 06:09:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 91A0F1FF7E;
 Mon, 12 Oct 2020 14:09:22 +0100 (BST)
References: <20201009205513.751968-1-crosa@redhat.com>
 <20201009205513.751968-4-crosa@redhat.com>
 <d5ffb1b7-5516-ffdf-a78e-91a8cda7fac7@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 3/3] Acceptance tests: show test report on GitLab CI
In-reply-to: <d5ffb1b7-5516-ffdf-a78e-91a8cda7fac7@redhat.com>
Date: Mon, 12 Oct 2020 14:09:22 +0100
Message-ID: <87tuuzzj3x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 10/9/20 10:55 PM, Cleber Rosa wrote:
>> Avocado will, by default, produce JUnit files.  Let's ask GitLab
>> to present those in the web UI.
>
> https://gitlab.com/philmd/qemu/-/pipelines/200764992/test_report
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

That's awesome - I wonder if the tap reports can also be read?

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

