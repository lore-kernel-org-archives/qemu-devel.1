Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	HTTPS_HTTP_MISMATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB44C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FD1206FC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8CtC/jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FD1206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNURe-0001Bd-QX
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 01:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mshivam2196@gmail.com>)
 id 1kNUQG-0000Gy-Oe; Wed, 30 Sep 2020 01:13:00 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:44772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mshivam2196@gmail.com>)
 id 1kNUQC-0003ZW-I3; Wed, 30 Sep 2020 01:13:00 -0400
Received: by mail-il1-x141.google.com with SMTP id c5so353244ilk.11;
 Tue, 29 Sep 2020 22:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=y7Gt9TNc6AcwSFnrB9UNPGht4bFuEWGWY8NT7crmRik=;
 b=F8CtC/jf3NbqozuBB5WmyKCobucHQ5SRyZMFjkibKZZV3gBzvQdq9VHfljjkF1Gvps
 t+winQSxsI8DIapVF91FUrxzhS53NbhFVnnnhmNfnM1XMqGlAqVlX9TD+qUR8ly5LBdU
 zlegbWlEDbg8kQWy0tTUrlHqOFjLGCBQK0ZwTC09DgpTUhOIB7FwrODy0zU4AFx5Ll8h
 +ezZwpPbE5+z5djf9CUvpElQYSlImdPb8RdF+X8ryN6GDxw64ogMjCk8sUFGnFzD1yqj
 n0dGPfPMEEpscuEngoafde/fu/ynWN9c5rLstMRmhRYijBK2HKXrrDjuUMMwdF1M+b35
 ArDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=y7Gt9TNc6AcwSFnrB9UNPGht4bFuEWGWY8NT7crmRik=;
 b=Jjigzbzw6quWMsO+vOZ+L6Bw+JqjWvVhx4U4Ba7stq5cvpIju9iXuNS8uAauKm1KXc
 W9vR7sZwZgr0jwDUw/OtPtDObpNiQ0G5qWq2IqiBgGCgslhQaoWn8K+fjOXvUA5GrmA4
 aJ1EXhgGeRtSEUTzfXqhx+tmL69Uy6Nme+ZIWXvRijbPz2EqGHQIjSR/2jVkU/nBAqWM
 rAH8hjI52/E+FTNc8nJLQDPo/i5PYjwvF0U1XPkQO9p+KDky52K1Sh28xtZ2jeRvKM32
 TODLOTLbgPZ6YesV6QAuo/s63S7xzUjqhMOABb4c568sBTMhQLAWgcZrqvds/7MGWdYc
 y2fg==
X-Gm-Message-State: AOAM532JlESKwWJmQHi3T+TZoKJmnrTUaZnAyzyoqezDhxbemIsXqmLS
 EWK1TD2GhUoCcJj6sAYH4Yyt5nH/wzlNaoGgqSpDJT6qaZumOw==
X-Google-Smtp-Source: ABdhPJylARHoaX6AQaTLKqsNTtoJSjqpi/laSGN34GEF+nh6X6van7PzP8IO1CThM8tUyBTNJBi1gYZcD2MsZj68vBo=
X-Received: by 2002:a05:6e02:f48:: with SMTP id
 y8mr644535ilj.103.1601442774865; 
 Tue, 29 Sep 2020 22:12:54 -0700 (PDT)
MIME-Version: 1.0
From: Shivam Mehra <mshivam2196@gmail.com>
Date: Wed, 30 Sep 2020 10:42:43 +0530
Message-ID: <CANp2S64q_MEp6MWuYvt2iNFq4kKZQ+3xOhVhbQ0AqD9CrQqcSQ@mail.gmail.com>
Subject: network buffering in fault tolerance
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b95ae105b080f321"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=mshivam2196@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 HTML_OBFUSCATE_05_10=0.26, HTTPS_HTTP_MISMATCH=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b95ae105b080f321
Content-Type: text/plain; charset="UTF-8"

I came across this documentation with source code for providing network
buffering to applications
https://www.nfradead.org/~tgr/libnl/doc/api/route_2qdisc_2plug_8c_source.html
<https://www.infradead.org/~tgr/libnl/doc/api/route_2qdisc_2plug_8c_source.html>.
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

--000000000000b95ae105b080f321
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"margin-top:0px;margin-right:0px;margin-left:0p=
x;padding:0px;border:0px;font-variant-numeric:inherit;font-variant-east-asi=
an:inherit;font-stretch:inherit;line-height:inherit;font-family:Arial,&quot=
;Helvetica Neue&quot;,Helvetica,sans-serif;font-size:15px;vertical-align:ba=
seline;box-sizing:inherit;clear:both;color:rgb(36,39,41)">I came across thi=
s documentation with source code for providing network buffering to applica=
tions=C2=A0<a href=3D"https://www.infradead.org/~tgr/libnl/doc/api/route_2q=
disc_2plug_8c_source.html" rel=3D"nofollow noreferrer" target=3D"_blank" st=
yle=3D"margin:0px;padding:0px;border:0px;font-style:inherit;font-variant:in=
herit;font-weight:inherit;font-stretch:inherit;line-height:inherit;font-fam=
ily:inherit;vertical-align:baseline;box-sizing:inherit">https://www.nfradea=
d.org/~tgr/libnl/doc/api/route_2qdisc_2plug_8c_source.html</a>. This networ=
k-buffering helps output-commit problem when providing fault tolerance to v=
irtual machines. The output is buffered until an acknowledgement arrives fr=
om the backup VM and then released to the external world. So that backup an=
d primary VMs seem consistent externally. Initially developed for XEN VMM t=
o provide fault tolerance to VMs and I think it&#39;s now available for=C2=
=A0<code style=3D"margin:0px;padding:2px 4px;border:0px;font-style:inherit;=
font-variant:inherit;font-weight:inherit;font-stretch:inherit;line-height:i=
nherit;font-family:Consolas,Menlo,Monaco,&quot;Lucida Console&quot;,&quot;L=
iberation Mono&quot;,&quot;DejaVu Sans Mono&quot;,&quot;Bitstream Vera Sans=
 Mono&quot;,&quot;Courier New&quot;,monospace,sans-serif;font-size:13px;ver=
tical-align:baseline;box-sizing:inherit;white-space:pre-wrap;border-radius:=
3px">QEMU</code>=C2=A0too.</p><p style=3D"margin-top:0px;margin-right:0px;m=
argin-left:0px;padding:0px;border:0px;font-variant-numeric:inherit;font-var=
iant-east-asian:inherit;font-stretch:inherit;line-height:inherit;font-famil=
y:Arial,&quot;Helvetica Neue&quot;,Helvetica,sans-serif;font-size:15px;vert=
ical-align:baseline;box-sizing:inherit;clear:both;color:rgb(36,39,41)">Wher=
e does the script reside which does network-buffering for checkpoints? and =
what are the commands to make this happen?</p><p style=3D"margin-top:0px;ma=
rgin-right:0px;margin-left:0px;padding:0px;border:0px;font-variant-numeric:=
inherit;font-variant-east-asian:inherit;font-stretch:inherit;line-height:in=
herit;font-family:Arial,&quot;Helvetica Neue&quot;,Helvetica,sans-serif;fon=
t-size:15px;vertical-align:baseline;box-sizing:inherit;clear:both;color:rgb=
(36,39,41)">I want to do this network-buffering for=C2=A0packets originatin=
g=C2=A0from an application. Is it possible to do it in the same way as abov=
e? Does it do any damage to the host kernel? Can I get=C2=A0 a simple worki=
ng example for this?</p></div>

--000000000000b95ae105b080f321--

