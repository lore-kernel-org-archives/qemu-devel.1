Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D4BC43215
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0818E206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJBNqxW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0818E206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvfZ-000500-Uc
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sameid@google.com>) id 1iUvbz-0001OP-VM
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameid@google.com>) id 1iUvby-00044B-Ip
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:35:19 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:37767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sameid@google.com>) id 1iUvbw-00041k-J2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:35:18 -0500
Received: by mail-qk1-x741.google.com with SMTP id e187so2285003qkf.4
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 08:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SkZ7vb9dOUvTVroUidoDFjMZpFuFCc60ezXoeOjm4Ok=;
 b=dJBNqxW8vTw6t3KaiY1EOt58shSLuxRhHA1NVADvsra1/HKpV7unGQPyt949M1VgBk
 Ny4r9bU83uR3klDzlTaMV5I/mBXXIiGZnhEgioq7WTgvLCnmW7W980mWeXwEqYzn3U3i
 6XY5y8Sjm1ME+3Ks420GXILpQNRjHqqNGX33P7WYrFImF9r6lLSW7VuMnzisCYj91FBf
 fJ7He3punD/f5Sw87ylf6oiH6u+NaX0CTJmpfbnI6g5upxBslTj17kCadHkArgEbygkM
 Q3DbBzKsGlPrx4UnCR395npKuxcuMIhDCn4UcqSfEujw/kQRIex4FJXRZU8Ht3FQoGyg
 et5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SkZ7vb9dOUvTVroUidoDFjMZpFuFCc60ezXoeOjm4Ok=;
 b=Qte6cHhSNsCDIs86c/ilCduJ3bXZ4MgyNNJ4EXWxSlLKc4WD6owmQdGs3XcQs0epJn
 +JHv2Doft88ydJBXCkvaCVffRFIvrTksl7Fz+9DKnioXkHB44dRPPFPfdp9ty+gyIIGD
 k6uXvezVrtRRduIz1M7h+bMOgNJYAt3mIAx3S7pySpGx3yShg/9Cq003mzw5OQrjEmSe
 6ZrsOlBx/O8qaySkOTYemkvax8EuGAaLasD5zz1Lm0NF1IMgvwgDXsGFK4dmoJEH9BMv
 OKx2hz1aPKs3LQPkebKHtWllhR8vAwBaxeCl+xdUEmruimqB10KYM62tiGUmQwKTzHIZ
 nzYQ==
X-Gm-Message-State: APjAAAU8IpUe9sUW9jaUZTo+9ldeVxWisusfRjFuqur+jHY08Z06cSgd
 6i8/hkEjX8iuWYfftIWPHEVQlXJNITqukn/00n+d8A==
X-Google-Smtp-Source: APXvYqyYfvXYeGxwgRhlHer3wZqydexi7OMg3bmionzBqAcC9FC14g8yI0FpQGD3oOHtECbO6pszlsHhjlixcea7+kE=
X-Received: by 2002:a37:b2c5:: with SMTP id b188mr3467737qkf.30.1573662914121; 
 Wed, 13 Nov 2019 08:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20191113091809.31365-1-kraxel@redhat.com>
 <84d3a1aa-bbb2-d831-0abc-fe1169f8a860@redhat.com>
 <20191113140057.2ocwfa3rqqfkbg3r@sirius.home.kraxel.org>
 <CAFr6bUn5W2-w3z4Ty9XD7mh+=kxVq2rQJ3ZUz5nXA13ZdxQtsg@mail.gmail.com>
 <ca6dadb1-fddf-5f6f-a6fc-f94eb02862b6@redhat.com>
In-Reply-To: <ca6dadb1-fddf-5f6f-a6fc-f94eb02862b6@redhat.com>
From: Sam Eiderman <sameid@google.com>
Date: Wed, 13 Nov 2019 18:35:02 +0200
Message-ID: <CAFr6bUkGrC64gXfLgeZ5hYEkzLF4J-NzNCG3X1deHEovyJ7qSw@mail.gmail.com>
Subject: Re: [SeaBIOS] Re: [PATCH] ahci: zero-initialize port struct
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 seabios@seabios.org, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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

Sure,

There are two issues here.

The first issue is that my commits which applied to seabios master:

* 9caa19b - geometry: Apply LCHS values for boot devices
* cb56f61 - config: Add toggle for bootdevice information
* ad29109 - geometry: Add boot_lchs_find_*() utility functions
* b3d2120 - boot: Reorder functions in boot.c
* 7c66a43 - geometry: Read LCHS from fw_cfg

Are not from the latest version which was submitted to the mailing list (v4=
)
* fw_cfg key name has changed
* The value and of the key has changed from binary (v1) to textual (v4)
* Other fixes and variable name changes.

So these commits need to be reverted and reapplied with the latest version =
(v4)

The second issue is that my commits, (in v4 too) will require this fix
that Gerd added ([PATCH] ahci: zero-initialize port struct) since they
change how SeaBIOS uses lchs.

Previously, before any of my commits, drive.lchs could contain "random
crap" since it was always set before being used in
setup_translation().

After my patches, get_translation() invokes overriden_lchs_supplied()
which checks: "return drive->lchs.cylinder || drive->lchs.head ||
drive->lchs.sector;"
So there is an assumption that "drive->lchs" is zeroed when lchs is
not supplied for the host.

This was true for all devices using "drive->lchs" (all were memset to
0) except ahci.
(I used 'git grep "drive_s * drive"' to find them all).

So Gerd fix is indeed needed and then all devices are covered
(drive->lchs is memset to 0).

Now only the first issue remains...

Sam

On Wed, Nov 13, 2019 at 6:12 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Sam,
>
> On 11/13/19 4:03 PM, Sam Eiderman wrote:
> > Hi,
> >
> > Does this fix a bug that actually happened?
> >
> > I just noticed that in my lchs patches I assumed that lchs struct is
> > zeroed out in all devices (not only ahci):
> >
> > 9caa19be0e53 (geometry: Apply LCHS values for boot devices)
> >
> > Seems like this is not the case but why only ahci is affected?
> >
> > The list of devices is at least:
> >
> >          * ata
> >          * ahci
> >          * scsi
> >              * esp
> >              * lsi
> >              * megasas
> >              * mpt
> >              * pvscsi
> >              * virtio
> >          * virtio-blk
> >
> > As specified in the commit message.
> >
> > Also Gerd it seems that my lchs patches were not committed in the
> > latest submitted version (v4)!!!
> > The ABI of the fw config key is completely broken.
>
> What do you mean? Can you be more specific?
>

