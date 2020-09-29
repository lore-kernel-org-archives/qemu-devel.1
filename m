Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F367BC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4274D20848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmEDq4q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4274D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGKU-0006bt-26
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mshivam2196@gmail.com>)
 id 1kNCkn-0001q5-VP; Tue, 29 Sep 2020 06:21:01 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:38539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mshivam2196@gmail.com>)
 id 1kNCkk-0004hb-44; Tue, 29 Sep 2020 06:21:00 -0400
Received: by mail-il1-x141.google.com with SMTP id z5so4309493ilq.5;
 Tue, 29 Sep 2020 03:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=SyOahntcd+v0WDcpNph02CspFUNkXunqNDmD2DNoLj8=;
 b=mmEDq4q8yg6W6MWWMa2Od0dZ7ETqfbp6OqA4VTLe8pyyDBgvAEPbMLbV//esK161Eg
 FWq5C9VqqgZvAKNDhD/EyUirm5hlo01/6OXAVi3MJulrQQPmkIq7s+uB3yUOvs7HjZoY
 GTnua8FELa4LLMTlxHntz+WbqPksrcuWQskmICYd8LhP0sz5DMdxMczaXjda3xFReXEP
 TG5WNkJVo5V0fId0y7si8D5uTqI+Lj+zNn0etFcuHfe6hiATf8rIcAODqqXudVP81pqW
 XVYcI7nCSncGqb4a8l9J4V3Kl6pBKwA9i2DvT77O2aLj/Yzatwa6HTE+Crd+CglPEdaT
 7GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=SyOahntcd+v0WDcpNph02CspFUNkXunqNDmD2DNoLj8=;
 b=rcGgE/N6Q9XhwWG4lVY3RrV4SehXCG8yS07NKd1eM6mOW8Axv+8MeUgbGpzg4YiAW6
 Iw4/BcbGwlhzINbdAeumPfQ7nkSc8NTT0CldrjJKdGkmHafPOPBRhqoOsNHf3T/4OLwa
 8U5Bo5ilAANdi2jD3fJaoo5DOY8J1bO1BZpIMWv6qtQicQFSRqQisfLXcT5k7KMdkDLN
 ofLW2+bLAOyeghgCpbIhFnw2xGHVnP4NY/Qljd+u1JVxsgQwBq2BxlTcp7m9W0IvM0ai
 hssCZSR3mh9561+10krCKw2yf6uh0AdfFlEW2lJuKqj+54jBCURPoaYQmNAVdIfeTrIs
 Hsfw==
X-Gm-Message-State: AOAM532NE/dILS3mSvtqFPywnWLOo1p2/NgTlD/7DW8XE4V3cpbCpjFP
 27A9LjaTVGx6iRojVrZktBD7b7Gn1tSIvKd/c/H0vKgK8xcIDg==
X-Google-Smtp-Source: ABdhPJzo2WDxRAMHvi4QfRXlr6uzK3bUw2giGOiVctffIbreT9jWZNs/eahPejNIGBdYK+JrY3Cs0uNzoN/r9gUJkbg=
X-Received: by 2002:a05:6e02:f48:: with SMTP id
 y8mr2432429ilj.103.1601374854342; 
 Tue, 29 Sep 2020 03:20:54 -0700 (PDT)
MIME-Version: 1.0
From: Shivam Mehra <mshivam2196@gmail.com>
Date: Tue, 29 Sep 2020 15:50:43 +0530
Message-ID: <CANp2S668GWL6r8uLmRpLtD-3qMxqGbuRa3ghwsTJkDUSmGZQ6Q@mail.gmail.com>
Subject: Network I/O Buffering
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000586e3805b07123b6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=mshivam2196@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 HTML_OBFUSCATE_05_10=0.26, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 29 Sep 2020 10:08:35 -0400
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

--000000000000586e3805b07123b6
Content-Type: text/plain; charset="UTF-8"

