Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779DDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F4E20734
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYwHSivJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F4E20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwOQs-0008AZ-6t
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 07:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jwOQ1-0007Tz-6Q
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:20:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25358
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jwOPy-0001cw-Tf
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594984841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v1SOHxz8jDSY9RTfQEmRPP6K4kWVdqDd5wByb7Te0lU=;
 b=EYwHSivJyCYtvZ7+97B6jjKaZu5ElGZGelGQQgEv4jfgmk88hicb9AUghSTzc7JjHONMNE
 R2by2Mb25kQ62DL8kJ5+BFpPNLaorwf9TOK2ZvVwU3d4oyJ8ZuCMLKfvFTZih0MQdLOhPC
 cCQ07i24IXJy4ARr2vqJIqvCaV7KZTY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-L7x3NXEENyKEr64RpcAQZQ-1; Fri, 17 Jul 2020 07:20:37 -0400
X-MC-Unique: L7x3NXEENyKEr64RpcAQZQ-1
Received: by mail-ed1-f70.google.com with SMTP id m12so5581251edv.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 04:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p/++CV5Kuuxo6NAoDuKwh3eTZiTjpw3nAbgYon+WvJE=;
 b=WODa+UW40kxuu4XB8cUvmfF0Xs98NuQgibDZdeA2qWPzG9qf1xXyrNyC7YegKEiWej
 YtCF5/vtgdIVyxNWWcfElowF+uQjMLYqX94M+dZzYDVConazdEMiFL40riQDELSqPlXp
 MDibV6oxYF7d1m3D3ULneIlRyyfZr2dVnwZQmsjEkxIKBzhgvyWkt0pZhUv9h+r28kfC
 EgiJO1RNiUuZrKJCd7qEaeK74d56tQXGvmMAN/T4nOuhjnmY0qsGS+Dv7B0zJXqW13wy
 BAXSOasVjxl/QNDy7Yc1ywmgMQbIU1m3wQglmNTslp8e65eAUG5nXkjYRZATa6ayvEY7
 OfiA==
X-Gm-Message-State: AOAM532/47KOFdCYmUsoy4QSIN262FQMsJlpYPf3eUjjSapSrNAFBdLi
 oRW1mhJNXZhO+EwFLHg8cj//udLGnIbhZQL9G/Yv13HShHoURbk0+aRXHwWANRXvXspTD420++i
 PUvuUbrAzV/kYD0RBB79QG1FBMgzlLCs=
X-Received: by 2002:a17:906:5657:: with SMTP id
 v23mr8346264ejr.196.1594984835868; 
 Fri, 17 Jul 2020 04:20:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFnQAaOkfXpLrLae94PVQUVhzQBBQYfdmycjtGgw53rbAKfj3T4MFXewWXmbrJ7VXHI1wh1ERwKoiDF8xKs4w=
X-Received: by 2002:a17:906:5657:: with SMTP id
 v23mr8346248ejr.196.1594984835689; 
 Fri, 17 Jul 2020 04:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <20200706164155.24696-29-pbonzini@redhat.com>
 <CAFEAcA-Ha4+ub=QQASREraok747+U2tUcNkSYu6PFnoc29_Jrw@mail.gmail.com>
In-Reply-To: <CAFEAcA-Ha4+ub=QQASREraok747+U2tUcNkSYu6PFnoc29_Jrw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Jul 2020 13:20:23 +0200
Message-ID: <CABgObfaFYmsiR-aYsq5vBEruL5Z2=qD0Z6Zf0d0C2N1cbfq4kQ@mail.gmail.com>
Subject: Re: [PULL 28/53] Makefile: simplify MINIKCONF rules
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000008dc57c05aaa15838"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008dc57c05aaa15838
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 17 lug 2020, 13:03 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Mon, 6 Jul 2020 at 18:03, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > There is no reason to write MINIKCONF_DEPS manually, since minikconf.py
> > emits a dependency file, and also no reason to list multiple Kconfig
> > files on the command line since they can be included from a master file
> > in the top-level source directory.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Hi Paolo. With this change Make seems no longer to realise
> that a change to a Kconfig file means it needs to rebuild
> the config-devices.mak, which means that we tend to get
> weird compile failures for changes which update Kconfig files.
>
> Specifically here, the $(MINIKCONF_DEPS) long list of Kconfig
> files has been removed from the dependency list of
> config-devices.mak.
>
> There doesn't seem to be any machinery for creating .d
> files for make to include to tell it that Kconfig has a
> dependency on hw/Kconfig which has a dependency on hw/i2c/Kconfig etc.
> How is this intended to work ?
>

I cannot look at a build tree right now, but shouldn't that be in the .d
file produced by minikconf.py Those are passed to minikconf.py as the
second argument and included with "include $(SUBDIR_DEVICES_MAK_DEP)".

No objection against reverting though.

Paolo


> For 5.1, should we just revert this commit ?
>
> thanks
> -- PMM
>
>

--0000000000008dc57c05aaa15838
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 17 lug 2020, 13:03 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org" target=3D"_blank" rel=3D"noreferrer">pete=
r.maydell@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">On Mon, 6 Jul 2020 at 18:03, Paolo Bonzini &lt;<a href=3D"mailto:pbon=
zini@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_blank">pbonzini@r=
edhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; There is no reason to write MINIKCONF_DEPS manually, since minikconf.p=
y<br>
&gt; emits a dependency file, and also no reason to list multiple Kconfig<b=
r>
&gt; files on the command line since they can be included from a master fil=
e<br>
&gt; in the top-level source directory.<br>
&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">pbonzini@redhat.com</a>&g=
t;<br>
<br>
Hi Paolo. With this change Make seems no longer to realise<br>
that a change to a Kconfig file means it needs to rebuild<br>
the config-devices.mak, which means that we tend to get<br>
weird compile failures for changes which update Kconfig files.<br><br>
Specifically here, the $(MINIKCONF_DEPS) long list of Kconfig<br>
files has been removed from the dependency list of<br>
config-devices.mak.<br>
<br>
There doesn&#39;t seem to be any machinery for creating .d<br>
files for make to include to tell it that Kconfig has a<br>
dependency on hw/Kconfig which has a dependency on hw/i2c/Kconfig etc.<br>
How is this intended to work ?<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">I cannot look at a build tree right now, but =
shouldn't that be in the .d file produced by <a href=3D"minikconf.py">minik=
conf.py</a> Those are passed to minikconf.py as the second argument and inc=
luded with &quot;include $(SUBDIR_DEVICES_MAK_DEP)&quot;.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">No objection against reverting though.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
For 5.1, should we just revert this commit ?<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--0000000000008dc57c05aaa15838--


