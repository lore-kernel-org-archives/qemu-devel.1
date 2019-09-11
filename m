Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D5C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 19:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9FD206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 19:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9FD206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i88Os-000306-1n
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 15:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i88Nv-0002FK-2S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 15:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i88Nt-0004Y8-No
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 15:34:34 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i88Nt-0004Xg-Gq
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 15:34:33 -0400
Received: by mail-yb1-f195.google.com with SMTP id z2so7773771ybp.9
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 12:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nRy3z5QR1LkdMSnlc9BpK3E+xj6jhz9+8qZTavJ/Wfo=;
 b=SOPujyUF7IiiW3xOsRG9bcysfC6yx2zHOvOwYLML+4qDcgXOf05lKh0ZyR+djXyMFK
 jeC02L/UI0i8azUOR59E2DyCZdxpfhTZwLa/IENweG2QI8uswHBW6qKaTfLpm6QvRmDG
 vZT/+GoSIDOXfsstFmcc2HAkgmBdB4rpArZqWmGuR1/yARfztxpOn23Uf/Y1o3dK5IAR
 yzeADefKf/OztEDR8ooQ0ZQQY9TKZhwSj5Dtb051MH3m/DZzhsDCW+DOgi/uBlJ12jWO
 3mk1ZmyEEAe2DqmGxkx+fCWtLccbOZMTxIvcCn4VGyCKnLdDcTO1Xl2ADhoI7IMuLggQ
 hVTg==
X-Gm-Message-State: APjAAAWwdKVu4P758hQ+GFmkn/HO7DOVjZBJbJ5xq4JJpzqLHpMS7uHL
 LfHHMjD3nOxPT9gbiVHfie46QEjvDtLTeDP6iR8=
X-Google-Smtp-Source: APXvYqz6sLyGldHin+xtefBhr/nq0h1d6e0nSIdAriBmHQrAn0/jxpG/DoOJuylldf18Ck5di0/YuKby9dsGv4CBhYM=
X-Received: by 2002:a25:141:: with SMTP id 62mr9854556ybb.387.1568230472253;
 Wed, 11 Sep 2019 12:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190908061543.25136-1-f4bug@amsat.org>
 <20190908061543.25136-5-f4bug@amsat.org>
 <046c1718-f938-b16f-5100-36406281f040@vivier.eu>
In-Reply-To: <046c1718-f938-b16f-5100-36406281f040@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 11 Sep 2019 21:34:21 +0200
Message-ID: <CAAdtpL4ykZAinOZWWUc6jU90DvEijEjaGrAJaRJ_3-bx3tn_zA@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.195
Subject: Re: [Qemu-devel] [PATCH v6 4/8] linux-user/syscall: Introduce
 target_sockaddr_nl
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
Cc: =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 9, 2019 at 4:23 PM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 08/09/2019 =C3=A0 08:15, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit :
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Tested-By: Guido G=C3=BCnther <agx@sigxcpu.org>
> > ---
> >  linux-user/syscall.c      | 6 ++++--
> >  linux-user/syscall_defs.h | 7 +++++++
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 8b41a03901..5128312db5 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -1494,8 +1494,10 @@ static inline abi_long host_to_target_sockaddr(a=
bi_ulong target_addr,
> >          sizeof(target_saddr->sa_family)) {
> >          target_saddr->sa_family =3D tswap16(addr->sa_family);
> >      }
> > -    if (addr->sa_family =3D=3D AF_NETLINK && len >=3D sizeof(struct so=
ckaddr_nl)) {
> > -        struct sockaddr_nl *target_nl =3D (struct sockaddr_nl *)target=
_saddr;
> > +    if (addr->sa_family =3D=3D AF_NETLINK &&
> > +        len >=3D sizeof(struct target_sockaddr_nl)) {
> > +        struct target_sockaddr_nl *target_nl =3D
> > +               (struct target_sockaddr_nl *)target_saddr;
> >          target_nl->nl_pid =3D tswap32(target_nl->nl_pid);
> >          target_nl->nl_groups =3D tswap32(target_nl->nl_groups);
> >      } else if (addr->sa_family =3D=3D AF_PACKET) {
> > diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> > index 0662270300..fcedd0d0fb 100644
> > --- a/linux-user/syscall_defs.h
> > +++ b/linux-user/syscall_defs.h
> > @@ -153,6 +153,13 @@ struct target_sockaddr_un {
> >      uint8_t sun_path[108];
> >  };
> >
> > +struct target_sockaddr_nl {
> > +    uint16_t nl_family;     /* AF_NETLINK */
> > +    uint16_t __pad;
> > +    uint32_t nl_pid;
> > +    uint32_t nl_groups;
> > +};
>
> You should use abi_ushort and abi_uint to keep alignments good (for
> instance m68k aligns on 16bit whereas others on 32bit).

Are you sure? The other target_sockaddr don't use that...
Is this because netlink is a host-only structure? (while other are
serialized over some interface).

Thanks,

Phil.

