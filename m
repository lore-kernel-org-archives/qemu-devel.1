Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26BBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E70E2068F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="ZOQbDx9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E70E2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vayavyalabs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxTVd-0002du-Uz
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 06:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1jxTUu-0002EE-JJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:58:16 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:46986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1jxTUs-0007sk-VG
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:58:16 -0400
Received: by mail-wr1-x433.google.com with SMTP id r12so17281271wrj.13
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vayavyalabs.com; s=vayavyalabs;
 h=mime-version:from:date:message-id:subject:to;
 bh=PkMyWrgDfAorxYZfV3EdOhdoB9F+/SdmpCjZTo7Ev48=;
 b=ZOQbDx9FbdpuYtj0tlodMrtz7Sg+BUJFcBxJaa84FRapskktltX64DBUDMxUluSU1I
 EpNucD0+ku/9hagRSawckz3UalNTyFP91p5xLEF1QhaF36jIPmTcNAwYsfg7V9/mP9Bz
 Zh7L/oiuTHA0aISw//UNBDGHX1TppAUJcHNKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=PkMyWrgDfAorxYZfV3EdOhdoB9F+/SdmpCjZTo7Ev48=;
 b=kybHXZO6h5b+05h2GALkfbBuvX2prhYaATemx7W7QASLrLbYvN59VchCVbMmz8rBhF
 PNGtE1r4c9Sa8bPdTMmOE2XchkjCuC8o96lSIFMYWCYxN2QW8FLb++L7hgZR55d5hjAD
 HT56ji2vjbJEHiaZzSbfp5X9ILd61eGPBnwZrRsm5FKFUGLTX4OMmqZj82u1W+vfmMiE
 U8Vtx426wxLsJFl2/Qxliu6X9J+dhEip3oHiUA0lsfz/4eb1AYuk64Yp7hjpr3sqS6VA
 DixnQTawzrcgCF0DYRvU+1NIYOk3T7wlI3DZzFYZC7B78m0wOuoNj7GGbBiJ0uI3zqRP
 6fHg==
X-Gm-Message-State: AOAM531624rYYVGtxDj7qY4+mLGVD5EWepqy0v073wEhInF8LOlgJwT1
 +WNnyGjl2LgNf0rtpkkqSPuqM6pWwYKfHH8cRIFRqCylRSo=
X-Google-Smtp-Source: ABdhPJwW7vbGnCbfrLEsDMzeH8nG6nKF1IwyNK5+11taYmfU5fLztfYNwrJWlUqiy4gM8/KC1R13mzlJYrnG7UWUeIo=
X-Received: by 2002:a5d:4bc8:: with SMTP id l8mr21225148wrt.159.1595242692340; 
 Mon, 20 Jul 2020 03:58:12 -0700 (PDT)
MIME-Version: 1.0
From: Pratik Parvati <pratikp@vayavyalabs.com>
Date: Mon, 20 Jul 2020 16:28:01 +0530
Message-ID: <CA+aXn+EE2s55Y9gKUpckW_skw5sgonniPuEOFTjC+i1-dcWQyw@mail.gmail.com>
Subject: VMState in QEMU
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000001fe9605aadd62f9"
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=pratikp@vayavyalabs.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000001fe9605aadd62f9
Content-Type: text/plain; charset="UTF-8"

Hi team,

Can someone please explain to me briefly the significance of VMState in
Migration. I understand that this reduces the lot of duplication of code
across all the devices in QEMU with the common put and get implementation
somewhere in the code. Does this have any other significance?

Is it mandatory to define the state of each device? Like, for example, I am
referring hw/arm/versatilepb.c; I see the VMState is defined for sic
(secondary interrupt controller) Whereas VMState is not defined for PL011
UART device. How do I know which device should be considered for VMState?

Below snippet is used as a reference

typedef struct vpb_sic_state {
    SysBusDevice parent_obj;

    MemoryRegion iomem;
    uint32_t level;
    uint32_t mask;
    uint32_t pic_enable;
    qemu_irq parent[32];
    int irq;
} vpb_sic_state;
static const VMStateDescription vmstate_vpb_sic = {
    .name = "versatilepb_sic",
    .version_id = 1,
    .minimum_version_id = 1,
    .fields = (VMStateField[]) {
        VMSTATE_UINT32(level, vpb_sic_state),
        VMSTATE_UINT32(mask, vpb_sic_state),
        VMSTATE_UINT32(pic_enable, vpb_sic_state),
        VMSTATE_END_OF_LIST()
    }
};

From the above code, it is definite that VMState is implemented as per the
device (I mean, there is no common structure for defining a VMState of the
device). From the migration point of view, how does this declaration help?

Thanks for your continuous support

Regards,

Pratik

--00000000000001fe9605aadd62f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"markdown-here-wrapper" style=3D""><p style=
=3D"margin:0px 0px 1.2em!important">Hi team,</p>
<p style=3D"margin:0px 0px 1.2em!important">Can someone please explain to m=
e briefly the significance of VMState in Migration. I understand that this =
reduces the lot of duplication of code across all the devices in QEMU with =
the common put and get implementation somewhere in the code. Does this have=
 any other significance?</p>
