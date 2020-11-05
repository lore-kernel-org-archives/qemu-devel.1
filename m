Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76597C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 08:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97C520729
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 08:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97C520729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaadv-0003jb-Kl
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 03:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kaadO-0003IY-2r; Thu, 05 Nov 2020 03:28:42 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:42764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kaadM-0002ZJ-F8; Thu, 05 Nov 2020 03:28:41 -0500
Received: by mail-ot1-f46.google.com with SMTP id h62so674203oth.9;
 Thu, 05 Nov 2020 00:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xicmHF4rJAUG4xgwhhtkHu520Lkff9VoRcMLqSQLnKw=;
 b=qlO3OBTFtI0Q9TQMFgQ3dyCJqXTAHku/UHpm7L0bRPWW1wttlTA1ut2w3bFHEU52xN
 p7FjFQHI8IdG109/Ce83qFscSvPua/IDzZ8HRffv7E40TS+yN4T7HAbzfwVlygWymPWS
 q3cy/8lie8IU2enaRnz2v0Vdqo5ZpHW1lRX6VUDxvigDfIHjGXoQPHKHd+qdCwvXK2rn
 DQQFPNhqZRNI0m/AeuAdbwCP7IllMzIaXjSqkUN+EnKfmxZmOs2ktnoKW8fnGHAvgdyk
 kjiwmczMeTSd0BXgTju2vr6htl2ubN9i+QNx0LkvKzHf0t/CViwCcSObHtYefglnTnKO
 tUZA==
X-Gm-Message-State: AOAM533BLwMe1XLNYNjbnROIJS8tdNApAYRBum++qT+Y1QeBjRvjfryw
 0U6gWVDY1XN6ZJLleEsFCIuvSP0UEQmZp9Siiuk=
X-Google-Smtp-Source: ABdhPJxEnS6iGJDfFZSOe00EmRjaIdeCWilAcRGjzSID/8pP/7VpwLVCFr4tVDvsPF7uAQfyKHOUI4NIAHwsXXz43kQ=
X-Received: by 2002:a05:6830:2085:: with SMTP id
 y5mr940046otq.37.1604564919101; 
 Thu, 05 Nov 2020 00:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <20201103165247.GT205187@redhat.com>
 <7654e063-98d3-84e0-8116-5a1b41d14636@redhat.com>
 <21e90ddb-fe8a-c780-2741-9b7a2f7f1c9a@redhat.com>
 <alpine.DEB.2.21.2011031722100.3264@sstabellini-ThinkPad-T480s>
 <9ac5e985-a701-f357-29fb-ef7975f5f2c2@redhat.com>
 <alpine.DEB.2.21.2011041805060.3264@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2011041805060.3264@sstabellini-ThinkPad-T480s>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 5 Nov 2020 09:19:34 +0100
Message-ID: <CAAdtpL6tGqKyRSZiQK7ZaEuJyG6z2tAauzsDVQnet=3EkuqPBQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: Stefano Stabellini <sstabellini@kernel.org>
Content-Type: multipart/alternative; boundary="00000000000005af5d05b357e2c9"
Received-SPF: pass client-ip=209.85.210.46;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ot1-f46.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 03:28:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000005af5d05b357e2c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 5 nov. 2020 05:28, Stefano Stabellini <sstabellini@kernel.org> a
=C3=A9crit :

> On Wed, 4 Nov 2020, Thomas Huth wrote:
> > On 04/11/2020 03.27, Stefano Stabellini wrote:
> > [...]
> > > Actually I care about Xen and 9pfs support, it is one of the few
> > > combinations that I use regularly and it is even enabled in the Xilin=
x
> > > product I look after. But admittedly I don't test QEMU master as much
> as
> > > I should. With the recent changes to the build system it is not very
> > > suprising that there are some issues. It would be great to have a Xen
> > > and 9pfs test in the gitlab CI-loop.
> > >
> > >
> > > FYI I tried to build the latest QEMU on Alpine Linux 3.12 ARM64 and I
> > > get:
> > >
> > >   ninja: unknown tool 'query'
> > >
> > > Even after rebuilding ninja master by hand. Any ideas? I don't know
> much
> > > about ninja.
> > >
> > >
> > > So I gave up on that and I spinned up a Debian Buster x86 container f=
or
> > > this build. That one got past the "ninja: unknown tool 'query'" error=
.
> > > The build completed without problems to the end.
> > >
> > > Either way I can't reproduce the build error above.
> >
> > Did you run "configure" with "--without-default-devices" ?
>
> Yes, and still I can't repro the issue, strange. Anyway, I saw that
> Philippe managed to find and fix the issue with "hw/9pfs: Fix Kconfig
> dependency problem between 9pfs and Xen", so all sorted :)
>

Paolo figured the problem and sent a diff, I just forwarded it as a formal
patch ;)

>

--00000000000005af5d05b357e2c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le jeu. 5 nov. 2020 05:28, Stefano Stabellini &lt;<a href=
=3D"mailto:sstabellini@kernel.org">sstabellini@kernel.org</a>&gt; a =C3=A9c=
rit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Wed, 4 Nov 2020, Thom=
as Huth wrote:<br>
&gt; On 04/11/2020 03.27, Stefano Stabellini wrote:<br>
&gt; [...]<br>
&gt; &gt; Actually I care about Xen and 9pfs support, it is one of the few<=
br>
&gt; &gt; combinations that I use regularly and it is even enabled in the X=
ilinx<br>
&gt; &gt; product I look after. But admittedly I don&#39;t test QEMU master=
 as much as<br>
&gt; &gt; I should. With the recent changes to the build system it is not v=
ery<br>
&gt; &gt; suprising that there are some issues. It would be great to have a=
 Xen<br>
&gt; &gt; and 9pfs test in the gitlab CI-loop.<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; FYI I tried to build the latest QEMU on Alpine Linux 3.12 ARM64 a=
nd I<br>
&gt; &gt; get:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0ninja: unknown tool &#39;query&#39;<br>
&gt; &gt; <br>
&gt; &gt; Even after rebuilding ninja master by hand. Any ideas? I don&#39;=
t know much<br>
&gt; &gt; about ninja.<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; So I gave up on that and I spinned up a Debian Buster x86 contain=
er for<br>
&gt; &gt; this build. That one got past the &quot;ninja: unknown tool &#39;=
query&#39;&quot; error.<br>
&gt; &gt; The build completed without problems to the end.<br>
&gt; &gt; <br>
&gt; &gt; Either way I can&#39;t reproduce the build error above.<br>
&gt; <br>
&gt; Did you run &quot;configure&quot; with &quot;--without-default-devices=
&quot; ?<br>
<br>
Yes, and still I can&#39;t repro the issue, strange. Anyway, I saw that<br>
Philippe managed to find and fix the issue with &quot;hw/9pfs: Fix Kconfig<=
br>
dependency problem between 9pfs and Xen&quot;, so all sorted :)<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo figure=
d the problem and sent a diff, I just forwarded it as a formal patch ;)</di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
</blockquote></div></div></div>

--00000000000005af5d05b357e2c9--

