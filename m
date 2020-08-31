Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1869CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67BE206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67BE206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrR5-0007Me-Il
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDX-0004Eg-IP; Mon, 31 Aug 2020 17:19:55 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]:35394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDV-0001Xx-Ld; Mon, 31 Aug 2020 17:19:55 -0400
Received: by mail-qv1-f48.google.com with SMTP id b13so3181873qvl.2;
 Mon, 31 Aug 2020 14:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zGJ5M0aRFmWCGsr1aaGK/L8xV1bL+0o/NJ2U/Ijf3kg=;
 b=QZIRRqXBpeHy2Uz/+0kbMEBX80baaG/onP1vkzXPviGnQTiham7i1amOdAdH+yOOH/
 tgktdl5U3OgGFZSxzSYqd0AtFb4w/0hE8AHBo4MEpa/vtVOCb5s4hYluPVySDSialLbE
 40xYR/h/9ZYkKyDQypMpyRyYeJshBZY6DXPFSxkz4Ln2qigiym/0J5sqsbo44zMUeXZt
 Zs14gIhbSsa2YBjMZosKf1bU7uJwuphaMB5sKzxX6po/ZkngOixSxWifzINOaVHPpMfu
 97s4lO5dImlH7dJy8Rtlw/szTUt/P+exyC2cHKCTE9RSV07BTmlvvROZsldOiPmlYsD+
 3cIg==
X-Gm-Message-State: AOAM530VaDWCnv1PjDK6lsAUVJ94l1JwEH4o52zyXxs5/dr+5AKt9E4M
 mEEXhjlqe3/nfYp4DhGkWH2p57l6Y5Qi7TV5E7dC0mzA
X-Google-Smtp-Source: ABdhPJyuWICbB7b6xYHn790qp1yI51ON4VF6m2lqwrT8qQwun0PluimMbAff6kNrZ7aCf4WYXXotUkz+Lj6tsqsr+jo=
X-Received: by 2002:a0c:f491:: with SMTP id i17mr3005633qvm.85.1598908792490; 
 Mon, 31 Aug 2020 14:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200827114428.1850912-1-ppandit@redhat.com>
In-Reply-To: <20200827114428.1850912-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 22:27:59 +0200
Message-ID: <CAAdtpL6o7_Cvnui+dsaobNaY93Noj7fcLWYx37mEGd3kTBv56Q@mail.gmail.com>
Subject: Re: [PATCH] hw/ide: check null block pointer before blk_drain
To: P J P <ppandit@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009ad55305ae32f65b"
Received-SPF: pass client-ip=209.85.219.48;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qv1-f48.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:19:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Ruhr-University <bugs-syssec@rub.de>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009ad55305ae32f65b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 27 ao=C3=BBt 2020 13:47, P J P <ppandit@redhat.com> a =C3=A9crit :

> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While cancelling an i/o operation via ide_cancel_dma_sync(),
> check for null block pointer before calling blk_drain(). Avoid
> null pointer dereference.
>
>  ->
> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=3D%2Fide_nullptr=
1
>     =3D=3D1803100=3D=3DHint: address points to the zero page.
>     #0 blk_bs ../block/block-backend.c:714
>     #1 blk_drain ../block/block-backend.c:1715
>     #2 ide_cancel_dma_sync ../hw/ide/core.c:723
>     #3 bmdma_cmd_writeb ../hw/ide/pci.c:298
>     #4 bmdma_write ../hw/ide/piix.c:75
>     #5 memory_region_write_accessor ../softmmu/memory.c:483
>     #6 access_with_adjusted_size ../softmmu/memory.c:544
>     #7 memory_region_dispatch_write ../softmmu/memory.c:1465
>     #8 flatview_write_continue ../exec.c:3176
>     ...
>
> Reported-by: Ruhr-University <bugs-syssec@rub.de>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/ide/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index d997a78e47..038af1cd6b 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -718,7 +718,7 @@ void ide_cancel_dma_sync(IDEState *s)
>       * whole DMA operation will be submitted to disk with a single
>       * aio operation with preadv/pwritev.
>       */
> -    if (s->bus->dma->aiocb) {
> +    if (s->blk && s->bus->dma->aiocb) {
>

But s->blk mustn't be null here... IMHO we should assert() here and add a
check earlier.

Don't we already have a Launchpad bug for this BTW?

         trace_ide_cancel_dma_sync_remaining();
>          blk_drain(s->blk);
>          assert(s->bus->dma->aiocb =3D=3D NULL);
> --
> 2.26.2
>
>
>

--0000000000009ad55305ae32f65b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le jeu. 27 ao=C3=BBt 2020 13:47, P J P &lt;<a href=3D"mail=
to:ppandit@redhat.com">ppandit@redhat.com</a>&gt; a =C3=A9crit=C2=A0:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">From: Prasad J Pandit &lt;<a href=3D"mai=
lto:pjp@fedoraproject.org" target=3D"_blank" rel=3D"noreferrer">pjp@fedorap=
roject.org</a>&gt;<br>
<br>
While cancelling an i/o operation via ide_cancel_dma_sync(),<br>
check for null block pointer before calling blk_drain(). Avoid<br>
null pointer dereference.<br>
<br>
=C2=A0-&gt; <a href=3D"https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?=
path=3D%2Fide_nullptr1" rel=3D"noreferrer noreferrer" target=3D"_blank">htt=
ps://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=3D%2Fide_nullptr1</a>=
<br>
=C2=A0 =C2=A0 =3D=3D1803100=3D=3DHint: address points to the zero page.<br>
=C2=A0 =C2=A0 #0 blk_bs ../block/block-backend.c:714<br>
=C2=A0 =C2=A0 #1 blk_drain ../block/block-backend.c:1715<br>
=C2=A0 =C2=A0 #2 ide_cancel_dma_sync ../hw/ide/core.c:723<br>
=C2=A0 =C2=A0 #3 bmdma_cmd_writeb ../hw/ide/pci.c:298<br>
=C2=A0 =C2=A0 #4 bmdma_write ../hw/ide/piix.c:75<br>
=C2=A0 =C2=A0 #5 memory_region_write_accessor ../softmmu/memory.c:483<br>
=C2=A0 =C2=A0 #6 access_with_adjusted_size ../softmmu/memory.c:544<br>
=C2=A0 =C2=A0 #7 memory_region_dispatch_write ../softmmu/memory.c:1465<br>
=C2=A0 =C2=A0 #8 flatview_write_continue ../exec.c:3176<br>
=C2=A0 =C2=A0 ...<br>
<br>
Reported-by: Ruhr-University &lt;<a href=3D"mailto:bugs-syssec@rub.de" targ=
et=3D"_blank" rel=3D"noreferrer">bugs-syssec@rub.de</a>&gt;<br>
Signed-off-by: Prasad J Pandit &lt;<a href=3D"mailto:pjp@fedoraproject.org"=
 target=3D"_blank" rel=3D"noreferrer">pjp@fedoraproject.org</a>&gt;<br>
---<br>
=C2=A0hw/ide/core.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/ide/core.c b/hw/ide/core.c<br>
index d997a78e47..038af1cd6b 100644<br>
--- a/hw/ide/core.c<br>
+++ b/hw/ide/core.c<br>
@@ -718,7 +718,7 @@ void ide_cancel_dma_sync(IDEState *s)<br>
=C2=A0 =C2=A0 =C2=A0 * whole DMA operation will be submitted to disk with a=
 single<br>
=C2=A0 =C2=A0 =C2=A0 * aio operation with preadv/pwritev.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 if (s-&gt;bus-&gt;dma-&gt;aiocb) {<br>
+=C2=A0 =C2=A0 if (s-&gt;blk &amp;&amp; s-&gt;bus-&gt;dma-&gt;aiocb) {<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">But s=
-&gt;blk mustn&#39;t be null here... IMHO we should assert() here and add a=
 check earlier.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Don&#39;=
t we already have a Launchpad bug for this BTW?</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_ide_cancel_dma_sync_remaining();<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blk_drain(s-&gt;blk);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(s-&gt;bus-&gt;dma-&gt;aiocb =3D=3D=
 NULL);<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000009ad55305ae32f65b--