<p style=3D"margin:0px 0px 1.2em!important">Is it mandatory to define the s=
tate of each device? Like, for example, I am referring hw/arm/versatilepb.c=
; I see the VMState is defined for sic (secondary interrupt controller) Whe=
reas VMState is not defined for PL011 UART device. How do I know which devi=
ce should be considered for VMState?</p>
<p style=3D"margin:0px 0px 1.2em!important">Below snippet is used as a refe=
rence</p>
<pre style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Courier,mon=
ospace;font-size:1em;line-height:1.2em;margin:1.2em 0px"><code class=3D"hlj=
s language-C" style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Co=
urier,monospace;margin:0px 0.15em;padding:0px 0.3em;white-space:pre-wrap;bo=
rder:1px solid rgb(234,234,234);background-color:rgb(248,248,248);border-ra=
dius:3px;display:inline;white-space:pre;overflow:auto;border-radius:3px;bor=
der:1px solid rgb(204,204,204);padding:0.5em 0.7em;display:block!important;=
display:block;overflow-x:auto;padding:0.5em;color:rgb(51,51,51);background:=
rgb(248,248,248)"><span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51)=
;font-weight:bold">typedef</span> <span class=3D"hljs-keyword" style=3D"col=
or:rgb(51,51,51);font-weight:bold">struct</span> vpb_sic_state {
    SysBusDevice parent_obj;

    MemoryRegion iomem;
    uint32_t level;
    uint32_t mask;
    uint32_t pic_enable;
    qemu_irq parent[<span class=3D"hljs-number" style=3D"color:rgb(0,128,12=
8)">32</span>];
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">int</span> irq;
} vpb_sic_state;

<span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:bold"=
>static</span> <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);fo=
nt-weight:bold">const</span> VMStateDescription vmstate_vpb_sic =3D {
    .name =3D <span class=3D"hljs-string" style=3D"color:rgb(221,17,68)">&q=
uot;versatilepb_sic&quot;</span>,
    .version_id =3D <span class=3D"hljs-number" style=3D"color:rgb(0,128,12=
8)">1</span>,
    .minimum_version_id =3D <span class=3D"hljs-number" style=3D"color:rgb(=
