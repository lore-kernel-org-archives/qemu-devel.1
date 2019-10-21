Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF58CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 04:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1766214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 04:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfwARNjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1766214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMm8e-0006hG-3g
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 00:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1iMetH-0002Ac-GY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1iMetG-0002Fr-F9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:06:59 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131]:39015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>) id 1iMetG-0002DU-9n
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:06:58 -0400
Received: by mail-il1-x131.google.com with SMTP id i12so2878997ils.6
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=r86v/gryGeQHdP9bdkT7xHHHK0UVk8I1HqdlEEe/bGk=;
 b=sfwARNjW+6422jwzlez3bVItWOsBOQmac15N3C9nRm35aRcNTg6nVyxSDEZokdnMY/
 AzsGcafS8pyxF2YzC8yfofkYuRHE+O1bpayOOepIhzGodA52dC+hUjUzmqvwkvRCW8lS
 QdaSwmBPqg9yspmOos/Z4cDRziA4eqNBovja4vt+2/SZZBYALf+OHWMqmQafGso7L2JL
 ngPHd0z3EELbaVbx9SSWiATX6NlhnicTGntBrrhmdhbUO5DvbWlBhzno+vKVLITzWviH
 IIZKe8d4x57z1dYcxv0Sl+p47CismzWAzcbox91PdBpT71nW49B8rDq28mxvOl5HL/qY
 YXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=r86v/gryGeQHdP9bdkT7xHHHK0UVk8I1HqdlEEe/bGk=;
 b=YnAtI8jSKbIO1sctroG4N6V1sdZMASdU2ndyIPDaKq+N8oUPeOc06bhSribXqf3Op+
 cNc9QrpvbFYO58tLuNcVvGc+Ej8+s+ksiiteAB6xgmcSFViYqNFulc7Yp5CX6Hh6Y0T+
 wA+KEohCV75ukjHP+55YX9kPQKKrQ0GjIAEe342rDedkrjM9A5r5KKqwBPklCY8836lb
 FIq2FCPP7yJM2nHfoJdSke77uFBBxnvcubnHzff6zwQ5dRe3oWY7TNpW1AXcUeGWp7RA
 kzx/P+YA3hEvNcab6UUZBEFm+UBdawHuFQ+n/C46lmYfMagrj+qtnz/1YgJLX0cTb17g
 ALYA==
X-Gm-Message-State: APjAAAXEwh0IPbtOuAq7RjhVVwEFHpdskbilMaM+wYYMkeFP9JL6qfAB
 PjAOR2vC8hUZrp6SfyTCWuuhTcWArU96ohqRKKcmpypn
X-Google-Smtp-Source: APXvYqzTWGGaCpwQDQZfHyXLRDy0fWCCsFiEmTAVpyVphBZsIJLL+tMu8fYORWcqjZ9VjT2iLY9H9si3aVfdoVrvGGA=
X-Received: by 2002:a92:360b:: with SMTP id d11mr27584051ila.143.1571692014681; 
 Mon, 21 Oct 2019 14:06:54 -0700 (PDT)
MIME-Version: 1.0
From: Wayne Li <waynli329@gmail.com>
Date: Mon, 21 Oct 2019 16:06:43 -0500
Message-ID: <CAM2K0np63wni3G7GNWPxTq40Kb1VeTN7Ocn=E=BqSmd+pDsX9A@mail.gmail.com>
Subject: Missing PVR setting capability
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003b466d0595721080"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::131
X-Mailman-Approved-At: Tue, 22 Oct 2019 00:50:14 -0400
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

--0000000000003b466d0595721080
Content-Type: text/plain; charset="UTF-8"

Dear Qemu list members,

I'm attempting to enable KVM in a Qemu-based project that is running on a
T4240RDB board.  After compiling my code with the -enable-kvm option I ran
the qemu executable with the -enable-kvm option.  The application exited
with the following error message: "kvm error: missing PVR setting
capability."  What are some possibilities causing this error?

*Wayne Z. Li*
*The Boeing Company* | BT&E ESSI Midwest

Software Tools & Modeling | St. Louis

Cell: (801) 691-4098 * | *wayne.z.li@boeing.com <justin.l.jiang@boeing.com>

--0000000000003b466d0595721080
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Qemu list members,<div><br></div><div>I&#39;m attempt=
ing to enable KVM in a Qemu-based project that is running on a T4240RDB boa=
rd.=C2=A0 After compiling my code with the -enable-kvm option I ran the qem=
u executable with the -enable-kvm option.=C2=A0 The application exited with=
 the following error message: &quot;kvm error: missing PVR setting capabili=
ty.&quot;=C2=A0 What are some possibilities causing this error?</div><div><=
br></div><div><p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-=
size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:12pt;fon=
t-family:&quot;Palatino Linotype&quot;,serif"><font color=3D"#2f5496"><b>Wa=
yne Z. Li</b></font><br>
</span><b><span style=3D"font-size:9pt;font-family:Arial,sans-serif">The
Boeing Company</span></b><span style=3D"font-size:9pt;font-family:Arial,san=
s-serif">
| BT&amp;E ESSI Midwest </span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif"><span style=3D"font-size:9pt;font-family:Arial,=
sans-serif">Software
Tools &amp; Modeling | St. Louis</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif"><span style=3D"font-size:9pt;font-family:Arial,=
sans-serif">Cell:
(801) 691-4098=C2=A0<i>=C2=A0| </i><span style=3D"color:rgb(47,84,150)"><a =
href=3D"mailto:justin.l.jiang@boeing.com" style=3D"color:rgb(5,99,193)"><sp=
an style=3D"color:rgb(47,84,150)">wayne.z.li@boeing.com</span></a></span></=
span></p></div></div>

--0000000000003b466d0595721080--

