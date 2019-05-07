Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0DBC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB26520C01
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax2P1sj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB26520C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41129 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtwy-0000Z5-6o
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:51:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hNtvy-00005I-JZ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hNtvx-0002Qi-BS
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:50:38 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:40529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1hNtvx-0002P9-6u
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:50:37 -0400
Received: by mail-qt1-x842.google.com with SMTP id k24so618497qtq.7
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 23:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=F7WpCSujS6jvkyhN1EheFd4VHSQipAqkbsMsJ6z5HWI=;
	b=ax2P1sj1NWoZeii74e37Dz8w/l6TcqN6u+kspVTsyrYs8FfJRd4J6NTyXjb0TV1D39
	2Tj9a74XdA2Wb7RGc7v67GL9UDJ+QxDmhyAYSohuvfyvRjkKY0STngWoPBaAR67/r9sp
	tfLb7UwokUGlGIvf380iteX160M3isOywdsgt7HtSWXjgeIttZNNVX//Wqyzu8zPiXr2
	0jFeiaHrwyeDU/1gmgpLuQfnyoh2/Im7vaddrSDHQTYQphb0BLu/loZZyQvsTotDbkF7
	wmZ/MSAKHjnIB3vZbnQHsowbgFYTkwWvSpuRXx/0UVHBzO7STzQqHAOy439wmRkSMgwj
	I05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=F7WpCSujS6jvkyhN1EheFd4VHSQipAqkbsMsJ6z5HWI=;
	b=hZtPijgsGg3M+7O+FFavnUTUnjwAXJiAax7+mNOmBHuo+2IRjXkEleHJEtCVnZdj8y
	2717C3PgxeJSE+jzQssFZW/W0MvUYefqRBK7sH/Zk3KY4XUNa30K3CWfDd/omTjEAOMY
	gj83Uw68oO4KWk4O4hxUl4JFBH51P09CkiQZXpGMZ0fkiRWJ98ljFpIwioVsXGPQiaMK
	LDAB3+ZqTGwO60o4/rg6rIso7qCXLR/c6JXYSADvcD7U5aK8kEY6EwW7nWoXEjhNwu9A
	2jP4pJtV8pPu2o74LvVQnQOmtQtOMjAmNkYerlx9z60SkwDpUhvTzzMG9TqVZkoEs3YQ
	BZFQ==
X-Gm-Message-State: APjAAAUOhVv+jb7wggHe8Pv+tF+NjLifisFw0rl2Mnzd4MWVGCKMZBH4
	sI1IKry0jElJffXwW7FCt+cdQSwbLdJZpS2UjVM=
X-Google-Smtp-Source: APXvYqwU0Fn0WYsHbQvXOHb6qcRfYzKFI5VKAVpyPUtDsS6Z+1pfzxu2eXYehLiiR28HJR6lF3prnp9w8svVL3w9pLE=
X-Received: by 2002:ac8:4401:: with SMTP id j1mr3152486qtn.271.1557211836504; 
	Mon, 06 May 2019 23:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190507054914.25261-1-marcel.apfelbaum@gmail.com>
	<f7c57c29-0aa1-c68e-44ed-4ea52d3006c4@redhat.com>
In-Reply-To: <f7c57c29-0aa1-c68e-44ed-4ea52d3006c4@redhat.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Tue, 7 May 2019 14:49:55 +0800
Message-ID: <CABSdmrmKYMyMFX-O6y2fAGRow9sHhtSN50knQ_yVwKiNmdyGBw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] ui/console: Precautionary glBindTexture
 and surface->texture validation in surface_gl_update_texture
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

My real name is "HOU Qiming". @Marcel Apfelbaum <marcel.apfelbaum@gmail.com=
>
can you incorporate that in your v2 patch? Thanks!

Qiming

On Tue, May 7, 2019 at 2:25 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> Hi Marcel,
>
> On 5/7/19 7:49 AM, Marcel Apfelbaum wrote:
> > From: HQM <hqm03ster@gmail.com>
> >
> > In a GVT-g setup with dmabuf and GTK GUI, the current 2D texture at
> > surface_gl_update_texture is not necessarily
> > surface->texture. Adding a glBindTexture fixes related crashes and
> > artifacts, and is generally more secure.
> >
> > Signed-off-by: HQM <hqm03ster@gmail.com>
>
> This looks like an acronym, per
>
> https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a=
_Signed-off-by:_line
>
> "Patch emails must include a Signed-off-by: line [...] Please use your
> real name to sign a patch (not an alias or acronym)."
>
> > Tested-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
> > [fixed malformed patch, rebase to master]
> > Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > ---
> >
> > v2:
> >  - fixed malformed patch
> >  - rebased to master
> >
> >  ui/console-gl.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/ui/console-gl.c b/ui/console-gl.c
> > index a56e1cd8eb..c1cb3bd673 100644
> > --- a/ui/console-gl.c
> > +++ b/ui/console-gl.c
> > @@ -92,13 +92,17 @@ void surface_gl_update_texture(QemuGLShader *gls,
> >
> >      assert(gls);
> >
> > -    glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
> > -                  surface_stride(surface) /
> surface_bytes_per_pixel(surface));
> > -    glTexSubImage2D(GL_TEXTURE_2D, 0,
> > -                    x, y, w, h,
> > -                    surface->glformat, surface->gltype,
> > -                    data + surface_stride(surface) * y
> > -                    + surface_bytes_per_pixel(surface) * x);
> > +    if (surface->texture) {
> > +        glBindTexture(GL_TEXTURE_2D, surface->texture);
> > +        glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
> > +                      surface_stride(surface)
> > +                      / surface_bytes_per_pixel(surface));
> > +        glTexSubImage2D(GL_TEXTURE_2D, 0,
> > +                        x, y, w, h,
> > +                        surface->glformat, surface->gltype,
> > +                        data + surface_stride(surface) * y
> > +                        + surface_bytes_per_pixel(surface) * x);
> > +    }
> >  }
> >
> >  void surface_gl_render_texture(QemuGLShader *gls,
> >
>
