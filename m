Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750C8C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 07:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5DF2076A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 07:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="g3ZAIykF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5DF2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vayavyalabs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwgzC-0001Vi-GM
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 03:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1jwgyc-00015J-Md
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 03:09:42 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1jwgyb-00073Z-5c
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 03:09:42 -0400
Received: by mail-wr1-x42c.google.com with SMTP id f7so13278523wrw.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 00:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vayavyalabs.com; s=vayavyalabs;
 h=mime-version:from:date:message-id:subject:to;
 bh=5eaDodjveWk4QGdLDuaR1WhLLG43e52vro9yF5U6DiY=;
 b=g3ZAIykF/BDlYeHQ6aTWWvDKqxMV6ij+WRVUXaN6lxB1N1/0hZQvKj/KNJoo0aBOf+
 GlQFK/x2M/k9mEfs0Qn1SF+828nEsChQRTuFWUXSrwGDv42AMJUrNTMLJcjrAkryv+MP
 TwSAGO3vKMw0xc8hIM6MBxZAuJvQ9IHWLF5E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=5eaDodjveWk4QGdLDuaR1WhLLG43e52vro9yF5U6DiY=;
 b=cnAN+VZs54z5X+6uoHH0DL2OgJE+4Vf2eyWFcOfTbkPWb8IrJekInZKOeIy0Zwb45G
 GMBKrrwEphrivI849UZC2waIqObRNq+yUtdLtjKjFe+BXjEmN+w1VU7JV1AhWioZnhV5
 uyOMi7OxVYDAUgY4hV8YLtg/BgFptEbWzBaYi+dA6Ldx0S5SPoEGG4JtADHmqN8tILLJ
 It+idpp4xPsVhU+eGGJaFlw3h7woCPKEPK0PexmOUq2SwiEr8+03Vc5Dfm6Fgdgd6UBl
 k8XEdQsGyM2v5b0NZqdexADbFlSQYLrc2rCS6IAFWilm0j5YKRkRGTaDuruz8h3CDgsn
 5gkg==
X-Gm-Message-State: AOAM532y/eGmCNaKdQkBju/a6zUT1mZYEcNTprRpab4NxufoDRxKKfjD
 wDxyr5+CRdNgrQV96+qnw3MnlyKgymqJMaKwJjj44/JEqkyE7g==
X-Google-Smtp-Source: ABdhPJwnualr/breS3v/6Zg+4JKBpyC7iuMOUxxQNvH02+v8uQH8F3YfXrJ5zFTu9+xsWQ+Tc1IZWwrJU7+2kwzPGLU=
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr13332472wrs.384.1595056178751; 
 Sat, 18 Jul 2020 00:09:38 -0700 (PDT)
MIME-Version: 1.0
From: Pratik Parvati <pratikp@vayavyalabs.com>
Date: Sat, 18 Jul 2020 12:39:27 +0530
Message-ID: <CA+aXn+E2r1ZFyd1AZnwyvnxB1VsStkJC8vqkhmqZ4JDE_0LwMg@mail.gmail.com>
Subject: instance_init() and the realize() functions
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ee7a9405aab1f413"
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=pratikp@vayavyalabs.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ee7a9405aab1f413
Content-Type: text/plain; charset="UTF-8"

Hi team,

Could someone please guild me to understand the difference between
*instance_init()* and the* realize()* functions? The *class_init() *function
is straight forward (it is similar to the constructor in C++ OOP); But I
am, finding hard to quote the difference between *instance_init()* and
*realize()*.

What is the code flow when both functions are defined?

Thanks & Regards,
Pratik

--000000000000ee7a9405aab1f413
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi team,<div><br></div><div>Could someone please guild me =
to understand the difference between=C2=A0<b>instance_init()</b> and the<b>=
 realize()</b> functions? The <b>class_init() </b>function is straight=C2=
=A0forward=C2=A0(it is similar to the constructor in C++ OOP); But I am, fi=
nding hard to quote the difference between <b>instance_init()</b>=C2=A0and=
=C2=A0<b>realize()</b>.</div><div><br></div><div>What is the code flow when=
 both functions are defined?</div><div><b><br clear=3D"all"></b><div><div d=
ir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><di=
v dir=3D"ltr">Thanks &amp; Regards,<div>Pratik</div></div></div></div></div=
></div>

--000000000000ee7a9405aab1f413--

