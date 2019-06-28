Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D336BC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55F320645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLRHcj2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55F320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtQN-0003oU-U7
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33654)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtHo-0000TV-4Q
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtHm-0004kg-Sh
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:59:40 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39863)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtHl-0004eG-F3; Fri, 28 Jun 2019 11:59:38 -0400
Received: by mail-lj1-x242.google.com with SMTP id v18so6489224ljh.6;
 Fri, 28 Jun 2019 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7cUWX/ZieAKkgIsDyf9qkme3Oof2TM034f9jO2yRigU=;
 b=qLRHcj2K10tqhKf9aBRDi4ZXEqS9XN26m73UxY6wB1RPKk6CEdlMOtfIuLmvMkpvfO
 BVGMCdrvxzSrhCJP+LSWqPF1q2/7fGKeVX8wdUKLuTvmF2y/WEYhbLW89pdSG8p9hA7n
 u3+f6zWP5x83UyE6AF/sNXq3HHRZKlU3hcqATj2+rXNXrG+iOam1MylFzIj88OvcN/44
 D+c5L+IhHYTodHrCFGJU3F+Cths63CAfnGhEVPT7ncP3IfN9087SHDxji2okcl8Boibk
 flsDC9bvLBo0KIfVF8rveXYol5DPMCgCmvB87VE+IRUpCljIMKofL3qGb0Cf6sf8Yv5m
 JqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7cUWX/ZieAKkgIsDyf9qkme3Oof2TM034f9jO2yRigU=;
 b=SEy5ysTTkOSUwTvnUhao+o8j4gY0wD2vlUG+1nBCi7mcVTdl3w6CiVTU4khDIAXUzy
 O4mKSTdS+uWh7MjctUTwETaMxnltHcdymABGO25dFnMxTTflIRpsR2heKSpdKP2PGFPP
 J73CzXNt6xg8nQb+s37TvLz0tutxDo+kyafDmYNBKdHPeAD3rE3zOsqM7Q5RSVtdrP+H
 f7pQxwfFMIfn9AqTkmGKpdoxWRthxnQQ4+/enYj9ovayaypGGGd6zbC0ZkO0+Arf0c4N
 sFrAYDd7ohqVGhUxCV3eq6o9YJBK7V07KS5qfaw/njQnimnVXiB9rvr9xCrhxDEjiIl2
 sLjw==
X-Gm-Message-State: APjAAAUVPn4lA/Un4yBxm1t2cw4Dr2itRSAWabJmX91GcDRyfUnoDdkS
 SnuLeizNhfcIjnIZybv1J0ESsS/b2NpC22vzx1Y=
X-Google-Smtp-Source: APXvYqzQvjbcLxYrrCCskCm6IVc7U45KkUWqxa3fcWEbLHtIfDsCU2p/J50N9QefW1EpEjyLSL0bv+hSbx0UmITR+yo=
X-Received: by 2002:a2e:480a:: with SMTP id v10mr6393865lja.94.1561737570112; 
 Fri, 28 Jun 2019 08:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-6-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-6-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 08:56:29 -0700
Message-ID: <CAKmqyKNWXhv6TVyv5AtHw9JPqLmMyk7w6JJFELs5C20Xt4fEQQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v5 05/28] hw/block/pflash_cfi02: Add an
 enum to define the write cycles
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 1:44 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> No change in functionality is intended with this commit.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: Extracted from bigger patch]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 43796e551a..303d225f23 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -57,6 +57,11 @@ do {                                                  =
     \
>
>  #define PFLASH_LAZY_ROMD_THRESHOLD 42
>
> +/* Special write cycles for CFI queries. */
> +enum {
> +    WCYCLE_CFI              =3D 7,
> +};
> +
>  struct PFlashCFI02 {
>      /*< private >*/
>      SysBusDevice parent_obj;
> @@ -286,7 +291,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
>          if (boff =3D=3D 0x55 && cmd =3D=3D 0x98) {
>          enter_CFI_mode:
>              /* Enter CFI query mode */
> -            pfl->wcycle =3D 7;
> +            pfl->wcycle =3D WCYCLE_CFI;
>              pfl->cmd =3D 0x98;
>              return;
>          }
> @@ -458,7 +463,8 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
>              goto reset_flash;
>          }
>          break;
> -    case 7: /* Special value for CFI queries */
> +    /* Special values for CFI queries */
> +    case WCYCLE_CFI:
>          DPRINTF("%s: invalid write in CFI query mode\n", __func__);
>          goto reset_flash;
>      default:
> --
> 2.20.1
>
>

