Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105D1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 02:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4EF2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 02:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4EF2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8EAL-0003tN-55
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 22:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8E76-00070Q-GF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 22:46:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8E72-0005ct-Bt
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 22:46:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id v22so16881771edy.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 19:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DLH641eQFnc2YDUjL1CU6K47OGchbwvFiAQd3wIq/tI=;
 b=D5usJNpkKMzUKanBfLj4+LyfLtf9S+TNtz57JemgeiFkrDlh7shqPp08xRdiSznkd1
 1kH3oTq0WBPNGZsf+C+6bz3LLFBxVSHInw3yFF7r6nTykrrOIVNczPUSZ72jW+YCb89w
 WV8yUfwslmC/LxWKFO5rhBvHLBvX84S0816hv7GoM8TomN+aCvnHATIu3958x4CssWSw
 qrSMHCRtNklwI5FanLyJSnfI99nmHLfoQCBa3JxZGEtiCP/FSLxHpzBRiboiHg0iUYVr
 zvos2oraOE9iR31ike9p8ChB5ucgmLOeAOBhms81QHvdLIfCY94yxb/wTIOtAYTS0KkP
 jOWA==
X-Gm-Message-State: AOAM5307Y7duRQZu4Q5v4daRKa7FK+XIwUY95HgX4fifbcCfyjFn3D4T
 qI29bLCggUXfa0WYrzv+iSBsTemAFbqLNiZTGuU=
X-Google-Smtp-Source: ABdhPJxzlyDR5hejsJsOK4huq3MefHA9IRL2wz7SM5manWcNoc7N6OHKmdWPMsp2Hh8Tzu6tgZeOdhvZJbr7t5tQn3c=
X-Received: by 2002:aa7:c0d3:: with SMTP id j19mr22123332edp.157.1597805162534; 
 Tue, 18 Aug 2020 19:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-2-ehabkost@redhat.com>
 <3af41d38-3d5f-bdc3-9624-8848151992ae@amsat.org>
 <20200818213033.GB500103@habkost.net>
In-Reply-To: <20200818213033.GB500103@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 19 Aug 2020 04:45:50 +0200
Message-ID: <CAAdtpL4bBJ+UmeWA-On-5XHTWw77SWfm99RaqTH75XOssaVi2Q@mail.gmail.com>
Subject: Re: [PATCH 01/41] pl1110: Rename PL1110 enum
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000221b7805ad3201c0"
Received-SPF: pass client-ip=209.85.208.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 22:46:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000221b7805ad3201c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 18 ao=C3=BBt 2020 23:30, Eduardo Habkost <ehabkost@redhat.com> a =
=C3=A9crit :

> CCing maintainer (pmaydell).
>
> On Fri, Aug 14, 2020 at 07:45:40PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 8/14/20 12:25 AM, Eduardo Habkost wrote:
> > > The PL1110 enum value name will conflict with the PL1110 type
> > > cast checker, when we replace the existing macro with an inline
> > > function.  Rename it to PL1110_STOCK.
> >
> > typo s/PL1110/PL110/ in subject and description.
>
> Thanks for spotting that!  Will be fixed in v2.
>
> >
> > >
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  hw/display/pl110.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/hw/display/pl110.c b/hw/display/pl110.c
> > > index c2991a28d2..4664fde3f2 100644
> > > --- a/hw/display/pl110.c
> > > +++ b/hw/display/pl110.c
> > > @@ -42,7 +42,7 @@ enum pl110_bppmode
> > >  /* The Versatile/PB uses a slightly modified PL110 controller.  */
> > >  enum pl110_version
> > >  {
> > > -    PL110,
> > > +    PL110_STOCK,
> > >      PL110_VERSATILE,
> > >      PL111
> >
> > For completeness I'd also rename PL111.
> >
> > What about:
> >
> >  enum pl110_version
> >  {
> >     PL110_VERSION,
> >     PL110_VERSATILE_VERSION,
> >     PL111_VERSION
> >  }
> >
> > ?
>
> That would work too, although I'm more used to enum values to
> have a common prefix instead of a common suffix.
>
> Any objections to:
>
>   enum pl110_version
>   {
>       VERSION_PL110,
>       VERSION_PL110_VERSATILE,
>       VERSION_PL111
>   }
>
> ?
>

Sounds good.


> --
> Eduardo
>
>

--000000000000221b7805ad3201c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le mar. 18 ao=C3=BBt 2020 23:30, Eduardo Habkost &lt;<a href=
=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</a>&gt; a =C3=A9crit=C2=
=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">CCing maintainer (pmaydell).<b=
r>
<br>
On Fri, Aug 14, 2020 at 07:45:40PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:<br>
&gt; On 8/14/20 12:25 AM, Eduardo Habkost wrote:<br>
&gt; &gt; The PL1110 enum value name will conflict with the PL1110 type<br>
&gt; &gt; cast checker, when we replace the existing macro with an inline<b=
r>
&gt; &gt; function.=C2=A0 Rename it to PL1110_STOCK.<br>
&gt; <br>
&gt; typo s/PL1110/PL110/ in subject and description.<br>
<br>
Thanks for spotting that!=C2=A0 Will be fixed in v2.<br>
<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@red=
hat.com" target=3D"_blank" rel=3D"noreferrer">ehabkost@redhat.com</a>&gt;<b=
r>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 hw/display/pl110.c | 12 ++++++------<br>
&gt; &gt;=C2=A0 1 file changed, 6 insertions(+), 6 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/hw/display/pl110.c b/hw/display/pl110.c<br>
&gt; &gt; index c2991a28d2..4664fde3f2 100644<br>
&gt; &gt; --- a/hw/display/pl110.c<br>
&gt; &gt; +++ b/hw/display/pl110.c<br>
&gt; &gt; @@ -42,7 +42,7 @@ enum pl110_bppmode<br>
&gt; &gt;=C2=A0 /* The Versatile/PB uses a slightly modified PL110 controll=
er.=C2=A0 */<br>
&gt; &gt;=C2=A0 enum pl110_version<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 PL110,<br>
&gt; &gt; +=C2=A0 =C2=A0 PL110_STOCK,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 PL110_VERSATILE,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 PL111<br>
&gt; <br>
&gt; For completeness I&#39;d also rename PL111.<br>
&gt; <br>
&gt; What about:<br>
&gt; <br>
&gt;=C2=A0 enum pl110_version<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0PL110_VERSION,<br>
&gt;=C2=A0 =C2=A0 =C2=A0PL110_VERSATILE_VERSION,<br>
&gt;=C2=A0 =C2=A0 =C2=A0PL111_VERSION<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt; ?<br>
<br>
That would work too, although I&#39;m more used to enum values to<br>
have a common prefix instead of a common suffix.<br>
<br>
Any objections to:<br>
<br>
=C2=A0 enum pl110_version<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 VERSION_PL110,<br>
=C2=A0 =C2=A0 =C2=A0 VERSION_PL110_VERSATILE,<br>
=C2=A0 =C2=A0 =C2=A0 VERSION_PL111<br>
=C2=A0 }<br>
<br>
?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Sounds good.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
-- <br>
Eduardo<br>
<br>
</blockquote></div></div></div>

--000000000000221b7805ad3201c0--

