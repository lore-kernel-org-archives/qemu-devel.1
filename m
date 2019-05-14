Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089BAC46470
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C429221530
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZLBWtjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C429221530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQUZx-0001W0-JD
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 06:22:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hQUZ6-0001AX-J5
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hQUZ5-00045Q-MA
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:21:44 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hQUZ5-0003zt-Ez
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:21:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id o189so2261836wmb.1
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=q1bwrXGqrHFXXuWx7Jfvjk+A+/ggJ7v6BeBYYO9QDps=;
	b=HZLBWtjsfsVt4TgAMxo9pbeixbdXZScP9jRw6vjObs1j2qKHUbzrwUFday4pKHuB3/
	WB6qmHfpaSvOeSmRWQt8yxqX75ivIf5MUR0bEqOqjtz3wkyvfnpgVIZu1Y+IZwcmaqUD
	zZjRCkamwD8jYQ246gSVLSWdpfteSASCPjwnhrzq/3JQQdblrW3rYB3KLCBNyswIrrX4
	dDepnQGTPGDOdK6pYsXrXZQb3fIZrIYgQ9IyLS57BPlRgkati99tKYuZmf1EysPLsvX0
	TcpNe1CkAk3t7ZdBCKIEBQ1F8pXobvYCzQKqk3mloniZxPTFb08LBh2psurrcxghYZFB
	8FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=q1bwrXGqrHFXXuWx7Jfvjk+A+/ggJ7v6BeBYYO9QDps=;
	b=Vx2pzgb0FAO5eGpMGAHw19sPAlOeor6/g7XjaEgWg8I+KxCKLKkDuXB+QrNkzcYSF9
	E8AOxMBqAHB1rBmxxRYC7Cwjqbh34MFuCJ2mZNm6iqngBMhmDblZ4vBfKHUxwYimF3Kb
	dg3RGUvewjMznvHMfiOLfmBcV/v0TKJ/3XZE7A7ej+5o5MiLP/e9t6Nf3kX96nULH1Ld
	j905hZH5MLaTWFZJrUPxO77JOruB1gVwb6MPsHnBGl34WmDXlUBfaB83ZvU9gKkzhOHJ
	fcquHVZQQIHe+v4L8HrNapVvCd4opEnW39UqeEWIGz5c38yhqNlfZdYkBxYooeRHKL5A
	vWyQ==
X-Gm-Message-State: APjAAAX+nHhqlWVXJowX48aNHZl+BcXGBg/LAa5iV9gxOb28zfOdRqBq
	lmaPBJ05hXM8jZs1Ig2BMmP3/JOpEf97Erc1pkI=
X-Google-Smtp-Source: APXvYqyH/7dWWyj4SyTpmJb4ymwY4yh3VuVzTwqF14Q/Wka4Jn5vY6Wtiz49nqTWgzjXWQehbQhfRbX5nJbyvhVeaVc=
X-Received: by 2002:a1c:5f02:: with SMTP id t2mr18440541wmb.19.1557829301795; 
	Tue, 14 May 2019 03:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190513183325.8596-1-marcandre.lureau@redhat.com>
	<20190513183325.8596-4-marcandre.lureau@redhat.com>
	<20190514065109.eitymbi7d5gdjqpr@sirius.home.kraxel.org>
In-Reply-To: <20190514065109.eitymbi7d5gdjqpr@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 May 2019 12:21:30 +0200
Message-ID: <CAJ+F1CJkofOcoBh53BVUTtRh0woAaa0yd-LqUSqLOhzRVQ1Jbg@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 3/3] contrib: add vhost-user-input
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
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, May 14, 2019 at 8:51 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Mon, May 13, 2019 at 08:33:25PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Add a vhost-user input backend example, based on virtio-input-host
> > device. It takes an evdev path as argument, and can be associated with
> > a vhost-user-input device via a UNIX socket:
> >
> > $ vhost-user-input -p /dev/input/eventX -s /tmp/vui.sock
> >
> > $ qemu ... -chardev socket,id=3Dvuic,path=3D/tmp/vui.sock
> >   -device vhost-user-input-pci,chardev=3Dvuic
> >
> > This example is intentionally not included in $TOOLS, and not
> > installed by default.
>
> Patch doesn't apply cleanly to git master.  Also git complains that it
> can't find the sha1 and therefore can't try a 3way merge.  Does this
> depend on unmerged local patches?
>
> (same goes for the vhost-user-gpu patch in the other series btw).

Nothing special, patchew managed to apply the series.

But patch 2/3 here is bad, I'll resend.


--=20
Marc-Andr=C3=A9 Lureau

