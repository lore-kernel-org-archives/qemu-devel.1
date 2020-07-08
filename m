Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5942C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E8320672
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG2dCsjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E8320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt4yy-0002Xs-L3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 03:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jt4yA-0001p8-B8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 03:58:18 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35]:41378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jt4y8-00040b-El
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 03:58:18 -0400
Received: by mail-io1-xd35.google.com with SMTP id o5so45912961iow.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L/nW8tzx/cjOPiSReYsetk89LCeUrWj4ZIvVPSZWd6I=;
 b=nG2dCsjg1jrX7N6lNmtCWCPcdIuJl76zkYZPd+VUa/9mJy5M9ef0MjEIGiUStvf/AI
 ecyemG5LVzNDd+HdIOgI42l8G//8upIB3+Jua9RNGGlsDVX/iDpSkCAOWKgOyL2mBTya
 Hx8oLDDLog2sq+HLbIIo6Whgme+EYREMPBO4uESvR44xa1vr2uREwyEEqVZHw3Uy4War
 +Q8zLl2mF9MmZRAOEEqX4FUIkglgOQjB8MW6jwZm4yVfcqsBASTMpDI9u3Op/mhMPdnZ
 yLu04vVtLTcQ1WJg9Wxz6y1V0K3qSVpHbv2ZpOUZwP8mWJS44eBm8vJYoJL0xO/xJSHx
 XHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L/nW8tzx/cjOPiSReYsetk89LCeUrWj4ZIvVPSZWd6I=;
 b=nwb6G+6HWx6LCZFMQJcJ3pD641iycUvBgBopM+sdqgE5arxIVEip3SxeLJXSXIaqXn
 wCadKEzUBO2DWHsB3dQc7+xSZSwZSJZ65HIuu0iUy5/Xjk44VsnfuE5iswNl0lU3+ziy
 85HoZCNWNFkjm5CnAG3uusCG1POGnX4j9evn8YtQ3hrAq53RjcQ9fAabhKj1Y0QRVCB2
 4whyJZTuj2qZ896W3UVC+eu6feAoVDIFwFCV4gk6o8zcV4z23tE3aHy1Tp4GpGiWn+SY
 HbsiIIwWFKZWbEzpwxdIUAHR4zmznpGzC7093wFGmyZRiWzFa0YzymLWgG9/DExog7hv
 XFBQ==
X-Gm-Message-State: AOAM532Cu3TKxPznA1OcXValh7z0cbBT19suZQmPK1vInmiZymjd3PMV
 1ua+I91FUsBsiPpmbR3IobhOWvUlb6Lcbywge0g=
X-Google-Smtp-Source: ABdhPJxzstsoeACh6uyRGd4sd9OQdShV6IQSEKyGoBUmPz7DfpZKdNQOTHdbKFqDIIZT2+Cpld53ofdBZwVyJFLcu2A=
X-Received: by 2002:a5e:c801:: with SMTP id y1mr35494917iol.127.1594195094835; 
 Wed, 08 Jul 2020 00:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0@BY5PR02MB6772.namprd02.prod.outlook.com>
 <CADBGO7-hp4Pyfn+rq9d=ZxHmpMwitv-oLjYPJmCKSH6cLHVx=w@mail.gmail.com>
 <CADBGO78-mqwapj+mdpFUO-puL0OZ_1QeBc+4yo4S9g1O4deNjg@mail.gmail.com>
 <2d312ec0-d280-c0e3-2b1e-ff9c70c3168f@gmail.com>
 <20200707075740.dkc76ceb7wytdoem@sirius.home.kraxel.org>
 <CADBGO79KSm3KV7=otOg=u7WjwBV=j3T7iU0fcTF-nGgtZvy+Aw@mail.gmail.com>
 <20200708072947.7hynrm53622tp3ha@sirius.home.kraxel.org>
In-Reply-To: <20200708072947.7hynrm53622tp3ha@sirius.home.kraxel.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Wed, 8 Jul 2020 00:57:48 -0700
Message-ID: <CADBGO7-38Q3MS-G5rCbW1i_1rvq7NRf2J+bMErXr=7xhZ=jEWg@mail.gmail.com>
Subject: Re: Failure prints during format or mounting a usb storage device
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005494ff05a9e9780c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd35.google.com
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

--0000000000005494ff05a9e9780c
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 8, 2020 at 12:29 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > > Why does 7ad3d51ebb8a522ffcad391c4bef281245739dde look at short-not-ok?
> >
> > Because the patch changes dev-storage to terminate the transfer if a
> > short packet is received, so I figured 'short-not-ok' should affect
> > that behavior.
>
> I don't think so.  dev-storage should not need to look at short-not-ok.
>
> > I guess instead I could add another flag that only hcd-dwc2 sets. Does
> > that sound OK to you?
>
> Sounds like that'll be another workaround.  dev-storage should not need
> to know what kind of host adapter is used ...
>
> A usb-storage transfer looks like this:
>
>   (1) out transfer with the command (USB_MSDM_CBW)
>   (2) data transfer, might be:
>       - out (USB_MSDM_DATAOUT) for writes, or
>       - in (USB_MSDM_DATAIN) for reads, or
>       - nothing.
>       depending on the scsi command.
>   (3) in transfer with the status (USB_MSDM_CSW).
>
> (1) and (3) usually fit into a single usb packet.
> (2) can be multiple usb packets.
>
> The critical case seem to be reads, i.e. we have in transfers for
> both (2) and (3), and the transition from USB_MSDM_DATAIN state to
> USB_MSDM_CSW state.
>
> What is the sequence of usb packets submitted by the guest to hcd-dwc2
> for reads?  Where exactly does it expect a short transfer?
>

