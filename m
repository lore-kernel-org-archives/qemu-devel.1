Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40117C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0439A205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE4hSVAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0439A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip6ZK-00010Y-5F
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 03:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ip6Yk-0000ag-8S
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ip6Yh-0004Do-LM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:19:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25937
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ip6Yh-0004Cl-D5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578471558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5p7wBkAAMT37Dcaa3Q+E6/DWG923bEwJeikQ09vofIs=;
 b=XE4hSVAfDD3FFtptFG1e3lT6wIB3UsAbYFcRYW0FrQ5fm7wvP5NwBSVVX1TsBjHicDkC5F
 w/qOT9b8RnWm0mKzn41ecn9DTcK1smoNsIMYDIOqY+xU4YUZ7w7BU3Hmwyse2og0YAKoMN
 LutHapK+nlt4kUPM392NDaElxgGpbGI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-LESaEUB_OVSxiqoiIaZHTg-1; Wed, 08 Jan 2020 03:19:14 -0500
Received: by mail-ed1-f69.google.com with SMTP id u20so1240527eda.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 00:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rtVQ+AIvqiEx2ES52b3HolCMYrhq0uELNRfu/w+vMOY=;
 b=fNogyHE2/pBxM9jFXf3OtsBEXyOICA0C4IpvNoHNcaZhEO8oyeEz1u3/DkyoBYJCQ2
 +b9MUcgwB6aLLlkZ9tmFSA3dw2e6DopXkhdaO+5UYijQKtNKK8aOG8utpqExJIpD/dP9
 OiksBp+ABlPsHMIv8BAFF/lCgCA9Oj2TEogevjcFfb3rJNcmcV8dfX891w+6VgHOPZV0
 iBALYYFUVl9wUAmeGvxiensPGBxiWfv43/Cte1Hu+FZS/xxPLy2+UfSUusvMXYQ4141x
 DfWfpFzdOr3sWFrjPCy/MsdfLekmHXDjVXyQta4ns9634+zMC5GRu1AzHzGg2M7CRb/z
 ez/Q==
X-Gm-Message-State: APjAAAXkDAfqRm02+Ouw3ZWFtjPdqSS4sO739Bh4KbNdW+zZOVsJsb3p
 +HE/RnatU4r5pUnZ85cxyVe4Gotw9B2gGP9VBiazTOp/3rv/3a4P+fSgMV6w4SKeCmZ9tNzHNf6
 dACUWWEY2DJ9CcHvfKtGOSeUFPeT8ia8=
X-Received: by 2002:a50:ed18:: with SMTP id j24mr4126912eds.124.1578471553292; 
 Wed, 08 Jan 2020 00:19:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzRyqIYL9Y5OjQjbgvZhCbluyp6WNQdgCOaFAcS+RsY5Jf6W211EEkjRYD1DrRONEuI8imktgVTCEb//119cPg=
X-Received: by 2002:a50:ed18:: with SMTP id j24mr4126906eds.124.1578471553099; 
 Wed, 08 Jan 2020 00:19:13 -0800 (PST)
MIME-Version: 1.0
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
 <1576171754-45138-7-git-send-email-pbonzini@redhat.com>
 <20200108080355.l762jkzec57iecsv@sirius.home.kraxel.org>
In-Reply-To: <20200108080355.l762jkzec57iecsv@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 8 Jan 2020 09:19:01 +0100
Message-ID: <CABgObfYv1e2ztyed2-4uyWfFYhvCUEGYaVBH1343pcv0m3akOg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] x86: move more x86-generic functions out of PC
 files
To: Gerd Hoffmann <kraxel@redhat.com>
X-MC-Unique: LESaEUB_OVSxiqoiIaZHTg-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="000000000000360f0b059b9c8ce8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000360f0b059b9c8ce8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, I am preparing a pull request now.

Paolo

Il mer 8 gen 2020, 09:04 Gerd Hoffmann <kraxel@redhat.com> ha scritto:

> On Thu, Dec 12, 2019 at 06:29:12PM +0100, Paolo Bonzini wrote:
> > These are needed by microvm too, so move them outside of PC-specific
> files.
> > With this patch, microvm.c need not include pc.h anymore.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Current master does not work with libvirt ...
>
> $ virsh start fedora-org-base
> error: Failed to start domain fedora-org-base
> error: internal error: Failed to probe QEMU binary with QMP:
> /home/kraxel/projects/qemu/target/i386/kvm.c:2176:kvm_arch_init: Object
> 0x5608f33be1f0 is not an instance of type x86-machine
>
> ... and git bisect lands at this patch.
>
> cheers,
>   Gerd
>
>

--000000000000360f0b059b9c8ce8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes, I am preparing a pull request now.<div dir=3D"auto">=
<br></div><div dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">Il mer 8 gen 2020, 09:04 Gerd Hoffma=
nn &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt; ha sc=
ritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">On Thu, Dec 12, 2019 at 06:2=
9:12PM +0100, Paolo Bonzini wrote:<br>
&gt; These are needed by microvm too, so move them outside of PC-specific f=
iles.<br>
&gt; With this patch, microvm.c need not include pc.h anymore.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
<br>
Current master does not work with libvirt ...<br>
<br>
$ virsh start fedora-org-base<br>
error: Failed to start domain fedora-org-base<br>
error: internal error: Failed to probe QEMU binary with QMP: /home/kraxel/p=
rojects/qemu/target/i386/kvm.c:2176:kvm_arch_init: Object 0x5608f33be1f0 is=
 not an instance of type x86-machine<br>
<br>
... and git bisect lands at this patch.<br>
<br>
cheers,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div>

--000000000000360f0b059b9c8ce8--


