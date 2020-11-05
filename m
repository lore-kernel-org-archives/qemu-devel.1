Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37942C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 09:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DF6206FB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 09:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="jzCntycd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DF6206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kabKL-0007cx-9P
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 04:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kabIj-0006Yz-VY
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 04:11:26 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kabIi-00015x-3M
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 04:11:25 -0500
Received: by mail-oi1-x241.google.com with SMTP id u127so969505oib.6
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 01:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IDMvoz2/1E2tbuIRMIai5ZSsY7ulxaVmFXWYDEgNlo0=;
 b=jzCntycdZjKVRNywpWTwW3vAy2izfAyFTN4pTOMVClXSGz7LFjtgIGSaY3HL1Wgbx/
 POvsQMSHnlWpaKHF11b3a1l5eGt0pV4KHzTSy4LGZ5+mJ6nc8FI+mePC/YNYcH8OeGOz
 uaqyUs+2YC/QLiQ7upu83ypeOOZbTIYjphgubsOfr5+uK+FoCwFg09K6r1qexDIpgoOu
 rXwl5qgrRkh8ZwWfxsmIilcGwuvSM07X0XiWpbKydbtbTKNI6bWQ+0G3VwopzwxqI5Yx
 gKRIw6x5bTUhbkKCL6/LQ9sVoaN4DP5dvyt1Qk+92/FEr/1YjMYIigUSrjjCQkIl8tTp
 1gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IDMvoz2/1E2tbuIRMIai5ZSsY7ulxaVmFXWYDEgNlo0=;
 b=BwTvotkmzOUHVbxYTsciIsJeJwQGvkZxpwx1AEggOaKuRMrfm5PwmuAzKhxtHyxWpo
 6UDSV7ZKB87/YhTvuscedGHElc/7rYyvhu3gNCG7VRZcrRRTUPISxfaWH3OHCTqaZNDV
 Ux/NGIl7MtrVThjQVU0pP9wUoueqY9LpWux97OFzTEFcZ29Pf6jZLy4uKmOJMuDif6eN
 h1u3IZNlYvfceYPYTFyPqtqX/0EWlUyqTdc3zj2Ruyk/s1222TyJiVK4+1dJYwQXAfSG
 14xX+JxrtfZ2wmPcTHRPihApu/jca+f2r9N2OpWeraZXd6+9fWAN6GqXb07Fiq5xhHKf
 g+Pg==
X-Gm-Message-State: AOAM531a2zTvye71lGA02Bj80lS/+bjxO12ofRyzyQHTgcmBrSXQym/0
 Q5RGMgKXOLHkFVUBUH+3hOJO0ctPHxpAcD1JvhFO2A==
X-Google-Smtp-Source: ABdhPJyynTcZAJt8J09VXuNx06rHZTRvBc/h/vPmCmLhljhbrdjeBt1YKkFrSi29JZOa9/CeoDAqxjku3ltXq7J+v/8=
X-Received: by 2002:a05:6808:1c4:: with SMTP id x4mr979059oic.91.1604567483017; 
 Thu, 05 Nov 2020 01:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20201102185115.7425-1-andrew@daynix.com>
 <0164a42f-4542-6f3e-bd71-3319dfaae190@redhat.com>
 <CAOEp5Oe3btwgPcOA6v=kK9s2to=x2Hg6Qw2iCFXOOWZs49s=-Q@mail.gmail.com>
 <caa38709-88f1-bd6d-3ff9-61e64c3aa51f@redhat.com>
 <20201104093155.GB565323@redhat.com>
 <cc53c09c-9b3c-63e1-6df3-b5fc949e626c@redhat.com>
 <4bc0321a-773a-8aae-d94a-ef488f7ff646@redhat.com>
In-Reply-To: <4bc0321a-773a-8aae-d94a-ef488f7ff646@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 5 Nov 2020 11:11:11 +0200
Message-ID: <CAOEp5OfEvVKipm8kw-tbcWdetWQ3i4onVAasCNa9TXDY5q8LoA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] eBPF RSS support for virtio-net
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d8025105b3587a92"
Received-SPF: none client-ip=2607:f8b0:4864:20::241;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Yan Vugenfirer <yan@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d8025105b3587a92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2020 at 5:52 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/11/5 =E4=B8=8A=E5=8D=8811:46, Jason Wang wrote:
> >>
> >> It's probably ok if we treat the bytecode as a kind of firmware.
> > That is explicitly *not* OK for inclusion in Fedora. They require that
> > BPF is compiled from source, and rejected my suggestion that it could
> > be considered a kind of firmware and thus have an exception from buildi=
ng
> > from source.
>
>
> Actually, there's another advantages. If we treat it as firmware,
> (actually it is). It allows us to upgrade it independently with qemu.
>
> Hi Jason,
I think this is a big disadvantage to have the BPF binary outside of QEMU.
It is compiled with common structures (for example RSS configuration)
defined in QEMU and if it is not built in the QEMU then nobody is
responsible for the compatibility of the BPF and QEMU.
Just an array of instructions (af today) is ~2k, full object file (if we
use libbpf) is ~8K, so there is no big problem with the size.
If we even keep the entire object in QEMU, it is for sure 100% compatible.

Thanks
>
>

--000000000000d8025105b3587a92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 5, 2020 at 5:52 AM Jason =
Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/11/5 =E4=B8=8A=E5=8D=8811:46, Jason Wang wrote:<br>
&gt;&gt;<br>
&gt;&gt; It&#39;s probably ok if we treat the bytecode as a kind of firmwar=
e.<br>
&gt; That is explicitly *not* OK for inclusion in Fedora. They require that=
<br>
&gt; BPF is compiled from source, and rejected my suggestion that it could<=
br>
&gt; be considered a kind of firmware and thus have an exception from build=
ing<br>
&gt; from source. <br>
<br>
<br>
Actually, there&#39;s another advantages. If we treat it as firmware, <br>
(actually it is). It allows us to upgrade it independently with qemu.<br>
<br></blockquote><div>Hi Jason,</div><div>I think this is a big disadvantag=
e to have the BPF binary outside of QEMU.</div><div>It is compiled with com=
mon structures (for example RSS configuration) defined in QEMU and if it is=
 not built in the QEMU then nobody is responsible for the compatibility of =
the BPF and QEMU.</div><div>Just an array of instructions (af today) is ~2k=
, full object file (if we use libbpf) is ~8K, so there is no=C2=A0big probl=
em with the=C2=A0size.</div><div>If we even keep the entire object in QEMU,=
 it is for sure 100% compatible.</div><div><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
Thanks<br>
<br>
</blockquote></div></div>

--000000000000d8025105b3587a92--

