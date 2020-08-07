Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29981C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59CE206B5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNqFGB9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59CE206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3y4r-00045c-52
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3y4I-0003el-67
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:49:38 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:39545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3y4F-0006Nj-Cd
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:49:37 -0400
Received: by mail-ot1-x32b.google.com with SMTP id z18so1032332otk.6
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/UHKsD2UVF4t64QfwSzJuB8EP/y1777OFzvBcbNCjPQ=;
 b=dNqFGB9e7wZopJA9NiPVMsVXZGtpAWKMSfOnOdlN8ea6bTXpeDl/JxfrCj17Y34ZV5
 G8X8UgWveiC9AOO0ixew9Y2nS63aGo3B5paRe06n6jMNxxBoEUZ1pxELX9VVPSZ1WnDY
 SDZdb3PRtE5mElv5vSjc9kwMJQpfaQ1Ba8u8xrBs2Zuo9lSIUjx8lYr70IquOK4Z8ps2
 WPyyEsnV3MGSDqZ7csh2FLKIaZjdfXSRjo1xiGH9BTRLQH6fTALQeyA1+ApjBq5wjIqq
 qSN3+ATMUDUYpfVgMf89vpbuZ/mQxg2M/iLAkBgUfNaccQsC6OBopjAvG/IPs/A1v/Aa
 k3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/UHKsD2UVF4t64QfwSzJuB8EP/y1777OFzvBcbNCjPQ=;
 b=XtDLLEPRw2ux3g13j7louLoME+mUOwyHAGEb61ILifSPn695BXj7S7a3JNiGK6RKcH
 lP62LxLWRQUdRf+AlCQ927Qoj/mDe6t0IHc07QwU2L7HPGyfX1j1tk1cl1CPKatmYT3L
 763gmcKedOHtrV67Sih0SdMORUvzeNJO4bGcQxR5reKkkk12xmirBb0NFRkoN7exWzln
 FXPZmXB4Gk6FYWKeQbz1I9ejorgnZ2AeHNYqhtR6aoz44o0g2lx6Ua13lwT4ZX4Zk8NR
 dBnVyxkM7+hxvSUzeDdYyW1xGDkY/Ji7kGSnx1zTEMtKPn9SbmeFz7GH5m1FJcnmsvyB
 DKpA==
X-Gm-Message-State: AOAM533m2HoCUCxIqHdVwD8NI0vRgc2ivWvNxA32f9qKcAL3QhcswcWV
 0qLj6rK8AvUH0p42rh5/A2OVUXJ/aFjcJpOrXRsA4g==
X-Google-Smtp-Source: ABdhPJzIQP+9X7mKHKuiPpHZhLpJI/JOfdKCifDawYTE3IBCfegZICXhfF46LKJ8dheoFtbJasvb6zm1vMX3ckcU/b8=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr4561347otq.221.1596790174219; 
 Fri, 07 Aug 2020 01:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Aug 2020 09:49:23 +0100
Message-ID: <CAFEAcA-d0F9y2OSX5D7GrzUYU7yf4nAhHabE1dUVii3LRrueLQ@mail.gmail.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32b.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 20:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This the more or less final version of the Meson conversion.  Due to
> the sheer size of the series you have been CCed only on the cover
> letter.

Does this work with actually-released versions of Meson yet?
I am still not very enthusiastic about the prospect of having
to carry around an entire build system in a submodule. That
still seems to me to be living closer to the bleeding edge
than I would like...

-- PMM

