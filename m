Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E941C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45C2206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZjKouzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45C2206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDwR-00016r-Uq
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBDvZ-00006u-6r
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBDvW-0001oQ-AZ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598519432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Ulmca+NnMF3ZhjIRuL7kmcMlcwqDC+mVHXDKMtIO0s=;
 b=aZjKouzcEzrDK5cIT2XWyUWcjA35UXQz6GtwNFMmM3syI7caTf8zIQvT3LZIic0RyL0b4W
 rdOPsLogHhxMaFW9qsJdEY1wo2lExUI3c4jLINIcoTmhY7eX69HjNn0pir6c2lRyns3Q20
 D/6E6VE1ti97X9MZhkH/JOY/xJW8I1I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-fMLAYlXUPxGa9NVO4aQ74g-1; Thu, 27 Aug 2020 05:10:29 -0400
X-MC-Unique: fMLAYlXUPxGa9NVO4aQ74g-1
Received: by mail-ej1-f70.google.com with SMTP id gf10so2306118ejb.12
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 02:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Ulmca+NnMF3ZhjIRuL7kmcMlcwqDC+mVHXDKMtIO0s=;
 b=pKJAJvpGP5BAjCQBKZpQs+lsHCJvX4ZkjLfv0RIv9Ny4CfuuZf0ScCZjv/y6t0nbG3
 d1hoFIqa74BHm3g1S4RUa44uLFom0uccK/F1I8QeHGlL6Dz5VOk5ozM3jW96jcMF9nXv
 W8hkM++CBQowayFjkLQeqgnRZdu2a3GgWZRTLtg2U62fqhMObIU2cNNM9Pme7ZxcS9rR
 qtpWHb5xYppK0AwqHt5x1WqT0J3T8lKT+N8vC/fVFBDDIJoleux1KCND4qGerRIKhtA9
 eVVP+yhMEZe2HFe+Bm0Nq5Ey9mdXyjSNZ0JpcWvulVP1uOIoY1parNP9uoHwZOQEBWbb
 OspA==
X-Gm-Message-State: AOAM532ZbjKBp63ZvfuXCwZdvwx/LGYH04LrF7lWtYqtk/xgZCTBQSRR
 TOTuN5rtAaL+qCbWKMwQTZyQDLEWIjjwdvPv7Vhnhm4ohx1wfpFBQhS4nB9WRQtxM7BgKQqtn6T
 QBWv/AhdBNrA2nOkB7Dq4URtIIHeRb0c=
X-Received: by 2002:a50:9f0c:: with SMTP id b12mr18176987edf.129.1598519427950; 
 Thu, 27 Aug 2020 02:10:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5EERGifRqvvW/wbLrM9k8MxbtT6cy5Z9jNGlFFFMhW+J3GLLiPrb9pyGLY+u4A9ksbO/vNd38RV6sDtB7xso=
X-Received: by 2002:a50:9f0c:: with SMTP id b12mr18176973edf.129.1598519427796; 
 Thu, 27 Aug 2020 02:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200826190128.22707-1-pbonzini@redhat.com>
 <3c7ca48a-5eb0-cfd4-bac0-a2a7475eec39@vivier.eu>
 <CABgObfZhE1+N1XiHBaPx7SZHawUwNeA4yG5g1TPNQ5TMCO9xSA@mail.gmail.com>
In-Reply-To: <CABgObfZhE1+N1XiHBaPx7SZHawUwNeA4yG5g1TPNQ5TMCO9xSA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2020 11:10:15 +0200
Message-ID: <CABgObfas4KFFc=0r9o_N8BYC0jHUoVx=iS0VYFU+zSCj-9yVQg@mail.gmail.com>
Subject: Re: [PATCH] ninjatool: quote dollars in variables
To: Laurent Vivier <laurent@vivier.eu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a925d705add84e6d"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a925d705add84e6d
Content-Type: text/plain; charset="UTF-8"

Found; https://github.com/mesonbuild/Meson/issues/5191.

(With the fix there's no rpath at all in the QEMU build process).

Let's ask for a backport to 0.55.2.

Paolo

Il gio 27 ago 2020, 10:22 Paolo Bonzini <pbonzini@redhat.com> ha scritto:

>
>
> Il gio 27 ago 2020, 09:33 Laurent Vivier <laurent@vivier.eu> ha scritto:
>
>> This actually fixes the '-Wl,-rpath,$ORIGIN/', but doesn't fix the crash
>> with statically linked binaries.
>>
>
> I will try to reproduce when I am back; it works for Peter so there must
> be something different in the setup.
>
> In any case, if needed we can both momentarily hack around it in
> Makefiles, and fix it for good in Meson.
>
> Paolo
>
>
>> Could we simply remove the the '-Wl,-rpath,$ORIGIN/' in the case of
>> "-static" build?
>>
>> Thanks,
>> Laurent
>>
>>

--000000000000a925d705add84e6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Found; <a href=3D"https://github.com/mesonbuild/Meson/iss=
ues/5191">https://github.com/mesonbuild/Meson/issues/5191</a>.<div dir=3D"a=
uto"><br></div><div dir=3D"auto">(With the fix there&#39;s no rpath at all =
in the QEMU build process).</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Let&#39;s ask for a backport to 0.55.2.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">Il gio 27 ago 2020, 10:22 Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div><br><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 27 =
ago 2020, 09:33 Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" tar=
get=3D"_blank" rel=3D"noreferrer">laurent@vivier.eu</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">This actually fixes the &#39;-Wl,-rpat=
h,$ORIGIN/&#39;, but doesn&#39;t fix the crash<br>
with statically linked binaries.<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">I will try to reproduce when I am back; it =
works for Peter so there must be something different in the setup.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">In any case, if needed we can bo=
th momentarily hack around it in Makefiles, and fix it for good in Meson.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<br>
Could we simply remove the the &#39;-Wl,-rpath,$ORIGIN/&#39; in the case of=
<br>
&quot;-static&quot; build?<br>
<br>
Thanks,<br>
Laurent<br>
<br>
</blockquote></div></div></div>
</blockquote></div>

--000000000000a925d705add84e6d--


