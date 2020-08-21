Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFE7C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF3920791
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au5dMfJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF3920791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Dk7-0004Bv-Q0
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 16:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.j.carter@gmail.com>)
 id 1k9DUP-0007wT-9b
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 16:18:17 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a]:46494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.j.carter@gmail.com>)
 id 1k9DUN-0005qm-CD
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 16:18:16 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id j10so1183879qvo.13
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 13:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ghHq/gN6HsAxHxp8Jxfh3H2YZBwkc0Pdir4IW4kIrZ4=;
 b=Au5dMfJSOign/wgp4D2Sy6AmfRUYWO0xZzhYPp/QK9IIT6yZ+zW4P4YVxlMa041g/L
 6Kx+Gpumi+pcBSedV/gEAxVila9kHcIhNw6qg76JphTyK7TbgbCo68fWYBxc/0OpPgIT
 ve2/0cAeWIxwaQPCK1PxxwnYfIik9lQbUdFeR7AYOloPkgHVFKAN6JWxgoy7qcPQfVWx
 iI3Dx2+Jj5/KV2+yQoRBY+aHkHASUqc/r8xvRPaXYF1amLKFbOiDityVTp4/kqNwZcxf
 LrO9QyQ1r6RY4toQypNx06estlkflxRuz+mIfyb/RQ6pjwbVK1DWdXltVxTE2PwwHmwz
 RVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ghHq/gN6HsAxHxp8Jxfh3H2YZBwkc0Pdir4IW4kIrZ4=;
 b=EhNVGuLn6+Dn9Sr9+gipRVJ+oY2pLJVyWmJNG3PCysBCiaYH4Wjvz4Bmw3+IVVCvD1
 ZonuZBAGFgbALtq9VAX3W4wjjPKh4OSmfUijjFBRBQLL1epBzxWIqtoWXh651kBWSMlf
 nc1swwF3omARAsMGxcuDceyI4hYchQiXBJw4wR5EaVmOjOthZJ5BQ8y1AJvOLn1RLdxk
 bFs4/tf9fCmpUIzAUIXmWiSr5d0KY0v9wMhc8cApTdm7l5ttAbJ4+rS0aViicEGpX9pa
 XlkyuiBzo3gxicnUCk1CGL8ulH+li0uFXOrnNbUqu87RNg4Y0gcy3MX6aYbGbNSkyMzn
 z9jg==
X-Gm-Message-State: AOAM531Tk5EeeCakBakrH0lUAgDl8pVBr8g4zxXY+UsX7ScIRSQSQPnf
 lZ6RNipIUWY6T/KoR/Odrjm6Pu83wMJHPRK7zdM=
X-Google-Smtp-Source: ABdhPJzV4r2fZTyLhm42ZLBpZUCqhxnKUKodqMegyD/SQKhCPE+1EN42602rN8rc5QC5P5JEaCQDoZtmofrfvH3oNE8=
X-Received: by 2002:a05:6214:108a:: with SMTP id
 o10mr4047491qvr.239.1598041093913; 
 Fri, 21 Aug 2020 13:18:13 -0700 (PDT)
MIME-Version: 1.0
From: Alex Carter <alex.j.carter@gmail.com>
Date: Fri, 21 Aug 2020 16:18:03 -0400
Message-ID: <CAB12sgLhsgu282Ye=m2pjhdq7BE-zy2LHEdfxuxDdDLEas5+Gg@mail.gmail.com>
Subject: Re: Why QEMU should move from C to Rust (clickbait alert ;))
To: stefanha@gmail.com
Content-Type: multipart/alternative; boundary="000000000000bd40b905ad68ef5b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=alex.j.carter@gmail.com; helo=mail-qv1-xf2a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Aug 2020 16:33:43 -0400
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alexander <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dave Gilbert <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bd40b905ad68ef5b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

My name is Alex, I=E2=80=99m a student at the University of Michigan and I =
just
completed an internship at IBM Research. There, I have been working on a
project very related to this topic. I tested using Cloud Hypervisor=E2=80=
=99s
Rust-based vhost-user virtiofs and block devices with QEMU. Bigger picture,
I wanted to explore the implications of using Rust for vhost-user devices
in QEMU.



I agree with the points from the original post, namely:

=C2=B7      C programming bugs are responsible for a large number of CVEs, =
and
specifically CVEs coming from the implementations of virtual devices.

=C2=B7      As a programming language, Rust has matured to a point where it=
 is
worth considering it more seriously for production use. It has extensive
libraries and community support. Many big players in the industry are
already using Rust for production workloads.



Full Transparency: the Drawbacks:

It would be deceptive to only showcase Rust in an ideal light.

=C2=B7      The benchmarks I ran show a noticeable performance hit from
switching to a RustVMM implementation of a virtiofsd device.

