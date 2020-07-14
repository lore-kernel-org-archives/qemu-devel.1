Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC147C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A064227BF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1Ns6qDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A064227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvPfn-0005J6-Ip
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 14:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jvPeq-0004Ni-43
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:28:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40437
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jvPeo-0006jK-HF
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594751272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5gHSh/sgi4lMESIgSBejG+2/2eDBxQ5Q5zmQEbf3JWE=;
 b=i1Ns6qDbNyvstkQCE/O+qH2C/oJNosVKzpxMYEH9wvwLw8D+iW8BwJy9ccoCj39CgIKmxg
 rLDi0BdShVCYjUaGxeEKiSB8Fh9zltNxTsXeJjoQ3ADw/rKu+hg3nuUW1efvQB3o75TRJ3
 pfx4wIHj4OnURnTgFWk5AsuRH2QgDEE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-7wznPz1vOZ-lBlRMkwjKAw-1; Tue, 14 Jul 2020 14:27:51 -0400
X-MC-Unique: 7wznPz1vOZ-lBlRMkwjKAw-1
Received: by mail-ed1-f70.google.com with SMTP id u59so25080479edc.16
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 11:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5gHSh/sgi4lMESIgSBejG+2/2eDBxQ5Q5zmQEbf3JWE=;
 b=tc58lWnH8HtPxl6BO3FQ/FhWXtzRAcHtULbP9lr0AmNRQbo2OyPekpmO21IvwWpy8y
 wj+iQbt3mOXkgoESMAY093dz/PhuFg40chPvbMgw9TqQLadSq7fMAwdvVH+XF9dYLg7H
 VTVpWlMeLbeSHMUE7XK+DTsG3Dumwm1nQQ6FgIcW3ym4ihb+lOPeBhSi4V6Dz830pXGE
 dPBga44cAdcAa6PCo0m3um6ZvlMg/00/ppc6T4ZWjnuUM3OsArbHN7BaETrvONSJ+Nzh
 c5ERRrAynbuwvtyfEu7YI2Hy3XNgq1nbE3CEXZSU0Un5/5onUlOW3qbviFfgCJaySB2z
 yNGg==
X-Gm-Message-State: AOAM530kvZkCjy3kNF7877viq1X1SvyKQu9r2RYxwmL/kBVC6k2992hu
 76MlPFbVCT29navs8P5F0XF9Ws/KrO0Ne31wXyZjReZ0s3nYwbznMB8hHdSvHMpv/iMqRPzcEzi
 9A23oVsBDBBZ4eDYnk9FDem78rm0Ggdw=
X-Received: by 2002:a05:6402:1d89:: with SMTP id
 dk9mr5852355edb.31.1594751269763; 
 Tue, 14 Jul 2020 11:27:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcmWt3GwAM5wmHEbfQE30Z3QGYn79QztNNALn6G5GK1eDgzAkym5L3u2YIPU6/V3P7KixIs0JPnIF2hYVrTP0=
X-Received: by 2002:a17:906:e213:: with SMTP id
 gf19mr5584189ejb.433.1594750815838; 
 Tue, 14 Jul 2020 11:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200714090726.41082-1-r.bolshakov@yadro.com>
 <20200714103932.GB90799@SPB-NB-133.local>
In-Reply-To: <20200714103932.GB90799@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Jul 2020 20:20:04 +0200
Message-ID: <CABgObfYgRVpy6WvjzFG0Zb+2bjQp6HYOuZePbtkbxWjLkxBYjw@mail.gmail.com>
Subject: Re: [PATCH for-5.1] i386: hvf: Explicitly set CR4 guest/host mask
To: Roman Bolshakov <r.bolshakov@yadro.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e2424205aa6adb07"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: programmingkidx@gmail.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e2424205aa6adb07
Content-Type: text/plain; charset="UTF-8"

Hi Roman, please ask Peter to apply it directly because I won't be able to
send a pull request in the next couple of weeks.

Paolo

Il mar 14 lug 2020, 12:39 Roman Bolshakov <r.bolshakov@yadro.com> ha
scritto:

> On Tue, Jul 14, 2020 at 12:07:27PM +0300, Roman Bolshakov wrote:
> > Removal of register reset omitted initialization of CR4 guest/host mask.
> > x86_64 guests aren't booting without it.
> >
> > Fixes: 5009ef22c6bb2 ("i386: hvf: Don't duplicate register reset")
> > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> >
>
> If one has a chance to test or review it, it'd be very helpful. That'd
> allow to include it in RC0.
>
> Thanks,
> Roman
>
>

--000000000000e2424205aa6adb07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Roman, please ask Peter to apply it directly because I=
 won&#39;t be able to send a pull request in the next couple of weeks.<div =
dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 14 lug 2020, 12:=
39 Roman Bolshakov &lt;<a href=3D"mailto:r.bolshakov@yadro.com">r.bolshakov=
@yadro.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On T=
ue, Jul 14, 2020 at 12:07:27PM +0300, Roman Bolshakov wrote:<br>
&gt; Removal of register reset omitted initialization of CR4 guest/host mas=
k.<br>
&gt; x86_64 guests aren&#39;t booting without it.<br>
&gt; <br>
&gt; Fixes: 5009ef22c6bb2 (&quot;i386: hvf: Don&#39;t duplicate register re=
set&quot;)<br>
&gt; Signed-off-by: Roman Bolshakov &lt;<a href=3D"mailto:r.bolshakov@yadro=
.com" target=3D"_blank" rel=3D"noreferrer">r.bolshakov@yadro.com</a>&gt;<br=
>
&gt; <br>
<br>
If one has a chance to test or review it, it&#39;d be very helpful. That&#3=
9;d<br>
allow to include it in RC0.<br>
<br>
Thanks,<br>
Roman<br>
<br>
</blockquote></div>

--000000000000e2424205aa6adb07--


