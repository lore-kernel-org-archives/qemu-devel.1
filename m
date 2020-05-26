Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0A2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954132073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX3AlHiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954132073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcUp-0005Ik-Ig
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdcSI-0003YU-0x
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:29:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdcSH-0002I1-3y
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:29:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id t18so6967087wru.6
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=V6ykpu323/hkpcPq28c3whFfHCBSSO7lfj/XeW+QWV4=;
 b=FX3AlHiIpXZcd2ugG1zpEHme9sY05qzbtR4whTlL7ywsBMlBntZwbBIIuV2QQk/b5e
 eXzWEPCh/3xHMewhBl0k8pfqsYaywF7OTRlQRU/So/RvGR4z9NnoZpLrgpE43/thPD80
 f0i2PbBtt5HG7lPvYxyApB/COgr4plbx+NIUl9nT1NsSPaISbYT7DvRkbPxEjrZTEwnv
 uxma8iDwJa06Lx/AS/Ru6UNJ0uxl3Ksz1Mm9Lk/QKg6gO26T0P0qV0k9/hCi6Jg4yuEo
 Pfl29Oag5twfO5a7DhWJM6JZdGQwgjyktGfEl02s8zZfRxhBZcGQ7lsHKD5DaYBZSdiP
 Clhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=V6ykpu323/hkpcPq28c3whFfHCBSSO7lfj/XeW+QWV4=;
 b=mv16sLPti/v7WZayxShewshuLMnfWAeoT+Ioa1r4Br2P5SPiN5kVGplrh5sTzJn3Ny
 AheJI0W5+oKkaedyuoO4wY2W5qNwexwiP2wzqAKEy+RdHe5nwa4135Gg9XWlVxEDSU/z
 nnJpBDWQ9/QfCm3hpaXlhYnqv0kMhUEr58cb/EWc5gwRLrRQ0GHFDxQmF+ZHzmttxoJR
 FDUAiRz2I+TfU+HQdW6HLrU35D8dVkimNy7oZYUMD/9ic621Br+rGRHD374UUd0RJ1nm
 dg60BngAuZr3yctLc9BYROWqqiE6DcjL+MFN+w/EdWb6NIpWqHu4uLVjdAlxjjdJjWna
 V2fA==
X-Gm-Message-State: AOAM533fvwPHioBu7oMxbBIm7JXFD+VLbFP+bvfUiyclcgSHzA6bOQ2W
 AHaAtn37tvvEOmRNkrI9Pqz4dMSPG60MR0Vp+I8=
X-Google-Smtp-Source: ABdhPJxOnc+9N7irJ4jfBhRzSdX9k3zinSzdw5A+hPLMYFaB10tYv4Fko1TTNej8diOucoIo4DX+b6ANDHM1YPJvE9E=
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr20377828wrq.162.1590510567432; 
 Tue, 26 May 2020 09:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
 <a0f3967f-e125-d888-bc6d-44414edbfd5b@linaro.org>
 <CALTWKrVGqVb1mjsaoxYm4Y1iQoXYwz7ToC7T6r2EDPp-_LO=LQ@mail.gmail.com>
 <4e78400c-42be-08c6-492d-dc5596551efd@linaro.org>
 <CAHiYmc6zKmxgyKHzT4gazvJvPsX3SQYLjSXwK50_2eURkR3_NA@mail.gmail.com>
 <CAHiYmc7z+OfvE7nN1j14n2O8seVtqem_hsBwq=WyFgeo=WfybA@mail.gmail.com>
 <CALTWKrXv6NQUEzKFvPN4TmDGCKxY-Zaa+Dt-z0+sTgndco+EMA@mail.gmail.com>
In-Reply-To: <CALTWKrXv6NQUEzKFvPN4TmDGCKxY-Zaa+Dt-z0+sTgndco+EMA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 18:29:14 +0200
Message-ID: <CAHiYmc6289cQZEptA=KjpMDLx3S94Au7W79DXH9KTM-MLi3ADA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Update use_goto_tb() in hppa and rx targets
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 18:08 Ahmed Karaman
<ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Tue, May 26, 2020 at 4:14 PM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> > Ahmed, please follow the instructions on this page: How to report a QEM=
U bug and file the bug related to the discussion, to the best of your abili=
ties, if possible, today.
>
> Please find the link to the bug below:
> https://bugs.launchpad.net/qemu/+bug/1880722

I think your last sentence in the bug report is not entirely correct.
It is not known what would be performance results in case of
correcting mmap.c. So, if possible, and unless Richard or someone else
disagrees, please change that last sentence to: "By doing so, a better
performance results could be achieved, compared to the case of the
workaround described above."

Also, please add the tag "linux-user".

Yours,
Aleksandar

