Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92342C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67DFC20B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DFC20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41022 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtm2-0006c1-OT
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:40:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNtXw-0002pI-Dt
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNtXu-0004Bk-WF
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:25:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNtXu-0004Ao-Pc
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:25:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so5208208wro.10
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 23:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=G94PzqjOgbNBWWICz4Z0zVrOGcPD6e3nX+8MWq0Xifw=;
	b=d6dqbQckjO/Oq93ZXS5tY1kZyuCrO9wAosme3J9De5M9Yx7tbRzWzntQMBg3alWACq
	cDcd5ABmwPOQ/8t4EhBdWNH9IL7qjzdAJzicMHuEGheB2cbZTFfJAot0h7QeqAM90YK/
	Sto+y62VSMxnzj5r7CwWeBwnRgH06UR1JcLLVvqQ3JJxaELN/rZJyOwxopB38+GgmUu6
	M6gE71ibEao5pFCbI/rMNfAd6YYvT0ui+sx91NjFYZ0s1N2rSTnadPb4K5YgeA8+EmqW
	nRF3La+lwGvnECtC4PTKBHdSiw6vYSNMXA0MpsrO5wgyZAYT6qaJqOxOw3nzNJS3OfdE
	BE9g==
X-Gm-Message-State: APjAAAUmULUa5xasHh18/HtOY60GKozBbwiSdOey6kbx0Ui9LYfig3Qv
	Z2/ucpawVJdghPMbyr81DLa6bg==
X-Google-Smtp-Source: APXvYqz5kELB0vuKLyfnVZNwSCdcE1jehK4CKhEbSIQmWENgoB82XoVhp4mEmWv+TzLDRfXN3SuuAQ==
X-Received: by 2002:adf:b446:: with SMTP id v6mr5520122wrd.30.1557210345656;
	Mon, 06 May 2019 23:25:45 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	t18sm23406549wrg.19.2019.05.06.23.25.44
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 23:25:45 -0700 (PDT)
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
References: <20190507054914.25261-1-marcel.apfelbaum@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f7c57c29-0aa1-c68e-44ed-4ea52d3006c4@redhat.com>
Date: Tue, 7 May 2019 08:25:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507054914.25261-1-marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
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
Cc: kraxel@redhat.com, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marcel,

On 5/7/19 7:49 AM, Marcel Apfelbaum wrote:
> From: HQM <hqm03ster@gmail.com>
> 
> In a GVT-g setup with dmabuf and GTK GUI, the current 2D texture at
> surface_gl_update_texture is not necessarily
> surface->texture. Adding a glBindTexture fixes related crashes and
> artifacts, and is generally more secure.
> 
> Signed-off-by: HQM <hqm03ster@gmail.com>

This looks like an acronym, per
https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line

"Patch emails must include a Signed-off-by: line [...] Please use your
real name to sign a patch (not an alias or acronym)."

> Tested-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
> [fixed malformed patch, rebase to master]
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
> 
> v2:
>  - fixed malformed patch
>  - rebased to master
> 
>  ui/console-gl.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/ui/console-gl.c b/ui/console-gl.c
> index a56e1cd8eb..c1cb3bd673 100644
> --- a/ui/console-gl.c
> +++ b/ui/console-gl.c
> @@ -92,13 +92,17 @@ void surface_gl_update_texture(QemuGLShader *gls,
>  
>      assert(gls);
>  
> -    glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
> -                  surface_stride(surface) / surface_bytes_per_pixel(surface));
> -    glTexSubImage2D(GL_TEXTURE_2D, 0,
> -                    x, y, w, h,
> -                    surface->glformat, surface->gltype,
> -                    data + surface_stride(surface) * y
> -                    + surface_bytes_per_pixel(surface) * x);
> +    if (surface->texture) {
> +        glBindTexture(GL_TEXTURE_2D, surface->texture);
> +        glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
> +                      surface_stride(surface)
> +                      / surface_bytes_per_pixel(surface));
> +        glTexSubImage2D(GL_TEXTURE_2D, 0,
> +                        x, y, w, h,
> +                        surface->glformat, surface->gltype,
> +                        data + surface_stride(surface) * y
> +                        + surface_bytes_per_pixel(surface) * x);
> +    }
>  }
>  
>  void surface_gl_render_texture(QemuGLShader *gls,
> 

