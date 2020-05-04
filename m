Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9FBC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCE4206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKFh5TiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCE4206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdLy-0006aX-P6
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jVdL8-0005Gc-5h; Mon, 04 May 2020 11:49:06 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:36092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jVdL7-0001av-9F; Mon, 04 May 2020 11:49:05 -0400
Received: by mail-il1-x141.google.com with SMTP id c16so11691824ilr.3;
 Mon, 04 May 2020 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bN87UJXfjmwfM+atFCvecKPRgJa9fhNuqva5fTWGk0c=;
 b=PKFh5TiFOrzDXpdlAsWCWrRlmdldo/OUvKPxTwB+bQLhIeuwF/P7uSv6fqVfUx8XeR
 KI7adUBfIhKmlZlST81Ve/lYdLrvQXYX2RdZT8hDjLJCjWvin36vxzTHnFQ+fcqOoeU+
 gM1EqO3MGz+XSPXdKY+kgpK0+1SJ8rTXCZNAaYw9BomOWIc4lHFdh3glMbgcrzTaRqQE
 +oazMODGCS7FzfbbSr4bNc8ANTwPAlX2cEN0ShfAHCqUTsiZo02jY+aXf+GJhsKiE2HQ
 5yNptAJvSltdTj/gB1rfgFNSvq64QhSXfby9639CeqLG3ytxugPJPcQSbqe2pkcUtdwD
 oz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bN87UJXfjmwfM+atFCvecKPRgJa9fhNuqva5fTWGk0c=;
 b=p25BgkgL0z0dzu1hWAnGE8FzkV1lIBfDkuIVZWTNaNoVGA91zSRRArvBG4Kah2vksP
 XHtyCO2V7ysvy4Dr5sGjIboy7UHb9dfbgfNwSC+c1ancw5doItqS/Z3OwfmMayKe+8jb
 UyXEmfizRyIHipKEIrJpAhkpO2/S/NuaIXzXzZZEVgRHubZPEohbTP/GV8ZugP3w3GGU
 Cymrd/ssJZeDtsNBXEr7HqWI1Phs0g8pgMqce/mMCe1J+VxSzTgcB2wdI0fOPA6cbHu0
 aOna8i4sZRo6UWGxDQzRpujyxUkJ7permGRtP5KxsAQGen3E7E/Frys4Ubl2EPzTR2/j
 J3GA==
X-Gm-Message-State: AGi0PuZJsUYFfQZIwea+xizyOLKU8cTGbmpqa/zZTUbuwEbDYlKFPtDB
 PogPtjJerUxkAB5fywhqrxRgz32fHKct9QWamok=
X-Google-Smtp-Source: APiQypLvktqUqQAWexvReAvK7qqZb3HmmC/bCh1gFoa77AUtHNWBLvB50zqVBKagR1qCztIaPOqbgGS+tCbBf+g7l7w=
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr17258103ili.267.1588607342900; 
 Mon, 04 May 2020 08:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200504152922.21365-1-philmd@redhat.com>
 <20200504152922.21365-3-philmd@redhat.com>
In-Reply-To: <20200504152922.21365-3-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 4 May 2020 08:40:22 -0700
Message-ID: <CAKmqyKMQ2Z1sh8orth-8x0hq8LZ0T3JrNcgM=DkoyCN6CLjT2A@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] configure: Avoid building TCG when not needed
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 4, 2020 at 8:29 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Avoid building TCG when building only tools:
>
>   ./configure --enable-tools --disable-system --disable-user
>
> This saves us from running the soft-float tests enabled since
> commit 76170102508.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configure | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/configure b/configure
> index 23b5e93752..e3b4afbb60 100755
> --- a/configure
> +++ b/configure
> @@ -1663,6 +1663,10 @@ if [ "$ARCH" =3D "unknown" ]; then
>    linux_user=3D"no"
>  fi
>
> +if [ "$bsd_user" =3D "no" -a "$linux_user" =3D "no" -a "$softmmu" =3D "n=
o" ] ; then
> +  tcg=3D"no"
> +fi
> +
>  default_target_list=3D""
>
>  mak_wilds=3D""
> --
> 2.21.3
>
>