DWC2 needs a short transfer to indicate the end of all IN transfers
that are not an exact multiple of max packet size. This means that
the guest USB driver submits all read requests not with the actual
length of the read, but with a length that is rounded up to a
multiple of MPS.

IIRC, without the dev-storage patch, the very first SCSI command
would get stuck waiting for the CSW, because the CSW is not a
multiple of MPS. I will have to work on getting a debug trace for
you, I'll get back to you with that.

Thanks,
Paul

--0000000000005494ff05a9e9780c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Jul 8, 2020 at 12:29 AM Gerd Hoffmann=
 &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 Hi,<br>
<br>
&gt; &gt; Why does 7ad3d51ebb8a522ffcad391c4bef281245739dde look at short-n=
ot-ok?<br>
&gt; <br>
&gt; Because the patch changes dev-storage to terminate the transfer if a<b=
r>
&gt; short packet is received, so I figured &#39;short-not-ok&#39; should a=
ffect<br>
&gt; that behavior.<br>
<br>
I don&#39;t think so.=C2=A0 dev-storage should not need to look at short-no=
t-ok.<br>
<br>
&gt; I guess instead I could add another flag that only hcd-dwc2 sets. Does=
<br>
&gt; that sound OK to you?<br>
<br>
Sounds like that&#39;ll be another workaround.=C2=A0 dev-storage should not=
 need<br>
to know what kind of host adapter is used ...<br>
<br>
A usb-storage transfer looks like this:<br>
<br>
=C2=A0 (1) out transfer with the command (USB_MSDM_CBW)<br>
=C2=A0 (2) data transfer, might be:<br>
=C2=A0 =C2=A0 =C2=A0 - out (USB_MSDM_DATAOUT) for writes, or<br>
=C2=A0 =C2=A0 =C2=A0 - in (USB_MSDM_DATAIN) for reads, or<br>
=C2=A0 =C2=A0 =C2=A0 - nothing.<br>
=C2=A0 =C2=A0 =C2=A0 depending on the scsi command.<br>
=C2=A0 (3) in transfer with the status (USB_MSDM_CSW).<br>
<br>
(1) and (3) usually fit into a single usb packet.<br>
(2) can be multiple usb packets.<br>
<br>
The critical case seem to be reads, i.e. we have in transfers for<br>
both (2) and (3), and the transition from USB_MSDM_DATAIN state to<br>
USB_MSDM_CSW state.<br>
<br>
What is the sequence of usb packets submitted by the guest to hcd-dwc2<br>
for reads?=C2=A0 Where exactly does it expect a short transfer?<br></blockq=
uote><div><br></div><div class=3D"gmail_default" style=3D"font-family:monos=
pace">DWC2 needs a short transfer to indicate the end of all IN transfers</=
div><div class=3D"gmail_default" style=3D"font-family:monospace">that are n=
ot an exact multiple of max packet size. This means that</div><div class=3D=
"gmail_default" style=3D"font-family:monospace">the guest USB driver submit=
s all read requests not with the actual</div><div class=3D"gmail_default" s=
tyle=3D"font-family:monospace">length of the read, but with a length that i=
s rounded up to a</div><div class=3D"gmail_default" style=3D"font-family:mo=
nospace">multiple of MPS.</div><div class=3D"gmail_default" style=3D"font-f=
amily:monospace"><br></div><div class=3D"gmail_default" style=3D"font-famil=
y:monospace">IIRC, without the dev-storage patch, the very first SCSI comma=
nd</div><div class=3D"gmail_default" style=3D"font-family:monospace">would =
get stuck waiting for the CSW, because the=C2=A0CSW is not a</div><div clas=
s=3D"gmail_default" style=3D"font-family:monospace">multiple of MPS. I will=
 have to work on getting a debug trace for</div><div class=3D"gmail_default=
" style=3D"font-family:monospace">you, I&#39;ll get back to you with that.<=
/div><div class=3D"gmail_default" style=3D"font-family:monospace"><br></div=
><div class=3D"gmail_default" style=3D"font-family:monospace">Thanks,</div>=
<div class=3D"gmail_default" style=3D"font-family:monospace">Paul</div><div=
 class=3D"gmail_default" style=3D"font-family:monospace"><br></div></div></=
div>

--0000000000005494ff05a9e9780c--

