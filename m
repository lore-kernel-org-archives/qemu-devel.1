Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7465AC282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 07:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F7B26A17
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 07:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvn0SzlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F7B26A17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXKbF-0003Mv-Cp
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 03:08:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hXKa6-0002Yh-99
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 03:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hXKa4-0007q3-AN
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 03:07:02 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hXKa4-0007lJ-2w
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 03:07:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id j49so13223003otc.13
	for <qemu-devel@nongnu.org>; Sun, 02 Jun 2019 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=y/qn07rmNzL0aJn530IXXzE6FLPno9F/2WXPBC6suD0=;
	b=lvn0SzlUcHVsi8fwd9OWyz8efe5scZMiq9MdlNNeV70gefxTrPHdA5BPXstFzDItpE
	X9DkROwATdg0JDIaE/WoiKo5LObU4jdXjwcJQ2FEwEaULDCNWkGtmo00L6n5+ivRQYKR
	PpKNVdzCYgDB0MQ0znD84UvhfUPLYjaHFvek8zXinecOFjN3oFE7XVkId6svpYrdgS4C
	ClEbhOMocIDopZOKv+xCXnxEprpK4pqqnFmNerSP5Z+78fSZiAUyLB+E6Vn0TAz7xu18
	4aMuGhmPkWXp0ZwqMCodT13M3QM9IY6i7P2hDbgCXhwXoHDHJNyU6VTy1uwxIFRh8JO5
	cJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=y/qn07rmNzL0aJn530IXXzE6FLPno9F/2WXPBC6suD0=;
	b=c83qViSJqrO78qy2yr7zHae0euElbVBHwvOZ1Oikw6eTURQYcOEJyNX7yoXYSJ8mUf
	lORe59y71u9jxj7h52ys0+x4EBOWMa5LqzQdOoltY1r5h01E5iwKrO1F4LX4nI++F5LP
	iylF81IrSHsAvOslNxKPigYKVNYVyIKxA/MfajfBaj8lXwjqHAhiRjwZRg9h5sA8OK18
	/FDRDE7d9Ahz3Aeot5wGP3s7Pt7rLDyoQktRQWDHMqk2zyO+XhkhXVAtCg1KiNJV0SjV
	r03sMH400nq7pWgA73tHg1kjpKYOiZwzidY3xD3snG9wxRhF/B/2tQTjc84TPnumbFko
	mxeQ==
X-Gm-Message-State: APjAAAV2rozhkPYFRIbfhtY8V48vvImt5nmhocEH+4L5G91+QbGVktxW
	CFjhwmdsa7005i8FeuR4b0PIS46nutCIN0zIY7jMNhWE
X-Google-Smtp-Source: APXvYqwz4NcpC9Xws3DB2XtqIsrGaxBvvRFEnQ94VT1/ifgVzIk0kpcymlc8LEuCmPH1Szly3yXbANZk52n81+TdEKA=
X-Received: by 2002:a05:6830:c6:: with SMTP id x6mr1563297oto.64.1559459215248;
	Sun, 02 Jun 2019 00:06:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:7212:0:0:0:0:0 with HTTP;
	Sun, 2 Jun 2019 00:06:54 -0700 (PDT)
Received: by 2002:a9d:7212:0:0:0:0:0 with HTTP;
	Sun, 2 Jun 2019 00:06:54 -0700 (PDT)
In-Reply-To: <BN6PR2201MB1251E8A4D8209209DAC36D69C61A0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1551718283-4487-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551718283-4487-2-git-send-email-mateja.marjanovic@rt-rk.com>
	<BN6PR2201MB1251E8A4D8209209DAC36D69C61A0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 2 Jun 2019 09:06:54 +0200
Message-ID: <CAL1e-=gfyTOeYZtgZ=xpgUDje2jG1N05cH9-2-dCcgMcaoJ21A@mail.gmail.com>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Improve performance for
 MSA binary operations
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, aurelien@aurel32.net,
	Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 1, 2019 4:16 PM, "Aleksandar Markovic" <amarkovic@wavecomp.com>
wrote:
>
> > From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> > Sent: Monday, March 4, 2019 5:51 PM
> > To: qemu-devel@nongnu.org
> > Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
> > Subject: [PATCH 1/2] target/mips: Improve performance for MSA binary
operations
> >
> > From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> >
> > Eliminate loops for better performance.
> >
> > Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> > ---
> >  target/mips/msa_helper.c | 43
++++++++++++++++++++++++++++++-------------
> >  1 file changed, 30 insertions(+), 13 deletions(-)
> >
>
> The commit message should be a little bit more informative - for example,
> it could list the affected instructions. Please consider other groups of
> MSA instructions that are implemented via helpers that use similar "for"
> loops. Otherwise:
>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>

Mateja, you don't need to do anything regarding this patch, I am going to
fix the issues while appying.

Thanks, Aleksandar

> > diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> > index 4c7ec05..1152fda 100644
> > --- a/target/mips/msa_helper.c
> > +++ b/target/mips/msa_helper.c
> > @@ -804,28 +804,45 @@ void helper_msa_ ## func ## _df(CPUMIPSState
*env, uint32_t > df,         \
> >      wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
  \
