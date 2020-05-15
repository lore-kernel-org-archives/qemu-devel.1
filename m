Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBFEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653DD2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctqXXivl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653DD2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZhf-0007rD-Kq
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZZfk-0005LK-68
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:42:40 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:32880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZZfi-0000eO-NH
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:42:39 -0400
Received: by mail-oo1-xc44.google.com with SMTP id q6so405597oot.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Han7w5xposZtBLb1PROyrE4a4LcCEXDsEhnWpBfnBP8=;
 b=ctqXXivl40Eh/BsbJ8SCkIEf6LnI1HUpBiXNXPkFxBdVclXSAXQNL+DIJjttRdOo2g
 Ym56MlvqPkANvFz3B9Ddb/57Bk7VIVHFGtWG/K3JaAkEhrrem5BNXG9603Tu3nOy6fkn
 e6Pg+g31Hu3KZnuSqnHyR1tROFB8/nQcXxMqghk4gw5IWUh73Md4g/Ezzr+0LDAowb3E
 3P11v0Jy4bA9v8d/VpyqxL0L6XUpJRyjE8J426AUzQWGV1yODK+FJbk2TyZAag59qhbN
 sxVtk5HcIPLXajiqog9ydCFdksTUlglVBsECNyXaGo9DSmTFxVaFFTR/0Uj9le0caHlM
 KTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Han7w5xposZtBLb1PROyrE4a4LcCEXDsEhnWpBfnBP8=;
 b=J9r6uVl+AMa8nXBDAm4kD/0PcqY75a90EyNJJdwXa4gKVIKDTRC5a61utRDrnUItmQ
 c6vEtkQeLP5StOAXBUNQUJHWZUYccnfAvViMmJIZsyxv/AALuS5Yy36yhbrI1SVJO6C2
 WuIsIO4FXd4XQkVVFlx9R8ygYFFVGJu22ITE2NHkhsgaYL29Z/dpFRA0TRLnnYGBJmBu
 vtoMPxvPB+EJdS68fxYn/55Kaj/iAm/1PlDF0WveHCtZMRKpbB+uNoncga7pWaHH5+A9
 MwF7rgzZ0BenwpqdRA1S70kSyPojPN21zyHnPQgikmmsvIx2/Mzo1RNLSLyK+6D+PdfN
 lceQ==
X-Gm-Message-State: AOAM53015NxidMt+c/68XvR3RzCU385MtuE91N8h+SORikaeEtAn5OzF
 rCnbg+b7Jm7ekHW9yiGDld2omeUovZNu1dhCIKwnBg==
X-Google-Smtp-Source: ABdhPJwt3MFVaqk6ZTCRXSfpep1/A1cJrZUTO4ycOo/VIPzeifPy18jTRkTsHMFtR62ILsDITKqVi5ExYucLRordbYg=
X-Received: by 2002:a4a:8253:: with SMTP id t19mr2314899oog.69.1589546557331; 
 Fri, 15 May 2020 05:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200515082145.4732-1-kraxel@redhat.com>
In-Reply-To: <20200515082145.4732-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2020 13:42:26 +0100
Message-ID: <CAFEAcA_BcUicuNNkTtkqB5P_MDuwR=uXBSnHxxeG0HeeYt7izw@mail.gmail.com>
Subject: Re: [PULL 0/2] Ui 20200515 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 at 09:22, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit d5c75ec500d96f1d93447f990cd5a4ef5ba27fae:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2020-05-08-1' into staging (2020-05-12 17:00:10 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20200515-pull-request
>
> for you to fetch changes up to 32ec9839d89d2b814ada20b041b25feae23596bc:
>
>   ui/sdl2: fix segment fault caused by null pointer dereference (2020-05-14 14:26:42 +0200)
>
> ----------------------------------------------------------------
> ui: sdl bugfix, -show-cursor deprecation message
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

