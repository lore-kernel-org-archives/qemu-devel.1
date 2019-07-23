Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB6AC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10166218D3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKBR8VEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10166218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpwxh-0007oT-7O
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 11:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50449)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hpwxX-0007Oh-Dh
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hpwxW-0002h6-Es
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:44:11 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hpwxW-0002gZ-8x
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:44:10 -0400
Received: by mail-ot1-x343.google.com with SMTP id r6so44499265oti.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nRbQVkwsIt+YiMMIkxhYBhGqnWdgi33peTZVJ2xAS6s=;
 b=qKBR8VEpuIuVECc/QLfHrIrkLmCGLNWFt30pGNvR84OhHIzxQppVmePghj0FtlfKLm
 KYzK7VjjrFVduMP3PVqjRy2iABizdtHpenQeucl5GOIRw3imEJa81hpVMv+M30bKUVAG
 7OvF2gi9eviCQ5dqz/MMSWMusGcJajqjIcSukAVpfFKRU6/GTqEB411WTwGGib/Hogni
 C0Ms0wiMWMr3C5hH7h/HGaOumhREZQUIog0Hd1fcFsF1rLb3ALRrHI+k0EjpVp2KC2k9
 pkflAa5BTTqVWSw/pcBdJAww4MZn1+/XVBEns8r1Xb/93k4eheQq+ZlTG1ztNtCSzFfs
 663g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nRbQVkwsIt+YiMMIkxhYBhGqnWdgi33peTZVJ2xAS6s=;
 b=iXMuDn92+BhMtzfF/yUKr8L5bHBOTeDORp0Tz4pJcm+d3T/7SsY3Le3cSUxR1sxd/i
 OpMRsRGgyG4x9GIX01Zbh4NVQw9PHPl3fUwzzBf7rZAtN3dWNC7QSs++p/rfOgdUOdOe
 U+sYUDd8OIw5OK8QpAOrWNuDeH8GXhjfovvbphGLKSkzi5OvXp+cbmxFgER7r80xn++o
 J+DezCowPjHIXO2Buj0b8g3XNYaAz6wkgkNz8o5/UHtXi3tN8+On+9YxQ9kLOGgiU9BU
 Lhzxo8XUJ/qNkfDc4mzqS8khb3naPiIBk/vEn5IWNVQu65AX8ECwwTeEbwPA6U+guzaV
 vmZA==
X-Gm-Message-State: APjAAAXE3vAhay5bJO07GNpXv+frVONtgn03G2r6OHeyEOGLppNVl5zE
 7Y3xSNQLxBTB8QcHD5vweBXPIr7xJ++SjaJ8iwo=
X-Google-Smtp-Source: APXvYqzLMBDjrLArNmYWmxtxVCPBksIgRDNdJ1AmYgahuc2xWZUc6ZGHW7Pm2UbSr9HoRfueJRFB34SadfW9OwRerYs=
X-Received: by 2002:a9d:6c91:: with SMTP id c17mr34561677otr.181.1563896649309; 
 Tue, 23 Jul 2019 08:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190723104754.29324-1-ppandit@redhat.com>
 <20190723104754.29324-4-ppandit@redhat.com>
 <20190723130326.GC5445@stefanha-x1.localdomain>
In-Reply-To: <20190723130326.GC5445@stefanha-x1.localdomain>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 23 Jul 2019 23:43:33 +0800
Message-ID: <CAKXe6S+pXN0d6K9Vw=kxsy51bVz1PxXBHYEmTesUnYo8u8vcYg@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v4 3/3] net: tap: replace snprintf with
 g_strdup_printf calls
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
Cc: Jason Wang <jasowang@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@gmail.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:03=E5=86=99=E9=81=93=EF=BC=9A

> On Tue, Jul 23, 2019 at 04:17:54PM +0530, P J P wrote:
> > -            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s",
> > -                     helper, "--use-vnet", fd_buf, br_buf);
> > +            helper_cmd =3D g_strdup_printf("%s %s %s %s", helper,
> > +                            "--use-vnet", fd_buf, br_buf ? br_buf : ""=
);
>
> The change to the br_buf argument isn't covered in the commit
> description.  Why did you change this, was it a bug, etc?
>


IIUC, if we pass the NULL argument in g_strdup_printf, the 'helper_cmd'
will contain the '(null)' char.
If we pass "" to g_strdup_printf, there is nothing in 'helper_cmd'. The
original is like this.
So here Prasad has to check the 'fd_buf'.

So:

Reviewed-by: Li Qiang <liq3ea@gmail.com>


Thanks,
Li Qiang
