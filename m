Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ABDC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E29320673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQ8A9MiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E29320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHniI-0000Y7-72
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHngc-0007y8-RI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHngb-00083z-Gj
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:29:50 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHngb-00083b-B3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:29:49 -0400
Received: by mail-oi1-x241.google.com with SMTP id k20so14485401oih.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 04:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dgBh35W6hYKy6Z4T5nFE0D3RCI/mNttBLeqA/Hn9uy8=;
 b=mQ8A9MiS2aK5i1DJ2NUTEnRP5IGxfu+UBic34RhFLdMUdynDYpRpfRiWIWNaNZrSuG
 6TlRtFAPnfSz+T1PDIPq5zkW1f7v2Z7sTZ+MRD+356QAaB6GBKNZjGll4LUm0SJiZzqV
 nEY87vKlLGJnzEr03pIOQjOC89oE0nppdEmmwivWknn9/BHYWCHvAv2MtITUXtCHb9YK
 MnYlMJiYLUEJ1MA2Wj/AEhlSq6wl/1sKjoOs3Oju/7iFzEuiaAj8d/OsTprh1h4h4Q1Z
 2GzWBOHFqxy8xCffJcSd+OBrEbquBZ3kYL8zIqtpLkiQErtjt7fkMCYW++ZfD1nZafP5
 BHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dgBh35W6hYKy6Z4T5nFE0D3RCI/mNttBLeqA/Hn9uy8=;
 b=CncL0pzZk7KGxiNX3phk8EypQLPSS6vQKQs8VM2CXrgXoMhVTWyvNGQTpSC+mka71c
 SxsfcvaS+ra0eG62m1HfItq14ZUkpbI8zKH1huf+EDwiPZGvJFWY5aIZOlYVlhMLc6r5
 NKzNaarsz5AbnXZBWmsJ+RWvHSFOBXZtl5orolBV8GORRmOFsdIvTF3LbxTaCIK7teWj
 EWA5WAf3M3nKkEgsgieSzgzHaCnH9lt1Yyx8dKkimx+KGJiF6nopuHxZnguA7fFXknJM
 52eX790SufHuxvgiSaT9mU9HAQBnpOtjQj6kSUZzZbDTJ3Cz6tBeWXR5UfFoJ8FiYGDv
 ltlw==
X-Gm-Message-State: APjAAAU6eYs2FwtnD/zLO8/n+mnR0K58vVjRTXNHWjrsUYWG7xnpOiEn
 bcAeKU/Vr1sXTahMLg7Z2x9PW4+8/9Bwp6iW297wJ9g453U=
X-Google-Smtp-Source: APXvYqz40E6yNWU8GoAldEU50nIgE2RJOlj3HWpyDqxG0Fy9dulBDkhySMz9Zg5ZcEz5KgorXbx85Mzn5sAoj22NwL4=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr3533094oih.170.1570534187653; 
 Tue, 08 Oct 2019 04:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191006235537.32016-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20191006235537.32016-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2019 12:29:36 +0100
Message-ID: <CAFEAcA-YQHv+q1MLVSDbpfO9ygxhW4s5yXA-PnNNi3_2tgp=Fw@mail.gmail.com>
Subject: Re: [PULL 0/1] slirp update
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Mon, 7 Oct 2019 at 00:55, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit 860d9048c78ce59c5903c3d5209df56f38400986:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20190924-pull-request' into staging (2019-09-24 13:51:51 +0100)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 120b721f5b590393971673a315f02969ec89cccb:
>
>   slirp: Allow non-local DNS address when restrict is off (2019-10-01 19:03:08 +0200)
>
> ----------------------------------------------------------------
> slirp: Allow non-local DNS address when restrict is off
>
> ----------------------------------------------------------------
> Samuel Thibault (1):
>       slirp: Allow non-local DNS address when restrict is off
>
>  net/slirp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

