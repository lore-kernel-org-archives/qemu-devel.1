Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83055C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7022084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw3PSQfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7022084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtQv-0004LB-Ev
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdtOe-0000Cw-53
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:34:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdtOd-0003gI-7v
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:34:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id n5so2540636wmd.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 03:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=i7oX+0rQF0YRlkRdzMZGbfpi2Pyl70rqPsDiRtn6wXI=;
 b=dw3PSQfevNhzdtlJnCcERf73MCQuBB758Thlf1q1tGu4S3hMQD1EhoXwfrDPR691VR
 XQfq4CB/k5itpX1idzWi2Yb/G84tCxwhlbg1GJkszu0LWFBhM2QFG23XNSf9B9nwAiGv
 UxFFP1HLwG7wzo2c8PQ2ENdLzvT69SPAmojvxMRJxP8Q3jw0kIZE6c4rJnMdG2+fpjZ4
 gPpIb2Aub7ydVOyl1Xk69okutWQVhGPnbKgmCHEg66h7FwXtNMKLaETtTgqJwdlmNAqq
 ZFywf9hztHyb4ErW89VDQK1lgNVv+PCvtotQAaNsLYmi15VFlMeTzqq+i9oxD+mkCg5H
 kCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i7oX+0rQF0YRlkRdzMZGbfpi2Pyl70rqPsDiRtn6wXI=;
 b=tTVwXl5UQWIp8RsfPWc9USSIyLsAthSH6Op4B9xzu5NaM5KJVEvAuCdkQZjbyX86cH
 6V0N1JGapwQLKW3xQbzDKQ9DvT7nXWoGG01O48n2ebPqWFvhQM9AGdYrgW04rPHwTODz
 SYyrowFpvZzaDRlcjtKg2VN0lpR5upBlovkohW2qFRaRO3iRUgkpK1xxN+pRLr20Q5VR
 SXiOHfSzxzlAJTfZGrc+5ChZITYJa8h+ex5W56fK5DyzYTP8zltLHDOiAume5EKq0cJ1
 daKXPGpVcF6mrWIRXJlPnApSAWlUOLZfjPFZfXZO4hwyHw0mchYfgbOJMHAP7GwcU2Cu
 MePg==
X-Gm-Message-State: AOAM533kJwwKJQL17qkiOpPPBMwVJByKvJYq4rFZBortRSc2z/8eBH3+
 vF2P8vTP0VqjjN+TBKe2kq04t9/OjZA=
X-Google-Smtp-Source: ABdhPJzKZtmNQd+4k5qSHFSlFPi+nXBRLhumJgiz4HDAz1bZ3z4EirAUNvlHqKMbr1uwMFGKicFIug==
X-Received: by 2002:a1c:a74a:: with SMTP id q71mr3566974wme.23.1590575689108; 
 Wed, 27 May 2020 03:34:49 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u13sm2404070wrp.53.2020.05.27.03.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 03:34:48 -0700 (PDT)
Date: Wed, 27 May 2020 11:34:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] coroutine: support SafeStack in ucontext backend
Message-ID: <20200527103446.GB29137@stefanha-x1.localdomain>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <20200429194420.21147-2-dbuono@linux.vnet.ibm.com>
 <20200521094402.GA251811@stefanha-x1.localdomain>
 <c4411a43-ea2b-7d8a-60db-6f98239089d7@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <c4411a43-ea2b-7d8a-60db-6f98239089d7@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 11:18:20AM -0400, Daniele Buono wrote:
> On 5/21/2020 5:44 AM, Stefan Hajnoczi wrote:
> > On Wed, Apr 29, 2020 at 03:44:17PM -0400, Daniele Buono wrote:
> > > @@ -160,6 +169,19 @@ Coroutine *qemu_coroutine_new(void)
> > >       /* swapcontext() in, siglongjmp() back out */
> > >       if (!sigsetjmp(old_env, 0)) {
> > >           start_switch_fiber(&fake_stack_save, co->stack, co->stack_s=
ize);
> > > +#ifdef CONFIG_SAFESTACK
> > > +        /*
> > > +         * Before we swap the context, set the new unsafe stack
> > > +         * The unsafe stack grows just like the normal stack, so sta=
rt from
> > > +         * the last usable location of the memory area.
> > > +         * NOTE: we don't have to re-set it afterwards because sigse=
tjmp was
> > > +         * called with the original usp. Since we are not coming bac=
k with a
> > > +         * swapcontext, but with a siglongjmp, when we are back here=
 we
> > > +         * already have usp restored to the valid one for this funct=
ion
> >=20
> > I don't understand this comment. __safestack_unsafe_stack_ptr is a
> > thread-local variable, not a CPU register. How will siglongjmp()
> > automatically restore it?
> >=20
> Correct, setjmp/longjmp have no visibility of the unsafe stack. What I
> meant is that it is not automatically restored by the longjmp itself,
> but by code the compiler adds around the sigsetjmp.
>=20
> Specifically, every sigsetjmp/sigjmp is intercepted by the compiler, the
> current value of __safestack_unsafe_stack_ptr is saved on the normal
> (safe) stack.
> Right after the sigsetjmp call it is then restored.
>=20
> I will change the comment to make it clearer.
>=20
> In practice, this is what happens:
>=20
> Original clang implementation in qemu_coroutine_new:
> ----
> 40130c:  callq  4008d0 <__sigsetjmp@plt>
> 401311:  cmp    $0x0,%eax
> 401314:  jne    40132d <qemu_coroutine_new+0x12d>
> ----
> Clang Implementation with safestack:
> ----
> 4027a7:  mov    %rdx,-0x38(%rbp) <- Save unsafe ptr onto the safe stack
> [...]
> 40289c:  callq  401410 <__sigsetjmp@plt>
> 4028a1:  mov    0x201738(%rip),%rdi        # 603fe0
> <__safestack_unsafe_stack_ptr@@Base+0x603fe0>
> 4028a8:  mov    -0x38(%rbp),%rbx
> 4028ac:  mov    %rbx,%fs:(%rdi) <- Restore the unsafe ptr
> 4028b0:  cmp    $0x0,%eax
> 4028b3:  jne    4028d9 <qemu_coroutine_new+0x179>

Oh, that's interesting. Thanks for explaining and updating the comment.

Stefan

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OQkYACgkQnKSrs4Gr
c8h/pQgAp8avcEM7ugbsD98AKSsyWo+wPUoXMyE7eaWFbvAUidNxmdBe1ZGPky+A
tIIv2+C56S2589NUVq++VwbUZ+9EjwyuS8eM9l54M1y+31qPBN3flSXaU71we4up
xphKsMPCCBqi0ePpjn9vLmaaTYGj6Uvii7gtS6suzLcP4goOWtW8QlqqjlIdTdHg
se1LIPPcSrRa+LT4oCSsBY+RWLfmwaQpvgXFciswc3G+MRetHIoPzKUTCfmMDCJo
7JxEvPKnkahXrWpADFA0Kab6nBe6qSmtY0xHvJujtsdG1GOGboZi4uDar1umowey
pckPnFbiQKwzpvh6meT2kz0CxbyP3g==
=ke6V
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--

