Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D3EC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 07:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691DC20989
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 07:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691DC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41585 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNumq-0004A3-8Q
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 03:45:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNuly-0003ps-LU
	for qemu-devel@nongnu.org; Tue, 07 May 2019 03:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNulx-0004y2-CW
	for qemu-devel@nongnu.org; Tue, 07 May 2019 03:44:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNulx-0004wu-6M
	for qemu-devel@nongnu.org; Tue, 07 May 2019 03:44:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so20833904wrb.9
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 00:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ZOBaeZ/j3KhD5od9lLwNv8kxQQPgWwQty3aEqsGsUjA=;
	b=OCXvWDoDEt6EeeacDc8zfcjIxOUE78sxnegEx7y+kKhOiM7m7CZ6iJ9nS1A7RFvIy/
	wY0SwO4b1VW+zi0n33hMu+yrLPZ3q7KQz74rmUR1XEHd15DrM486a9WvESvFoOp3AwXH
	us5mTdCQdkOZQuQae+q32ZZfoK9WShc5Y+LO4f74MtVh6DW20wIXZl6YmomPvJ2yDTpr
	P/RtYPCQR/uoHSWdpAr+qjD4zUSTfx3j4GWPb5kEM6ytixN3GIFMyFp6y/GxIv07nrOR
	PUZsIlvKI5v9oO1GZ5CNJOCj/wZludFfrDtaAYdeonjEPzf5EtDh0wAI79N80ehaH0bx
	oK4Q==
X-Gm-Message-State: APjAAAUqgdLaZKK6FAoG4aM79zOeB2+94ccUsIDhZ4MkMQBuDWy9M9xv
	LrpKL0Ph7x2oHOqzLQ+dL9KrsA==
X-Google-Smtp-Source: APXvYqwKNlF8q+mmqR0pw25iEO+NCTXNfEs3737r9DglJCCo3k+/0cqg46MePVdLNU3/2JL7NqQACg==
X-Received: by 2002:adf:df92:: with SMTP id z18mr4189335wrl.213.1557215059619; 
	Tue, 07 May 2019 00:44:19 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	v17sm9142534wmc.30.2019.05.07.00.44.18
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 00:44:19 -0700 (PDT)
To: Hou Qiming <hqm03ster@gmail.com>
References: <20190507054914.25261-1-marcel.apfelbaum@gmail.com>
	<f7c57c29-0aa1-c68e-44ed-4ea52d3006c4@redhat.com>
	<CABSdmrmKYMyMFX-O6y2fAGRow9sHhtSN50knQ_yVwKiNmdyGBw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e4c2c9bf-f73e-5f75-3c2b-5bf92cb3a524@redhat.com>
Date: Tue, 7 May 2019 09:44:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABSdmrmKYMyMFX-O6y2fAGRow9sHhtSN50knQ_yVwKiNmdyGBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
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

On 5/7/19 8:49 AM, Hou Qiming wrote:
> My real name is "HOU Qiming". @Marcel Apfelbaum
> <mailto:marcel.apfelbaum@gmail.com> can you incorporate that in your v2
> patch? Thanks!

Thanks a lot Qiming :)

> On Tue, May 7, 2019 at 2:25 PM Philippe Mathieu-Daudé <philmd@redhat.com
> <mailto:philmd@redhat.com>> wrote:
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
>     > Signed-off-by: HQM <hqm03ster@gmail.com <mailto:hqm03ster@gmail.com>>
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
>     > @@ -92,13 +92,17 @@ void surface_gl_update_texture(QemuGLShader *gls,
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

