Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1D6C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EF12168B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmsfPGIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EF12168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8cX-0006zJ-T2
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:44:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hU8bn-0006ho-I8
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hU8bm-0003kT-OX
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:43:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hU8bm-0003jI-GS
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:43:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id f8so9710773wrt.1
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=raCyOECgaOQJXiHTsKuSPkgkL9udeBwdxOIqB7DIOk4=;
	b=kmsfPGIiyDUYNGPdZB2HBAiEzMOMMvda58TjU32fkYqgLKf/jn1V3nEB7OhNsKpaBO
	niVC/fIoU7AtywZjXRq/HeGExq9VJEtOHl6JrJ1cCTNllevYizKnKVqoV72r7TELxi8E
	GFpRER/cptCj4X+xEZF80CatAGh4Q4kSB055cUTZBrg12LBPxJF8VyMICBMELZfc4RCe
	S/AF8Zy/IRb/OyV53NEZTHd9+nfUMm4UEqE7EjBW/xVBfZrlrPYlRBvQ3RqybzvabVWp
	JN+qZsbRSWDSSgZUBKRqlzUV3rYiFqtVyFy4dHUc/ydgsXkMbS3l2uAIreX3jw5t0iUC
	aFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=raCyOECgaOQJXiHTsKuSPkgkL9udeBwdxOIqB7DIOk4=;
	b=FzexSPEnNgCFS+0TR1r12/GmsIo4djZFkseoHOBHFh7oV3xRbT5LUlj2aciHmRVMen
	W/ci422Cgn7KiUM4DRGgUytkzLIZvVAO6l4hsZJqCu96QHewyuSrc6HGdh21QX5lHlgh
	7KnBp18cjxPMBdyeYtQBef04C7Jtf2eKabPLB/KZ8f4s6mqVJ78I0Fpw7J/UTTziawLb
	k3kqsWqo+X/pfjwio+t/1QFQu+ZCXcY+TfNgx1JBdUWCwKBBPOHeh610VSwVlariyg9w
	Bij4JJh8TdNGVKXbE4rKbkjqj1Aa+QoyvhoN2WPqe9KF3Hvt8kq5AnARN55xeHWZ60E2
	hg9g==
X-Gm-Message-State: APjAAAXiv6lgrKYzLNL3KOcIfnSK0ZQV/ngsN2HKrM0ta2DD7NdxxieG
	bf291a1t2SCSS9gpqy3+6z0F5WtpllmpZcAWxu8=
X-Google-Smtp-Source: APXvYqw8cUFzHjF92AzzrTwGGbOGvzSW3Qxa2BJ/ERlNIrVk9h7qXBw4i+VX2nhtGyPgI6jyNakO6DMTNFus2rDHovM=
X-Received: by 2002:adf:c149:: with SMTP id w9mr52886546wre.40.1558698213336; 
	Fri, 24 May 2019 04:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190523132035.20559-1-marcandre.lureau@redhat.com>
	<20190523132035.20559-6-marcandre.lureau@redhat.com>
	<20190524102929.4s45fvjt65ia6af2@sirius.home.kraxel.org>
In-Reply-To: <20190524102929.4s45fvjt65ia6af2@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 May 2019 13:43:20 +0200
Message-ID: <CAJ+F1CJNFueLT68wAumiZ_WS3pEVKfC6saZc6t8RbKCyp7fYOw@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v8 5/8] contrib: add vhost-user-gpu
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 24, 2019 at 12:50 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, May 23, 2019 at 03:20:32PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Add a vhost-user gpu backend, based on virtio-gpu/3d device. It is
> > associated with a vhost-user-gpu device.
> >
> > Various TODO and nice to have items:
> > - multi-head support
> > - crash & resume handling
> > - accelerated rendering/display that avoids the waiting round trips
> > - edid support
>
> Fails to build with "configure --disable-opengl".

Oops, some leftovers from previous iterations:

-//#include <xf86drm.h> /* not much to do with xf86 */
-#include <drm_fourcc.h>

thanks

--=20
Marc-Andr=C3=A9 Lureau

