Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4E5C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24C420897
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mE/fqbCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24C420897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0Hc-0005Cm-TU
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO0Fx-00039Z-CL
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:12:29 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:42920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO0Fu-0007Oh-SI
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:12:29 -0400
Received: by mail-ej1-x636.google.com with SMTP id q13so8588427ejo.9
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ufkl596PRR/6f6zA/XRuoULkdebSj0NrQU1kYj2pEbg=;
 b=mE/fqbCr1cdOZZ9oCXoPuft5c0iWmSnS7pcvDfzrdYkAcixX56Gl6bP06XQ0RFP6/4
 keuMxYT5MpvxGJs9fhEPd6vtDSwWgIFdPk13RkLnlQJr9dsMjsj0un1t82O/NteTZOSc
 eSz0G0JxKlRAymBoz76hSQwvqYBYWD1jBx1QX+88/mMpdQKSi2uQShZm697adsvjuadq
 LGcO7FgD80r8+D/ayJ69VLy74lp47FloScKNmHCCdsqZNQSiGCEqOCy7Zf4E0LEpcfcm
 ULg8v3Zg9Bnn478eeNXcL9QYqKAo6h7hS6MdttTS2EiIdZ/PGHeMTzUFYnSi+pFnrw8T
 //Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ufkl596PRR/6f6zA/XRuoULkdebSj0NrQU1kYj2pEbg=;
 b=pGNvHzkqSFdCFo0WjgBrJHm/L/L0Uxo3Scth8RxgLXRVv2n5TLSiADNzBTxslSwZub
 ePJqhdG+n2WgWnNXf2MqtvlsoBpRffFnmms4M0gEdor8WD725u1XMSLn1ehvZhL8o3UT
 kogf1IQJpF2SUdEd5ScYIPUpfNpzD8rNBUtw+o/rb+vlqcUevQbwymOureFfP+X/mTu0
 vcIhTFDlxnQahTRPu91tF04i/hQwdvtmt0R+HxpxNjOLt8ZDOAblz3Sa3X8v7GFQEfCQ
 qQlveIUBiw87DAkr/+LcO4x5vCMsNMCqLSQuk2VKNfxQFNJKSm9QpU68LDuzzbchMm7K
 lh6A==
X-Gm-Message-State: AOAM531xmCMrj6yS3mYe4oQQ8TqOkiAiCiMTWYKB2QB51DjCdAa9n7n8
 LuLY6OGAF/rVBmZ0VNSGnKywMXhHdJTwkPcZVSuMxA==
X-Google-Smtp-Source: ABdhPJyE3kID8BEnbuvFOX5MhmFuDbHIyIFf9OwQieeU41ZeN6k+cU1/vgNanwNpWmnmClhP6BtLD0Kq5WDgFWV7w80=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr4533419ejb.482.1601565143587; 
 Thu, 01 Oct 2020 08:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200930101305.305302-1-stefanha@redhat.com>
 <CAFEAcA87+50vkXLkLwVtrtNn4No4Fvsjd+LDEEu2cmhJcQdZ=A@mail.gmail.com>
 <20201001150248.GB559957@stefanha-x1.localdomain>
In-Reply-To: <20201001150248.GB559957@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 16:12:12 +0100
Message-ID: <CAFEAcA9JdhSSJesCLB=F+GMc-wK4+ukHQwA18wdU7HaqoPiTfg@mail.gmail.com>
Subject: Re: [PULL 00/17] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 16:03, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Oct 01, 2020 at 12:23:00PM +0100, Peter Maydell wrote:
> > This produces this error message on ppc64be Linux:
> >
> > make: Entering directory `/home/pm215/qemu/build/all'
> > make[1]: Entering directory `/home/pm215/qemu/slirp'
> > make[1]: Nothing to be done for `all'.
> > make[1]: Leaving directory `/home/pm215/qemu/slirp'
> > Generating qemu-version.h with a meson_exe.py custom command
> > Generating qemu-options.def with a meson_exe.py custom command
> > Generating block-gen.c with a custom command
> > YAML:1:83: error: unknown enumerated scalar
> > {"IndentWidth": 4, "BraceWrapping": {"AfterFunction": true},
> > "BreakBeforeBraces": "Custom", "SortIncludes": false,
> > "MaxEmptyLinesToKeep": 2}
> >
> >            ^~~~~~~~
> > Error parsing -style: Invalid argument, using LLVM style
> > YAML:1:83: error: unknown enumerated scalar
> > {"IndentWidth": 4, "BraceWrapping": {"AfterFunction": true},
> > "BreakBeforeBraces": "Custom", "SortIncludes": false,
> > "MaxEmptyLinesToKeep": 2}
> >
> >            ^~~~~~~~
> > Error parsing -style: Invalid argument, using LLVM style
> > Compiling C object libqemuutil.a.p/util_qemu-error.c.o
> > Compiling C object libqemuutil.a.p/util_qemu-sockets.c.o
> > Compiling C object libqemuutil.a.p/util_aio-posix.c.o
> > Compiling C object libqemuutil.a.p/util_osdep.c.o
> >
> > The error does not cause the build to fail, which seems
> > like it's also a bug...
> >
> > (My guess is this is due to some script implicitly wanting
> > a newer version of something or other than the PPC box
> > happens to have installed, rather than being an endianness
> > issue.)
>
> Please rerun with make -j1 V=1 so the full command is printed. I'm not
> sure what is emitting these errors.

Build tree already overwritten to handle a different pullreq,
I'm afraid. I can come back and retry later...

thanks
-- PMM

