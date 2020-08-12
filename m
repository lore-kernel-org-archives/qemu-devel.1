Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9643C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F1F2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLEDyd+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F1F2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5twH-00032L-LT
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 12:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1k5tvY-0002c6-G4
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:48:36 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:40594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1k5tvV-0004qT-CC
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:48:36 -0400
Received: by mail-ot1-x335.google.com with SMTP id h16so2464622oti.7
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bYqV05IN6FYP3YEVvIYax3XmayJQLqKvuUgZ3/4a2Is=;
 b=nLEDyd+z/IuFR9GNMZI2dsDzttRyYzWYWL6LzS1P6frjcWPgOL+cAf0pYAtm/zsaLi
 YAa9+VJcVa9MASbVH5VAHkkCoJVJqgUENapcl+PTZsf2rqX562QOjqJVDAhRXykialNH
 jnhEzpU2woHXhFKq9NLMTbqvL5cDfnqaRH+uylAgdS2jorKr/DdrXFm7O9VYarzPnJCU
 srDTlQxXssdeflp/b//HvYbK3mQeBoOLiTeFV8EmCiTzj7qrxEzrj6hsNWcUwn7Mhdcq
 2JwkX8mjZe0HfCQwBXatO9TRZe7OXFRdLiQi0aJCP5h2TtrhUI4rDR6v39QEOGv/y2pX
 mhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bYqV05IN6FYP3YEVvIYax3XmayJQLqKvuUgZ3/4a2Is=;
 b=Ju0c0fkkR9gAXNL9q+m4w8kBj+3LBsiugtxZ2HWBUdATh7slm+DsRPd8eSTQY85+Vy
 MkBOLET/5tSWUCx6R9cQXk7s1bitKYc4tIKDkCAikGYW1CJftVFGieOP4wiX1TwZYnr+
 OLKO2fn8vAKFkTyMytP7G5n/XGecAwXVH3gU4zT5piQf8GU13dR46IQVi3W3gFtO0iTd
 8UKYoWme0AQuvdISUnyk0hHdD2G0IJX8Ok1wR9bRYZiU+y2iKkzIa6jeRuDKr50+f6tT
 nRMHiJpgLRWRVI4h3ZTSJpVhen69bmLfCvVvRElt8wWeOcfeR8Yf9tgSU6OZrzxZC14W
 f8AQ==
X-Gm-Message-State: AOAM530b7MOnWe50A7GWl7XaW9R5N/IOtLFrr4ftLgZBHK5elHGy11yB
 bVMUvpuGqHnph4uIp3NoJMm1TYIOvJDfI2KTgR4=
X-Google-Smtp-Source: ABdhPJzhHY5UKRKM/hZ/77f2eOBC7CIFUBOrcRhjRUh0TLaCWYXhKDjYKfLaDMQAvnRXf6tknJXLjv3ETV+QyGG8tqI=
X-Received: by 2002:a9d:d84:: with SMTP id 4mr488433ots.173.1597250912181;
 Wed, 12 Aug 2020 09:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <20200811154241.4vzuxvhbwt7ztfvh@steredhat>
 <CABLmASH9rXQjnYYbADtaq5f4c0uqr+kv10p=hC7GR9wF-EzPUw@mail.gmail.com>
 <2548b5fb-97cd-2d7d-8a7e-33b93f3003cb@amsat.org>
In-Reply-To: <2548b5fb-97cd-2d7d-8a7e-33b93f3003cb@amsat.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Wed, 12 Aug 2020 18:48:20 +0200
Message-ID: <CABLmASG=f0540ZchBkzQneMXVrD1QJ=6C6ZiTN9t7Tkga5cpPg@mail.gmail.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000003ce38105acb0f50f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ot1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003ce38105acb0f50f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2020 at 3:24 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Hi Howard,
>
> On 8/12/20 8:32 AM, Howard Spoelstra wrote:
> > Hi,
> >
> > I just compiled qemu-system-ppc using the the meson-poc-next branch wit=
h:
> > git clone -b meson-poc-next http://www.github.com/bonzini/qemu
> > qemu-mesonbuild-next
>
> I notice you refer to github while Paolo mentioned gitlab in the
> cover:
>
> "This is available from https://gitlab.com/bonzini/qemu.git branch"
>
> I am not sure he maintains both sync, can you retest using the gitlab
> branch?
>
> Hi Philippe,

I have the same issue when building from the gitlab repo just minutes ago:
qemu-system-ppc-meson-gitlab: Display 'sdl' is not available.
qemu-system-ppc-meson-gitlab: Display 'gtk' is not available.

Best,
Howard

--0000000000003ce38105acb0f50f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 12, 2020 at 3:24 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Hi Howard,<br>
<br>
On 8/12/20 8:32 AM, Howard Spoelstra wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I just compiled qemu-system-ppc using the the meson-poc-next branch wi=
th:<br>
&gt; git clone -b meson-poc-next <a href=3D"http://www.github.com/bonzini/q=
emu" rel=3D"noreferrer" target=3D"_blank">http://www.github.com/bonzini/qem=
u</a><br>
&gt; qemu-mesonbuild-next<br>
<br>
I notice you refer to github while Paolo mentioned gitlab in the<br>
cover:<br>
<br>
&quot;This is available from <a href=3D"https://gitlab.com/bonzini/qemu.git=
" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/bonzini/qemu.git<=
/a> branch&quot;<br>
<br>
I am not sure he maintains both sync, can you retest using the gitlab<br>
branch?<br>
<br></blockquote><div>Hi Philippe,</div><div><br></div><div>I have the same=
 issue when building from the gitlab repo just minutes ago:</div>qemu-syste=
m-ppc-meson-gitlab: Display &#39;sdl&#39; is not available.</div><div class=
=3D"gmail_quote"><div class=3D"gmail_quote">qemu-system-ppc-meson-gitlab: D=
isplay &#39;gtk&#39; is not available.</div><div><br></div><div>Best,</div>=
<div>Howard<br></div><div><br></div></div></div>

--0000000000003ce38105acb0f50f--