=C2=B7      While Rust has matured greatly, it still is missing a bit. One
example of this that came up was that the rust compiler does not have
Control Flow Integrity (CFI) features. While these are not as important as
in =E2=80=9Cunsafe=E2=80=9D languages such as C, the ability to express uns=
afe portions of
code does allow for some types of memory bugs =E2=80=93 although to a much =
lesser
extent (an interesting case of this surfaced from Firecracker, and the
handling of mmio [1]). So further protections such as Control Flow
Integrity can still be desirable, even with rust code.

=C2=B7      There have been years of optimization work put into the C
implementations of these devices, and it=E2=80=99s hard to evaluate how opt=
imized
the relatively novel rust implementations are.

A piece of exciting news is that many of these drawbacks show a pathway for
future improvement. Improvements to rust infrastructure are very realistic.
Rust boils down to LLVM just like C, so porting over C=E2=80=99s CFI featur=
es
should be feasible. If more development resources are put into the RustVMM
project, there is no reason their implementations can=E2=80=99t be as optim=
ized as
the C versions, and this could be greatly aided by expertise coming from
the QEMU communities familiarity with these topics.



I believe vhost-user devices are an excellent place to start since It
lowers the entry barrier for developing in Rust. The device only has to
interface with the C-based QEMU binary through a standardized protocol. It
removes many worries of moving entirely away from C, since adding a set of
Rust devices would simply be giving more options and room to explore.



I am putting together the scripts I used for all of the tests at this repo:

https://github.com/Alex-Carter01/Qemu-Rust-Testing

I am working to standardize everything to make it easier to replicate. I
would love any community involvement if people wanted to see how results
differ based on the hardware setup, build configuration of the devices etc.

The repo also has links to a recording of my original presentation and the
slides I was using if you would like to look at that format or see the
discussion which came out of it.

--000000000000bd40b905ad68ef5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><p class=3D"MsoNormal" style=3D"font-size=
:medium;color:rgb(0,0,0);margin:0in;font-family:Calibri,sans-serif">Hi ever=
yone,<span></span></p><p class=3D"MsoNormal" style=3D"font-size:medium;colo=
r:rgb(0,0,0);margin:0in;font-family:Calibri,sans-serif">My name is Alex, I=
=E2=80=99m a student at the University of Michigan and I just completed an =
internship at IBM Research. There, I have been working on a project very re=
lated to this topic. I tested using Cloud Hypervisor=E2=80=99s Rust-based v=
host-user virtiofs and block devices with QEMU. Bigger picture, I wanted to=
 explore the implications of using Rust for vhost-user devices in QEMU.=C2=
=A0<span></span></p><p class=3D"MsoNormal" style=3D"font-size:medium;color:=
rgb(0,0,0);margin:0in;font-family:Calibri,sans-serif"><span>=C2=A0</span></=
p><p class=3D"MsoNormal" style=3D"font-size:medium;color:rgb(0,0,0);margin:=
0in;font-family:Calibri,sans-serif">I agree with the points from the origin=
al post, namely:<span></span></p><p class=3D"gmail-MsoListParagraphCxSpFirs=
t" style=3D"margin:0in 0in 0in 0.5in;font-size:12pt;font-family:Calibri,san=
s-serif"><span style=3D"font-family:Symbol">=C2=B7<span style=3D"font-stret=
ch:normal;font-size:7pt;line-height:normal;font-family:&quot;Times New Roma=
n&quot;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span></span>C programming bu=
gs are responsible for a large number of CVEs, and specifically CVEs coming=
 from the implementations of virtual devices.=C2=A0<span></span></p><p clas=
s=3D"gmail-MsoListParagraphCxSpMiddle" style=3D"margin:0in 0in 0in 0.5in;fo=
nt-size:12pt;font-family:Calibri,sans-serif"><span style=3D"font-family:Sym=
bol">=C2=B7<span style=3D"font-stretch:normal;font-size:7pt;line-height:nor=
mal;font-family:&quot;Times New Roman&quot;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0</span></span>As a programming language, Rust has matured to a point =
where it is worth considering it more seriously for production use. It has =
extensive libraries and community support. Many big players in the industry=
 are already using Rust for production workloads.<span></span></p><p class=
