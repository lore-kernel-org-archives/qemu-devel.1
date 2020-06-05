Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA902C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 22:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42C52065C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 22:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+VsTObR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42C52065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhKbz-0002N4-0e
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 18:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jhKbP-0001vP-Vv
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 18:14:16 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:37658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jhKbL-0008Cj-Vz
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 18:14:14 -0400
Received: by mail-il1-x144.google.com with SMTP id e11so6024788ilr.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 15:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l3LApbFuco5ml50rZlUvhriZVsMaf6StvxKMz/in5Ns=;
 b=B+VsTObR5/+jlSuehQVhnhV1Sk3sIMua5Q4d065DayYlHYNozJD+XjDcwUB4tHf6NQ
 tSNuGKOzqtyY0VwF8zaeHYI0tH6rNj2O133o/ZvVkHQ9Woes1wPN4quGWLfU1O3moE0n
 Kqq6lCqV/VxvJ0Au6wYS0H1oy+0IJ0aXVvDaZEU7fzaTq67Exf1PrVBFsGSez/qCNusz
 MzN44gSQBXk11xFyAh2sDqtfpIFPKYscfV0TwgAI9+M7gRa1G7N4pF3OCZzOi6V6dKcl
 KaSgghp5IL2pkU/4sD3YqYS6fKiMzl6MHrx4oSBo5CWb3ezlLgpVcVHts//Q5HWiazFa
 jbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l3LApbFuco5ml50rZlUvhriZVsMaf6StvxKMz/in5Ns=;
 b=K5F13emh3zfveqfWs1FUdNHRJEpHVTGqX6mKYenKjLovhhaHQsOpJvWDQJCAeaBE2u
 ipZ0xIrnfk97yKXbBKr7cfpxG3ZRhocuqz/JWTn35AWzoUBp2ZvZyheS0f9TzNNIQ46C
 6xdXO0qrOtVelxJdmOL7xQvysXsfeWY0zL0uTzccAf6kI2YNwX47VtLPp62enzw9F2Qx
 nmrQnO2OAvW1RbxGjPvpSr0qQv/EuOBAB2//kXmpkdAyd/gCru7KqG2a9I1aZXYmEENy
 Ked/JcFsqPyqrDtusRTaKw5weJzCRv9W04Gqroe0++9pwaBRDKzCX3sLRFqPhgYahtIf
 vKDA==
X-Gm-Message-State: AOAM531cv++dIH89QXjSKlP8iJM7AQ+5HYgN80dZR7hJsSTo1jBz6kJx
 7DcCn23PuIVro69LCH8d2yOeE+SDN6JhvA9aBnY=
X-Google-Smtp-Source: ABdhPJwxTPv92qZtE+eG6w6Hu0E3aEaXoRqbPtN8vNiyFAMMvnjQ/2LxSc7m/hIkJysqdjpinpgVs4EB9SeN9Iv2VS4=
X-Received: by 2002:a92:c947:: with SMTP id i7mr6597654ilq.276.1591395250024; 
 Fri, 05 Jun 2020 15:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200520235349.21215-1-pauldzim@gmail.com>
 <CAFEAcA-4DuvX2jqFbMvXyqpeytj95gUn7pVnhH1b_622GgAMog@mail.gmail.com>
In-Reply-To: <CAFEAcA-4DuvX2jqFbMvXyqpeytj95gUn7pVnhH1b_622GgAMog@mail.gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Fri, 5 Jun 2020 15:13:43 -0700
Message-ID: <CADBGO781dmXsAUMrPzZEWNT0Y7DztO3hCt8chKy8jW-fi_CNzg@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] dwc-hsotg (aka dwc2) USB host controller emulation
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000093332705a75d94a6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=pauldzim@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000093332705a75d94a6
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 5, 2020 at 7:28 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 21 May 2020 at 00:54, Paul Zimmerman <pauldzim@gmail.com> wrote:
> >
> > This verion fixes a few things pointed out by Peter, and one by
> > Felippe.
> >
> > This patch series adds emulation for the dwc-hsotg USB controller,
> > which is used on the Raspberry Pi 3 and earlier, as well as a number
> > of other development boards. The main benefit for Raspberry Pi is that
> > this enables networking on these boards, since the network adapter is
> > attached via USB.
>
> Applied to target-arm.next, thanks.
>
> (Gerd, I'm assuming from the fact you put a previous version
> of this series into a usb pullreq that you're happy with the
> "usb: add short-packet handling to usb-storage driver" patch
> even though you didn't provide a reviewed-by for it.)
>
>
Thanks Peter! Does this require an update to Maintainers and/or the release
notes?

Thanks,
Paul

--00000000000093332705a75d94a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Jun 5, 2020 at 7:28 AM Peter Maydell =
&lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Thu, 21 May 2020 at 00:54, Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gm=
ail.com" target=3D"_blank">pauldzim@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This verion fixes a few things pointed out by Peter, and one by<br>
&gt; Felippe.<br>
&gt;<br>
&gt; This patch series adds emulation for the dwc-hsotg USB controller,<br>
&gt; which is used on the Raspberry Pi 3 and earlier, as well as a number<b=
r>
&gt; of other development boards. The main benefit for Raspberry Pi is that=
<br>
&gt; this enables networking on these boards, since the network adapter is<=
br>
&gt; attached via USB.<br>
<br>
Applied to target-arm.next, thanks.<br>
<br>
(Gerd, I&#39;m assuming from the fact you put a previous version<br>
of this series into a usb pullreq that you&#39;re happy with the<br>
&quot;usb: add short-packet handling to usb-storage driver&quot; patch<br>
even though you didn&#39;t provide a reviewed-by for it.)<br>
<br></blockquote><br>Thanks Peter! Does this require an update to Maintaine=
rs and<span class=3D"gmail_default" style=3D"font-family:monospace"></span>=
/or<span class=3D"gmail_default" style=3D"font-family:monospace"></span> th=
e release notes?<br><br>Thanks,<br>Paul</div></div>

--00000000000093332705a75d94a6--

