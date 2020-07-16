Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF620C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 19:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96858206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 19:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK/GWY8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96858206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw9wm-0000iE-TW
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 15:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jw9vz-0000FX-JR
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 15:52:51 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:34144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jw9vx-0005MA-OA
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 15:52:47 -0400
Received: by mail-ot1-x32d.google.com with SMTP id e90so5202834ote.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:user-agent:to
 :references:in-reply-to:message-id:subject:date;
 bh=nWxz5MeZS/iGSu+rt3DsZmvftjtW8jSBb4YISirYNAQ=;
 b=gK/GWY8maJcTdJvqEVIVt6x797TaLpcDnkvFmeFlCD1dQex8KQ1ilpP2QHzQlOzMow
 EVKYa891jh3qeXjBTkobi+qJKct1a09GwEQAJYzMVpFuY1nPpo845T39XEUPyIwBqThU
 ckOtL4cIE8WLz1sOctoL0IcR9dAvNmgd5+rZ48/rTvgQwRnMhKYxTK8TNqi6vGhkpc7V
 7maBRrWHeOymD3TkMz1AHD3yq4tbFmayfGIaiLwWMmz7ucCftw0eeMaku8UGBtNAruUQ
 5L2YQHV8V19ldVTXsKobWfLVhLQ8RxA8HUKpctCqBzXJexpAMkovJKueKKIL4YyRv2rz
 lwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:user-agent:to:references:in-reply-to:message-id:subject:date;
 bh=nWxz5MeZS/iGSu+rt3DsZmvftjtW8jSBb4YISirYNAQ=;
 b=TTw2TAEgldJnGJbFlV1Yc+Ppy8+vLvvkyoMsNLApbVo7qNM9ZtW6oycVLkkc0HdFXg
 HoXaLaFwunOUwVUYlT+Dgpy4tuuSRJWZf3htuotrNz+DWgwbQ3pWf3MkbH5lcgllhhTS
 p6qVQSk7fzQlHNaV0XystkowkQvDoqk+m1HtwE9RRNqdaX/3K1q8nh13GJOH5vmhEUWJ
 erqwxDqTe1FUIzxKoxufLFRhNq7mt7IToZSHLeCMOq8c1yX7CkXhtIIfS4Tx8UdeVpch
 nZfs5LAvfmL0HeKtsdIETZx/LZUI/2H40StmYusnhRYrYhE+iQdzzHAjXPbrT0x84AFI
 J0Zw==
X-Gm-Message-State: AOAM532BRtwhNVs8jPaDaZ5OH7AF4FaJfYtvFGc2ioBBBMMrWmrE6ogI
 W6QRxT0NLh9z8ZdwxMQwwdI=
X-Google-Smtp-Source: ABdhPJwwUWUZgwHkjJ8oXZC6wmw6fPSzqx2zfhcQhnydTMLN+dO/s1+gm272vW2vxMA8vfGngyPrtA==
X-Received: by 2002:a05:6830:151:: with SMTP id
 j17mr5797878otp.142.1594929164398; 
 Thu, 16 Jul 2020 12:52:44 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id w74sm1248350oif.57.2020.07.16.12.52.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 16 Jul 2020 12:52:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-reu8gKpBMgEffStTRA+M02OWj75riXqBYXjgtOh5Z_A@mail.gmail.com>
 <159492211230.15440.2651129078319986183@sif>
 <78b8c6b3-1710-da21-68ac-194bd19437b2@redhat.com>
In-Reply-To: <78b8c6b3-1710-da21-68ac-194bd19437b2@redhat.com>
Message-ID: <159492915780.15440.8588802536547059593@sif>
Subject: Re: qemu test-qga failure on mergebuild after VERSION file change:
 dependency issues??
Date: Thu, 16 Jul 2020 14:52:37 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

Quoting Philippe Mathieu-Daud=C3=A9 (2020-07-16 12:59:28)
> On 7/16/20 7:55 PM, Michael Roth wrote:
> > Quoting Peter Maydell (2020-07-16 05:53:17)
> >> The first merge I tried to process after bumping VERSION for rc0
> >> failed on test-qga like this:
> >>
> >> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> >> tests/test-qga -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driv
> >> er.pl --test-name=3D"test-qga"
> >> PASS 1 test-qga /qga/sync-delimited
> >> PASS 2 test-qga /qga/sync
> >> PASS 3 test-qga /qga/ping
> >> **
> >> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-qga.c:303:test_=
qga_info:
> >> assertion failed (version =3D=3D QEMU_VERSION): ("5.0.9
> >> 0" =3D=3D "5.0.50")
> >> ERROR test-qga - Bail out!
> >> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-qga.c:303:test_=
qga_info:
> >> assertion failed (versio
> >> n =3D=3D QEMU_VERSION): ("5.0.90" =3D=3D "5.0.50")
> >> Aborted (core dumped)
> >> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:659:
> >> recipe for target 'check-unit' failed
> >>
> >> Looking at timestamps on files, tests/test-qga.o never got rebuilt,
> >> even though config-host.h has been updated (and so has the new
> >> QEMU_VERSION). Any idea what's gone wrong here?
> >>
> >> Also weird: this build tree has no .d files in it.
> > =

> > I've been trying to reproduce with:
> > =

> > make
> > make check-unit
> > *bump VERSION
> > make check-unit
> > =

> > but test-qga.o gets rebuilt as expected and the test passed.
> > =

> > This is with ubuntu 18.04, x86, with out-of-tree build directory. Are y=
ou aware
> > of any other factors that might be needed to reproduce this?
> =

> The problem is not for qga, it affects all QEMU objects.

But is it intermittent, environment-dependent? I'm trying to understand how=
 to
replicate Peter's result since it seems like it would be straightforward
reproducer.

> =

> > =

> >>
> >> thanks
> >> -- PMM
> > =

>=20

