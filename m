Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373CEC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 12:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0072D20757
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 12:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+BKOlKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0072D20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVEAh-0008HB-7h
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 08:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVE9x-0007iF-Mn; Sun, 03 May 2020 08:55:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVE9w-0004K9-87; Sun, 03 May 2020 08:55:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so12467595wra.7;
 Sun, 03 May 2020 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9WR9M2Jx9sP9QqMrvIt/lRPOgcp0VhfdcGx5VWlzzGE=;
 b=j+BKOlKAmZblQGnC8bLybEodoDMQ4VOY+ZafJIrL9tMVYfK+DigfPLm96pHeJFmjKj
 xoEQRGjn+8IwUFgLrNPm280FsitsEsMfKyYbmbYOFftf3daqY34fzBRHqVRHrjZieXlx
 40MaeaeaOVCNSQqWkQR/iLn/8KQRxj7XU4qb/Dav4hMDqZZT4i9y3i7XDXkUBWWBbpTv
 fXdtPFBg+Ma+38jwb1omDS3wWkDyf7KRurS6GAbsE0nykx0HT606gZfrEC0Yz3kEoNAb
 AHGrF0PI1WskJv2RWYGV17Sw5HkGOLhQfyej+Gql8pxy8WZpoQc7R3ayY5ws/ww5qX3z
 xAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9WR9M2Jx9sP9QqMrvIt/lRPOgcp0VhfdcGx5VWlzzGE=;
 b=tWZhFEGDR745uTTLue4ohSl2I2t6n6yviB4793HBZ2Dq1KuL8pieAHnN0oFWpAOjky
 M1U6aAYUkXxerS17ot4mkQ6YQ8fzgT/nlCg51gqEWm9NG5PpoCotDBWBr+yXPUczIxdh
 +3HAa2ScXtlgZxSQ8w3tcMoqjKBPsN5Rd0YrficJNMdg0eQYf2+w2samUSnkQcVyrAcP
 cAlS6ZS0XqJVeDzPRxCm+AsZuv/6ZgehN9q5NFuZBwnw8Lng407wpY7VROV3jG8MyrD9
 PtdRCXpi8YV2SV8X7LXV6LrLIDvKX/Z7J9Vsaf+67tiIe7xTOIwMLmhE3706Vjwl5vYl
 aH+Q==
X-Gm-Message-State: AGi0Pua1ZPDGkScYdO9ZCgblHkYNTQSkNnnBpnRI/k3ect5vyNUWeTZW
 CbwCfzsPox4HNp1DE52vQ8Op3nDBUnZVSu5Z1Ho=
X-Google-Smtp-Source: APiQypJcVBoz5K3wiSeBcVCQy76Un/iUGax3NZ444nFt6xcQrGyJ20VMH0GxwCN2R47SS+8rljPzGvtdbbF6Ct7TBtk=
X-Received: by 2002:adf:dc50:: with SMTP id m16mr13924379wrj.329.1588510550219; 
 Sun, 03 May 2020 05:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200503113220.30808-1-f4bug@amsat.org>
 <20200503113220.30808-3-f4bug@amsat.org>
 <CAHiYmc61KAjFHuYCMyRunkfMdf4DD83TFTo4DJF-58KZ5YQ+Jg@mail.gmail.com>
In-Reply-To: <CAHiYmc61KAjFHuYCMyRunkfMdf4DD83TFTo4DJF-58KZ5YQ+Jg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 3 May 2020 14:55:37 +0200
Message-ID: <CAHiYmc4J2fEfOU9tXi=TAHTMUXDY9oJ1Gc85gT-+q=5EQ-oyzA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] linux-user/mmap: Fix Clang 'type-limit-compare'
 warning
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 14:49 Aleksandar Mar=
kovic
<aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> =D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 13:33 Philippe Mat=
hieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > When building with Clang 10 on Fedora 32, we get:
> >
> >     CC      linux-user/mmap.o
> >   linux-user/mmap.c:720:49: error: result of comparison 'unsigned long'=
 > 18446744073709551615 is always false [-Werror,-Wtautological-type-limit-=
compare]
> >           if ((unsigned long)host_addr + new_size > (abi_ulong)-1) {
> >               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
> >
> > Fix by restricting the check for when target sizeof(abi_ulong) is
> > smaller than target sizeof(unsigned long).
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  linux-user/mmap.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> > index e378033797..b14652d894 100644
> > --- a/linux-user/mmap.c
> > +++ b/linux-user/mmap.c
> > @@ -714,6 +714,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulon=
g old_size,
> >              errno =3D ENOMEM;
> >              host_addr =3D MAP_FAILED;
> >          }
> > +#if TARGET_ABI_BITS < TARGET_LONG_BITS

Or, for that matter, a comment should be inserted before this
line with explanation why the check is not needed for this case.

I think QEMU is too full with unexplained "ifdefs", which, of
course, doesn't help readibility.

> >          /* Check if address fits target address space */
> >          if ((unsigned long)host_addr + new_size > (abi_ulong)-1) {
> >              /* Revert mremap() changes */
> > @@ -721,6 +722,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulon=
g old_size,
> >              errno =3D ENOMEM;
> >              host_addr =3D MAP_FAILED;
> >          }
> > +#endif /* TARGET_ABI_BITS < TARGET_LONG_BITS */
>
> Hm, Philippe, this will silence the clang error, but is this the right
> thing to do?
>
> Why do you think the case:
>
> TARGET_ABI_BITS < TARGET_LONG_BITS
>
> doesn't need this check? In any case, for clarity, the reason should
> be mentioned in the commit message.
>
> Regards,
> Aleksandar
>
>
> >      }
> >
> >      if (host_addr =3D=3D MAP_FAILED) {
> > --
> > 2.21.3
> >
> >

