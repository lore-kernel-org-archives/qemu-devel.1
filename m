Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E11C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6B6221E3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZ/bkyu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6B6221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3nK7-0004ey-Go
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 17:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3nJV-0004EC-HE
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:20:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3nJT-0005Yz-Hh
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596748834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlRQcgfY51Kp01uwREV+l6YpW7olEb2k+QC8UClRUPY=;
 b=HZ/bkyu7aa4d255jPPM15j4wnoDmUpS1HnwMlM3j9TMqVDdoE6kK6X1CybKccxddo0oCYk
 AIammQPLTkx5UDwOQkNluOrNjYbVXp0vRhF1fAl8Y3pBsEZ/d7crAABb7H5wvpOCCD0zxJ
 t24V7/6Xam5G9chqYJP9bO/ymPASh9U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-FAdP4UcBMHe5F_XJpxpAvQ-1; Thu, 06 Aug 2020 17:20:32 -0400
X-MC-Unique: FAdP4UcBMHe5F_XJpxpAvQ-1
Received: by mail-ed1-f71.google.com with SMTP id b11so6428103edy.17
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 14:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MlRQcgfY51Kp01uwREV+l6YpW7olEb2k+QC8UClRUPY=;
 b=uPNsaHmlrYkC64RGc4jbVHm0L0wSAKOi+aWaYzUEktrsh53tWlGR2G7qYILb5MRhLi
 uuiVnHa7BGx4Z3rumNICxY78MrAlLNvRsxeTeayMPwntoo+d+96pgV1pyQKGOYTaiyYo
 NiX55+s/muyJMTi9krlhCBLAV9tCSTBBqjKWX0UjeP2ryAHctfe7zrQ/WSBVrd6O/VCt
 fB0WNOT9onqOieXSyKv0s/DKPmA2iPTY8g8XjvIFNbrXoGQS1HQyuplRARl6gTetxEdv
 7RuLs6UW/d1SmZ3joYUHyJ44kIAT8Xn8jOI1wQVCXm38bSeAdF+Kr4xwG+3GAElWgE7Y
 j0tg==
X-Gm-Message-State: AOAM531rbRf/LIK3T2zAQc2wiyoAAM8zo9VPJryMvkg4Ij/mbcrZCtGG
 zymMcnG0/2fxZkwnRonoJirZqmJPwyF/LR0botl9NwVgk7NRKmBg3RBO6az8xo51n/gysn7GnlL
 5qsjwoBrQf6E80YrLQ7Dh7+DD01Z9kyk=
X-Received: by 2002:a17:906:82c1:: with SMTP id
 a1mr6368549ejy.172.1596748830825; 
 Thu, 06 Aug 2020 14:20:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIKa2XEwS0CD5nvyKA3b0751rrBSZB+6q2J6qeDvr7wsZ6YoKBTqoLdQ1aJCu8AKugF0hj1g9R7QdhSizPZEg=
X-Received: by 2002:a17:906:82c1:: with SMTP id
 a1mr6368535ejy.172.1596748830558; 
 Thu, 06 Aug 2020 14:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-109-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_j2N1ee3Aqjcw3cKF1ksJ9Ls4qF6eXBH058A8oNBObfw@mail.gmail.com>
In-Reply-To: <CAFEAcA_j2N1ee3Aqjcw3cKF1ksJ9Ls4qF6eXBH058A8oNBObfw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Aug 2020 23:20:17 +0200
Message-ID: <CABgObfYry+2he0aL_UujxaSCTNELQL+mbtD8GYc_R4b1H94x8g@mail.gmail.com>
Subject: Re: [PATCH 108/143] meson: convert hw/intc
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000d7645c05ac3c0e47"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d7645c05ac3c0e47
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 6 ago 2020, 23:02 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Thu, 6 Aug 2020 at 21:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Compared to:
>
> > -common-obj-$(CONFIG_HEATHROW_PIC) +=3D heathrow_pic.o
>
> > +softmmu_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true:
> files('heathrow_pic.c'))
>
> this feels pretty clunky. Doesn't Meson have a nicer
> way of expressing this kind of thing?


Nope, in fact it turns out we had to implement it ourselves because there
was no way to express it at all in the way that QEMU build multiple
binaries. My initial version didn't have the when/if_true part but the
maintainer was quite adamant on requiring them instead of just relying on
positional arguments.

Unfortunately, while common in QEMU, and in Linux too, it doesn't seem to
be a very common idiom in general; Makefiles do express it in a very
readable and concise way.

I cannot deny it looks clunky. While Meson does have a huge advantage in
terms of predictability and lack of surprises when doing harder things, the
imperative syntax is heavier when dealing with the simplest. They do remain
simple (it's still one line of coffee), but the quotes and commas seem to
be enough to "switch" our brain to a different mode.

My opinion is that you don't really look at these things very much, so it
doesn't really matter, but I can see people disagreeing.

(You had already pointed this out during the very first discussions, if I
remember correctly. I can't add much except that with extra experience the
balance does tilt in favor of Meson despite the heavier syntax for simple
cases).

Paolo

It's really
> common and I'd hope that a build system language
> would provide less long-winded ways to write common
> operations...
>
> thanks
> -- PMM
>
>

--000000000000d7645c05ac3c0e47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 6 ago 2020, 23:02 Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On Thu, 6 Aug 2020 at 21:10, Pao=
lo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" rel=
=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com<=
/a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@re=
dhat.com</a>&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
<br>
Compared to:<br>
<br>
&gt; -common-obj-$(CONFIG_HEATHROW_PIC) +=3D heathrow_pic.o<br>
<br>
&gt; +softmmu_ss.add(when: &#39;CONFIG_HEATHROW_PIC&#39;, if_true: files(&#=
39;heathrow_pic.c&#39;))<br>
<br>
this feels pretty clunky. Doesn&#39;t Meson have a nicer<br>
way of expressing this kind of thing? </blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Nope, in fact it turns out we had to impl=
ement it ourselves because there was no way to express it at all in the way=
 that QEMU build multiple binaries. My initial version didn&#39;t have the =
when/if_true part but the maintainer was quite adamant on requiring them in=
stead of just relying on positional arguments.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Unfortunately, while common in QEMU, and in Linux to=
o, it doesn&#39;t seem to be a very common idiom in general; Makefiles do e=
xpress it in a very readable and concise way.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">I cannot deny it looks clunky. While Meson does have =
a huge advantage in terms of predictability and lack of surprises when doin=
g harder things, the imperative syntax is heavier when dealing with the sim=
plest. They do remain simple (it&#39;s still one line of coffee), but the q=
uotes and commas seem to be enough to &quot;switch&quot; our brain to a dif=
ferent mode.</div><div dir=3D"auto"><br></div><div dir=3D"auto">My opinion =
is that you don&#39;t really look at these things very much, so it doesn&#3=
9;t really matter, but I can see people disagreeing.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">(You had already pointed this out during the v=
ery first discussions, if I remember correctly. I can&#39;t add much except=
 that with extra experience the balance does tilt in favor of Meson despite=
 the heavier syntax for simple cases).</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">It&#39;s really<br>
common and I&#39;d hope that a build system language<br>
would provide less long-winded ways to write common<br>
operations...<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000d7645c05ac3c0e47--


