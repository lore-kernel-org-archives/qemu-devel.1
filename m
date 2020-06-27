Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59659C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 15:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F3D20674
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 15:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcJMPM5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F3D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpCmi-0007js-EM
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 11:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpCm1-0007CY-Mt
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 11:29:46 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:39246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpCm0-0007t5-5n
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 11:29:45 -0400
Received: by mail-io1-xd44.google.com with SMTP id f23so12864207iof.6
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=252szu6XzUhLi/t7tMEXBw3LKBY2LFN/dKLgnNNeVDc=;
 b=xcJMPM5PtUwGdXF9WpgyMhzmmJM0m3UHhhPYiE/atwnTB9/zZ4lb+t++t9NgjGeDmU
 5hXuE3tVim9ssRjcrCQAGA0oScWWBUfNsTPz4gVKPtLWaYDWWsVJDbll3KeyaC+YYhw6
 SJN/7UResDGSf1nutm59YvtUqCz45zgipGvtqw/RSijiyjJ9dDU87x9dWREFWuF0ofpf
 5ogi8TcSuDnOWTbScnGM3z/KjrJv40Jvj0Y7frJXud4kHvy34KYq5OkoDiR4IBQW26Qq
 2vExnP6/plwzmZO2s3NdJLJloW4H5yF0qrmdRY78LQ5I3tE/4uAXLeG7pgHXHcJ72orU
 SAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=252szu6XzUhLi/t7tMEXBw3LKBY2LFN/dKLgnNNeVDc=;
 b=QoA6vVhPFXrkohYHUNdebhdy2SPabdg8pT8lKJdf6t84zKPoF0jJLjSp0RM9d3Duu8
 xYGr0AT1Te1BFZpzENYTWdSPSbMfV0h+8OfD7axKXSowIWzei3bpg7WgE7irzln35c/7
 l7GjAh/o/F6Gash7jAZgmA1mlbiopbpPlcXbbV3yXcy7a1Vdm/qRfW8Wbaao8iXmNzH+
 jqvkEbVcaxM3x+EJv2rg6uB0q6oUjuTNLElRPcbHZB2CjAm4f5I3lrNr2MVPFjKrmKk5
 sncheF9Jlf68KDjjDKl62h/YxfRJezvTpX7AVsWGOV4UcEngJK2dFt7WXkdonZA/bjCW
 3VOQ==
X-Gm-Message-State: AOAM532BSWu+shkaDR4vM+63ydmUzxhIikWvJJpyfYPDpiYPrjrgjfsl
 zAJSpayzMIkGx+8dbpbB7xOaKYIi7UTW508rQWchBQ==
X-Google-Smtp-Source: ABdhPJweNTk+JFRbCcjbr/b9ENxsKkQ9kIC2D/wKEWxBzt4spSejJp4f7gO/mrDi14hHwQkPEM8oFWs5FXNQLqEY68Y=
X-Received: by 2002:a6b:3bc6:: with SMTP id i189mr8826577ioa.180.1593271782692; 
 Sat, 27 Jun 2020 08:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200625220336.10186-1-beata.michalska@linaro.org>
 <20200625220336.10186-2-beata.michalska@linaro.org>
 <20200626090050.3sqsukopwydv43od@kamzik.brq.redhat.com>
 <CAFEAcA_pKMkwAGAAdkCXk3dOqJQnX+qRsZuLMWA0qfMsw+aF1Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_pKMkwAGAAdkCXk3dOqJQnX+qRsZuLMWA0qfMsw+aF1Q@mail.gmail.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Sat, 27 Jun 2020 16:29:31 +0100
Message-ID: <CADSWDzvW3v0bVaEjaPLSk_N4c8nA_ZcReerh2dd3Lg2jgDRiHQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] target/arm: kvm: Handle DABT with no valid ISS
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=beata.michalska@linaro.org; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 kvmarm@lists.cs.columbia.edu, QEMU Developers <qemu-devel@nongnu.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,
Hi Andrew

Thanks for quick review.
I have pushed the updated version.

BR
Beata

On Fri, 26 Jun 2020 at 13:59, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 26 Jun 2020 at 10:01, Andrew Jones <drjones@redhat.com> wrote:
> > nit: How about using '= {0}' when declaring the variable, rather than this
> > memset?
>
> We prefer "= {}" -- although "= {0}" is the C standard approved
> version, some compiler versions produce spurious warnings for
> it in some situations. (cf commit 039d4e3df0049bdd8f9).
>
> thanks
> -- PMM