=3D"gmail-MsoListParagraphCxSpMiddle" style=3D"margin:0in;font-size:medium;=
color:rgb(0,0,0);font-family:Calibri,sans-serif"><span>=C2=A0</span></p><p =
class=3D"gmail-MsoListParagraphCxSpMiddle" style=3D"margin:0in;font-size:me=
dium;color:rgb(0,0,0);font-family:Calibri,sans-serif">Full Transparency: th=
e Drawbacks:<span></span></p><p class=3D"gmail-MsoListParagraphCxSpMiddle" =
style=3D"margin:0in;font-size:medium;color:rgb(0,0,0);font-family:Calibri,s=
ans-serif">It would be deceptive to only showcase Rust in an ideal light.=
=C2=A0<span></span></p><p class=3D"gmail-MsoListParagraphCxSpMiddle" style=
=3D"margin:0in 0in 0in 0.5in;font-size:12pt;font-family:Calibri,sans-serif"=
><span style=3D"font-family:Symbol">=C2=B7<span style=3D"font-stretch:norma=
l;font-size:7pt;line-height:normal;font-family:&quot;Times New Roman&quot;"=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span></span>The benchmarks I ran sho=
w a noticeable performance hit from switching to a RustVMM implementation o=
f a virtiofsd device.=C2=A0<span></span></p><p class=3D"gmail-MsoListParagr=
aphCxSpMiddle" style=3D"margin:0in 0in 0in 0.5in;font-size:12pt;font-family=
:Calibri,sans-serif"><span style=3D"font-family:Symbol">=C2=B7<span style=
=3D"font-stretch:normal;font-size:7pt;line-height:normal;font-family:&quot;=
Times New Roman&quot;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span></span>Wh=
ile Rust has matured greatly, it still is missing a bit. One example of thi=
s that came up was that the rust compiler does not have Control Flow Integr=
ity (CFI) features. While these are not as important as in =E2=80=9Cunsafe=
=E2=80=9D languages such as C, the ability to express unsafe portions of co=
de does allow for some types of memory bugs =E2=80=93 although to a much le=
sser extent (an interesting case of this surfaced from Firecracker, and the=
 handling of mmio [1]). So further protections such as Control Flow Integri=
ty can still be desirable, even with rust code.<span></span></p><p class=3D=
"gmail-MsoListParagraphCxSpLast" style=3D"margin:0in 0in 0in 0.5in;font-siz=
e:12pt;font-family:Calibri,sans-serif"><span style=3D"font-family:Symbol">=
=C2=B7<span style=3D"font-stretch:normal;font-size:7pt;line-height:normal;f=
ont-family:&quot;Times New Roman&quot;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0</span></span>There have been years of optimization work put into the C =
implementations of these devices, and it=E2=80=99s hard to evaluate how opt=
imized the relatively novel rust implementations are.<span></span></p><p cl=
ass=3D"MsoNormal" style=3D"font-size:medium;color:rgb(0,0,0);margin:0in;fon=
t-family:Calibri,sans-serif">A piece of exciting news is that many of these=
 drawbacks show a pathway for future improvement. Improvements to rust infr=
astructure are very realistic. Rust boils down to LLVM just like C, so port=
ing over C=E2=80=99s CFI features should be feasible. If more development r=
esources are put into the RustVMM project, there is no reason their impleme=
ntations can=E2=80=99t be as optimized as the C versions, and this could be=
 greatly aided by expertise coming from the QEMU communities familiarity wi=
th these topics.<span></span></p><p class=3D"MsoNormal" style=3D"font-size:=
medium;color:rgb(0,0,0);margin:0in;font-family:Calibri,sans-serif"><span>=
=C2=A0</span></p><p class=3D"MsoNormal" style=3D"font-size:medium;color:rgb=
(0,0,0);margin:0in;font-family:Calibri,sans-serif">I believe vhost-user dev=
ices are an excellent place to start since It lowers the entry barrier for =
developing in Rust. The device only has to interface with the C-based QEMU =
binary through a standardized protocol. It removes many worries of moving e=
ntirely away from C, since adding a set of Rust devices would simply be giv=
ing more options and room to explore.=C2=A0<span></span></p><p class=3D"Mso=
Normal" style=3D"font-size:medium;color:rgb(0,0,0);margin:0in;font-family:C=
alibri,sans-serif"><span>=C2=A0</span></p><p class=3D"MsoNormal" style=3D"f=
ont-size:medium;color:rgb(0,0,0);margin:0in;font-family:Calibri,sans-serif"=
>I am putting together the scripts I used for all of the tests at this repo=
:<span></span></p><p class=3D"MsoNormal" style=3D"font-size:medium;color:rg=
b(0,0,0);margin:0in;font-family:Calibri,sans-serif"><a href=3D"https://gith=
ub.com/Alex-Carter01/Qemu-Rust-Testing" style=3D"color:rgb(149,79,114);text=
-decoration:underline">https://github.com/Alex-Carter01/Qemu-Rust-Testing</=
a><span></span></p><p class=3D"MsoNormal" style=3D"font-size:medium;color:r=
gb(0,0,0);margin:0in;font-family:Calibri,sans-serif">I am working to standa=
rdize everything to make it easier to replicate. I would love any community=
 involvement if people wanted to see how results differ based on the hardwa=
re setup, build configuration of the devices etc.<span></span></p><p class=
=3D"MsoNormal" style=3D"font-size:medium;color:rgb(0,0,0);margin:0in;font-f=
amily:Calibri,sans-serif">The repo also has links to a recording of my orig=
inal presentation and the slides I was using if you would like to look at t=
hat format or see the discussion which came out of it.<span></span></p></di=
v></div>

--000000000000bd40b905ad68ef5b--

