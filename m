Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7CEC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 17:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7B52064A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 17:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="eIvM22Xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7B52064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCl5-0007As-83
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 13:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani@anisinha.ca>) id 1jUCk1-0006dz-7w
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 13:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani@anisinha.ca>) id 1jUCjq-0005Sh-Od
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 13:12:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1jUCjq-0005RE-6u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 13:12:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id y24so2845486wma.4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dyCi02HU4lMw6Td9Z3vxrZdwP6ujsprSmHgD5oNTtyY=;
 b=eIvM22XtuP4qiHr+ZUt16YUfJZLh71OCm8fC5KSjMH/2dms0noCPX2tYdVHe+E7dZc
 NfWp7yfhSxnbi11I1J97sCziPX0FdbHBpLugYD3WM8UlW8Tvgsf/Wl+lcTY83RoSYh4H
 alnBncjtw8ENJb1ItI5dnzEfO/fx/ndM82B3BF8hfbqF7SyWEQdeYxa9ZhqDpY6m9wDi
 qEBoAweakiGWMDlUSBJ7MddPyM4HfPIdeJFQMEDAxk+oYYOxjR21WI1bJ0ufYJre/vkP
 7j2SFBgrRgUZZIAbFfK0hcOcEFi2yueYDqTIb9azCXg67EV7ookpL2uHDdaWgjGdJaX8
 M4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dyCi02HU4lMw6Td9Z3vxrZdwP6ujsprSmHgD5oNTtyY=;
 b=t6q/VR2mnb7ps8IejrLaonUAWo7n8n8tCDBVCx5zaKbmRizw7LztaGlnU8cMOwck/B
 xHIqQ3R7Pn3MvCwTwdVHozChoREszizk8GaIgkV2oBZltPBx4LnqtoKa9MEXYc+UGcv9
 EjdW93pnE9ujqbtbuV9zhHpuL1TI6h93J3+cxV545v3grlE9+oAbJk9X3f1IaoW6ycnM
 BPyPcLNeaPVzdUYselBlkBZiwMCW8Wc0Z8EYxnH7pnJpUI7+YQj9pQBUcVxmkVTIGWT5
 wBfvXn4FtS65nIQIq+ouBeoSx5/KGqS4Xa1kXNfpDIe4n18LMdE+W9v/je/Q3CZ3UM2C
 sBKA==
X-Gm-Message-State: AGi0PuZ7MxvVj4yF3i9LIvjBA+2gfRzBia6fNN/JqtIWsyPOmVdeWjuX
 9+UfR+4AM8hmMwJRG0zR0yEbyo5k0LzQYT2EeizTQg==
X-Google-Smtp-Source: APiQypLd+I1/by+2meugdJr+4X6TbCpaTy0cmrvlhnq0QHXKHmJmiChN4p4WLXxHcL33WAs2POc5XVpX5ignNwumcuk=
X-Received: by 2002:a7b:c959:: with SMTP id i25mr4036875wml.20.1588266759048; 
 Thu, 30 Apr 2020 10:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200428121837-mutt-send-email-mst@kernel.org>
 <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
 <20200428164428-mutt-send-email-mst@kernel.org>
 <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
 <20200429011228-mutt-send-email-mst@kernel.org>
 <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
 <20200429025200-mutt-send-email-mst@kernel.org>
 <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
 <20200429025535-mutt-send-email-mst@kernel.org>
 <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
 <20200429033657-mutt-send-email-mst@kernel.org>
 <D4141715-B662-407A-8B4D-0EB64B41F6A1@nutanix.com>
In-Reply-To: <D4141715-B662-407A-8B4D-0EB64B41F6A1@nutanix.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 30 Apr 2020 22:42:27 +0530
Message-ID: <CAARzgwyUd=k7FPJBjznJpzfKZu_0aqZUEK1rg77tnTNbcewe8A@mail.gmail.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
To: Ani Sinha <ani.sinha@nutanix.com>
Content-Type: multipart/alternative; boundary="000000000000fb636a05a4852bb8"
Received-SPF: none client-ip=2a00:1450:4864:20::342;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fb636a05a4852bb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

.


Accidental? So maybe what you need is actually something else then -

avoid *removing* the device when it's powered down.


You don=E2=80=99t get it. It is not hypervisor admins who are unplugging it=
. It is
the end users. Even RedHat customers want this feature. See following
resources:
https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
https://bugzilla.redhat.com/show_bug.cgi?id=3D1802592
https://bugzilla.redhat.com/show_bug.cgi?id=3D1790899

My approach is much more fine grained than just disable everything approach
that we have for q35. For i440fx we can do better than that


By the way, here's another glaring feature disparity between i440fx and q35
which we perhaps did not debate with as much fervour and push back as we
debated here. When we implemented per slot hotplug disable for PCIE, we
ignored to implement the same per slot capability for conventional PCI. Why
was feature disparity across two machine types wasn't so much of an issue
then?






--=20

MST

--000000000000fb636a05a4852bb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto"></div></div><div><div dir=3D"ltr"><br></div><div dir=
=3D"ltr">.</div><blockquote type=3D"cite"><div dir=3D"ltr"><blockquote type=
=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><span>Acc=
idental? So maybe what you need is actually something else then -</span><br=
></blockquote><blockquote type=3D"cite"><span>avoid *removing* the device w=
hen it&#39;s powered down.</span><br></blockquote><span></span><br><span>Yo=
u don=E2=80=99t get it. It is not hypervisor admins who are unplugging it. =
It is the end users. Even RedHat customers want this feature. See following=
 resources: </span><br><span><a href=3D"https://www.redhat.com/archives/lib=
vir-list/2020-February/msg00110.html" target=3D"_blank">https://www.redhat.=
com/archives/libvir-list/2020-February/msg00110.html</a></span><br><span><a=
 href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1802592" target=3D"_=
blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D1802592</a></span><br>=
<span><a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1790899" tar=
get=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D1790899</a></s=
pan><br><span></span><br><span>My approach is much more fine grained than j=
ust disable everything approach that we have for q35. For i440fx we can do =
better than that</span><br></div></blockquote><div><br></div></div><div><di=
v>By the way, here&#39;s another glaring feature disparity between i440fx a=
nd q35 which we perhaps did not debate with as much fervour and push back a=
s we debated here. When we implemented per slot hotplug disable for PCIE, w=
e ignored to implement the same per slot capability for conventional PCI. W=
hy was feature disparity across two machine types wasn&#39;t so much of an =
issue then?=C2=A0</div><blockquote type=3D"cite"><div dir=3D"ltr"><span></s=
pan><br><blockquote type=3D"cite"><span></span><br></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></=
span><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></block=
quote></blockquote></blockquote></div></blockquote></div><div><div dir=3D"a=
uto"><blockquote type=3D"cite"><div dir=3D"ltr"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span></span><br></blockquote></blockquote></blockquote></blockquote><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>-- </span><br></bl=
ockquote></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>MST</span><br></blockquote><=
/blockquote></blockquote></blockquote></blockquote><span></span><br></div><=
/blockquote></div></div>

--000000000000fb636a05a4852bb8--

