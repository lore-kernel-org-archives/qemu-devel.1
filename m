Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB81C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 21:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC382074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 21:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uieuPuzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC382074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiP3H-0004l0-UD
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 17:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jiP2E-0004FR-3b
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 17:10:22 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229]:34094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jiP2B-0001ZQ-OE
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 17:10:21 -0400
Received: by mail-lj1-x229.google.com with SMTP id x18so5865365lji.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6CiWruclAGEwJVioiw1z4zdem5M2/S2aB5LdxcSpjtg=;
 b=uieuPuzkvSM7B4KwX113KTVJt9X0k/dCuZk0I+GyLSv+Rz/2OggKRIRn60KokP6e4b
 8pY/1vckrKFyyzZFBGX8LWB2ur2iipKZuegA1IG8WYo8RAFSe9qYC1V1KIfJ0PhE9vux
 2PsmR6PkD2cglGpK820pImkoD54ZNXo8Rc4WkDE1CJFGYDj6ZbgunJ01gnkPwXzpkXCo
 7CP8vf0uxJL6GwS30bNP8SbGj0DUWEurqrmKINhpo3QYUlvzC+kVwSutfU371FgUhe3P
 w9RcqL/yu4OVe0/NYbtv2t1JZYoMSKADD3W/Ac8kqO6O3RpG3OTp9ujjxC/2SscFZdcu
 BRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6CiWruclAGEwJVioiw1z4zdem5M2/S2aB5LdxcSpjtg=;
 b=Zm9lMxFIdI6BgC79s10/d3NU0qmJUa6UOm7TdZSyVX/O1yBDrIFPbrwvi2hovEoqn0
 jE1wWFua7JD7+C/X/lpdHxd5AqZbiPghL4LAxkuZFdSVUGhOAdZUIVLBaj//t5paLyqt
 jbbPNTEcsMYpAEuJfO7ajQkmBpwP6mogyptnN6jiumhbGAu1WEkDOrNOXNPAF7ua/o1S
 FVAneQyPDqI2E6ahaRaKH8eV0JVCXl3yAX1lxs/AMwQsgNKYev8XYPteMs/GFKZHGy7e
 wBmJQfdDqM3zQSlPSj8GR1rBMNP89bj2lRBd/b8SYpufz8couNJVQ+3ORRdRwYajgB0X
 0m0w==
X-Gm-Message-State: AOAM532MaiRKWCYjsSV81uV1vOQ7jvqFmitXG2gkXvjXQ2woa+/lS3sY
 Ug1yGvY9ln2q3vvkmvTvyR4Gk3Jfr9oKDScYcEQCQg==
X-Google-Smtp-Source: ABdhPJze5JA97XvUqGC65ZbSIUQv8td9J5N8YXPaqQmrQJQumLgOZy/6tc4JhquSKu3bBltSkCdeTbmBfzgfBMgYw/c=
X-Received: by 2002:a2e:974e:: with SMTP id f14mr11627408ljj.102.1591650614802; 
 Mon, 08 Jun 2020 14:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200605173422.1490-1-robert.foley@linaro.org>
 <20200605173422.1490-7-robert.foley@linaro.org> <87zh9d62ib.fsf@linaro.org>
In-Reply-To: <87zh9d62ib.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 8 Jun 2020 17:10:15 -0400
Message-ID: <CAEyhzFtWjAC7ecO8jhEzutGtx6S-DV0trZez4phfHc+x=ToOjg@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] tcg: call qemu_spin_destroy for tb->jmp_lock
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x229.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Puhov <peter.puhov@linaro.org>, "Emilio G. Cota" <cota@braap.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jun 2020 at 10:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
<snip>
> > +static void tcg_region_tree_reset_all(tb_destroy_func tb_destroy)
> >  {
> >      size_t i;
> >
> > @@ -510,6 +519,10 @@ static void tcg_region_tree_reset_all(void)
> >      for (i =3D 0; i < region.n; i++) {
> >          struct tcg_region_tree *rt =3D region_trees + i * tree_size;
> >
> > +        if (tb_destroy !=3D NULL) {
> > +            g_tree_foreach(rt->tree, tcg_region_tree_traverse, tb_dest=
roy);
> > +        }
> > +
>
> Isn't tb_destroy always set? We could assert that is the case rather
> than make the cleaning up conditional.

I agree, tb_destroy seems to always be set, so the assert would be reasonab=
le.

>
> >          /* Increment the refcount first so that destroy acts as a rese=
t */
> >          g_tree_ref(rt->tree);
> >          g_tree_destroy(rt->tree);
> > @@ -586,7 +599,7 @@ static inline bool tcg_region_initial_alloc__locked=
(TCGContext *s)
> >  }
> >
> >  /* Call from a safe-work context */
> > -void tcg_region_reset_all(void)
> > +void tcg_region_reset_all(tb_destroy_func tb_destroy)
> >  {
> >      unsigned int n_ctxs =3D atomic_read(&n_tcg_ctxs);
> >      unsigned int i;
> > @@ -603,7 +616,7 @@ void tcg_region_reset_all(void)
> >      }
> >      qemu_mutex_unlock(&region.lock);
> >
> > -    tcg_region_tree_reset_all();
> > +    tcg_region_tree_reset_all(tb_destroy);
>
> Could you name the variables of type tb_destroy_func differently as
> although the variable is only ever tb_destroy the function it gets
> confusing real quick when trying to grep for stuff. Maybe tbd_fn?
>
> That said given the single usage why a function pointer? Would we be
> just as well served by an exposed public function call from the
> appropriate places?

Good point.  Unless we see an imminent need to pass different values,
then it seems
reasonable to just use the public function call and remove the need for
the function pointer.

Thanks & Regards,
-Rob


>
> Richard do you have a view here?
>
> --
> Alex Benn=C3=A9e

