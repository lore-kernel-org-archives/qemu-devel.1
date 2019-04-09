Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6864CC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2292084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKqvrw+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2292084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDqX3-0005NG-G0
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 09:11:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDqWJ-0004tS-CJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDqWI-0002om-7N
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:10:35 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDqWI-0002nI-0w
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:10:34 -0400
Received: by mail-ot1-x343.google.com with SMTP id k21so15496274otf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=CBWNFXKaaW24Be/ZegpPnpVAvQooQLs4io1cMLpyjOo=;
	b=lKqvrw+D6FhIIop6JHLEU6Tx+gWx7/igOVnS4M5SpvZjTzO737ekwmJsccIPmHjZVO
	L3GuF1NQHSxGFHk4h19WLl+3bx22QnIzBFNj7JgkcEUSbzWcvUDERuS7rRgC8qvG5O74
	X+m01QxYAy7WuiJuChZvhX+UsycRKoZCEuxxM/EUIhVoYxG9lY0CcYGVZkYO7zW55wtS
	4Pa48s/ZRXd8lBaNGsahlnPNSz+TrrzgQjEW7R++tHHHtDARjy1RtfM+3AEHPp8Eqz+2
	/xHDEMa6bEvtDQIlQK4ri/aj9I3udnYxpXSsczOFEPzAN215teKIDNXWPNG2k1uhTOh5
	U8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=CBWNFXKaaW24Be/ZegpPnpVAvQooQLs4io1cMLpyjOo=;
	b=T+56gUz26uPJ5mv+HbiDdgIgIaOMRfQ/kfgUdIYlfcPoXXcFa/x4Apq4d9t8hGuEzK
	Msh3QdpWWrGLvmnFvNBPoFp04Iv7JS1A7bM04dxvsjD4IocrwyCefAatXl24YukR+9pT
	cXN7RwFPaxS61hTQ9jbgguRRWLdVkMmhVbU4a71Ih6wKIWxYsfTtwbmQPgqS2MZkvJXp
	fx+AHb5GCUZBFmU0QKVnuIqtUaE1b5aDNx8dXS1Q3fCnZuL1EZZpRN33LXshKysLwf7g
	8pQVWPBmMFY66OlFCwaMDdrpt/HO5dsh+TvvM7VeygexlJiSGm3rVHZW1eTyxpNW/O3E
	+O7g==
X-Gm-Message-State: APjAAAXMwnhOtqvXuF9kJGWkbVsZgktlca/meyYctzxQY7uWpdSosxfc
	735koAyOf7JJ74ieC2z/Rbp3AphvgOEuk5wX5E6BVg==
X-Google-Smtp-Source: APXvYqyqzI18zqm532RCIHWPcamsbV3L7fnbgzpjX5fSpylofwDbr4ZMrTTKwmYlUySzGtStIYFO11pt/J2nWBTuvx8=
X-Received: by 2002:a05:6830:1497:: with SMTP id
	s23mr20152145otq.236.1554815432867; 
	Tue, 09 Apr 2019 06:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190328104750.25046-1-peter.maydell@linaro.org>
	<9d4def49-7caa-c44b-7818-e81986442f18@redhat.com>
In-Reply-To: <9d4def49-7caa-c44b-7818-e81986442f18@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 14:10:21 +0100
Message-ID:
 <CAFEAcA_NwBsRz5KAVrkje3jqnbaTMqEPTNCds3ViLCKb_gcNWA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH for-4.0] target/i386: Generate #UD for LOCK
 on a register increment
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <rth@twiddle.net>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"patches@linaro.org" <patches@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409131021.0EycKyL8A-KZQDzZIVafsnOmYghlM59-Dgn2P7e5oGo@z>

On Thu, 28 Mar 2019 at 11:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 28/03/19 11:47, Peter Maydell wrote:
> > Fix a TCG crash due to attempting an atomic increment
> > operation without having set up the address first.
> > This is a similar case to that dealt with in commit
> > e84fcd7f662a0d8198703, and we fix it in the same way.
> >
> > Fixes: https://bugs.launchpad.net/qemu/+bug/1807675
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  target/i386/translate.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/target/i386/translate.c b/target/i386/translate.c
> > index 49cd298374b..b725bec37cd 100644
> > --- a/target/i386/translate.c
> > +++ b/target/i386/translate.c
> > @@ -1398,6 +1398,11 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
> >  static void gen_inc(DisasContext *s1, TCGMemOp ot, int d, int c)
> >  {
> >      if (s1->prefix & PREFIX_LOCK) {
> > +        if (d != OR_TMP0) {
> > +            /* Lock prefix when destination is not memory */
> > +            gen_illegal_opcode(s1);
> > +            return;
> > +        }
> >          tcg_gen_movi_tl(s1->T0, c > 0 ? 1 : -1);
> >          tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
> >                                      s1->mem_index, ot | MO_LE);
> >
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Feel free to apply it yourself.

Applied to master, thanks.

-- PMM

