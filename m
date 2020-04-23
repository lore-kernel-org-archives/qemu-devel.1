Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD4DC5518A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 03:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2C820747
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 03:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq2GofDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2C820747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRSNx-0004FZ-2l
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 23:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hqm03ster@gmail.com>) id 1jRSLN-0001FE-Tg
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 23:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <hqm03ster@gmail.com>) id 1jRSLN-000150-B9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 23:16:05 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832]:46028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hqm03ster@gmail.com>)
 id 1jRSLM-00014T-QB
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 23:16:04 -0400
Received: by mail-qt1-x832.google.com with SMTP id 71so3706120qtc.12
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 20:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OB9OTvstqtb6HGcd0Td8y0gSItB1DlBtyYkYV9ML6VM=;
 b=Hq2GofDP/1AA/mah67XdfR9lOlSEhtpNuWABsbxGj0AQscbMapqXDqiHEB7xcvF9I7
 tFRH9b3VhQYe05RYODdzBTH59cDaY9zweOmagWyL82YEIhwHeCMZqjm0QuCBez7MHlFL
 FMTfZfVCEpVxvIwx3EDjW+iByRiXVP7qPBi1vYqq03T6mLnkIm/UZSBF0F+am+Dh3eZS
 7PNBj9XnTBYZAiPopeNIcMHOWfOjfw0HoFFpi7GWmVTCsNfptAqPoIEckwpk9ABkPFfZ
 htfnqCTwN2/743ayxy8xEMQdNCzRhAfNH8L/L7IU0gd49F9i7PIArlN4loKWDWGSOmdT
 QSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OB9OTvstqtb6HGcd0Td8y0gSItB1DlBtyYkYV9ML6VM=;
 b=BHfPY53jOR80IBihWPx6QG8FmVrf1oMCSQat8SpNPQVGQY0xqCDf7pUwiHECWthLmI
 A5J69KG5ZIUsoohaKjZgfTqn8q6CkLyqqj8GH+pLANXoGPAx83MlbfqFWH9tfFoeR4b5
 j2BZqLX8aWGTSFLLeaQTytROF9vTMFcX3NbiWCqD8YChhUxXpH5fMGGD5A8ljMG/0WG0
 eTIw7Wgcji6sU8Jhz25IFkYbaJGjpAlG1c2gGvf67he/QGDZDP2k4lrUjQP2fesAM9q2
 s+lOn41T/rATATpHOB6ERiFKIiwiB/42vRzQHk9/PQBd5SqO1TxUDFOfysG6vralimxK
 LWeA==
X-Gm-Message-State: AGi0PuZ18xux/BMknDkfcw1sqn88WAgug0ZRTWmdMzRT3Zx6DlIlPaEm
 7TJgRYFbvQCG2CX3BTMEqVpolY1SY6s9mwMLdNk=
X-Google-Smtp-Source: APiQypIvGTV96hbJ64cOqZLG8Q/fZyp2vVqXzClIlzX3OhDMyTyFq+TgBbwgkKpoEKp5yiEC05r3nmd1kMVEw78SF2k=
X-Received: by 2002:ac8:162f:: with SMTP id p44mr1871446qtj.75.1587611763617; 
 Wed, 22 Apr 2020 20:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <623b1855-285c-cce3-c806-c17e5fd217ea@redhat.com>
 <5211.1586899245384995995@groups.io>
 <a972450d-8834-ae87-e4e3-5263a41d1735@redhat.com>
 <20200420141303.dxjqgvmzglrjtsly@sirius.home.kraxel.org>
 <9aed493a-2187-cacd-5631-54fb9973509c@redhat.com>
 <CABSdmrm2qp=nMdu7N7kxxS9PVA25_pfnK_F3EimLuq8twPKjgg@mail.gmail.com>
 <de03e16a-df14-c18b-31a0-ec025e7b2b65@redhat.com>
In-Reply-To: <de03e16a-df14-c18b-31a0-ec025e7b2b65@redhat.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Thu, 23 Apr 2020 11:15:50 +0800
Message-ID: <CABSdmrk5SYLNDBwLsmrOkx+JcyrfCFjWto-ErBvZSGutzLtHYw@mail.gmail.com>
Subject: Re: [edk2-discuss] Load Option passing. Either bugs or my confusion.
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000036331605a3ecabe9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=hqm03ster@gmail.com; helo=mail-qt1-x832.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::832
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
Cc: edk2-devel-groups-io <devel@edk2.groups.io>,
 qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 discuss@edk2.groups.io, valerij zaporogeci <vlrzprgts@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000036331605a3ecabe9
Content-Type: text/plain; charset="UTF-8"

>
>
> > And when the user provides an EDID one should parse it and set the
> default
> > resolution to match it. But that's a less important feature.
>
> It's more complex than you might think, and (to me personally) it seems
> to require more time than its importance justifies.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1749250
>
>
Read the thread. Actually, I wrote some EDID parsing code a while ago, but
that's before QEMU supporting EDID so I had to do it outside QEMU and pass
my parsing result to ramfb as the now-removed starting_width /
starting_height. In the context QEMU, the EDID actually reflects the user
preference since the whole structure is usually made up from the
user-specified resolution. And I think most guest OSes initialize
first-time-seen monitors to their EDID resolution, which should have
motivated QEMU to provide an EDID for a virtual monitor.

But at this point it's kind of awkward to do the EDID / resolution handling
(that I need) in the ramfb driver as the kvmgt EDID has to be read out from
the i915 MMIO just like a physical GPU. Guess now my use case is better
covered with a fully functional i915 framebuffer driver for OVMF. If I had
the time...

--00000000000036331605a3ecabe9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
&gt; And when the user provides an EDID one should parse it and set the def=
ault<br>
&gt; resolution to match it. But that&#39;s a less important feature.<br>
<br>
It&#39;s more complex than you might think, and (to me personally) it seems=
<br>
to require more time than its importance justifies.<br>
<br>
<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1749250" rel=3D"no=
referrer" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D1=
749250</a><br>
<br></blockquote><div><br></div><div>Read the thread. Actually, I wrote som=
e EDID parsing code a while ago, but that&#39;s before QEMU supporting EDID=
 so I had to do it outside QEMU and pass my parsing result to ramfb as the =
now-removed starting_width / starting_height. In the context QEMU, the EDID=
 actually reflects the user preference since the whole structure is usually=
 made up from the user-specified resolution. And I think most guest OSes in=
itialize first-time-seen monitors to their EDID resolution, which should ha=
ve motivated QEMU to provide an EDID for a virtual monitor.<br></div><div><=
br></div><div>But at this point it&#39;s kind of awkward to do the EDID / r=
esolution handling (that I need) in the ramfb driver as the kvmgt EDID has =
to be read out from the i915 MMIO just like a physical GPU. Guess now my us=
e case is better covered with a fully functional i915 framebuffer driver fo=
r OVMF. If I had the time...<br></div><div><br></div></div></div>

--00000000000036331605a3ecabe9--

