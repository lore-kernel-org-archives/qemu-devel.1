Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F88C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 12:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53B220872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 12:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOF5dtFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53B220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDphs-0008Fc-IY
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 08:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDpgO-0006mR-EX
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDpgM-0000lU-Ul
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:49:11 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDpgM-0000kS-Lb
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:49:10 -0400
Received: by mail-ot1-x344.google.com with SMTP id f21so2075405otl.13
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 05:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q+QPJMPwGc+wmihIWLZp5cObcHHdNgnM4im0YSZ39ig=;
 b=zOF5dtFzaYaASrNo2aBqogIE/6mgU0BH+n6M6XosgXpt9k7m+u92YBu6fRZf26Pa0C
 7LT8MElbIkMsXPvyfSHCoP4RYw+yP8T+FI1Zqsq0A+sdIRuzm6Ovigmw6Z1e8MeoTNWC
 m7WF5xHLzkS7NpCP2r6Sg55AUDOjBp9CDl7+CjVIN0FnCNJm5I/mcLuspRoo+f4jBFQJ
 NSP89mJbx7VOv2afRUBqKECRj724Na6i4dVf7P4CeN5MevLMRgxpci4+EdZWgon1/mti
 EoUV5YU3li9Xc8pIMgVvfROrbK2LzkXVv99tKxjf9Jwu87XHVE37WyS4x6F6LlOYmnOc
 4tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q+QPJMPwGc+wmihIWLZp5cObcHHdNgnM4im0YSZ39ig=;
 b=PivZzRnj8IHkVFyJiWgy4CdVSO+VQBZ0Q3JkLM3hzMwHCleC8t/VgXl0doX5+SU2Yf
 4zmBoyj6baEtmkuCrGjPuHKyBPIFkpe5CEEWv3J8PR0gjQ1H6aTES3Aip9o3Ecb6N8Ct
 LPINTM7FeGS+UQ+4+Idw5sCmzHWxScTQ01TCCDuRiJy5vYstDLzagIkcwJ5Z7jxCDQ7f
 TyOSbTOFEoj4AKu0Jj2gjIP/tfMdompmXLDR7V9SIYegomURw/RrlEdk21lr4gaH2pxo
 7xJcuwRL1Vbu3GhHl8wvKH/gb6pLv3bzDkNJdOLt2YGao96uoxvHOhY+TqCS2/087Pt/
 AvYw==
X-Gm-Message-State: APjAAAU/sR/ch7zwOsmyrIJt8zB06Y6RmsNT7s6X070tAv4/KzWthccu
 7XR1GZ2Qmo5o86o9j1zASZPriyM7/yAGyKWlMl78Vsg6Ctw=
X-Google-Smtp-Source: APXvYqxPk+VG+1OWkKDh51d5P+zyEvJS34rpRnyTTaMSoLesD+oeH1iESWz3TNG5s2kk0zBJ+NwJGfbMPGIfhaS6aH4=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr2822352ote.97.1569586943511; 
 Fri, 27 Sep 2019 05:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1569415572-19635-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <8f976a4a-e56a-d1f7-def9-14dd66140f0c@redhat.com>
 <CAL1e-=gdKQvtCX5DXCzMGPum5XiOxr7j51bQM0K8vosjPa-TcQ@mail.gmail.com>
 <874l0ydk00.fsf@dusky.pond.sub.org>
In-Reply-To: <874l0ydk00.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 13:22:12 +0100
Message-ID: <CAFEAcA-ougCHbdHG3fuyfqqhXLNE6KgRZ4kmn8eTPhGBhTz5Lw@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] target/mips: Clean up helper.c
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Sep 2019 at 13:03, Markus Armbruster <armbru@redhat.com> wrote:
>
> Aleksandar, your message is hard to read, because you sent Content-Type:
> multipart/alternative, and both the test/html and the test/plain
> alternative ride roughshot over the quoted text's line structure.
> Quoted patches become unreadable garbage.  Please check your e-mail
> setup.

Note that among the recent changes to the mailing list config to
handle DMARC/DKIM signed emails better is one where we no longer let the
list server try to fix up multipart/alternative or html emails into
plain text. This is because we want to have the mailing list server
never edit emails, in case they're signed and editing would cause
DMARC/DKIM failures. So it's possible that an email sending config
that previously produced acceptable emails on the list receipient/archive
end might no longer do so.

thanks
-- PMM

