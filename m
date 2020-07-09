Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE8BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 06:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0272073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 06:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8LXLT9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0272073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtPf8-0002F2-3l
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 02:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jtPeP-0001Wx-Qx
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 02:03:17 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d]:36851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jtPeN-0005tw-Tt
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 02:03:17 -0400
Received: by mail-io1-xd2d.google.com with SMTP id y2so1129241ioy.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 23:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BvcBUsuDLyAp4erjVQS19iEPeiF9KMA6yQOnrLOhAL0=;
 b=Z8LXLT9ZDhixyTNvOKFsmi5eKL/rJzV1eG8bExlU69E4Q3Zone8sq/t3DpB+E0j7ES
 EmOf8+cyXeHXWRo/TpaqbL4jhz/1BQ+XHecZ1oG6uPuWDKYLn9Xegz2Ma/8APuh0mxUT
 AWhw9/QsY5l/SFlW0I5GTLgRZ8GP6hvKMvfywX72FwRd+KelfwV0oXGvPlw1JwNFquGa
 tjevejOAUYSPcmR5+P+T5YLZNiIQidKcLOs6Q4jGZz3FAzoVEMUbMiP/CPRSRArWOXnR
 kFGAvjpa9sMC4Fh8w37hgy7mwqmPO+hKnJuXT6PyhMwgjL/Bpf9/sKmMuyDbR497hH8i
 Ov8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BvcBUsuDLyAp4erjVQS19iEPeiF9KMA6yQOnrLOhAL0=;
 b=fXHVT761nsHomK2kLH8IYcjbWBKMaKFQGHTZqazkFCLm1QbWKNCYipRl1wDwbp/X/C
 wfbvXh0ZOZnLGSdpTScaFoazFHBbRZNZo8dPXWMcEfFrYrQlO85LGWDzCGWsEQQtWqk7
 PlswBBCgpHxMQKjSA+xBeuDbNlxkWsBPt6eG0NTYq8PKFrmntTtO5vXaD5eDzV2G6/6r
 EkY9UJz/kcmwaV0cf50UACIUc2HgWHUEvkSWgFYfwrVPemycXC7hqPeD+VXJWFM/J7ti
 6fgX1eofAST07TODN7t4uDU5LLp87IoyX/twBLKQp0chige063nSIUOgJruYdH0985ki
 GQ5g==
X-Gm-Message-State: AOAM533RYb7VrEiAd1W0rHKQ20OTkYZ47X0IPgh7EaV7AHr4vEnfuYZg
 wEILVCsGny2xcIdFyIrwQrgm60Z2gUeyeePffUU=
X-Google-Smtp-Source: ABdhPJxniowRkQWqQjBn4j/qFQuaGB80mSU5nmv8g0pUv9bIe2qSj4RW5rZG4nA5AUAXQFfjssBvawXajBnLOYD8ElQ=
X-Received: by 2002:a6b:8e56:: with SMTP id q83mr41026642iod.61.1594274594426; 
 Wed, 08 Jul 2020 23:03:14 -0700 (PDT)
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
In-Reply-To: <20200708102958.kxnlr5outhsufxv5@sirius.home.kraxel.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Wed, 8 Jul 2020 23:02:47 -0700
Message-ID: <CADBGO7_08su0HqP1uiwvkLfwq3NUmUxoLhRK5H3b0v=C4iPYFg@mail.gmail.com>
Subject: Re: Failure prints during format or mounting a usb storage device
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000e028df05a9fbfacf"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd2d.google.com
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

--000000000000e028df05a9fbfacf
Content-Type: multipart/alternative; boundary="000000000000e028dd05a9fbfacd"

--000000000000e028dd05a9fbfacd
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 8, 2020 at 3:30 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > IIRC, without the dev-storage patch, the very first SCSI command
> > would get stuck waiting for the CSW, because the CSW is not a
> > multiple of MPS. I will have to work on getting a debug trace for
> > you, I'll get back to you with that.
>
> Hmm, dev-storage should be fine with the packet being larger than
> needed.  It'll actually do a short transfer then.  So I suspect the
> patch just papers over the underlying issue.
>
> Can you post a trace of this?
>
> (dev-storage has no trace support, so I think tracing usb_dwc2* to
>  stderr and enable DEBUG_MSD in dev-storage.c works best)
>
> take care,
>   Gerd
>
>
Attached is the log with the dev-storage patch reverted. The full log
was *huge*, so I had to strip out a lot of the content manually.

Starting at line 1746 is the first CBW, it's for an Inquiry command.

Starting at line 1759 is the response, notice at line 1761 the MSD debug
says "Data in 64/36", which is strange. Then the MSD defers the packet,
even though the full 36 bytes has already been received.

Starting at line 1781 (I trimmed out a bunch of lines with no activity
on the MSD here) I think the guest USB driver times out the transfer and
does a reset of the MSD. Notice a few lines later the packet status
return value is USB_RET_STALL.

After this, there is no further activity on the MSD.

Thanks,
Paul

