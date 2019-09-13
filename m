Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946BEC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4A520830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="aKHIo2F/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4A520830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8jRk-0001jG-Bj
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1i8jQs-0001Fw-0C
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1i8jQq-0000ul-QO
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:08:05 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:56202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1i8jQq-0000tq-Eb
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=goFrkVbD/01z+nm04kT2IMCrrkOC56gPn8N8tfOnDPI=; b=aKHIo2F/6Rh9jJtYBJRRfjTkzE
 LaDl+zcxXk7jpsC18lVm/6gsF6XcqPFbElh17lY0z5Zvy9YIDSuzUBkuNzJfzG3jcRWC1RfJJccBD
 s6usTbgN8mJw6vun4GAHwvJuO151+VHQ6uLoNA65bheBN+aGECu+dX85FC+30zPbEDDk=;
Received: from [2001:470:70c5:1111:5054:ff:febf:83e1] (helo=stackframe.org)
 by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.86_2) (envelope-from <svens@stackframe.org>)
 id 1i8jQn-0000RZ-Pb; Fri, 13 Sep 2019 13:08:01 +0200
Date: Fri, 13 Sep 2019 13:08:00 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190913110800.GA10636@stackframe.org>
References: <20190913101714.29019-1-svens@stackframe.org>
 <20190913101714.29019-3-svens@stackframe.org>
 <01208241-04a5-0db6-f941-ff9cbc64440f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01208241-04a5-0db6-f941-ff9cbc64440f@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:470:70c5:1111::170
Subject: Re: [Qemu-devel] [PATCH 2/2] target/hppa: prevent trashing of
 temporary in do_depw_sar()
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
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Fri, Sep 13, 2019 at 12:58:14PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Sven,
> 
> On 9/13/19 12:17 PM, Sven Schnelle wrote:
> > nullify_over() calls brcond which destroys all temporaries.
> > 
> > Signed-off-by: Sven Schnelle <svens@stackframe.org>
> > ---
> >  target/hppa/translate.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> > index b12525d535..c1b2822f60 100644
> > --- a/target/hppa/translate.c
> > +++ b/target/hppa/translate.c
> > @@ -3404,10 +3404,6 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
> >      TCGv_reg mask, tmp, shift, dest;
> >      unsigned msb = 1U << (len - 1);
> >  
> > -    if (c) {
> > -        nullify_over(ctx);
> > -    }
> > -
> >      dest = dest_gpr(ctx, rt);
> >      shift = tcg_temp_new();
> >      tmp = tcg_temp_new();
> > @@ -3440,11 +3436,17 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
> >  
> >  static bool trans_depw_sar(DisasContext *ctx, arg_depw_sar *a)
> >  {
> > +    if (a->c) {
> > +        nullify_over(ctx);
> > +    }
> >      return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_gpr(ctx, a->r));
> >  }
> >  
> >  static bool trans_depwi_sar(DisasContext *ctx, arg_depwi_sar *a)
> >  {
> > +    if (a->c) {
> > +        nullify_over(ctx);
> > +    }
> 
> I don't see how this patch helps or change anything, isn't it the same?
> You clean in the caller rather than the callee.

The Problem is that load_gpr()/load_const() allocate a temporary, which
gets destroyed in do_depw_sar() when nullify_over() is called. If we
move the nullify_over() before doing the load_gpr()/load_const() this
doesn't happen.

> >      return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_const(ctx, a->i));
> >  }
> >  
> >

Regards
Sven