> >      wr_t *pws = &(env->active_fpu.fpr[ws].wr);
  \
> >      wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
  \
> > -    uint32_t i;
 \
> >
  \
> >      switch (df) {
 \
> >      case DF_BYTE:
 \
> > -        for (i = 0; i < DF_ELEMENTS(DF_BYTE); i++) {
  \
> > -            pwd->b[i] = msa_ ## func ## _df(df, pws->b[i],
pwt->b[i]);  \
> > -        }
 \
> > +        pwd->b[0]  = msa_ ## func ## _df(df, pws->b[0], pwt->b[0]);
 \
> > +        pwd->b[1]  = msa_ ## func ## _df(df, pws->b[1], pwt->b[1]);
 \
> > +        pwd->b[2]  = msa_ ## func ## _df(df, pws->b[2], pwt->b[2]);
 \
> > +        pwd->b[3]  = msa_ ## func ## _df(df, pws->b[3], pwt->b[3]);
 \
> > +        pwd->b[4]  = msa_ ## func ## _df(df, pws->b[4], pwt->b[4]);
 \
> > +        pwd->b[5]  = msa_ ## func ## _df(df, pws->b[5], pwt->b[5]);
 \
> > +        pwd->b[6]  = msa_ ## func ## _df(df, pws->b[6], pwt->b[6]);
 \
> > +        pwd->b[7]  = msa_ ## func ## _df(df, pws->b[7], pwt->b[7]);
 \
> > +        pwd->b[8]  = msa_ ## func ## _df(df, pws->b[8], pwt->b[8]);
 \
> > +        pwd->b[9]  = msa_ ## func ## _df(df, pws->b[9], pwt->b[9]);
 \
> > +        pwd->b[10] = msa_ ## func ## _df(df, pws->b[10], pwt->b[10]);
 \
> > +        pwd->b[11] = msa_ ## func ## _df(df, pws->b[11], pwt->b[11]);
 \
> > +        pwd->b[12] = msa_ ## func ## _df(df, pws->b[12], pwt->b[12]);
 \
> > +        pwd->b[13] = msa_ ## func ## _df(df, pws->b[13], pwt->b[13]);
 \
> > +        pwd->b[14] = msa_ ## func ## _df(df, pws->b[14], pwt->b[14]);
 \
> > +        pwd->b[15] = msa_ ## func ## _df(df, pws->b[15], pwt->b[15]);
 \
> >          break;
  \
> >      case DF_HALF:
 \
> > -        for (i = 0; i < DF_ELEMENTS(DF_HALF); i++) {
  \
> > -            pwd->h[i] = msa_ ## func ## _df(df, pws->h[i],
pwt->h[i]);  \
> > -        }
 \
> > +        pwd->h[0] = msa_ ## func ## _df(df, pws->h[0], pwt->h[0]);
  \
> > +        pwd->h[1] = msa_ ## func ## _df(df, pws->h[1], pwt->h[1]);
  \
> > +        pwd->h[2] = msa_ ## func ## _df(df, pws->h[2], pwt->h[2]);
  \
> > +        pwd->h[3] = msa_ ## func ## _df(df, pws->h[3], pwt->h[3]);
  \
> > +        pwd->h[4] = msa_ ## func ## _df(df, pws->h[4], pwt->h[4]);
  \
> > +        pwd->h[5] = msa_ ## func ## _df(df, pws->h[5], pwt->h[5]);
  \
> > +        pwd->h[6] = msa_ ## func ## _df(df, pws->h[6], pwt->h[6]);
  \
> > +        pwd->h[7] = msa_ ## func ## _df(df, pws->h[7], pwt->h[7]);
  \
> >          break;
  \
> >      case DF_WORD:
 \
> > -        for (i = 0; i < DF_ELEMENTS(DF_WORD); i++) {
  \
> > -            pwd->w[i] = msa_ ## func ## _df(df, pws->w[i],
pwt->w[i]);  \
> > -        }
 \
> > +        pwd->w[0] = msa_ ## func ## _df(df, pws->w[0], pwt->w[0]);
  \
> > +        pwd->w[1] = msa_ ## func ## _df(df, pws->w[1], pwt->w[1]);
  \
> > +        pwd->w[2] = msa_ ## func ## _df(df, pws->w[2], pwt->w[2]);
  \
> > +        pwd->w[3] = msa_ ## func ## _df(df, pws->w[3], pwt->w[3]);
  \
> >          break;
  \
> >      case DF_DOUBLE:
 \
> > -        for (i = 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {
  \
> > -            pwd->d[i] = msa_ ## func ## _df(df, pws->d[i],
pwt->d[i]);  \
> > -        }
 \
> > +        pwd->d[0] = msa_ ## func ## _df(df, pws->d[0], pwt->d[0]);
  \
> > +        pwd->d[1] = msa_ ## func ## _df(df, pws->d[1], pwt->d[1]);
  \
> >          break;
  \
> >      default:
  \
> >          assert(0);
  \
> > --
> > 2.7.4
> >
> >
