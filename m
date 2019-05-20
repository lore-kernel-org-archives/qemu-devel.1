Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36949C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 04:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05469204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 04:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvTHMoPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05469204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57833 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSaHE-0003WD-86
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 00:51:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSaGM-0002xD-RP
	for qemu-devel@nongnu.org; Mon, 20 May 2019 00:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSaGL-0007lk-0o
	for qemu-devel@nongnu.org; Mon, 20 May 2019 00:51:02 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:39054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hSaGJ-0007iw-4x
	for qemu-devel@nongnu.org; Mon, 20 May 2019 00:50:59 -0400
Received: by mail-ed1-x543.google.com with SMTP id e24so21769543edq.6
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 21:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=tT9CGxH07NKpVGGgm0Cn5Cwn2T2kC+wsPSrgnsJbf8E=;
	b=nvTHMoPyoxCvi8cL1NokrB/XrXrjmcbV/D0vJ+0V2aErSgrxDCnRGH4zSpxI+3GkG6
	Nb4vEuvSSXioZPo9KhpsCQA1qHK23kDz3VI1mXvdaHb6lgyH/oEAl9AKMjbgZR/Btboa
	z/XsBr89ym9z5O1Vqn7RQ1tq/YllZWxCdAT38qs6Mu1moSDnCa7DdPOYK/jsbp3G1tBW
	++9gC29IpsiIdaicNxzYrWNif1R0Ip07F9PjFbJ9LXksByu615B1Odfum4ioJ7JeiOfx
	8gPlt6lFstvP2PX3CaryxreMjFzMMY0z3qbRUNJG1ukbfFG9E9sYVzg1xZgHfbP2vtle
	jRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=tT9CGxH07NKpVGGgm0Cn5Cwn2T2kC+wsPSrgnsJbf8E=;
	b=o5atEQ7q381h65OWi2M9Hg4grI+UKxpVbySBxJzj8TvQ6vjUcEko2g+qr3bPj316Qu
	J+bIs+brpV681hGzJ2G1CcHMBzvlFO1No9zjwb1RDT8BBkR42Df4f6R5tfVW2TrkSpqI
	txre3fBej+KmlElq03C/cPjPQy2VimbFiJXXymnK/GZVD6yYPXbtU0mdWSX1qcuWqYmH
	1bhymx0+Xi0AGrqRfh0cxb8w/r/cd18nYwkW46tLI2vVVIBU/B9rq9k0j02QzJ1jVFTZ
	bASiWqA8oRTd3kZ+u3rYDhsyTEhh5GVR+qzHklwIh/cJBkA90U7sG9SYDj/CiUz4LJ5y
	wItA==
X-Gm-Message-State: APjAAAU5cZGGVD/llTVOiMq2Ghk3P1fMdQnyZh8CPQfpqErm137X5W2j
	77e7JPE0tiF0p0KtS3dNDVgPFPdP1vafKlg2+Nk=
X-Google-Smtp-Source: APXvYqz9FyvKbWeAbuXPmQeLkaLQ8UNHkLvxOQK6Ot3SaQqTaoRYGZTYKzsqMzmyjsxr5wAZOeJ1GBuGWLMti+tHdU4=
X-Received: by 2002:a50:8818:: with SMTP id b24mr73695388edb.28.1558327857975; 
	Sun, 19 May 2019 21:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-23-arilou@gmail.com>
	<87bm03mx7e.fsf@zen.linaroharston>
In-Reply-To: <87bm03mx7e.fsf@zen.linaroharston>
From: Jon Doron <arilou@gmail.com>
Date: Mon, 20 May 2019 07:50:47 +0300
Message-ID: <CAP7QCohSPy_N5Yfo0cW4GdWHpan6zwxzwTd4toU-BnQEyjFdtw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v9 22/27] gdbstub: Implement generic query
 qemu.Supported
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I suggest then that I'll squash this commit into the commit that
refactors the the Q/q packets and will add the required documentation
about this
in the commit message.

Do you agree?
-- Jon.

On Wed, May 15, 2019 at 8:41 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Jon Doron <arilou@gmail.com> writes:
>
> > qemu.Supported query reply back with the supported qemu query/set
> > commands (commands are seperated with a semicolon from each other).
> >
> > gdb> maint packet qqemu.Supported
> >
> > Signed-off-by: Jon Doron <arilou@gmail.com>
> > ---
> >  gdbstub.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/gdbstub.c b/gdbstub.c
> > index 8bdfae4b29..00c07d6ec0 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -2127,6 +2127,11 @@ static void handle_query_attached(GdbCmdContext =
*gdb_ctx, void *user_ctx)
> >      put_packet(gdb_ctx->s, GDB_ATTACHED);
> >  }
> >
> > +static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *=
user_ctx)
> > +{
> > +    put_packet(gdb_ctx->s, "sstepbits;sstep");
>
> To maintain bisectability this response should be extended as each
> feature is added.
>
> > +}
> > +
> >  static GdbCmdParseEntry gdb_gen_query_set_common_table[] =3D {
> >      /* Order is important if has same prefix */
> >      {
> > @@ -2203,6 +2208,10 @@ static GdbCmdParseEntry gdb_gen_query_table[] =
=3D {
> >          .handler =3D handle_query_attached,
> >          .cmd =3D "Attached",
> >      },
> > +    {
> > +        .handler =3D handle_query_qemu_supported,
> > +        .cmd =3D "qemu.Supported",
> > +    },
> >  };
> >
> >  static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
>
>
> --
> Alex Benn=C3=A9e

