Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57236C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C6120661
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="z20FouPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C6120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWF78-0003fz-8b
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jWF6a-0003H7-4x
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:08:36 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:41687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jWF6Z-00082z-4W
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:08:35 -0400
Received: by mail-yb1-xb41.google.com with SMTP id w137so537143ybg.8
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 01:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QBoQcq26X5IlJyCrqUS2mhYO9rMfyiRH6PeZR70LsXw=;
 b=z20FouPus7rbY9GunnMpYnCtpqAbBIp5v+CES7BDKy3LW/MNdElAeoUUaMcNu/wlSJ
 JvUIPNgldzeZaeFMdg2Ij/83dkzf1HuHID9CPTtymz1i1BvXfeEiou6cFpaLzXAmmJjT
 rilBvTWb/p2MDqwDsDcoC36melEJ/Sgd3dqhcUrOLKyx6p00As8uh3GJJdexJZZ4Pv77
 i1IrwhDD0+/Odh45oncSCZgkreYpS1kgJZiV5tg8qhsrPsap0LAbto+ACvc3Hvongufh
 KkevwvZoG8Q8HRL+VrbOmTL/Se0AkcPx1znqTO61KoCdpKAJzIVwwphfKgmLpNX+/uKs
 t7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QBoQcq26X5IlJyCrqUS2mhYO9rMfyiRH6PeZR70LsXw=;
 b=Tsivi4UYdHjRNeEkzjG6lfFhOVk3bwM5H5QKRIAeM9rlMff+tDrrISZBh9CmuHv2XO
 mLf1Nw3pvy6gFL6RZQ7GXBSzhNAvfTRr4TjcUZlWTv+gdkmId9ZDZF8WlaBi2gK9UIU3
 r3RZqIKikjVj6x5FGodBdvoDoDsfBa+oa0VT+RHPEGeffRKZ/XkwIwnmYXivDsPrpw6Y
 NjtVhZfoKG3by0gBnR119mOoIedihjmP0cofKhKxHXp5PuggmFqIwWe6O3laZVE26fpr
 MuXj6x7+QRbnj3h/zD8LsU1EvpkzgiKIFooK/mXWH8nnMflJNK/TNcaqG9jJoLlvZ4Di
 bHgA==
X-Gm-Message-State: AGi0PuaEoRpxK74HwhlsJ/DWwEGkrtCPAuAKt+1NCAdJWAXIoTeBKOSP
 sn8mOAuIcLFlC7H3ptGFkOksqnZ7vy0Wg2UjSfh1Rg==
X-Google-Smtp-Source: APiQypIivjATMIzVr7ZnWP/R+NYHijYmeWgRdqqiQX2R+GXJCLSpnJHFZVijJEoGw2AYkZk4S8/OxLly0CdnTaS+Fro=
X-Received: by 2002:a5b:49:: with SMTP id e9mr12345725ybp.447.1588752513605;
 Wed, 06 May 2020 01:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200329150953.23812-1-yuri.benditovich@daynix.com>
 <20200331102004-mutt-send-email-mst@kernel.org>
 <CAOEp5OeOcTZM_b254LxX5=jRiiAkGSoLsbMeiMjPs2OoF1MxNA@mail.gmail.com>
 <90f00200-da2d-a8d6-a734-fc08e2e5313a@redhat.com>
In-Reply-To: <90f00200-da2d-a8d6-a734-fc08e2e5313a@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 6 May 2020 11:08:24 +0300
Message-ID: <CAOEp5OfuP7c+aOBhQP71BLRF=Wxg+w1BPFSm8=e8dfQOnLCK5Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] reference implementation of RSS and hash report
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000035b37d05a4f645eb"
Received-SPF: none client-ip=2607:f8b0:4864:20::b41;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000035b37d05a4f645eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll send v8 soon

Thanks,
Yuri

On Wed, May 6, 2020 at 8:37 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/5/1 =E4=B8=8B=E5=8D=8812:01, Yuri Benditovich wrote:
> > Michael/Jason,
> >
> > As Linux headers was updated in qemu and now include RSC/RSS/Hash
> > definitions, please let me know what you prefer:
> > 1. You apply this series as is, then I submit clean-up series that
> > will remove all the redundant defines from virtio-net.c
> > 2. I post v8 of this series with cleanup of all the redundant defines
> > and also RSC ones
> > 3. Something other
>
>
> Hi Yuri:
>
> Though I've queued this series but consider we have new headers, I think
> it's better to post v8.
>
> Thanks
>
>

--00000000000035b37d05a4f645eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ll send v8 soon<div><br></div><div>Thanks,</div><div=
>Yuri</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Wed, May 6, 2020 at 8:37 AM Jason Wang &lt;<a href=3D"mailto:=
jasowang@redhat.com">jasowang@redhat.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><br>
On 2020/5/1 =E4=B8=8B=E5=8D=8812:01, Yuri Benditovich wrote:<br>
&gt; Michael/Jason,<br>
&gt;<br>
&gt; As Linux headers was updated in qemu and now include RSC/RSS/Hash <br>
&gt; definitions, please let me know what you prefer:<br>
&gt; 1. You apply this series as is, then I submit clean-up series that <br=
>
&gt; will remove all the redundant defines from virtio-net.c<br>
&gt; 2. I post v8 of this series with cleanup of all the redundant defines =
<br>
&gt; and also RSC ones<br>
&gt; 3. Something other<br>
<br>
<br>
Hi Yuri:<br>
<br>
Though I&#39;ve queued this series but consider we have new headers, I thin=
k <br>
it&#39;s better to post v8.<br>
<br>
Thanks<br>
<br>
</blockquote></div>

--00000000000035b37d05a4f645eb--

