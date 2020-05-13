Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2488ECA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA18D206CC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA18D206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYmid-0007Mo-5k
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 04:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jYmhs-0006bi-Qv
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:25:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jYmho-0008P9-U3
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:25:36 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so10731167iov.11
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 01:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PWwUC0oYscwmWMCLjx5x2I4apKdnGNIbDeY2uI7/eo4=;
 b=qVSKf0PIzgMtCve3WDVK974dDwfVlgwCklmJCMydSDfwttV3c+1yaq98NVH0h0Ks5z
 1vWpo2NOzqmqVYNADG38gSn5tIoilvdChw6/wxTRv53o1DIpsSdXZrz2rkfr/H3fnnip
 y4lHdzE6OU1pdLCHG5USplkoKmGL9xxeEoIthdXFCaIMyLG8PV4H4uRJ6FNPO3aoI9o8
 TIBW3iXm0Jaoo5cn3oatnlRUPBCvPqzHDu5qF/dYWkA4a0DaTtb1ZmByc6Euqg0CHtkn
 Ccfrj/9Y+189OC4L0bj+AkbxWD4GpC4l9n6k8SnNPtCCvi077KkvUNUbEPShMnxSTeSj
 Xh3A==
X-Gm-Message-State: AGi0PuZmrCd9m/jhh0BouGCXoUDx99N5qHTbUXamSq3ukz63CFbE1KTA
 GF9wOpWRH3fU2buKBVBKh3n61HFRs0cfIiOKFSo=
X-Google-Smtp-Source: APiQypL5Wd22r/eO0Wd2UxNIUAGIUU0KDXQMz+d6nUDz3NlXjicskihKbXiH+aFpItX7dE/UpwtKrWp2pGK9En55xGI=
X-Received: by 2002:a02:ac1:: with SMTP id 184mr23829794jaw.137.1589358330770; 
 Wed, 13 May 2020 01:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
 <1586337380-25217-2-git-send-email-chenhc@lemote.com>
 <CAHiYmc5zPT97Zxr6JTXY8dHTSU7aFC3EY6ODgULuex-xRYWCQA@mail.gmail.com>
In-Reply-To: <CAHiYmc5zPT97Zxr6JTXY8dHTSU7aFC3EY6ODgULuex-xRYWCQA@mail.gmail.com>
From: Huacai Chen <chenhc@lemote.com>
Date: Wed, 13 May 2020 16:25:18 +0800
Message-ID: <CAAhV-H6bgF8McE7yR5JxXH=xSoGB3=wWJayym38WFCi=5XrNhg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips/mips_fulong2e: Set preferred page size to 16KB
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.166.67; envelope-from=chenhuacai@gmail.com;
 helo=mail-io1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:25:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Aleksandar,

On Wed, May 13, 2020 at 3:56 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> =D1=81=D1=80=D0=B5, 8. =D0=B0=D0=BF=D1=80 2020. =D1=83 11:08 Huacai Chen =
<chenhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE=
/=D0=BB=D0=B0:
> >
> > Loongson processor prefers 16KB page size in system emulator, so let's
> > define mc->minimum_page_bits to 14.
> >
> > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
>
> Huacai, thanks for the efforts regarding this series! I will very
> likely accept patches 1/3 and 2/3 from this series in my next MIPS
> queue, but the possible problem is that I somehow can't find patch 3/3
> from my series in my mailbox. (I think it also the case with the cover
> letter.) Could you perhaps resend the whole series? I'm concerned that
> patch 3/3 contains something important, and it would be a shame that
> it is omitted, and 1/3 and 2/3 are accepted.
Patch 3/3 is "Add myself as fulong2e co-maintainer", this is already
done in your series, so maybe I needn't resend?

Regards,
Huacai
>
> For this patch:
>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>
> >  hw/mips/mips_fulong2e.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> > index 5040afd..23897d7 100644
> > --- a/hw/mips/mips_fulong2e.c
> > +++ b/hw/mips/mips_fulong2e.c
> > @@ -399,6 +399,7 @@ static void mips_fulong2e_machine_init(MachineClass=
 *mc)
> >      mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-2E");
> >      mc->default_ram_size =3D 256 * MiB;
> >      mc->default_ram_id =3D "fulong2e.ram";
> > +    mc->minimum_page_bits =3D 14;
> >  }
> >
> >  DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
> > --
> > 2.7.0
> >

