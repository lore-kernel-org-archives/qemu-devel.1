Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56754C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A4520692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZr0y4qS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A4520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBgY-0002iP-Su
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@google.com>) id 1ip98b-0004iN-7D
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@google.com>) id 1ip98Z-0008SV-0y
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:04:32 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:42156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@google.com>) id 1ip98Y-0008Nk-Ly
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:04:30 -0500
Received: by mail-lj1-x244.google.com with SMTP id y4so2840268ljj.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 03:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GPrQXU7r+8TzRDkPJO/Bd8pkbD2/ocdKHXv4Gtb6bio=;
 b=KZr0y4qSlDhNV7qd/WU0KFsW4rQ10koeM7ltZ47PDf/xkOAgPg+CO8SawpL8Nu2Xap
 ZlYe+qjlf9wuKZxJe12MNmC3pIc48j3rbyx+hPUOYZH05ilxdIAdK6Qfo2YpfnUj+/a2
 fEJb1NqaJTe56CToJryA7frL72vlk1R1uJym0zxO207guv+R6aIwTbb77lJuBdgz/Ylc
 cFYgyY1+EE4G9UtMkUNs3LT9+rvSNfL7X9AUJozMXrel9ZjGmqimuovVXGAC5u8dvwSZ
 feaNwQLDDmlv3MXXJly4KfsndCVMuZvMaHnoLPL3+NEw6Zxopalx2bvCLUAo1Q15K0w1
 LSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GPrQXU7r+8TzRDkPJO/Bd8pkbD2/ocdKHXv4Gtb6bio=;
 b=nojkcfD65uspJGW8zpVoNALHgu2bY/rvRDP/LPxznQ/HNQJfqxH0hdb20um+9mPLdz
 9fbS/ql/MAG8KsxihF7aQziXSCclUa9pxVTZYoHBidnM2WcsxKj92O5FPlDiTd9WGc4G
 zvSsOcXqNgEBmrDZRLnZCB+3/MxOvbfop151m+Tps0V44XaiAVBuGcpnl2UyXpI9YsbB
 K+ddpGp5LkhmU1gErMrGhVT4P+3US7QJAclZwgtPd5TIk717RfcII7G2c5VljwRLnwdo
 a3Ex1ZZHpHm0Vn0lh4l+hP5ri2+ILnq3X/MF9AMIt5H6K1l99tDxFLqQbQoAeWsRBgKc
 5mCg==
X-Gm-Message-State: APjAAAWjqU4vU5eXXKFYPFwvtyExyPLAOt0nct/qF0YjCn3nr72oZAtv
 o3DVap871XUauu6gIjX7NcpJU4db2DNqewP8Mnt3yA==
X-Google-Smtp-Source: APXvYqws3/HwIKqBCkja9W+hEagukHWxJPaQ99txhgJJvv2brBb8a9BbAtoGAvQgUKcfopn2JcbVrQAwMxEkctRXS8k=
X-Received: by 2002:a2e:9942:: with SMTP id r2mr2613964ljj.182.1578481466681; 
 Wed, 08 Jan 2020 03:04:26 -0800 (PST)
MIME-Version: 1.0
References: <CAD=HUj6FA3VoTJqNa+gmAgVOv9zS7Qk9pdg46EY9NvtJOdz5_A@mail.gmail.com>
 <20200108104002.jxh6amnrazhnamej@sirius.home.kraxel.org>
In-Reply-To: <20200108104002.jxh6amnrazhnamej@sirius.home.kraxel.org>
From: David Stevens <stevensd@google.com>
Date: Wed, 8 Jan 2020 20:04:15 +0900
Message-ID: <CAOiLmNHMAz6UqxuEsiq6Y_dSNcCvtBrFR-FHG6voJAhpF8SeeA@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 1/2] content: define what exporting a
 resource is
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Stevens <stevensd@chromium.org>, virtio-dev@lists.oasis-open.org, 
 Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, 
 Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, 
 Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, 
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, 
 Pawel Osciak <posciak@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: multipart/alternative; boundary="0000000000001bcba4059b9edb4b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
X-Mailman-Approved-At: Wed, 08 Jan 2020 08:43:53 -0500
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

--0000000000001bcba4059b9edb4b
Content-Type: text/plain; charset="UTF-8"

>
> Hmm, I'd suggest to move the whole thing into the virtio-gpu section.
> There is no such thing as a "resource" in general virtio context ...
>

If this is moved into the virtio-gpu section, then any device type that
imports resources will have to refer to something defined by the GPU device
type. This would make the GPU device type a sort of special device type
that isn't just a leaf node of the spec. I think it's better to define
'resource' as a top level concept for virtio devices, even if the specifics
of what a 'resource' is are defined by individual device types.

-David

--0000000000001bcba4059b9edb4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hmm, I&#39;d suggest to move the whole thing into the vi=
rtio-gpu section.<br>
There is no such thing as a &quot;resource&quot; in general virtio context =
...<br></blockquote><div><br></div><div>If this is moved into the virtio-gp=
u section, then any device type that imports resources will have to refer t=
o something defined by the GPU device type. This would make the GPU device =
type a sort of special device type that isn&#39;t just a leaf node of the s=
pec. I think it&#39;s better to define &#39;resource&#39; as a top level co=
ncept for virtio devices, even if the specifics of what a &#39;resource&#39=
; is are defined by individual device types.</div><div><br></div><div>-Davi=
d=C2=A0</div></div></div>

--0000000000001bcba4059b9edb4b--

