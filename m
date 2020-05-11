Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E40C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F6B206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hybfyhWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F6B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYAlf-0002Y4-Cw
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 11:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <igotti@gmail.com>) id 1jYAkQ-0001SR-G3
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:53:42 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:39898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <igotti@gmail.com>) id 1jYAkO-0003ci-K3
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:53:41 -0400
Received: by mail-lf1-x143.google.com with SMTP id h26so7939198lfg.6
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZnCJz6+6KTdMt04/X/VPEjWbLhIlfeIW1KJvIDFxjyQ=;
 b=hybfyhWtxxLYpiXnl9SP2MOXnQUrt2uuTnjq0MyevsMe58BNPNtU8Cvh0krg5y0cT0
 ZDEj47vCC4/f32dWKblwoWPFtVsW5bPfoQd2zd4RA2XJ16+3vKrsK5Q/3DTkFAlxsTSa
 lWf5Ki2GoPEQrk6pg39GJQxyOgioZd78DhA4HWNmugvCWw9ujxboo4CACdffL0rBEnTe
 a+x5MtJleveFVykFoecz0JWr0GphRq37qAkOT4JzTkcjUO3yEVJbgu2C/Ft7dNc8GYXf
 0pC+Yf4VvyhFj1Bl6s9u4RVUlj6j/28w35bUTa1BOKyfT7m+gkxHh4xVyLJBWvn5vyZ+
 zrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZnCJz6+6KTdMt04/X/VPEjWbLhIlfeIW1KJvIDFxjyQ=;
 b=iyq3g9lPYAJm9iUL2TGAJsjX8eZWl1AsLD9d9sJmOEhtz+X59GGE3v+UVW16jTGuoO
 4zcjHMTJTxiSLGvbES5KfTzzWeDXWg/rBa8Z38OS8sIawzH5D4NhVCE2f8sFboV1eBbh
 XnkoaUd6Bi3sfByAcZ9m54voRxf+jRsQ/fuy61sy7rAGlyDahDiefODQRZD9pjY90R6I
 RFjp2l+rCAH1OIWiT/ALc3wuOeeJIeeTKiUgB1F1LbM9DOvNvJcznvXlhgYArATa7mis
 bHnBeqSV4KVBRtG00oi81Kd3UaDZaLlEOfGQyefl8O8HO55yTL6+DvqSNBeeu8Ay4h0u
 Zw+w==
X-Gm-Message-State: AOAM531pobxrXlGFRUFFGAFkS2ab389cuBvXUTaMqg3tepzXOb/3iYAz
 Oo0GL8FiQP/usn/gFoIbfy06uQEHja1Ynrcp9Rk=
X-Google-Smtp-Source: ABdhPJwtT7ywW/jr5oEZH6J3KYX1B6SJM2No6OHTVlYi9Wn28nuxUnF3vy3DFT6MpUpiBRlaZKRpn2eHR+5WHrInA60=
X-Received: by 2002:ac2:47fb:: with SMTP id b27mr11800344lfp.10.1589212413594; 
 Mon, 11 May 2020 08:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
 <f4feb648-7dc5-ac54-bc0b-db650dd176f1@vivier.eu>
 <CAEme+7EtF6B2+2U_yF2dd-g2m+=S3P5=DL1oLmHfmWw2S7PYAw@mail.gmail.com>
 <20200509230016.GA109593@sff>
In-Reply-To: <20200509230016.GA109593@sff>
From: Nikolay Igotti <igotti@gmail.com>
Date: Mon, 11 May 2020 18:53:19 +0300
Message-ID: <CAEme+7H82A2RNk5g09rmhThxW4=6sqWP5o65OCsJ8zf1L-nb+w@mail.gmail.com>
Subject: Re: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited
 several times
To: "Emilio G. Cota" <cota@braap.org>
Content-Type: multipart/alternative; boundary="00000000000062907005a56159d1"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=igotti@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: riku.voipio@iki.fi, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000062907005a56159d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attached to the mail counter.c when running with attached test.c compiled
to Linux standalone binary shows failing assert, unless the patch is
applied.

=D0=B2=D1=81, 10 =D0=BC=D0=B0=D1=8F 2020 =D0=B3. =D0=B2 02:00, Emilio G. Co=
ta <cota@braap.org>:

