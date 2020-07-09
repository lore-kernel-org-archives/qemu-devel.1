Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D156FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 21:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9610520672
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 21:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hESHln3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9610520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jteXA-0000RB-PO
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 17:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jteWF-0007u2-Tu
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 17:55:52 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29]:43069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jteWD-0001Nb-Qq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 17:55:51 -0400
Received: by mail-io1-xd29.google.com with SMTP id k23so3925455iom.10
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 14:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NfM2q5MsuBtISTcEk8XsvmXu9yzaadVqFdqRjRzwqBA=;
 b=hESHln3/xT/Sy8Ueo1UuNcqXissaF2EJK6dH/uX2GLoXLOo0iFzEfl8BTtw2/JtH1t
 bOQ8BIKrXlmy/GYKYORjDrZ0O6zC163DL/uKxfpMcwFnwbAaUOvzZHtyxT8OxZtGhhYd
 Qwv2dTUbiGC+VTMRehdWJM5qsti658ehrw9KhfbDPQRt8FvYP47dhdvWWT8vGcGMvq9s
 xTaDny8fHuRfJn8OyaQyXpXXgPE0vwRs3CXTh5OTRdP7LAOriOk5wMo1kiiquAS1UzMI
 IYGMKyxADIM3HeU2tLjpcts48rNj1P0WiqJCnWo2lujbTdRd9nJGPSwVWkB7EzIqDePz
 0l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NfM2q5MsuBtISTcEk8XsvmXu9yzaadVqFdqRjRzwqBA=;
 b=eCVmd3xt0afYnzWqN06kYFM/dtx29YHLdcL6h9WOwR4saN3Et4GT7LuXSdWxSSMsOG
 C5cAUSYHF0CX9lUpo+pqs5dJRNP6BgTX4KUgrt5W/NZfpd26OMUHV+n1VOhsie8M6atq
 npwsPUKN0dzEpXfnlvZvjDy0vq/wsFWsW5IWW6gD8FA1oy7nEkYNeZr56O2FlCKuehkF
 ggl9Lq1bMScLu3xaMrYDvgsFJU3RvQJTDvTFoa1a0bruWYg4sFBtdjFNdfduhDueguP5
 zEoofdORiDGnTIYlAe0M2sFMjWyIogdrxSxyMyF4sQ4JmT41eGekd5vYyaHkN07tPGiJ
 Dpmw==
X-Gm-Message-State: AOAM533BpbDGud1f8e7Isu1RsvmAG4BI1WsrUdZTOe3V8bPbu9zVpGsM
 zN1ICeR4E9YQ9RtGYvcBIAL068wuD2hOo/Ee4v8=
X-Google-Smtp-Source: ABdhPJwBqkfPQLl8z5RQbPpG3NDfxMOzqic1LEjpVzTR58KDnCJMN7QfSF5AvRNfvjL3lceaIfF4/9gTwILygP9u6is=
X-Received: by 2002:a6b:8e56:: with SMTP id q83mr44843203iod.61.1594331747605; 
 Thu, 09 Jul 2020 14:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0@BY5PR02MB6772.namprd02.prod.outlook.com>
 <CADBGO7-hp4Pyfn+rq9d=ZxHmpMwitv-oLjYPJmCKSH6cLHVx=w@mail.gmail.com>
 <CADBGO78-mqwapj+mdpFUO-puL0OZ_1QeBc+4yo4S9g1O4deNjg@mail.gmail.com>
 <2d312ec0-d280-c0e3-2b1e-ff9c70c3168f@gmail.com>
 <20200707075740.dkc76ceb7wytdoem@sirius.home.kraxel.org>
 <CADBGO79KSm3KV7=otOg=u7WjwBV=j3T7iU0fcTF-nGgtZvy+Aw@mail.gmail.com>
 <20200708072947.7hynrm53622tp3ha@sirius.home.kraxel.org>
 <CADBGO7-38Q3MS-G5rCbW1i_1rvq7NRf2J+bMErXr=7xhZ=jEWg@mail.gmail.com>
 <20200708102958.kxnlr5outhsufxv5@sirius.home.kraxel.org>
 <CADBGO7_08su0HqP1uiwvkLfwq3NUmUxoLhRK5H3b0v=C4iPYFg@mail.gmail.com>
 <20200709075702.2mrm45ncbfmmikde@sirius.home.kraxel.org>