0,128,128)">1</span>,
    .fields =3D (VMStateField[]) {
        VMSTATE_UINT32(level, vpb_sic_state),
        VMSTATE_UINT32(mask, vpb_sic_state),
        VMSTATE_UINT32(pic_enable, vpb_sic_state),
        VMSTATE_END_OF_LIST()
    }
};
</code></pre>
<p style=3D"margin:0px 0px 1.2em!important">From the above code, it is defi=
nite that VMState is implemented as per the device (I mean, there is no com=
mon structure for defining a VMState of the device). From the migration poi=
nt of view, how does this declaration help?</p>
<p style=3D"margin:0px 0px 1.2em!important">Thanks for your continuous supp=
ort</p>
<p style=3D"margin:0px 0px 1.2em!important">Regards,</p><p style=3D"margin:=
0px 0px 1.2em!important">Pratik</p>
<div title=3D"MDH:SGkgdGVhbSw8ZGl2Pjxicj48L2Rpdj48ZGl2PkNhbiBzb21lb25lIHBsZ=
WFzZSBleHBsYWluIGJy
aWVmbHkgdGhlIHNpZ25pZmljYW5jZSBvZiBWTVN0YXRlIGluIE1pZ3JhdGlvbi4gSSB1bmRlcnN=
0
YW5kIHRoYXQgdGhpcyByZWR1Y2VzIHRoZSBsb3Qgb2YgZHVwbGljYXRpb24gb2YgY29kZSBhY3J=
v
c3MgYWxsIHRoZSBkZXZpY2VzIGluIFFFTVUgd2l0aCB0aGUgY29tbW9uIHB1dCBhbmQgZ2V0IGl=
t
cGxlbWVudGF0aW9uJm5ic3A7c29tZXdoZXJlIGluIHRoZSBjb2RlLiBEb2VzIHRoaXMgaGF2ZSB=
h
bnkgb3RoZXIgc2lnbmlmaWNhbmNlPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXMgaXQgbWF=
u
ZGF0b3J5IHRvIGRlZmluZSB0aGUgc3RhdGUgb2YgZWFjaCBkZXZpY2U/IExpa2UsIGZvciBleGF=
t
cGxlLCBJIGFtIDxzcGFuIHpldW00YzE9IjE1OTUyNDIyMzI5MzciIGRhdGEtZGRud2FiPSIxNTk=
1
MjQyMjMyOTM3IiBjbGFzcz0ibmciIGRhdGEtd3BrZ3Y9InRydWUiPnJlZmVycmluZzwvc3Bhbj4=
m
bmJzcDs8aT5ody9hcm0vdmVyc2F0aWxlcGIuYzwvaT47IEkgc2VlIHRoZSBWTVN0YXRlIGlzIGR=
l
ZmluZWQgZm9yIHNpYyAoc2Vjb25kYXJ5IGludGVycnVwdCBjb250cm9sbGVyKSBXaGVyZWFzIFZ=
N
U3RhdGUgaXMgbm90IGRlZmluZWQgZm9yIFBMMDExIFVBUlQgZGV2aWNlLiBIb3cgZG8gSSBrbm9=
3
IHdoaWNoIGRldmljZSBzaG91bGQgYmUgaW5jbHVkZWQgdW5kZXIgVk1TdGF0ZT88L2Rpdj48ZGl=
2
Pjxicj48L2Rpdj48ZGl2PkJlbG93IHNuaXBwZXQgaXMgdXNlZCBhcyBhIHJlZmVyZW5jZTwvZGl=
2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+YGBgQzwvZGl2PjxkaXY+dHlwZWRlZiBzdHJ1Y3QgdnBiX3N=
p
Y19zdGF0ZSB7PGJyPiZuYnNwOyAmbmJzcDsgU3lzQnVzRGV2aWNlIHBhcmVudF9vYmo7PGJyPjx=
i
cj4mbmJzcDsgJm5ic3A7IE1lbW9yeVJlZ2lvbiBpb21lbTs8YnI+Jm5ic3A7ICZuYnNwOyB1aW5=
0
MzJfdCBsZXZlbDs8YnI+Jm5ic3A7ICZuYnNwOyB1aW50MzJfdCBtYXNrOzxicj4mbmJzcDsgJm5=
i
c3A7IHVpbnQzMl90IHBpY19lbmFibGU7PGJyPiZuYnNwOyAmbmJzcDsgcWVtdV9pcnEgcGFyZW5=
0
WzMyXTs8YnI+Jm5ic3A7ICZuYnNwOyBpbnQgaXJxOzxicj59IHZwYl9zaWNfc3RhdGU7PGJyPjx=
i
cj5zdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfdnBiX3NpYyA9IHs8YnI=
+
Jm5ic3A7ICZuYnNwOyAubmFtZSA9ICJ2ZXJzYXRpbGVwYl9zaWMiLDxicj4mbmJzcDsgJm5ic3A=
7
IC52ZXJzaW9uX2lkID0gMSw8YnI+Jm5ic3A7ICZuYnNwOyAubWluaW11bV92ZXJzaW9uX2lkID0=
g
MSw8YnI+Jm5ic3A7ICZuYnNwOyAuZmllbGRzID0gKFZNU3RhdGVGaWVsZFtdKSB7PGJyPiZuYnN=
w
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBWTVNUQVRFX1VJTlQzMihsZXZlbCwgdnBiX3NpY19zdGF=
0
ZSksPGJyPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBWTVNUQVRFX1VJTlQzMihtYXNrLCB=
2
cGJfc2ljX3N0YXRlKSw8YnI+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IFZNU1RBVEVfVUl=
O
VDMyKHBpY19lbmFibGUsIHZwYl9zaWNfc3RhdGUpLDxicj4mbmJzcDsgJm5ic3A7ICZuYnNwOyA=
m
bmJzcDsgVk1TVEFURV9FTkRfT0ZfTElTVCgpPGJyPiZuYnNwOyAmbmJzcDsgfTxicj59Ozxicj4=
8
L2Rpdj48ZGl2PmBgYDwvZGl2PjxkaXY+RnJvbSB0aGUgYWJvdmUgY29kZSwgaXQgaXMgZGVmaW5=
p
dGUgdGhhdCBWTVN0YXRlIGlzIGltcGxlbWVudGVkIGFzIHBlciB0aGUgZGV2aWNlIChJIG1lYW4=
s
IHRoZXJlIGlzIG5vIGNvbW1vbiBzdHJ1Y3R1cmUgZm9yIGRlZmluaW5nIGEgVk1TdGF0ZSBvZiB=
0
aGUgZGV2aWNlKS4gRnJvbSB0aGUgbWlncmF0aW9uIHBvaW50IG9mIHZpZXcsIGhvdyBkb2VzIHR=
o
aXMgZGVjbGFyYXRpb24gaGVscD88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcyBmb3I=
g
eW91ciBjb250aW51b3VzIHN1cHBvcnQ8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+PGR=
p
diBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSIgZGF0YS1zbWFydG1haWw9ImdtYWl=
s
X3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+UmVnYXJkcyw8ZGl2PlByYXRpazwvZGl2PjwvZGl=
2
PjwvZGl2PjwvZGl2PjwvZGl2Pg=3D=3D" style=3D"height:0;width:0;max-height:0;ma=
x-width:0;overflow:hidden;font-size:0em;padding:0;margin:0"></div></div></d=
iv>

--00000000000001fe9605aadd62f9--