> On Mon, Apr 20, 2020 at 13:04:51 +0300, Nikolay Igotti wrote:
> > In linux-user multithreaded scenarious CPU could be inited many times
> with
> > the same id,
> > so avoid assertions on already present hashtable entry.
> >
> > Signed-off-by: Nikolay Igotti <igotti@gmail.com>
> > ---
> >  plugins/core.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/plugins/core.c b/plugins/core.c
> > index 51bfc94787..889cc6441a 100644
> > --- a/plugins/core.c
> > +++ b/plugins/core.c
> > @@ -196,13 +196,10 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enu=
m
> > qemu_plugin_event ev,
> >
> >  void qemu_plugin_vcpu_init_hook(CPUState *cpu)
> >  {
> > -    bool success;
> > -
> >      qemu_rec_mutex_lock(&plugin.lock);
> >      plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);
> > -    success =3D g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
> > +    g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
> >                                    &cpu->cpu_index);
> > -    g_assert(success);
> >      qemu_rec_mutex_unlock(&plugin.lock);
>
> Do you have a reproducer for this? I'd expect (1) the g_hash_table_remove
> call in qemu_plugin_vcpu_exit_hook to clear this entry upon CPU exit,
> and (2) no two live CPUs to have the same cpu_index. But maybe assumption
> (2) is wrong, or simply (1) does not get called for some exiting CPUs,
> in which case the right fix would be to make sure that it does get called
> on CPU exit.
>
> Thanks,
>
>                 Emilio
>

--00000000000062907005a56159d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div><br></div><div><div dir=3D"auto">Attached to the mail counter.c w=
hen running with attached test.c compiled to Linux standalone binary shows =
failing assert, unless the patch is applied.</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=81, 10 =D0=BC=D0=B0=
=D1=8F 2020 =D0=B3. =D0=B2 02:00, Emilio G. Cota &lt;<a href=3D"mailto:cota=
@braap.org" target=3D"_blank">cota@braap.org</a>&gt;:<br></div></div></div>=
</div><div><div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">O=
n Mon, Apr 20, 2020 at 13:04:51 +0300, Nikolay Igotti wrote:<br>
&gt; In linux-user multithreaded scenarious CPU could be inited many times =
with<br>
&gt; the same id,<br>
&gt; so avoid assertions on already present hashtable entry.<br>
&gt; <br>
&gt; Signed-off-by: Nikolay Igotti &lt;<a href=3D"mailto:igotti@gmail.com" =
target=3D"_blank">igotti@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 plugins/core.c | 5 +----<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/plugins/core.c b/plugins/core.c<br>
&gt; index 51bfc94787..889cc6441a 100644<br>
&gt; --- a/plugins/core.c<br>
&gt; +++ b/plugins/core.c<br>
&gt; @@ -196,13 +196,10 @@ plugin_register_cb_udata(qemu_plugin_id_t id, en=
um<br>
&gt; qemu_plugin_event ev,<br>
&gt; <br>
&gt;=C2=A0 void qemu_plugin_vcpu_init_hook(CPUState *cpu)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 bool success;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_rec_mutex_lock(&amp;plugin.lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 plugin_cpu_update__locked(&amp;cpu-&gt;cpu_index, =
NULL, NULL);<br>
&gt; -=C2=A0 =C2=A0 success =3D g_hash_table_insert(plugin.cpu_ht, &amp;cpu=
-&gt;cpu_index,<br>
&gt; +=C2=A0 =C2=A0 g_hash_table_insert(plugin.cpu_ht, &amp;cpu-&gt;cpu_ind=
ex,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cpu-&gt;cpu_in=
dex);<br>
&gt; -=C2=A0 =C2=A0 g_assert(success);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_rec_mutex_unlock(&amp;plugin.lock);<br>
<br>
Do you have a reproducer for this? I&#39;d expect (1) the g_hash_table_remo=
ve<br>
call in qemu_plugin_vcpu_exit_hook to clear this entry upon CPU exit,<br>
and (2) no two live CPUs to have the same cpu_index. But maybe assumption<b=
r>
(2) is wrong, or simply (1) does not get called for some exiting CPUs,<br>
in which case the right fix would be to make sure that it does get called<b=
r>
on CPU exit.<br>
<br>
Thanks,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Emilio<br>
</blockquote></div></div>
</div>

--00000000000062907005a56159d1--

