Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F33C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D843920828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D843920828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBN2e-0004uR-00
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 14:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBN1g-0003hA-Cl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBN1d-0003CQ-E0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:21:14 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:51583 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jBN1c-00038e-Tu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:21:13 -0400
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
 by postfix.smtp1.imsva1 (Postfix) with ESMTPS id 28AE134DE6
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:21:02 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C537811004A
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:21:01 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B943B110045
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:21:01 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
 by imsva1.lgp.ehu.es (Postfix) with ESMTPS
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:21:01 +0100 (CET)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com
 [209.85.166.52]) by smtp1 (Postfix) with ESMTPSA id 62D3A34622
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:21:01 +0100 (CET)
Received: by mail-io1-f52.google.com with SMTP id t26so2376559ios.11
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 11:21:00 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3fMIo3FoM1DEkF5zUsbdMl5V5BIkQjlzggMpxeoWurHLsiddVG
 bEhQR5fERpM7/vrmtqYI1Ke87E+dBS9VMJfxJw==
X-Google-Smtp-Source: ADFU+vtXur5gbWXSiDiGhwFdscxuUO/Uo3ZyyjpBrtD3Hwimyi/LVICT2i4F4Jvlc4Bs6uXFte7A2eCn46lWG9Ob/18=
X-Received: by 2002:a02:c942:: with SMTP id u2mr16697427jao.49.1583778059809; 
 Mon, 09 Mar 2020 11:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200307172248.GA9@afee69d503a7>
 <1ba522c6-cae8-9e1f-ebf4-696076d2ca45@redhat.com>
In-Reply-To: <1ba522c6-cae8-9e1f-ebf4-696076d2ca45@redhat.com>
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Mon, 9 Mar 2020 19:20:48 +0100
X-Gmail-Original-Message-ID: <CAGZZdDEqW4wkqsrYHYPy5ex1jqn5AAdbb4S0uzjfegMvwDUXmA@mail.gmail.com>
Message-ID: <CAGZZdDEqW4wkqsrYHYPy5ex1jqn5AAdbb4S0uzjfegMvwDUXmA@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] qemu-binfmt-conf.sh: enforce safe style consistency
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a8783e05a07010b8"
X-Greylist: ACL 188 matched, not delayed by milter-greylist-4.6.2 (smtp1
 [10.0.100.73]); Mon, 09 Mar 2020 19:21:01 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25280.001
X-TM-AS-Result: No--7.637-7.0-31-10
X-imss-scan-details: No--7.637-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25280.001
X-TMASE-Result: 10--7.636800-10.000000
X-TMASE-MatchedRID: Dd3I5NVGlbWgBUTSh64wSUKGB4JJ2ELXO4rmf5nWGLaqvcIF1TcLYKDC
 wNPUO2EFuTy74kQkEIJOHJZtIbb+sqdEjxbnR+wFgRTWSf0X8xkA+JHhu0IR5vBvPrJMSOFHNli
 ywith3TToEU9QFg66iGELR5bg5nwH5Ev91/MDgla/Jrpc+Y//jwZyESFXAljfnF+Nm+WXvuIzy+
 CKVy54Htzaad7ROSD8pmqRctPy1oeOdk16g9Qx2WhQCsqhuTNiJd2n2XoSRFlpPI6NmimM1BtgC
 xIlF6QYYYS/vMwAxmuAMuqetGVettLvsKjhs0ldcJktTZ6qE7icfuxsiY4QFO5Fu38LTWqA6Y1H
 CEbiifr/EAux5zou/JRn2d38wHu5HWvlw73WvTyl63Pi+ahzVRBJqJQjOUquqbb+CmAcounJjoQ
 vRfijnsC+ksT6a9fy
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp1.imsva1 [10.0.100.73]);
 Mon, 09 Mar 2020 19:21:02 +0100 (CET)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 158.227.0.66
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
Reply-To: unai.martinezcorral@ehu.eus
Cc: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a8783e05a07010b8
Content-Type: text/plain; charset="UTF-8"

 2020/03/09 16:01, Eric Blake:

> On 3/7/20 11:22 AM, Unai Martinez-Corral wrote:
> > Spaces are added before '; then', for consistency.
>
> For consistency with what?  This is not our prevailing style; as
> evidenced by this pre-patch search:
>
> $ git grep 'if \[.*\];' | wc
>      274    2186   18170
> $ git grep 'if \[.*\] ;' | wc
>       25     256    1573
>
> and you are diverging from the dominant pattern.
>

For consistency within the script that is being modified. I'm not trying to
diverge, neither do I prefer any specific style.
Although the style in the current master is not consistent, ' ; ' is
significantly more frequent. When I was told to keep consistency in v2, I
picked that because it was the most common.
Anyway, I will push a new version where all these are changed to the
dominant pattern outside of this script.


> This part, however, is good.  Since one part is controversial, you may
> want to split this into two patches, or even drop the reformatting part.
>

Since the current master is neither consistent nor coherent with the
dominant pattern, I don't think I can drop the reformatting as long as I
want to fulfill your requirements.

--000000000000a8783e05a07010b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
<div dir=3D"ltr" class=3D"gmail_attr">2020/03/09 16:01, Eric Blake:<br></di=
v><span class=3D"gmail-im"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 3/7/20 11:22 AM, Unai Martinez-Corral wrote:<br>
&gt; Spaces are added before &#39;; then&#39;, for consistency.<br>
<br>
For consistency with what?=C2=A0 This is not our prevailing style; as <br>
evidenced by this pre-patch search:<br>
<br>
$ git grep &#39;if \[.*\];&#39; | wc<br>
=C2=A0 =C2=A0 =C2=A0274=C2=A0 =C2=A0 2186=C2=A0 =C2=A018170<br>
$ git grep &#39;if \[.*\] ;&#39; | wc<br>
=C2=A0 =C2=A0 =C2=A0 25=C2=A0 =C2=A0 =C2=A0256=C2=A0 =C2=A0 1573<br>
<br>
and you are diverging from the dominant pattern.<br>
</blockquote><div><br></div></span><div>For consistency within the script t=
hat is being modified. I&#39;m not trying to diverge, neither do I prefer a=
ny specific style.<br></div><div>Although
 the style in the current master is not consistent, &#39; ; &#39; is=20
significantly more frequent. When I was told to keep consistency in v2, I
 picked that because it was the most common.<br></div><div>Anyway, I will p=
ush a new version where all these are changed to the dominant pattern outsi=
de of this script.<br></div><span class=3D"gmail-im"><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
This part, however, is good.=C2=A0 Since one part is controversial, you may=
 <br>
want to split this into two patches, or even drop the reformatting part.<br=
></blockquote><div><br></div></span><div>Since
 the current master is neither consistent nor coherent with the dominant
 pattern, I don&#39;t think I can drop the reformatting as long as I want t=
o
 fulfill your requirements.</div>

</div>

--000000000000a8783e05a07010b8--