--000000000000e028dd05a9fbfacd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Jul 8, 2020 at 3:30 AM Gerd Hoffmann =
&lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 Hi,<br>
<br>
&gt; IIRC, without the dev-storage patch, the very first SCSI command<br>
&gt; would get stuck waiting for the CSW, because the CSW is not a<br>
&gt; multiple of MPS. I will have to work on getting a debug trace for<br>
&gt; you, I&#39;ll get back to you with that.<br>
<br>
Hmm, dev-storage should be fine with the packet being larger than<br>
needed.=C2=A0 It&#39;ll actually do a short transfer then.=C2=A0 So I suspe=
ct the<br>
patch just papers over the underlying issue.<br>
<br>
Can you post a trace of this?<br>
<br>
(dev-storage has no trace support, so I think tracing usb_dwc2* to<br>
=C2=A0stderr and enable DEBUG_MSD in dev-storage.c works best)<br>
<br>
take care,<br>
=C2=A0 Gerd<br>
<br></blockquote><div><br></div><div><span class=3D"gmail_default" style=3D=
"font-family:monospace">Attached is the=C2=A0log with the dev-storage patch=
 reverted.=C2=A0</span><span class=3D"gmail_default" style=3D"font-family:m=
onospace">The full log</span></div><div><span class=3D"gmail_default" style=
=3D"font-family:monospace">was *huge*, so I had to strip out=C2=A0</span><s=
pan style=3D"font-family:monospace">a lot of the content manually.</span></=
div><div><span class=3D"gmail_default" style=3D"font-family:monospace"><br>=
</span></div><div><span class=3D"gmail_default" style=3D"font-family:monosp=
ace">Starting at line 1746 is the first CBW, it&#39;s for an Inquiry comman=
d.</span></div><div><span class=3D"gmail_default" style=3D"font-family:mono=
space"><br></span></div><div><span class=3D"gmail_default" style=3D"font-fa=
mily:monospace">Starting at=C2=A0</span><span style=3D"font-family:monospac=
e">line 1759 is the response,=C2=A0<span class=3D"gmail_default" style=3D"f=
ont-family:monospace">notice at line 1761 the MSD debug</span></span></div>=
<div><span style=3D"font-family:monospace"><span class=3D"gmail_default" st=
yle=3D"font-family:monospace">says &quot;Data in 64/36&quot;, which is stra=
nge. Then the MSD defers the packet,</span></span></div><div><span style=3D=
"font-family:monospace"><span class=3D"gmail_default" style=3D"font-family:=
monospace">even though the full 36 bytes has already been received.</span><=
/span></div><div><span class=3D"gmail_default" style=3D"font-family:monospa=
ce"><br></span></div><div><span class=3D"gmail_default" style=3D"font-famil=
y:monospace">Starting at line 1781 (I trimmed out a bunch of lines with no=
=C2=A0</span><span style=3D"font-family:monospace">activity</span></div><di=
v><span style=3D"font-family:monospace">on the MSD<span class=3D"gmail_defa=
ult" style=3D"font-family:monospace"> here</span>) I think the guest USB dr=
iver times out the transfer<span class=3D"gmail_default" style=3D"font-fami=
ly:monospace"> and</span></span></div><div><span class=3D"gmail_default" st=
yle=3D"font-family:monospace">does a reset of the=C2=A0</span><span style=
=3D"font-family:monospace">MSD<span class=3D"gmail_default" style=3D"font-f=
amily:monospace">.</span>=C2=A0<span class=3D"gmail_default" style=3D"font-=
family:monospace">N</span>otice a few lines later the <span class=3D"gmail_=
default" style=3D"font-family:monospace">packet status</span></span></div><=
div><span style=3D"font-family:monospace"><span class=3D"gmail_default" sty=
le=3D"font-family:monospace"></span>return value<span class=3D"gmail_defaul=
t" style=3D"font-family:monospace"> </span></span><span class=3D"gmail_defa=
ult" style=3D"font-family:monospace"></span><span style=3D"font-family:mono=
space">is USB_RET_STALL<span class=3D"gmail_default" style=3D"font-family:m=
onospace">.</span></span></div><div><span class=3D"gmail_default" style=3D"=
font-family:monospace"><br></span></div><div><span class=3D"gmail_default" =
style=3D"font-family:monospace">After this, there is no further activity on=
 the MSD.</span></div><div><span class=3D"gmail_default" style=3D"font-fami=
ly:monospace"><br></span></div><div><span class=3D"gmail_default" style=3D"=
font-family:monospace">Thanks,</span></div><div><span class=3D"gmail_defaul=
t" style=3D"font-family:monospace">Paul</span></div><div><br></div></div></=
div>

--000000000000e028dd05a9fbfacd--

--000000000000e028df05a9fbfacf
Content-Type: application/gzip; name="stderr.log.gz"
Content-Disposition: attachment; filename="stderr.log.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_kceds90p0>
X-Attachment-Id: f_kceds90p0

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
QuwjbE0+ioUSSKkKx9QIqOr/AzgBM8do1gIA
--000000000000e028df05a9fbfacf--

