Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E29BC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779522225D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yowob/UK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779522225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQtP1-00028G-9o
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQtLD-0007zM-UJ; Fri, 09 Oct 2020 10:25:52 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34]:37069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQtLB-0006I2-Ry; Fri, 09 Oct 2020 10:25:51 -0400
Received: by mail-io1-xd34.google.com with SMTP id b1so5468915iot.4;
 Fri, 09 Oct 2020 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0leBTqsGF+DNwQbpDJ19tNyoY37fFPsxJznx7B0Alkc=;
 b=Yowob/UKWoMsozpB02XCuFMTQtfzHZ30gJA2EjYQlyY9J+8D3pjB+OjrfJvTLQOwf8
 x9iPfqIbD2Ho328MIF65TmckEyGixyz99i6DoFmJCZayRQ63UiD4bPiI4e/2sp13euEe
 mJ4TUcGKspGBlGCvvOP9FDIdxsm7A/mqn3zKVWjrylM1rGdbbtVv49fkDMvrW0Jb/0Xe
 epGFnPmSVvh2B8LYyEIgtuc34JPMFTDh1qkkjZlgqK4mB1OdfB7hFMI5paVW7F8pqEOA
 aOAHEPrGaZ23pq2zQYu+misI1cY+wPw/KYvvsTobHKXaakwnNHAUL7E2oUaOy+op591L
 JBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0leBTqsGF+DNwQbpDJ19tNyoY37fFPsxJznx7B0Alkc=;
 b=j5uViaBa0jldiy/R0VrUsavjj0fwRe35vg8xaacQn1KH+ae68bFhVi6lRPR5MvpOqw
 MM+XPcMmPw+/hI8jS4h3sr1kTnHYz5ZwkGCjSEutw9MS6LoPfbGcgl6gzBZDxtwAKrfS
 avlMGJ2N6HsXY9x5H1c4a4s71SpppZeemhOxPgEiqs5Ft4mDEAsecF9qdxmiGCv7HdEQ
 XYK6dBGTnxu0XJMwOppJ/wE07QpYQSbe+grZyMbJ+Edu85iyEq0F7oO3EhPZUZAJW3Un
 3vLijlk5nN0rhRmfF4kagR0BQ+cKcD4FIynNh+ZIJPRc8/W+xUx/jNRUFEqPx4nzXlLh
 ih5Q==
X-Gm-Message-State: AOAM531ETWYli5oJwbOamZG8m4LmdoW9K2zdZjpVyIGvkjAI+xa/bp1+
 RL93drSrX1iKDJ6x+bzMb3cmUu8cZiuwj9u2MeA=
X-Google-Smtp-Source: ABdhPJzFd2qS6dH1r1ZYfS5MWUA62TlPFxm0gqsElGr+0iqdK4Pfeb3E+ohl7thf8H3or9xQMoDCQgNjUZy2fHPPLSU=
X-Received: by 2002:a5d:9042:: with SMTP id v2mr9511137ioq.18.1602253548296;
 Fri, 09 Oct 2020 07:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201009063734.2627-1-chetan4windows@gmail.com>
 <9f236758-8039-0a16-df3a-b49b7e24168d@redhat.com>
 <20201009134337.GC25901@redhat.com>
In-Reply-To: <20201009134337.GC25901@redhat.com>
From: Chetan <chetan4windows@gmail.com>
Date: Fri, 9 Oct 2020 19:55:35 +0530
Message-ID: <CAPPKfOEvCvGHEPLJ0uJEabAGyZQUHoeDgvKyyv5M0wEv83N-_g@mail.gmail.com>
Subject: Re: [PATCH 1/5] Fixing Lesser GPL version number [1/5]
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000961e6c05b13db9da"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=chetan4windows@gmail.com; helo=mail-io1-xd34.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000961e6c05b13db9da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 9, 2020 at 6:38 PM Eric Blake <eblake@redhat.com> wrote:
>Thank you for contributing.  However, it will require more work before
>this is ready to merge; while I have a lot of comments below, I hope you
>read them in the intended tone of ideas on making your v2 better.  For
>more thoughts on patch submission, see
>.

Thanks for the remarks Eric, they are definitely going to help me a lot in
making v2 better.

On Fri, Oct 9, 2020 at 7:13 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:
>I'm happy to queue 80% of this patch, and a patch of patch 2, since
>they cover files in subsystems I maintain and the typos are largely
>my fault :-)

Thanks Daniel, as the idea was to get familiar with the process of sending
patches.
I=E2=80=99ll draft and split the patches again as per your and Eric=E2=80=
=99s comments and
then send them again.

Regards,
Chetan P.

