Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF27CC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A328217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMra7s9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A328217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47724 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9df-00082j-Ph
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:48:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP9O2-0000Ul-5K
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP9O0-0006x5-JM
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:32:46 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP9O0-0006wH-EU
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:32:44 -0400
Received: by mail-ot1-x343.google.com with SMTP id 66so6319018otq.0
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=SykRo9qqs1+mrTffhpwy+lr8qZ04FP5p4jBbzV76rAk=;
	b=VMra7s9bL7joupEnunClIHPG/S6DY7vsM+lio5V3agL4h8W5iGQ4svprUeyIeMaFUt
	ufe6mBw555nFAH69jt4urmslniBDkOpHww4ufiXfyQOxnXGFZYbH8h+KV6rd8h17+r1C
	S4YTQT1LYNH7vfe119z1pMp4DLx8lN+uWZ0jALsSX0DcRNPNwiechmb7Is7G0qNABcEm
	RxPy4xjAzGcfZTwTT/T/ThIxZ7MHgZkxyebjhHNDH3qHIsXHQ2HjsC5XjWfXuDVDzmuA
	0XKiR2Z+Xl5HvCIFKHvmaOAwriCdfalMldtVmHGCopeeK1cUTZVhKx7v14iFd/Wd8KPf
	kvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=SykRo9qqs1+mrTffhpwy+lr8qZ04FP5p4jBbzV76rAk=;
	b=gm9eF8WW+4SlFNM6MsZFTzDKBtA0meaKX2XHLZvPtMdXgEVWmfy0i0sBQ9yiZVP4Vl
	cEeS28mCaTUtlt3gjb8vIcE2TfklPchgcHiU5vf0JRgGaaVEyJMojMsqRtMF+kYr35IL
	+NCrFD4CueKhGODOwIQTtYSL7dGM0JbwaT+nWOGdjZrjktKuIrTLs8z5p88bcrufK57y
	V2QGVE8KiliA8wCyiq7gvXI8ADp7GnEwgcGYLKIslzD4uXclbutYMuXbxNYNhzJVcwyR
	IYct2OWBzAlsr3El/DjMRd+Qhy75WyFZx08qp86tzCTbJ9ZDz+96Omf28Rg38JmyKQI+
	MRRg==
X-Gm-Message-State: APjAAAWHi7da6ijS3TjjqiGUFWcO5PJSuu/nwUnK8KqnPaAp5tnwBZoG
	Kdhr8Ahr9L9oVx/ylYGFK2uLPwFtOy/2t1D/Y6/uZw==
X-Google-Smtp-Source: APXvYqx+tIf3Xny4SCWi+obxdw4DoHRGa7McDCpJ8Th3YUtdhAL530+D8vblQth9bvnLbxd78jAPXvfEm0MXSdMvbP4=
X-Received: by 2002:a9d:4793:: with SMTP id b19mr3207595otf.238.1557509563504; 
	Fri, 10 May 2019 10:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190510163536.4242-1-mark.cave-ayland@ilande.co.uk>
	<CAFEAcA8tHGciDGyDwCZ02S5km8XNf32PfgSbtbRzqLxcT9JWhA@mail.gmail.com>
	<4232e4b8-45fb-8fd8-3740-d6955dbf1e19@ilande.co.uk>
In-Reply-To: <4232e4b8-45fb-8fd8-3740-d6955dbf1e19@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 18:32:32 +0100
Message-ID: <CAFEAcA99bfhu7fWDyOzcRa1bqXVRNHp-xCKSdB2yNOrAQFz3+Q@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] configure: copy MacOS NDRV driver into
 sharedir for out-of-tree builds
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 18:18, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 10/05/2019 17:49, Peter Maydell wrote:
> > The comment above this bit of code says:
> >
> > # Caution: do not add files or directories here using wildcards. This
> > # will result in problems later if a new file matching the wildcard is
> > # added to the source tree -- nothing will cause configure to be rerun
> > # so the build tree will be missing the link back to the new file, and
> > # tests might fail.
> >
> > The pc-bios/ directory is awkward legacy which we
> > can't really apply the next part of the comment to
> > ("Prefer to keep the relevant files in their own
> > directory and symlink the directory instead"), but since
> > there is only one *.ndrv file we can at least avoid the
> > wildcard by writing "qemu_vga.ndrv" instead of "*.ndrv".
>
> I did spot that, but figured that it was outdated because no-one else was really
> following it. The reason for adding the explicit wildcard is that the driver build
> produces 2 separate .ndrv files - debug, and non-debug - and so it saves me a bit of
> effort after a rebase and rebuild.

It's followed by everything except for the legacy pc-bios
files that were too painful to clean up.

> Should we say up front as part of the conversion to o-o-t builds that all files must
> be explicitly listed in that section as per the comment? Or should each type of
> driver live in its own subdirectory?

The problem here really is that there are two possible
failure modes:
 (1) we use a wildcard, and then when we add a new file
     the link isn't added, and incremental builds fail
 (2) we don't use a wildcard, and then when we add a new
     file we have to manually list it, and if we forget
     then builds fail (both incremental and not)

The ideal way to avoid this is to have an entire directory
which contains pregenerated bios blobs and nothing else,
so we can just symlink the whole directory into the build
tree. But pc-bios has this awkward mix of files which
are pre-generated (and thus in git in the source tree)
and files which will get built by make (and which must
live only in the build tree).

thanks
-- PMM

