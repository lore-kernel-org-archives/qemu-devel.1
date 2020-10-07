Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0722C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD27212CC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fw5CInqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD27212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAN7-0000Id-Tq
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQALf-0007d2-MZ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:23:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQALa-0002uA-SZ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:23:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id m6so2430119wrn.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GG8ahCagwkP0u+A/F+/C9FnE8zNUg3WoyzMU3Vvn1FU=;
 b=fw5CInqU5HPfpjwlkZfCTA4pNqM0FIef0eRTgzEEPNqMRn4Fw2aWsyH7DsyvzcSpaw
 5D6TCOyZMr/+6p7CCKxwjbiiwbUBY6XWpBsHVSfUMbqoXpmOOAuV5WKbN8ClzDTQDx5/
 rH2FAztse1rQmF6wpN/hnHWaHnjdFr1vEOqy6LYZbbWdII+304lNBuNmEO9QWQftbSQX
 HRnSnITNji0GE1fJcKL9ioHLZ9dM3VehhjxPGR/UfpkH2wXUHVctuQYNd1NpgGelOOrK
 SIFpDTRYE9f7mCcB1XWHoRcxLx0v57ZaMzYXNPaF9qHAfidPfv9pDFsyyaN13r5sDJHx
 q+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GG8ahCagwkP0u+A/F+/C9FnE8zNUg3WoyzMU3Vvn1FU=;
 b=Q4sWSzpZfcxHm1eLapQBXSWfS3VUsyct6Wqpevf+qtTPTPVLcX/XqPKJUXZfrBmTdB
 SLeBcVvzDG92rFpLzsUIrrv44tYpdIdm+gJHXA2FhM41nncwcKYVfuUS+PEWP4d5z0ZD
 2Z16u0LOMA2Dmsgu6eUasSlxhzcpa8CabjNqaAw7UabyyCH1WOG7fRr7LTp4xJZwtHwd
 15uBjoz0QXfTwGk1rEFW7WNHEuQCZGF4+D/kAOIHPShougTVZNCRnlKAFVmaO6a9vjnj
 HkWdrEo7o5ugM41AnULcbgflFf/niI+zjvB83YjeDmMvX21s8Re8xAljbwevZab8At4C
 0NUg==
X-Gm-Message-State: AOAM532C80IIICr7bffgcv1vLDO8EtLkSaqTGIz9SZuEcRr89Ux3if0Q
 d/I2MVva5yqSSbqYrG0U/f8IOw==
X-Google-Smtp-Source: ABdhPJwPKQg41pdrQe5GlCSV6fkrdsAKXglihp9T68t2EzNg0JLMBc7Ew7TIZPG0XCzlcGJH6yUyeA==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr4137668wrp.390.1602080593075; 
 Wed, 07 Oct 2020 07:23:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g14sm3142880wrx.22.2020.10.07.07.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 07:23:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 45E231FF7E;
 Wed,  7 Oct 2020 15:23:10 +0100 (BST)
References: <20201007105518.1019-1-luoyonggang@gmail.com>
 <87zh4yyyhw.fsf@linaro.org>
 <CAE2XoE8XP1y-YSyEBM+LY=CGbBihSeZd50bjS49YF74Q9cMu7A@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: luoyonggang@gmail.com
Subject: Re: [PATCH v4 0/2] Improve cirrus msys2
In-reply-to: <CAE2XoE8XP1y-YSyEBM+LY=CGbBihSeZd50bjS49YF74Q9cMu7A@mail.gmail.com>
Date: Wed, 07 Oct 2020 15:23:10 +0100
Message-ID: <87r1qayv1t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-level <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:

> On Wed, Oct 7, 2020 at 9:08 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>
>>
>> Yonggang Luo <luoyonggang@gmail.com> writes:
>>
>> > Fixes the broken msys2/mingw ci and speed it up.
>>
>> Queued to testing/next, thanks.
> Hi alex, still have issue, the cirrus cache are rather slow, waiting for =
my
> v5 version

OK, will keep an eye out.

>> <snip>
>>
>>
>> --
>> Alex Benn=C3=A9e


--=20
Alex Benn=C3=A9e

