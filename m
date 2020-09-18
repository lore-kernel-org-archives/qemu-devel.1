Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC49C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E9921534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpytxL3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E9921534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJsm-0006qm-Gp
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 13:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthik.poduval@gmail.com>)
 id 1kJJXC-0004Hf-MW
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:46:54 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d]:40447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <karthik.poduval@gmail.com>)
 id 1kJJX7-00019Q-M4
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:46:54 -0400
Received: by mail-ua1-x92d.google.com with SMTP id j12so2072983ual.7
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VVFFh1mJwHjfXScSn8mmTPqrJd/8FU4jjlpAGYPwUm8=;
 b=FpytxL3fEhrOKA/OJchbM9xKk0IE2dgPkXJCB1OQi64MUDxhIWRR5OUtuTsdbcTLTb
 /3mfSNGloHMGMqUL99eG/WBHQnKc92Z93MTtstX7nyqvUoi8LtJ7Bkmhf5Cgk8zUSa1a
 QOyNhVIx4ICFn4hMwED/TPiCFGJs+OIoY/KJxM3iFqRmnBXbqIw96hFaesGRiX5b7gsf
 NKRG93HrRDEIUEiEXifXrJL+yv44abBN3LNLfjsFtjhZXZjFspMRUhx72xvKZWMjcdC7
 +1XSE5b47n7Hm76+xjl/zvD5JcHn8eOIWDfp6WxYfOiVxBOiqIpm+0u7ji4h1lrChXSU
 8qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VVFFh1mJwHjfXScSn8mmTPqrJd/8FU4jjlpAGYPwUm8=;
 b=Iy4jwhDRY+coikCBbo5Kcc0NvHwrNv8w2v6g4n+OKW+wKPpVzO3pE1odP0110tPznL
 RCt/jS1vLpNf1a9ISQAynPLxhJQVtkOlzx4wnrz8MAEhCKYF5noE7xj1cZ1ATPc5ZIoc
 uDzSvZ5ukHj9Wm82UhFp8pd+Sky2Hil97Ur1SuYeEe1XzoAtyWiXQsrUybF9+97WgFYe
 rh0Zfi5UJrlN1K4G+mvS/Lf0mryPIumwHngq4TH5sRgGS6HHRAdAJTRiveGgr87MQVpj
 NYEsCCa9G4Mm1Vvns94KsTVuceIIGeoR7sFh+PYm7WkmJVqOFPJReLY+Sft6gyfLMEQF
 6I9A==
X-Gm-Message-State: AOAM5328giagD6U+TRA+U/r3NwoSIywNjpJTgUbvxB3SbWVVsXAl8ni5
 eDtqq5/maViaeAQm8Vb5W+EmZ86eIHGU+AldyBABvK9nY2E=
X-Google-Smtp-Source: ABdhPJzm3DA4pEV37P9DOcZr3cTKpZ2IL4flzKGQ9HKvloFDfdpX+ZypuU5fsFW1GD4bkmU+/bbkhpwpg0tZ4s6ppWI=
X-Received: by 2002:a9f:2237:: with SMTP id 52mr18157828uad.141.1600447606220; 
 Fri, 18 Sep 2020 09:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAFP0Ok82wY26BfVToT7K_0CCngr9N27UV3iaou_5QOE-Nmw1BQ@mail.gmail.com>
 <CAFEAcA__4v60WjXsTzq3aXY8MReZ+Oreqs-zqUKTObefJQe2jw@mail.gmail.com>
In-Reply-To: <CAFEAcA__4v60WjXsTzq3aXY8MReZ+Oreqs-zqUKTObefJQe2jw@mail.gmail.com>
From: karthik poduval <karthik.poduval@gmail.com>
Date: Fri, 18 Sep 2020 09:46:31 -0700
Message-ID: <CAFP0Ok-Hhwu9d+W58zAT4RxSZDYEpG-URpP7Y8dr-enRaiwiAg@mail.gmail.com>
Subject: Re: Heterogeneous/AMP example in mainline?
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000cf1c905af993ff1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=karthik.poduval@gmail.com; helo=mail-ua1-x92d.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000cf1c905af993ff1
Content-Type: text/plain; charset="UTF-8"

Thanks Peter,

I will go through the Xilinx example.

--
Regards,
Karthik Poduval

On Fri, Sep 18, 2020 at 8:08 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Fri, 18 Sep 2020 at 14:15, karthik poduval <karthik.poduval@gmail.com>
> wrote:
> > Was sifting through the heterogeneous QEMU effort in archives here
> > https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg06256.html
> >
> > Did this effort make it to the mainline ? Are there any examples of
> > AMP SoC's in the mainline ?
>
> In upstream we can handle having asymmetric configurations
> as long as all the CPUs are the same basic architecture:
> so you can have for instance an Arm Cortex-M and a Cortex-A
> in the same board model (there's a xilinx board model
> with a mix of cortex-a53 and cortex-r5 cores in the tree).
> But we can't handle having multiple different architectures (eg
> Arm and x86) in the same board at once. It would be nice to be
> able to do that, but it would require a lot of untangling of
> things which currently assume various parameters that are
> guest-architecture-specific are compile-time fixed things.
> So far nobody has been sufficiently interested in having
> asymmetric configs to put in that work.
>
> thanks
> -- PMM
>


-- 
Regards,
Karthik Poduval

--0000000000000cf1c905af993ff1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks=C2=A0Peter,<div><br></div><div>I will go through th=
e Xilinx example.</div><div><br></div><div>--</div><div>Regards,</div><div>=
Karthik Poduval</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Sep 18, 2020 at 8:08 AM Peter Maydell &lt;<a h=
ref=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 18 =
Sep 2020 at 14:15, karthik poduval &lt;<a href=3D"mailto:karthik.poduval@gm=
ail.com" target=3D"_blank">karthik.poduval@gmail.com</a>&gt; wrote:<br>
&gt; Was sifting through the heterogeneous QEMU effort in archives here<br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg06=
256.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archiv=
e/html/qemu-devel/2015-10/msg06256.html</a><br>
&gt;<br>
&gt; Did this effort make it to the mainline ? Are there any examples of<br=
>
&gt; AMP SoC&#39;s in the mainline ?<br>
<br>
In upstream we can handle having asymmetric configurations<br>
as long as all the CPUs are the same basic architecture:<br>
so you can have for instance an Arm Cortex-M and a Cortex-A<br>
in the same board model (there&#39;s a xilinx board model<br>
with a mix of cortex-a53 and cortex-r5 cores in the tree).<br>
But we can&#39;t handle having multiple different architectures (eg<br>
Arm and x86) in the same board at once. It would be nice to be<br>
able to do that, but it would require a lot of untangling of<br>
things which currently assume various parameters that are<br>
guest-architecture-specific are compile-time fixed things.<br>
So far nobody has been sufficiently interested in having<br>
asymmetric configs to put in that work.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Regards,<br>Karthik Poduval<br></div>

--0000000000000cf1c905af993ff1--

