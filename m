Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A8C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B74721D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ch5lQV/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B74721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8qro-0003pB-GI
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j8qr2-0003Hk-UE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j8qr1-0007w1-FL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:35:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35543
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j8qr1-0007vO-Av
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583177750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wcpt54pIELueAs0E02bXK/mtYwjyh8PrVecjrsbs3uo=;
 b=Ch5lQV/EawI0Op+Vu5RF56jL5682pcrhqVifNe7W/v7qhZhLJnvsHHcMPIWNSxkS1kAnro
 ZXX/I0XIBwUHOS1U+JSqFgmDTpIzPc2/+hKoIxFX1fq0S6h0sdQujM9Giuxzw6dyxEWmC7
 3he6NapYID27aVxYwCLJMJbBtjhVGrY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-J1Hr9LgjP5iIMAVLSii8mw-1; Mon, 02 Mar 2020 14:35:48 -0500
X-MC-Unique: J1Hr9LgjP5iIMAVLSii8mw-1
Received: by mail-ed1-f69.google.com with SMTP id z20so361228edr.11
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 11:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yCcXWlxmR2EGtddiD22OuNT63UlNUDDKvyn60JJGP3w=;
 b=ULUqYenzSBkyWfQ5/hH3O3htO7Sb473rtrVLtvEu7tOS57x8PwgbOjIvS0zNElPCh8
 49arAK0Ts0UVmoevrV/NqnjNVxiyCw+qgH+d8NoiSNYJe+t7YN8ZJgiA8Uf//l0ybhr0
 vzI6rS/UnxA/xBXNbbvTlfftSXAb7Qhidx3bvS6IzkVhWW3WTcZn4G3b/WFWFsLTrwZo
 zGX908+SdQni8fcDtX1jVyGrKk0RmFYrxfczLzE+9pm1AyCGbV3tdyZ5R4+NOc0lfNE4
 wGBqjA1mIEh1ltctGeBhdieHXxhuqPuViHhtxX8i8OqN6C8VdCPhkDfvHrQcng6pQmjK
 KtNA==
X-Gm-Message-State: ANhLgQ12SRcj+ndEBXdJZVdnihzY7yisKxcgVicPTznPm14ijrD+7qW5
 s3521x/r1s7ZEbgOluI1vDi3bi0r9aKoMDk96sWJuhi4qhSSLxCDSON8D5GS7U+7Aima2xMoiZd
 L3fPc5iqru6O8R/eqKILaEMCYRRl3W5U=
X-Received: by 2002:aa7:cfcc:: with SMTP id r12mr876924edy.57.1583177747039;
 Mon, 02 Mar 2020 11:35:47 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvJhXQpYBmtYtEw5AfgdxHn526s9fkeNStKqQfp92JxfjKxcaltJjSvNKx8XsoO0ijpsLlTZkCkxWddT8LQ9ws=
X-Received: by 2002:aa7:cfcc:: with SMTP id r12mr876900edy.57.1583177746786;
 Mon, 02 Mar 2020 11:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com>
 <20200206213232.1918-4-n54@gmx.com>
 <e85f03be-60bc-2852-7856-91790ba5958b@redhat.com>
 <ca1210a3-2ea5-3862-c4fa-bdcd5624fe29@m00nbsd.net>
In-Reply-To: <ca1210a3-2ea5-3862-c4fa-bdcd5624fe29@m00nbsd.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Mar 2020 20:35:33 +0100
Message-ID: <CABgObfZjnFFV3hosrP+sf5d3KmPPGuFJZo-oY5=u340wtxLYGg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] Introduce the NVMM impl
To: Maxime Villard <max@m00nbsd.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000036bdc3059fe44b8e"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, jmcneill@invisible.ca, Kamil Rytarowski <n54@gmx.com>,
 philmd@redhat.com, rth <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000036bdc3059fe44b8e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Il lun 2 mar 2020, 20:28 Maxime Villard <max@m00nbsd.net> ha scritto:

>
> >> +        nvmm_vcpu_pre_run(cpu);
> >> +
> >> +        if (atomic_read(&cpu->exit_request)) {
> >> +            qemu_cpu_kick_self();
> >> +        }
> >> +
> >
> > This is racy without something like KVM's immediate_exit mechanism.
> > This should be fixed in NVMM.
>
> I don't immediately see how this is racy.


You can get an IPI signal immediately after reading cpu->exit_request.

It reproduces the existing
> logic found in whpx-all.c, and if there is a real problem it can be
> fixed in a future commit along with WHPX.
>

It's buggy there too and it has to be fixed in the hypervisor so it can't
be done at the same time I'm both. KVM does it right by having a flag
("immediate_exit") that is set by the signal handler and checked by the
hypervisor.

An earlier version of KVM instead atomically unblocked the signal while
executing the guest, and then ate it with a sigwaitinfo after exiting back
to userspace.

You don't have to fix it immediately, but adding a FIXME would be a good
idea.

Paolo


> Maxime
>
>

--00000000000036bdc3059fe44b8e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 2 mar 2020, 20:28 Maxime Villard &lt;<a href=3D=
"mailto:max@m00nbsd.net">max@m00nbsd.net</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 nvmm_vcpu_pre_run(cpu);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (atomic_read(&amp;cpu-&gt;exit_req=
uest)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_cpu_kick_self();<b=
r>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt; <br>
&gt; This is racy without something like KVM&#39;s immediate_exit mechanism=
.<br>
&gt; This should be fixed in NVMM.<br>
<br>
I don&#39;t immediately see how this is racy.</blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">You can get an IPI signal immediat=
ely after reading cpu-&gt;exit_request.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"> =
It reproduces the existing<br>
logic found in whpx-all.c, and if there is a real problem it can be<br>
fixed in a future commit along with WHPX.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s buggy there too and it ha=
s to be fixed in the hypervisor so it can&#39;t be done at the same time I&=
#39;m both. KVM does it right by having a flag (&quot;immediate_exit&quot;)=
 that is set by the signal handler and checked by the hypervisor.</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">An earlier version of KVM instead=
 atomically unblocked the signal while executing the guest, and then ate it=
 with a sigwaitinfo after exiting back to userspace.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">You don&#39;t have to fix it immediately, but =
adding a FIXME would be a good idea.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Maxime<br>
<br>
</blockquote></div></div></div>

--00000000000036bdc3059fe44b8e--