On Fri, Oct 9, 2020 at 7:13 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Fri, Oct 09, 2020 at 08:07:52AM -0500, Eric Blake wrote:
>
> > > There is no "version 2" of the "Lesser" General Public License. It is
> > > either "GPL version 2.0" or "Lesser GPL version 2.1". This patch
> replaces all
> > > occurrences of "Lesser GPL version 2" with "Lesser GPL version 2.1" i=
n
> comment section.
> >
> > I'm not a copyright lawyer; there may be legal ramifications for doing
> > this on files where you are not the copyright owner, although to me it
> > looks like an obvious correction of intent, so I'm okay with the idea.
>
> Yes, we've done exactly this same cleanup for various files before,
> and considered it acceptable since it is matching the intent.
>
>
> > Thus, maybe something like:
> >
> > backends: Fix LGPL version number
> > disas: Fix LGPL version number
> > target: Fix LGPL version number
> >
> > and so on.  There may be a smarter division of the work based on which
> > maintainer(s) will have to ack various patches; breaking the series int=
o
> > more than 5 chunks may be easier, although it then requires more topic
> > lines.  Or, if it truly is automated, doing it all in one shot may be
> > best after all.
>
> I'm happy to queue 80% of this patch, and a patch of patch 2, since
> they cover files in subsystems I maintain and the typos are largely
> my fault :-)
>
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000961e6c05b13db9da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>
On Fri, Oct 9, 2020 at 6:38 PM Eric Blake &lt;<a href=3D"mailto:eblake@redh=
at.com">eblake@redhat.com</a>&gt; wrote: <br></div><div>
&gt;Thank you for contributing.=C2=A0 However, it will require more work be=
fore<br>
&gt;this is ready to merge; while I have a lot of comments below, I hope yo=
u<br>
&gt;read them in the intended tone of ideas on making your v2 better.=C2=A0=
 For<br>
&gt;more thoughts on patch submission, see

</div><div>&gt;.</div><div><br></div><div>Thanks for the remarks Eric, they=
 are definitely going to help me a lot in making v2 better.</div><div><br><=
/div><div>
On Fri, Oct 9, 2020 at 7:13 PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailt=
o:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote: <br></div><div>
&gt;I&#39;m happy to queue 80% of this patch, and a patch of patch 2, since=
<br>
&gt;they cover files in subsystems I maintain and the typos are largely<br>
&gt;my fault :-)



=20

 </div><div><br></div><div>Thanks Daniel, as the idea was to get familiar w=
ith the process of sending patches.</div>I=E2=80=99ll draft and split the p=
atches again as per your and Eric=E2=80=99s comments and then send them aga=
in.<div><br></div><div>Regards,</div><div>Chetan P.<br></div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 9,=
 2020 at 7:13 PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@red=
hat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Fri, Oct 09, 2020 at 08:07:52AM -0500, Eric =
Blake wrote:<br>
<br>
&gt; &gt; There is no &quot;version 2&quot; of the &quot;Lesser&quot; Gener=
al Public License. It is<br>
&gt; &gt; either &quot;GPL version 2.0&quot; or &quot;Lesser GPL version 2.=
1&quot;. This patch replaces all<br>
&gt; &gt; occurrences of &quot;Lesser GPL version 2&quot; with &quot;Lesser=
 GPL version 2.1&quot; in comment section.<br>
&gt; <br>
&gt; I&#39;m not a copyright lawyer; there may be legal ramifications for d=
oing<br>
&gt; this on files where you are not the copyright owner, although to me it=
<br>
&gt; looks like an obvious correction of intent, so I&#39;m okay with the i=
dea.<br>
<br>
Yes, we&#39;ve done exactly this same cleanup for various files before,<br>
and considered it acceptable since it is matching the intent.<br>
<br>
<br>
&gt; Thus, maybe something like:<br>
&gt; <br>
&gt; backends: Fix LGPL version number<br>
&gt; disas: Fix LGPL version number<br>
&gt; target: Fix LGPL version number<br>
&gt; <br>
&gt; and so on.=C2=A0 There may be a smarter division of the work based on =
which<br>
&gt; maintainer(s) will have to ack various patches; breaking the series in=
to<br>
&gt; more than 5 chunks may be easier, although it then requires more topic=
<br>
&gt; lines.=C2=A0 Or, if it truly is automated, doing it all in one shot ma=
y be<br>
&gt; best after all.<br>
<br>
I&#39;m happy to queue 80% of this patch, and a patch of patch 2, since<br>
they cover files in subsystems I maintain and the typos are largely<br>
my fault :-)<br>
<br>
<br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--000000000000961e6c05b13db9da--

