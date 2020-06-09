Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B97CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D543920737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXiWz86X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D543920737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiku4-0000GE-49
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiksh-00082J-DD
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:29:59 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiksg-0001DA-4Q
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:29:58 -0400
Received: by mail-ot1-x343.google.com with SMTP id n70so5269255ota.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 13:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CFRf6n6iLfu5hI7ncpKY1KfboIP87lBy3pd3+ycOAj0=;
 b=dXiWz86X2pFp71METaCBn8XGWMlJ8WhHGQwCafAt51lu5owiT1x25Yo5dh07DSHtQ+
 SSqPhaEegYZmqEDBM0CI6Kc+RTdgsvx1uUhqRtB1w2/G32wV0zrzp2bYEIo+PBRIpIUB
 2ZrfMj1HCcQtgJEyvo1xBnIkupfhKEeE/U7toYVMmo9h6vZGsUUgnZnPz17pVKk0C2Yv
 hjJIHySJvP8TO/HhxtSqq0R2Xzt7BEoRkfuwFD79CKVv+MmPKcycjIMYneGZ2C1/pttw
 ejH+Ykkiy18uI9I3bbnp2ScbTqq4rb0W9l3IELRsArCQH6xmd1R9BvPaAZZ20k0bSSMp
 DKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CFRf6n6iLfu5hI7ncpKY1KfboIP87lBy3pd3+ycOAj0=;
 b=KviSTMfraEA9UHP8YSw+xPw/9gt6foQ+uVUjprL4A8+fVIGK4ldDitXNsYPss1PM5k
 icU46R4CQ1/SHgGYhr8mZ5hhD6bSg9E/IdSRik38e01POJ03VIoTyZih1PCHWHt1OoB3
 cbJvW65U6OEvQhyKmSqJ0xyc2rypvvHzvliQv3e5IYkp4WWoe7UqwIPsKFbRkuDfnof0
 N0kuI3tNPuu1fid+47svvo3+Yw/4HTFuRFIKTzMmRVoQpZDzt4gye70ECencTaZEzEzz
 vv51RQOtGybMYTrNo5t4FFfxAOtJ67dim4UV55hQyxwretCsqyqtN8czsPF0PJZQPVic
 Bv+A==
X-Gm-Message-State: AOAM532fnKqVE8soO8boG2ByWuoma9mUjWCPhFJ1wXK8xxsN39pbZilW
 5haWNdIOixmhNNyryxNB9pehxrGJkVpwLw8L5ooLjg==
X-Google-Smtp-Source: ABdhPJwyc5HzxjJqb0VN1FLG8nDlYLD6Vz7klANNdClE3pI2INfiz+RuGuJOozmNRu7TKjKuGV5szLa/mtieLwZOSqg=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr10648270otn.221.1591734596748; 
 Tue, 09 Jun 2020 13:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200609073214.14079-1-f4bug@amsat.org>
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2020 21:29:45 +0100
Message-ID: <CAFEAcA8ip_KyYVCaZi4=rFfRPh1a9F2HQxaiC2Hs4Cv+pqea=Q@mail.gmail.com>
Subject: Re: [PULL 00/16] SPARC patches for 2020-06-09
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jun 2020 at 08:33, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Hi Peter,
>
> These are the latest SPARC patches sent to the list.
>
> This pull request is with authorization of Artyom and Mark:
> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg710154.html
> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg710156.html
>
> Frederic doesn't have his GPG key signed:
> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg706509.html
>
> The following changes since commit 49ee11555262a256afec592dfed7c5902d5eef=
d2:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-p=
ull-=3D
> request' into staging (2020-06-08 11:04:57 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/sparc-next-20200609
>
> for you to fetch changes up to 86e8c353f705f14f2f2fd7a6195cefa431aa24d9:
>
>   target/sparc/int32_helper: Extract and use excp_name_str() (2020-06-09 =
09:2=3D
> 1:10 +0200)
>
> ----------------------------------------------------------------
> SPARC patches
>
> HW:
> - Use UNIMP device instead of EMPTY_SLOT
> - Make EMPTY_SLOT similar to UNIMP device
> - Map UART devices unconditionally
> - Pair of fixes for AHB PnP
> - Add trace events to AHB PnP
>
> TCG:
> - Improve exception logging
>
> CI:
> - https://gitlab.com/philmd/qemu/-/pipelines/154231191
> - https://travis-ci.org/github/philmd/qemu/builds/696321130


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

