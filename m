Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A87C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC5F20B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkmWO+LC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC5F20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41803 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNv2I-0001sO-Ii
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:01:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hNv1L-0001BP-Ts
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hNv1K-00020U-N7
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:00:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hNv1K-0001zZ-Dj
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:00:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id l2so20903271wrb.9
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 01:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=XDEzS1u45GgLC+1eXTh9PLk05NQCC8cTXqKPVG4zr44=;
	b=NkmWO+LC8DGe6iM+W8qn19NDmHu9cFX8BnBAHxa7xb2j31z8kxDet16p2vD2kTjNqT
	2xgkLPV86QnuLQ0GDHsA1C+hOdzGlWxcb8ct3Qlt8b9mVoZyMLzV4J+dMMefQb38DpNj
	YPUd3EvV4ReWhL08vv1a8gqBcT+VAyrIekkhTnsbGNJaha8dk5dfvQ7SPYRV26GjOdOF
	uYYtCaZEkWNi5Pol4Wwyz9UwhYyE4BxhkZ3WBXfN4XZfx1p43H/+kScMg+hKrazO6Vy1
	wP8Zu5P2neOsoBbjiffnP0zyTyaykgP/VSrOrnkWBr57Hv6K7/A39M4wBVv3yIs0SBcq
	cQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=XDEzS1u45GgLC+1eXTh9PLk05NQCC8cTXqKPVG4zr44=;
	b=ImM3AabNaLerKSd5dVCVCgitzumxFvwVMkjJ4J7l5C/SnhUfM6S6jf1mkSN2gMJrwR
	CQdh+YncJ86vTsGIOveuaA6coCsnwOY9U7vrfj4EMbc6LFfE0sa7TIkGUl5arY6HSsEV
	P9fMJh4Vj4vR/AiUYS1AIeRLPGXTyywECs3DJ/4C4uYN0orcAV/MnpC8e2d5TMgmLIK6
	FIILmYJ99rb+VAWTMxawNdAFJ1kAGGKBgp5Lhzo7dJTlgUPzpZxOn+ymf85a7ugg8Bcr
	kYRAqUNmucfRX/FOtwuLDKIkiQJAwdEyCzaNr3Y7JqsR30yYEB5IVp4nf6g5Fk4fAn9V
	AHPQ==
X-Gm-Message-State: APjAAAVCGeQzns6bTwc1hFxmMCTfo/f7KlRgWqZYhZPWshAFgXHRRMe7
	K2QdP5sK31McUE6J3vF4P6s=
X-Google-Smtp-Source: APXvYqyZQvdvAOnnxyQiE1ele+mgyyz4SsPglqStcy3pmdVz522db4bVwt5mFACC5It2qPpKaCQV3Q==
X-Received: by 2002:a5d:43cd:: with SMTP id v13mr23439704wrr.227.1557216013234;
	Tue, 07 May 2019 01:00:13 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id
	c10sm28102362wrd.69.2019.05.07.01.00.10
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 01:00:12 -0700 (PDT)
To: Hou Qiming <hqm03ster@gmail.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190507054914.25261-1-marcel.apfelbaum@gmail.com>
	<f7c57c29-0aa1-c68e-44ed-4ea52d3006c4@redhat.com>
	<CABSdmrmKYMyMFX-O6y2fAGRow9sHhtSN50knQ_yVwKiNmdyGBw@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <8a504fa1-0a71-b826-a872-ccc58822a735@gmail.com>
Date: Tue, 7 May 2019 11:00:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CABSdmrmKYMyMFX-O6y2fAGRow9sHhtSN50knQ_yVwKiNmdyGBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
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



On 5/7/19 9:49 AM, Hou Qiming wrote:
> My real name is "HOU Qiming". @Marcel Apfelbaum 
> <mailto:marcel.apfelbaum@gmail.com> can you incorporate that in your 
> v2 patch? Thanks!
>

Sure thing,

Thanks,
Marcel

> Qiming
>
> On Tue, May 7, 2019 at 2:25 PM Philippe Mathieu-Daudé 
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>
>     Hi Marcel,
>
>     On 5/7/19 7:49 AM, Marcel Apfelbaum wrote:
>     > From: HQM <hqm03ster@gmail.com <mailto:hqm03ster@gmail.com>>
>     >
>     > In a GVT-g setup with dmabuf and GTK GUI, the current 2D texture at
>     > surface_gl_update_texture is not necessarily
>     > surface->texture. Adding a glBindTexture fixes related crashes and
>     > artifacts, and is generally more secure.
>     >
>     > Signed-off-by: HQM <hqm03ster@gmail.com
>     <mailto:hqm03ster@gmail.com>>
>
>     This looks like an acronym, per
>     https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line
>
>     "Patch emails must include a Signed-off-by: line [...] Please use your
>     real name to sign a patch (not an alias or acronym)."
>
>     > Tested-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com
>     <mailto:marcel.apfelbaum@gmail.com>>
>     > [fixed malformed patch, rebase to master]
>     > Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com
>     <mailto:marcel.apfelbaum@gmail.com>>
>     > ---
>     >
>     > v2:
>     >  - fixed malformed patch
>     >  - rebased to master
>     >
>     >  ui/console-gl.c | 18 +++++++++++-------
>     >  1 file changed, 11 insertions(+), 7 deletions(-)
>     >
>     > diff --git a/ui/console-gl.c b/ui/console-gl.c
>     > index a56e1cd8eb..c1cb3bd673 100644
>     > --- a/ui/console-gl.c
>     > +++ b/ui/console-gl.c
>     > @@ -92,13 +92,17 @@ void surface_gl_update_texture(QemuGLShader
>     *gls,
>     >
>     >      assert(gls);
>     >
>     > -    glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
>     > -                  surface_stride(surface) /
>     surface_bytes_per_pixel(surface));
>     > -    glTexSubImage2D(GL_TEXTURE_2D, 0,
>     > -                    x, y, w, h,
>     > -                    surface->glformat, surface->gltype,
>     > -                    data + surface_stride(surface) * y
>     > -                    + surface_bytes_per_pixel(surface) * x);
>     > +    if (surface->texture) {
>     > +        glBindTexture(GL_TEXTURE_2D, surface->texture);
>     > +        glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
>     > +                      surface_stride(surface)
>     > +                      / surface_bytes_per_pixel(surface));
>     > +        glTexSubImage2D(GL_TEXTURE_2D, 0,
>     > +                        x, y, w, h,
>     > +                        surface->glformat, surface->gltype,
>     > +                        data + surface_stride(surface) * y
>     > +                        + surface_bytes_per_pixel(surface) * x);
>     > +    }
>     >  }
>     >
>     >  void surface_gl_render_texture(QemuGLShader *gls,
>     >
>


