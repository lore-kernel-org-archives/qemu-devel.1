Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98AAC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CE8206E2
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ordju5te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CE8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRqB-00025g-Nc
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 13:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yashjain.1999@gmail.com>)
 id 1jfRlm-0008Iu-HC
 for qemu-devel@nongnu.org; Sun, 31 May 2020 13:29:10 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34]:37455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yashjain.1999@gmail.com>)
 id 1jfRll-0002Pv-Pq
 for qemu-devel@nongnu.org; Sun, 31 May 2020 13:29:10 -0400
Received: by mail-vs1-xe34.google.com with SMTP id g129so4338870vsc.4
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=WKAoehjadjOD90qHMpoBpeMJbPh5bJh7iWCvEsh3SIg=;
 b=Ordju5teCJukQg1R2qgQ/hCq7kBTghRsfvcQV/Kuz6Gx0/PUzh8UZ7I35qhmF4CMTT
 f+N01ot/n0iajLkNcLdDzRwLxJNM87vugDH3wjmGv15zzH8aI/ipeJBoNFWutaQfLUNh
 QIX/vWNtF0/+w7BwKfl5HKVYPwCl8UAv9thbRwLr8GEplhOQn02gnLePDqcN83VUbyfD
 vsw7WO4KHI31ymr5RirIZWrLh2tzWBN3EBd/ppIXGX1AErhuHyOp8TcB8V9FIXgp1Y7p
 XBIIZYwAZi7kZH+i3QUVZ6AqsKRH+KTa6asaP0t0STCdgDnwBg7l1HtzHBqeu3UDEtDZ
 5uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=WKAoehjadjOD90qHMpoBpeMJbPh5bJh7iWCvEsh3SIg=;
 b=KTYb3bPr0ffPV3sKbe8KaHahz2TciByErkF58vF4pQOX2KW+irqMZsP7PtCIdHlv5E
 3TzW3jZ/gmlSoupxtkULF/bE7P16HGU8vLrOHpSZGUal8qZuFdNRnvbSLSfLe/rKBKYs
 //qWvcF/dPGH7oIqI2q4YV0i9amGSIHghLhEIUNG/QRdR4mAkkc2OtBaWhws2mzPgZ2O
 dLe37up0elHdqS1AdoQ6P99BesljlNVYe4/NQZFTx6zLZWWRW1NGH8APcLCx8Gz+3O9X
 NsdlMa6cMmXDNnqeIXZWErt+EMZkKnB298ff+PN+dEUhRCloNJ6FwnuSHjvFIj3gkeCB
 uD7Q==
X-Gm-Message-State: AOAM533tYzL9ZIwhK3vXvUphtdK6rCcV4fLnhbyh1Vp3qc30+zSLMp/Q
 VxwZqrEZkIN2jTIMUHv54mZus+NQ1VrmcW3R0LvQ/aoX
X-Google-Smtp-Source: ABdhPJy15vjsnvzJVAD2ZlEzrpq7DAPqDQB1S8Wj5g7SDm/sfOmgiqB8SrWz0NfqKWiN4OVJHF6m/AsXJhRxeb/IEsc=
X-Received: by 2002:a05:6102:10a:: with SMTP id
 z10mr12037772vsq.131.1590946147847; 
 Sun, 31 May 2020 10:29:07 -0700 (PDT)
MIME-Version: 1.0
From: Yash Jain <yashjain.1999@gmail.com>
Date: Sun, 31 May 2020 22:58:31 +0530
Message-ID: <CAEEnZxSx-ayjrMsL2osMe8-=8ojA22AvOxgeyZaafSitGPJYwQ@mail.gmail.com>
Subject: Adding a RISC-V board to QEMU
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ffd37c05a6f5030f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=yashjain.1999@gmail.com; helo=mail-vs1-xe34.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 31 May 2020 13:32:53 -0400
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

--000000000000ffd37c05a6f5030f
Content-Type: text/plain; charset="UTF-8"

Hi,
I'm Yash. I'm a 3rd year college undergraduate student, currently interning
in IIT Madras in Project Shakti. We have built RISC-V boards and  I have
been assigned the task to add these boards as machines to QEMU.
I am absolutely new to this and have no idea how to go about this. Please
help me out!
One way I can go about this is by modifying sifive code to fit my
requirements. Is that a viable option?

Thanks!
Yash Jain

--000000000000ffd37c05a6f5030f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif;font-size:small">Hi,<br></div><div class=3D"gmail_defaul=
t" style=3D"font-family:arial,helvetica,sans-serif;font-size:small">I&#39;m=
 Yash. I&#39;m a 3rd year college undergraduate student, currently internin=
g in IIT Madras in Project Shakti. We have built RISC-V boards and=C2=A0 I =
have been assigned the task to add these boards as machines to QEMU.</div><=
div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif=
;font-size:small">I am absolutely new to this and have no idea how to go ab=
out this. Please help me out!</div><div class=3D"gmail_default" style=3D"fo=
nt-family:arial,helvetica,sans-serif;font-size:small">One way I can go abou=
t this is by modifying sifive code to fit my requirements. Is that a viable=
 option?<br></div><div class=3D"gmail_default" style=3D"font-family:arial,h=
elvetica,sans-serif;font-size:small"><br></div><div class=3D"gmail_default"=
 style=3D"font-family:arial,helvetica,sans-serif;font-size:small">Thanks!</=
div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-=
serif;font-size:small">Yash Jain<br></div></div>

--000000000000ffd37c05a6f5030f--

