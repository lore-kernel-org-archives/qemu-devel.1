Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDECC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADEF207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3On0vmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADEF207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZXvu-0005WY-R2
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kZXvE-00052M-EC
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:22:50 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kZXvC-0007A0-Of
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:22:48 -0500
Received: by mail-pl1-x644.google.com with SMTP id r10so6674779plx.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 03:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6XDMO3dY+P6KF4ULhZ3+1GiinKDisc3vIbzVvD5wddI=;
 b=q3On0vmn+1n6io/wy2R/MzfqZ2V+uT0vOrys9i1FSo06hQd7zka103j/j/Q65sb1XF
 Nhg5TZbpdP5KrVQqfWEhQHNshqZQMH81ziDuByA995YnbZdJ6erZ2AXfxG6eiVcbnkAf
 d1vup+7rVQ7nttntHOZj7efPu/oeKKRqvDv4mk9RuWr6oDnAJTaGmb3eMgiRNJe9NLTf
 XAXUEyHK3zdF0BVEZ1DS0a7h3fFC5KgLKrj9tcSeqVPg9Jb95S6np03ALKNIXxAgfTG4
 qnk2gz4fztP83nQSYD+Itl5CBncusTAJsy3HWgycYdLNM8EJy5ApTjUDSZOSlEA0mtjd
 dJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6XDMO3dY+P6KF4ULhZ3+1GiinKDisc3vIbzVvD5wddI=;
 b=cOGJYAek7g2IiBSf+UZkCSGaUO2Ajw18ag2vGFsy/usbrc6a0HWJ2fXkLnYYz8LbMG
 j4SvMPGT4oGqX7rra+s49mS9s1+dr7Kjo4aj8pBQnwbaS3InNc1aLYjrzEHkdxS80f6Q
 cNY+vA2wsfl5I0QXcaqq5YaSm8ZDPEFD5CiMup9H2Cd/rCI+Wp9dGzfGLl6eFLW1zXDV
 oysYDlEDvoNg0Vr/94ooGtZcP2fMKFwX0KSL5aVhDua/d+XN62kdmCqn8RqKTbIKuXWw
 zec8XLcYUNxo4Yk+sXUfG5HQszqPkvFmJcaL0gKdoaj64had9tbTv7JwD+NctElLKG8u
 WFzg==
X-Gm-Message-State: AOAM5320bzu+XZorurCp9iwARQtetZeo+lJHnBEcg7nkWAY1M+1KTByl
 FExPkqAw8NcdWh5Er0sjbokit8zRt6UrkgDUvyY=
X-Google-Smtp-Source: ABdhPJxm9/cGvjcSBTye+nuDD2YcqAXEmOYCHIRtI6TWBTFY12ByUJ1BgcWTrPhOw2EvsJjXBHpWbhBo4TxNG4nHmMw=
X-Received: by 2002:a17:902:59cd:b029:d6:7656:af1 with SMTP id
 d13-20020a17090259cdb02900d676560af1mr20519279plj.43.1604316164552; Mon, 02
 Nov 2020 03:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20201030174700.7204-1-peter.maydell@linaro.org>
 <20201030174700.7204-3-peter.maydell@linaro.org>
In-Reply-To: <20201030174700.7204-3-peter.maydell@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 2 Nov 2020 11:22:33 +0000
Message-ID: <CAJSP0QXd0YF=kVL41oMSTPRbRe5YC8Tt+VLAvwvuVVtrWr+dYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] qemu-option-trace.rst.inc: Don't use option:: markup
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 5:48 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Sphinx 3.2 is pickier than earlier versions about the option:: markup,
> and complains about our usage in qemu-option-trace.rst:
>
> ../../docs/qemu-option-trace.rst.inc:4:Malformed option description
>   '[enable=]PATTERN', should look like "opt", "-opt args", "--opt args",
>   "/opt args" or "+opt args"
>
> In this file, we're really trying to document the different parts of
> the top-level --trace option, which qemu-nbd.rst and qemu-img.rst
> have already introduced with an option:: markup.  So it's not right
> to use option:: here anyway.  Switch to a different markup
> (definition lists) which gives about the same formatted output.
>
> (Unlike option::, this markup doesn't produce index entries; but
> at the moment we don't do anything much with indexes anyway, and
> in any case I think it doesn't make much sense to have individual
> index entries for the sub-parts of the --trace option.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/qemu-option-trace.rst.inc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Stefan Hajnoczi <stefanha@redhat.com>

