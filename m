Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F41C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED20206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlWAFVrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED20206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GFZ-00018x-Sj
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k6GAA-0007d2-N8
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:33:10 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k6GA8-0001kl-SV
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:33:10 -0400
Received: by mail-ot1-x341.google.com with SMTP id e11so5290270otk.4
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k+V2UckJy9PXzENfBxu2iVo2Z6wtayxcpLDlmOy+wFo=;
 b=FlWAFVrX1HQDfpSpO4KODakN8and3pSs3B7nul4G4842KcM65y6yJByzbZL/Sgr3it
 FnyzOIz/WOxyrQ80raqSix8smSh+F+xz5PIHOCf0b8KG+4xnZaahYg/lqYSpKZcIOukC
 ieCDxEPILZ/1MNa/1JrgMN6/tVOo5l+RTw3Y4uYB/oi60xLnEiZqPqb0G8724dwzdQJa
 YtN+TrfeEqGgUbmK+p5WXVThEGimsQ/kg2f86V2Ks5q+jamANuv1fu0P/aQ9DQ7mXLCi
 XAB3hcUyRaO+98ToyqzHRVwRsC7hXX8uzPYZfp+BfAGwjUSP3OSklP1yy9OjA9IhpvH5
 Pvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k+V2UckJy9PXzENfBxu2iVo2Z6wtayxcpLDlmOy+wFo=;
 b=OBkM0HbbmPZKbzSEfUMALKSuOzD8Di4e89MEM6XUI09iagxjPbnu+uLArU2IwDpUCy
 H3UCNLF0gTdmWgUxRT3M3YBdibCn8+B440qqrgsTilaEY2My1t62Fj2ghnYBzils87Uq
 cxtXzEd7SVuVg9CUouTTgNPsOK0LmfG5jRIVTwUfhG14K3gEB7VDw6J9spBvkko5w7eC
 gI93SxKWnQOlIQyBf7SBU7Ann4DIwFTZ/rPoaAWHLmGp+rqENuw+VCdy3vq4XhybOHNj
 8f0sUiRwydsSshN6M0MSa6U4X9uXge/GKAMCu8BKt79TFrK7X23D0o8fV7TvbMURp2bO
 +k4g==
X-Gm-Message-State: AOAM532JeGqzidydcRmTP60ONuOVPU2O/Ss0SlqYbJXcfiZ7A2lyOMWb
 r4XnHstrPAZYwBEVF7yP7qlIG9uMR+B4/B5MAwA=
X-Google-Smtp-Source: ABdhPJydDiGh1qtU5R39Ia8fSf2jAg685C5U/j9TGYJ7M7jg52ybpJ6+2MLxA2vxagrrnLi1w8NYM4Kun06gP+q7xXc=
X-Received: by 2002:a9d:748e:: with SMTP id t14mr4921662otk.333.1597336387118; 
 Thu, 13 Aug 2020 09:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200603161409.54682-1-liq3ea@163.com>
 <CAKXe6SJ-HNK-ZKYcGCGsiUmYi_MVGrVmSvric2OjK5m2q=TBjg@mail.gmail.com>
 <20200624105644.GG774096@redhat.com>
In-Reply-To: <20200624105644.GG774096@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 14 Aug 2020 00:32:30 +0800
Message-ID: <CAKXe6SJ0+qvRQaKxirq=j9jAaKAdjXZzxVoMTbcQg_W=RcGz8g@mail.gmail.com>
Subject: Re: [PATCH] tests: fix a memory in test_socket_unix_abstract_good
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: zxq_yx_007@163.com, marcandre lureau <marcandre.lureau@redhat.com>,
 Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=
=8824=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:56=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Thu, Jun 18, 2020 at 02:12:58PM +0800, Li Qiang wrote:
> > Ping..
> > Anyone queued this?
>
> Thanks, I've queud this now.

Hi Daniel,
It seems this patch still not in the upstream.

Thanks,
Li Qiang

>
> >
> > Thanks,
> > Li Qiang
> >
> > Li Qiang <liq3ea@163.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=884=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:31=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > After build qemu with '-fsanitize=3Daddress' extra-cflags,
> > > 'make check' show following leak:
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =3D=3D44580=3D=3DERROR: LeakSanitizer: detected memory leaks
> > >
> > > Direct leak of 2500 byte(s) in 1 object(s) allocated from:
> > >     #0 0x7f1b5a8b8d28 in __interceptor_calloc
> > > (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xded28)
> > >     #1 0x7f1b5a514b10 in g_malloc0
> > > (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x51b10)
> > >     #2 0xd79ea4e4c0ad31c3  (<unknown module>)
> > >
> > > SUMMARY: AddressSanitizer: 2500 byte(s) leaked in 1 allocation(s).
> > >
> > > Call 'g_rand_free' in the end of function to avoid this.
> > >
> > > Fixes: 4d3a329af59("tests/util-sockets: add abstract unix socket case=
s")
> > > Signed-off-by: Li Qiang <liq3ea@163.com>
> > > ---
> > >  tests/test-util-sockets.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> > > index 2ca1e99f17..ca6671f9bf 100644
> > > --- a/tests/test-util-sockets.c
> > > +++ b/tests/test-util-sockets.c
> > > @@ -312,6 +312,7 @@ static void test_socket_unix_abstract_good(void)
> > >      g_thread_join(serv);
> > >
> > >      g_free(abstract_sock_name);
> > > +    g_rand_free(r);
> > >  }
> > >  #endif
> > >
> > > --
> > > 2.17.1
> > >
> > >
> > >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