In-Reply-To: <20200709075702.2mrm45ncbfmmikde@sirius.home.kraxel.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Thu, 9 Jul 2020 14:55:21 -0700
Message-ID: <CADBGO7-yccD+F6EZ-SqGc4pFgYoueQ-HvEAMyBLwO_BuXpN3SQ@mail.gmail.com>
Subject: Re: Failure prints during format or mounting a usb storage device
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000785e7a05aa09497d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd29.google.com
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
Cc: Sai Pavan Boddu <saipava@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vikram Garhwal <fnuv@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000785e7a05aa09497d
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 9, 2020 at 12:57 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> > Starting at line 1746 is the first CBW, it's for an Inquiry command.
> >
> > Starting at line 1759 is the response, notice at line 1761 the MSD debug
> > says "Data in 64/36", which is strange.
>
> Not really.  First is the packet size, second is the (remaining) data
> size.  Inquiry data is 36 bytes, and dwc2 uses 64 byte instead of 36
> byte transfers.
>
> > Then the MSD defers the packet, even though the full 36 bytes has
> > already been received.
>
> Yes, and this is the problem.  The condition checks whenever there is
> room left in the usb packet.  But we should also check whenever there
> is actually more data pending, so how about this:
>
>     if (p->actual_length < p->iov.size && s->mode == USB_MSDM_DATAIN) {
>         DPRINTF("Deferring packet %p [wait data-in]\n", p);
>
> take care,
>   Gerd
>
>
Hi Gerd,

Hey, that works! But we still need to keep the rest of 7ad3d51ebb8a,
or else s->data_len eventually goes negative and we hit the assertion
on line 447 "Assertion `le32_to_cpu(s->csw.residue) == 0' failed.

But with that, hcd-dwc2 seems to work fine, and also the error
messages that Sai saw with hcd-xhci are gone.

Do you want to submit the patch for this?

Thanks,
Paul

--000000000000785e7a05aa09497d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Jul 9, 2020 at 12:57 AM Gerd Hoffmann=
 &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; Starting at=
 line 1746 is the first CBW, it&#39;s for an Inquiry command.<br>
&gt; <br>
&gt; Starting at line 1759 is the response, notice at line 1761 the MSD deb=
ug<br>
&gt; says &quot;Data in 64/36&quot;, which is strange.<br>
<br>
Not really.=C2=A0 First is the packet size, second is the (remaining) data<=
br>
size.=C2=A0 Inquiry data is 36 bytes, and dwc2 uses 64 byte instead of 36<b=
r>
byte transfers.<br>
<br>
&gt; Then the MSD defers the packet, even though the full 36 bytes has<br>
&gt; already been received.<br>
<br>
Yes, and this is the problem.=C2=A0 The condition checks whenever there is<=
br>
room left in the usb packet.=C2=A0 But we should also check whenever there<=
br>
is actually more data pending, so how about this:<br>
<br>
=C2=A0 =C2=A0 if (p-&gt;actual_length &lt; p-&gt;iov.size &amp;&amp; s-&gt;=
mode =3D=3D USB_MSDM_DATAIN) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Deferring packet %p [wait data-in=
]\n&quot;, p);<br>
<br>
take care,<br>
=C2=A0 Gerd<br>
<br></blockquote><div><span class=3D"gmail_default" style=3D"font-family:mo=
nospace"><br></span></div><div><span class=3D"gmail_default" style=3D"font-=
family:monospace">Hi Gerd,</span></div><div><span class=3D"gmail_default" s=
tyle=3D"font-family:monospace"><br></span></div><div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace">Hey, that works! But we still need t=
o keep the rest of 7ad3d51ebb8a,</div><div class=3D"gmail_default" style=3D=
"font-family:monospace">or else s-&gt;data_len eventually goes negative and=
 we hit the assertion</div><div class=3D"gmail_default" style=3D"font-famil=
y:monospace">on line 447 &quot;Assertion `le32_to_cpu(s-&gt;csw.residue) =
=3D=3D 0&#39; failed.</div><br></div><div><div class=3D"gmail_default" styl=
e=3D"font-family:monospace">But with that, hcd-dwc2 seems to work fine, and=
 also the error</div><div class=3D"gmail_default" style=3D"font-family:mono=
space">messages that Sai saw with hcd-xhci are gone.</div><div class=3D"gma=
il_default" style=3D"font-family:monospace"><br></div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace">Do you want to submit the patch for=
 this?</div><br></div></div><div class=3D"gmail_quote"><div class=3D"gmail_=
default" style=3D"font-family:monospace">Thanks,</div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace">Paul</div><div class=3D"gmail_defau=
lt" style=3D"font-family:monospace"><br></div></div></div>

--000000000000785e7a05aa09497d--

