Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D24C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 00:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA0BA20789
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 00:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSo3+ifl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0BA20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7pnL-0007fg-1q
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 20:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k7pmk-0007AW-Rt; Mon, 17 Aug 2020 20:47:30 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k7pmj-0004hv-7f; Mon, 17 Aug 2020 20:47:30 -0400
Received: by mail-oi1-x243.google.com with SMTP id k4so16479138oik.2;
 Mon, 17 Aug 2020 17:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G+zOtyx97TfAAJrlw+eOoM0dymIgIO4CgcDFJgl+9XA=;
 b=iSo3+iflY2P8on98wRFboJ9ySQFcXs46Rw+Azj/4fpxyfxTs1S09TyliVUWBEMp/6Z
 BpSFcOrRnfIoaQPgOnKGTivITtA7vECnnsrHnrmT+zUfGywc+bVPryWrxS2g1Jn5Z09r
 kzrYEtm2aUdl5yaKhN/kWkG+LCDGAoC5xJ6JtujlZ16wVBEAiIHfqPQdomZJotfsjjAg
 kLfaUQNF7nJtMEZRU7gUUMp3bBizoogSityQq0ztzlGeAQORrl6uEUkCUtpGYJYpfm8V
 QxvIQgT7rPNqGbp14On4+wp2l7O+CbOW/pH1/WZAcakoEqAozJRsQhCsMKRfovaPnSn5
 /F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G+zOtyx97TfAAJrlw+eOoM0dymIgIO4CgcDFJgl+9XA=;
 b=Ilam89Kg1QiMQQsAMaxvjjqKXG/sd94fg0EdUzFcUwYqFNf/VUfs8pAQBJmxO2mpvv
 BLRVVxrqVSg+RfCkhwEg9vzR+wopUnItSMpEfsXOISITxc/L6uMNPqG8W8Syi0XSEdpK
 p3rrcfi4dSSEwQSO4W4+C179aPfNh/WIwu5anbrbBCbJVYiwotpV0Rrg+mv7xqz63Uw2
 T/xlc1/gn/qp69dvge0aRn5YOEIif6Y+Pr0fdsDiqF4UmN+c40k9fYvb/9JexbWFQo7f
 zzGnqFjq/pSd/r2Y+ZYOsBmrGpfJ+qT7gNXkGjB8IoBO27Fz/as9yrLPcjEekoDhpcNt
 CU2Q==
X-Gm-Message-State: AOAM5308JYf+Wrhe7PX1q25pl9TPza2oJfJA+pk8tMlieSfAPlJZyV2O
 xLrRD05iPUN+Iy6bvUwm3lTEv8wv3lHWbgr6Njc=
X-Google-Smtp-Source: ABdhPJx36LFbWxe97IW1zrlRmSnjlaiwqDvsNE5moLNcRWHM2tD3mEMAbr504oqc/yAB17HatFErE4+C5Q4lE5ucsvA=
X-Received: by 2002:aca:1117:: with SMTP id 23mr11595380oir.97.1597711647331; 
 Mon, 17 Aug 2020 17:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200815141940.44025-1-liq3ea@163.com>
 <83092d06-25e3-abf8-67b2-8b9bcfb00732@redhat.com>
In-Reply-To: <83092d06-25e3-abf8-67b2-8b9bcfb00732@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 18 Aug 2020 08:46:50 +0800
Message-ID: <CAKXe6SLuz1jyGG9k0+yi288DUibUT_w5cPhFpA+s4ZBENLmo+g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix the assert failure in scsi_dma_complete
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000315bc705ad1c3bb7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
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
Cc: Fam Zheng <fam@euphon.net>, hare@suse.com, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000315bc705ad1c3bb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:05=E5=86=99=E9=81=93=EF=BC=9A

> On 15/08/20 16:19, Li Qiang wrote:
> > Currently in 'megasas_map_sgl' when 'iov_count=3D0' will just return
> > success however the 'cmd' doens't contain any iov. This will cause
> > the assert in 'scsi_dma_complete' failed. This is because in
> > 'dma_blk_cb' the 'dbs->sg_cur_index =3D=3D dbs->sg->nsg' will be true
> > and just call 'dma_complete'. However now there is no aiocb returned.
> >
> > This is the LP#1878263:
> >
> > -->https://bugs.launchpad.net/qemu/+bug/1878263
> >
> > To solve this we will consider the 'iov_count=3D0' is an error.
> > In the first patch, I uses -1 to indicate an error and in the second
> > patch I consider 'iov_count=3D0' is an error.
> >
> > Li Qiang (2):
> >   hw: megasas: return -1 when 'megasas_map_sgl' fails
> >   hw: megasas: consider 'iov_count=3D0' is an error in megasas_map_sgl
> >
> >  hw/scsi/megasas.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
>
> Queued, thanks.  But do you have a qtest for this?
>

Okay, I will cook a qtest for this recently.

Thanks,
Li Qiang


>
> Paolo
>
>

--000000000000315bc705ad1c3bb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Paolo Bonzini &lt;<a href=3D"mailto:p=
bonzini@redhat.com">pbonzini@redhat.com</a>&gt; =E4=BA=8E2020=E5=B9=B48=E6=
=9C=8818=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:05=E5=86=99=E9=81=
=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
15/08/20 16:19, Li Qiang wrote:<br>
&gt; Currently in &#39;megasas_map_sgl&#39; when &#39;iov_count=3D0&#39; wi=
ll just return<br>
&gt; success however the &#39;cmd&#39; doens&#39;t contain any iov. This wi=
ll cause<br>
&gt; the assert in &#39;scsi_dma_complete&#39; failed. This is because in<b=
r>
&gt; &#39;dma_blk_cb&#39; the &#39;dbs-&gt;sg_cur_index =3D=3D dbs-&gt;sg-&=
gt;nsg&#39; will be true<br>
&gt; and just call &#39;dma_complete&#39;. However now there is no aiocb re=
turned.<br>
&gt; <br>
&gt; This is the LP#1878263:<br>
&gt; <br>
&gt; --&gt;<a href=3D"https://bugs.launchpad.net/qemu/+bug/1878263" rel=3D"=
noreferrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1878263<=
/a><br>
&gt; <br>
&gt; To solve this we will consider the &#39;iov_count=3D0&#39; is an error=
.<br>
&gt; In the first patch, I uses -1 to indicate an error and in the second<b=
r>
&gt; patch I consider &#39;iov_count=3D0&#39; is an error.<br>
&gt; <br>
&gt; Li Qiang (2):<br>
&gt;=C2=A0 =C2=A0hw: megasas: return -1 when &#39;megasas_map_sgl&#39; fail=
s<br>
&gt;=C2=A0 =C2=A0hw: megasas: consider &#39;iov_count=3D0&#39; is an error =
in megasas_map_sgl<br>
&gt; <br>
&gt;=C2=A0 hw/scsi/megasas.c | 6 +++---<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)<br>
&gt; <br>
<br>
Queued, thanks.=C2=A0 But do you have a qtest for this?<br></blockquote><di=
v><br></div><div>Okay, I will cook a qtest for this recently.</div><div><br=
></div><div>Thanks,</div><div>Li Qiang</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
Paolo<br>
<br>
</blockquote></div></div>

--000000000000315bc705ad1c3bb7--

