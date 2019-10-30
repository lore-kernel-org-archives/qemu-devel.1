Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AABCA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 11:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35BC20874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 11:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VoV7v4eJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35BC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPlvz-0005r9-2b
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 07:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPluK-0004ni-GV
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 07:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPluJ-0005ml-2k
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 07:12:56 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:33044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPluI-0005mB-Bp
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 07:12:54 -0400
Received: by mail-ot1-x32e.google.com with SMTP id u13so1760008ote.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=b5231+nrqXdgbhdPeBz9xcS1mOX9BqD7FOH/X7Jhlpw=;
 b=VoV7v4eJO3Z49d315FE75ZrEPDPlPxiXf0AHebgZAqCwVaeLfQ/G8FYPLKELpH6zyK
 uj15nJ/SvuNKXAybxjqgCu68nWPNGb2Fh506+86+PE2YiaqFZAuFQ5EUKANqmP5MP0Nh
 CkCuS9096JPhuGwjGLxhlujYvDE5nZiGRBKp8IjLrUWiVt9Rpw5UTJNPutXHXyZx05fZ
 Q9O8KywPtnJGptos/FEFQLIqRqy79e8pQoj73otz78CmSodFsRk3NsH8brTdn/7JolwE
 VxcyG2RFQ6hD7kNrpCesCQR9wPYy2IxXDipCrjIJ4Cj+NfF7bIaaJTQbTpCXbSVlio0R
 IHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=b5231+nrqXdgbhdPeBz9xcS1mOX9BqD7FOH/X7Jhlpw=;
 b=nf05b3vS1bAWUjVPtKOP8WcZdG8zQzxvrrjKpNyrC8jwVis0dhpqsZsdFd6RAqR1YZ
 DlR4uID8aXRjpmDNCoK7JBlQqRaPsHA+6kZaTyNdxCW6t9VyKMDI9B698Qv297gpb2kq
 gs3IKzUN9ZyQr9oniKrzWGTp15qLAt+ybn7VlCdNLm9v1f5hKBU4nYqTNGOAt9bvJ1nD
 htElxsuEkg5JS11VgQf19PR2I+R7sCoGL6KQyppBMOaqBctzLnbtGsk450oUNphRejG2
 PicwLJWYk3QV4aAXG1jmkQO08OVBrGa77OQS7U8DBA1VLYANWDPwMfw+ZiiL2k3EqMeP
 XQCA==
X-Gm-Message-State: APjAAAUA8R2EYM3fgcJ8IEvDhRTFEsSCENDPekfhZwiETSGYQ1gllhkr
 H0uDHdGJqd4Y7V12VmHMlPr2ibTpKws1igGNzSSH3Q==
X-Google-Smtp-Source: APXvYqyqyGHK9jelI/LHwZSAEG6LomuM79GCZaEGveGjAwbRIj7l7rlTYmMZsNfQ+EYVRPxVgYlQV8B2415AAO+Xdws=
X-Received: by 2002:a05:6830:1b71:: with SMTP id
 d17mr1298949ote.232.1572433972296; 
 Wed, 30 Oct 2019 04:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191027192223.10855-1-alex.bennee@linaro.org>
In-Reply-To: <20191027192223.10855-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Oct 2019 11:12:41 +0000
Message-ID: <CAFEAcA9pdtDn3RM9ssKdYj4wKdauwzN-cAvDWN_-YzuPg4SyPw@mail.gmail.com>
Subject: Re: [PULL 0/3] a few gitdm updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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

On Sun, 27 Oct 2019 at 19:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 856bd2c28e108ad0eb909bbbf3774f6f8bd7c2=
d4:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-10-25 21:57:41 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-gitdm-next-271019-1
>
> for you to fetch changes up to 82448ecd110ec1c4af1504a394b5ea5097dcca3c:
>
>   contrib/gitdm: add China Mobile to the domain map (2019-10-27 19:16:30 =
+0000)
>
> ----------------------------------------------------------------
> gitdm updates
>
>   - Add a few individuals
>   - Add China Mobile
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

