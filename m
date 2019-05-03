Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C404C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD772081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=connect-hku-hk.20150623.gappssmtp.com header.i=@connect-hku-hk.20150623.gappssmtp.com header.b="XwtuNLM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD772081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=connect.hku.hk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44963 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbqF-0002fM-FS
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:19:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMblN-0007D1-Rh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMblM-0001RQ-UJ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:14:21 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:37685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hMblM-0001QL-Io
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:14:20 -0400
Received: by mail-yw1-xc44.google.com with SMTP id l8so1956801ywm.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=x0aCQ5qBwgt9DWvdLtyGVrRtiZ9Wk6BDR2oeCRD0tww=;
	b=XwtuNLM+QPBiu6YJ/ZgNHJn/Eu2EJkRlxi6ienrnS73Za5YMQTvOL/HVprpf1pSvUK
	eUz223PwF8i3d7OClAUgh/xok25X9VLDlQG0qRcPiTnQRE01VEzJwJFywwV5ekGdU+RP
	pbxMf7W5lwGql3JMXsomcD1iuIcKzwA5zoap6K64j/4WBHLMS+RekfIOELv1S/WM9WJk
	onsZoVAIvZYcZvH0jERocokWN53s1rxWt7hMhOfkRw27cPB0lMB3SrjX03sR6gk5rLZv
	jWwyEVZDss7ATwXoslqygXSFwoFv6p/cNmjAEnwRY7aBM4+WulYrUEuQ9O4g0fUo8cOQ
	Orxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=x0aCQ5qBwgt9DWvdLtyGVrRtiZ9Wk6BDR2oeCRD0tww=;
	b=DB5kLq3h936pcuLz5ArXsxokqNKqGCaLRtL3pTef7JsOjfMqRSaDZwJ3OusaYPuyEC
	J4gjCpvt3nrP42r4184V65B8wq9siwiZkgmI/EKBGMNVuN9COXIfyN0VcWaUFvYcuGI+
	5WB46cwc2OvE1uDmmdjk82ExRMIfOyPUlGgXfV87PuoKFdVrEeywmgHH1eDXjSOsCZsA
	Z/osytnE8ADRlAbdi9q/jyO/OCiCnr2XuneTJPfvUmU3vPCRVOsMA8z8LUQjkNMyk6vW
	4qneV4B5w0fYR+cKCvY6AP1q535u/xYyzDJpM9RqfgUp7fEZ5fa6zsLGpBIRilRza9l/
	9Tlw==
X-Gm-Message-State: APjAAAXJIT7LteStHQCeAVlYG3CUpQ2LjXxY/Gjyx1Pp7CHliMpe+szy
	MuD8ox0bWYVyovlyo9J+PiG0k0S4pgoDxxIjXD+y3Q==
X-Google-Smtp-Source: APXvYqyEmXs627YIjRRJIileqa6wgZqCKVFv1HFs7FjEv24cZY7EBgZIYi6j8qc90R+Dm8CQtSkM+vWmI7myYUJsrow=
X-Received: by 2002:a81:e0d:: with SMTP id 13mr8357280ywo.336.1556903659437;
	Fri, 03 May 2019 10:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190503154424.73933-1-liboxuan@connect.hku.hk>
	<87bm0j4im0.fsf@zen.linaroharston>
	<CALM0=-=b+z2aW-cuM=hmk3_oKG7w3ianMo_ZA7gj8zMgCOfC3g@mail.gmail.com>
	<878svn4gnq.fsf@zen.linaroharston>
In-Reply-To: <878svn4gnq.fsf@zen.linaroharston>
From: "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date: Sat, 4 May 2019 01:13:43 +0800
Message-ID:
 <CALM0=-m0Vd1YMn6s36oRbsqFCwjPwdga5Q0XRoO41dq6iw1Lzg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4] hw/virtio/virtio-mmio: Convert DPRINTF
 to trace and log
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503171343.oBHuFmJELdaelFQ-mydHPxv529MEqNIKlP_T6YubBo8@z>

Gotcha, thanks for the tip!

Best regards,
Boxuan Li

On Sat, May 4, 2019 at 1:00 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:

>
> LI, BO XUAN <liboxuan@connect.hku.hk> writes:
>
> > Hi Alex,
> >
> > Sorry about that, I am still trying to get familiar with the patch
> > submission process. Since my patch has been changed from your last
> review,
> > I thought it would be safe to not include the r-b tag from last time.
> Will
> > take care next time!
>
> That's ok. As a general rule as long as you haven't substantially
> changed a patch it's safe to keep previous r-b tags. You can always
> mention it in your cover letter if you are unsure.
>
> --
> Alex Benn=C3=A9e
>