I came across this documentation with source code for providing network
buffering to applications
https://www.infradead.org/~tgr/libnl/doc/api/route_2qdisc_2plug_8c_source.html.
This network-buffering helps output-commit problem when providing fault
tolerance to virtual machines. The output is buffered until an
acknowledgement arrives from the backup VM and then released to the
external world. So that backup and primary VMs seem consistent externally.
Initially developed for XEN VMM to provide fault tolerance to VMs and I
think it's now available for QEMU too.

Where does the script reside which does network-buffering for checkpoints?
and what are the commands to make this happen?

I want to do this network-buffering for packets originating from an
application. Is it possible to do it in the same way as above? Does it do
any damage to the host kernel? Can I get  a simple working example for this?

--000000000000586e3805b07123b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"margin-top:0px;margin-right:0px;margin-left:0p=
x;padding:0px;border:0px;font-variant-numeric:inherit;font-variant-east-asi=
an:inherit;font-stretch:inherit;line-height:inherit;font-family:Arial,&quot=
;Helvetica Neue&quot;,Helvetica,sans-serif;font-size:15px;vertical-align:ba=
seline;box-sizing:inherit;clear:both;color:rgb(36,39,41)">I came across thi=
s documentation with source code for providing network buffering to applica=
tions=C2=A0<a href=3D"https://www.infradead.org/~tgr/libnl/doc/api/route_2q=
disc_2plug_8c_source.html" rel=3D"nofollow noreferrer" style=3D"margin:0px;=
padding:0px;border:0px;font-style:inherit;font-variant:inherit;font-weight:=
inherit;font-stretch:inherit;line-height:inherit;font-family:inherit;vertic=
al-align:baseline;box-sizing:inherit">https://www.infradead.org/~tgr/libnl/=
doc/api/route_2qdisc_2plug_8c_source.html</a>. This network-buffering helps=
 output-commit problem when providing fault tolerance to virtual machines. =
The output is buffered until an acknowledgement arrives from the backup VM =
and then released to the external world. So that backup and primary VMs see=
m consistent externally. Initially developed for XEN VMM to provide fault t=
olerance to VMs and I think it&#39;s now available for=C2=A0<code style=3D"=
margin:0px;padding:2px 4px;border:0px;font-style:inherit;font-variant:inher=
it;font-weight:inherit;font-stretch:inherit;line-height:inherit;font-family=
:Consolas,Menlo,Monaco,&quot;Lucida Console&quot;,&quot;Liberation Mono&quo=
t;,&quot;DejaVu Sans Mono&quot;,&quot;Bitstream Vera Sans Mono&quot;,&quot;=
Courier New&quot;,monospace,sans-serif;font-size:13px;vertical-align:baseli=
ne;box-sizing:inherit;white-space:pre-wrap;border-radius:3px">QEMU</code>=
=C2=A0too.</p><p style=3D"margin-top:0px;margin-right:0px;margin-left:0px;p=
adding:0px;border:0px;font-variant-numeric:inherit;font-variant-east-asian:=
inherit;font-stretch:inherit;line-height:inherit;font-family:Arial,&quot;He=
lvetica Neue&quot;,Helvetica,sans-serif;font-size:15px;vertical-align:basel=
ine;box-sizing:inherit;clear:both;color:rgb(36,39,41)">Where does the scrip=
t reside which does network-buffering for checkpoints? and what are the com=
mands to make this happen?</p><p style=3D"margin-top:0px;margin-right:0px;m=
argin-left:0px;padding:0px;border:0px;font-variant-numeric:inherit;font-var=
iant-east-asian:inherit;font-stretch:inherit;line-height:inherit;font-famil=
y:Arial,&quot;Helvetica Neue&quot;,Helvetica,sans-serif;font-size:15px;vert=
ical-align:baseline;box-sizing:inherit;clear:both;color:rgb(36,39,41)">I wa=
nt to do this network-buffering for=C2=A0packets originating=C2=A0from an a=
pplication. Is it possible to do it in the same way as above? Does it do an=
y damage to the host kernel? Can I get=C2=A0 a simple working example for t=
his?</p></div>

--000000000000586e3805b07123b6--

