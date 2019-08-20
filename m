Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630B0C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 09:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3232A22CF5
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 09:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8dqMdpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3232A22CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i00Qh-0005u5-9W
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 05:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i00Q3-0005Rd-2J
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i00Q1-00055R-RF
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:27:10 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:46110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i00Q1-00054S-Lm
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:27:09 -0400
Received: by mail-ot1-x331.google.com with SMTP id z17so4402996otk.13
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cTuLr4jggrAqOR6Qr8EQBgaEOrqcNm0atKrOWYoLXOk=;
 b=g8dqMdpOyx8QgqeSt4EOj07bseZeNXjHCtlF7eHogtMq/ATtOG41ilnoSjNs/d/6MD
 t8lxMQT7qiAbZltIh42uGeNUGsGDfyoBgro5j8qvX0a1M+UqMRlnGmwN3NQkWp0FTbgN
 ZqqJzkaL/GaOUS9FW2LcC3vC0lglLMSjvxmRtQ6RayVw163NhKzs1YhvkpZJt/FsvDlh
 2R3f+v6zao6m79EDbUXKgFfXxRU3rx4HKUS69O4V6geP+DzXRRuFXMjmcmiCQDr8aibm
 qoYuDevZL7ZxWZu1iJqXp6UM+tJIDZewQfobJiSA3B786OndiU3S9amKDeioEMCB0Nev
 +IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cTuLr4jggrAqOR6Qr8EQBgaEOrqcNm0atKrOWYoLXOk=;
 b=F59ja+v67hSWCyczuxke76GMtCxQNymfmtuREcISerHgWYHXkt+wGw1AlfP+k2MCCT
 PB7JCYexBP3IlGplO3ohihhc4UagZGQQhr0U6f9t4QVAN9vzoZNy3Ph1HfH3h3SGf9ub
 qdfMSOrfcSjJDYr/7/KOfv2zoqUiVVq0TE3BA4/UvIRQdfLGH49xm0UCI4v6TOY/tYgR
 07qOxuRdI01UeqiOZvPhGP2gXIOjh5WPcZTX7X3zdYbV/sdEeAqmD9rFEsCd3sY6o6nN
 aL/hvxVQRoAUSBnC/nd3sKmnYVdAbek6rrtMIR45EhgpYneMMVbwTnQVJ4CrKUVc7Xes
 Bk+w==
X-Gm-Message-State: APjAAAUFHU1LHLiXSxTCdQRvaZSUfV0Kmy8PAp0M16cfaEiarvItQd3c
 Cxm0z3rRCaMWUJCO5u/shAow/TchFcdf70EwCj+zJg==
X-Google-Smtp-Source: APXvYqzqb33k6qV86Ifk0VhcspCA5QVzcdmRedX+QvX0liCQ6vg04xyk3Ox9vjDxBhDmAFY9RRGZQ9YJx/GKMh+9pY0=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr22491829oti.91.1566293228611; 
 Tue, 20 Aug 2019 02:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 10:26:57 +0100
Message-ID: <CAFEAcA_h6mVJ-BaQC4VxbJF7EnCOcD1jn1e4YEEKODn+zToCXQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
Subject: Re: [Qemu-devel] [PULL 00/36] QEMU patches for 2018-08-20
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Aug 2019 at 08:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 864ab314f1d924129d06ac7b571f105a2b76a4=
b2:
>
>   Update version for v4.1.0-rc4 release (2019-08-06 17:05:21 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6f93977075ae9971d73879ca872f75e2737f66c5:
>
>   x86: Intel AVX512_BF16 feature enabling (2019-08-20 08:59:18 +0200)
>
> ----------------------------------------------------------------
> * New KVM PV features (Marcelo, Wanpeng)
> * valgrind fixes (Andrey)
> * Remove clock reset notifiers (David)
> * KConfig and Makefile cleanups (Paolo)
> * Replay and icount improvements (Pavel)
> * x86 FP fixes (Peter M.)
> * TCG locking assertions (Roman)
> * x86 support for mmap-ed -kernel/-initrd (Stefano)
> * Other cleanups (Wei Yang, Yan Zhao, Tony)
> * LSI fix for infinite loop (Prasad)
> * ARM migration fix (Catherine)
> * AVX512_BF16 feature (Jing)
>
> ----------------------------------------------------------------

Hi; this fails to compile (all platforms):

/home/petmay01/linaro/qemu-for-merges/hw/core/loader.c: In function =E2=80=
=98rom_reset=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/core/loader.c:1123:9: error:
implicit declaration of function =E2=80=98runstate_check=E2=80=99; did you =
mean
=E2=80=98type_check=E2=80=99? [-Werror=3Dimplicit-function-declaration]
     if (runstate_check(RUN_STATE_INMIGRATE))
         ^~~~~~~~~~~~~~
         type_check
/home/petmay01/linaro/qemu-for-merges/hw/core/loader.c:1123:9: error:
nested extern declaration of =E2=80=98runstate_check=E2=80=99 [-Werror=3Dne=
sted-externs]
cc1: all warnings being treated as errors
/home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
'hw/core/loader.o' failed

I suspect the patchset has a semantic conflict with Marcus's
include-cleanup and needs an extra #include somewhere.

thanks
-- PMM

