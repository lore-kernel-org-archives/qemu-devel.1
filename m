Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565C6C38A2A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A65220722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbelZUrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A65220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXwvC-0003W5-8a
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jXwu1-0002ii-1E
 for qemu-devel@nongnu.org; Sun, 10 May 2020 21:06:41 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:34089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jXwtz-0007WX-SI
 for qemu-devel@nongnu.org; Sun, 10 May 2020 21:06:40 -0400
Received: by mail-lj1-x241.google.com with SMTP id f11so7653496ljp.1
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 18:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=onNWIa2FOZ31nfganHbfuVqwz/Y4eXhGGaqpIddJx1U=;
 b=DbelZUrv4o05YnDAecjhkm2Dzmb2K70F/SepW8zyExc3WrnJNRvKGeRgApqtTSt2yQ
 cfBk/NM3z/WL9nGvFxO61o1L46R7xeUQsK7azXSfHd9XiP1Ro+eS4BYHemwzyr7Cl1Gj
 /fqZEmykBt28GC9qqawvHUiBZibdIIeSWqULe3/hQkOfsZ61UxyYDeRlRFPBrHAVWyw1
 0dRl9yNntP65d5umx+i3YPRxDgfIiaAw9+G9zlggXASz+ukcya8vvf94v/s3UBZ3VzEY
 H/xXPyrz+8eP/HYLO9rQV6Qf6zH9S3RVHmCZb5QOtrukqgF7K0+tcT9SfsVtkJMJEMSL
 iJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=onNWIa2FOZ31nfganHbfuVqwz/Y4eXhGGaqpIddJx1U=;
 b=qeLM8H4DUhe7Srgaj/b0hqEkI0wrs9/+OOOxALrySbh1Mb6S886a0VzlO8RlNwYBcB
 KY9oOmZXMLi2+emT0b7RYi9fXoywfJd/96xYItp80YQLNyRS/Tbh+ckLVZ+Zj2QHZ180
 NzQ6HC0TbsxBEYehJeDv9cKT1E7oY1Cm9Xv/9mO0THSxUmNnsiedGA5U/IFrVRluFW4c
 pjjX63p97BDmC7NqGbbARsaa3rJtSKWSBiGB2veb8hX4rS4jif/XQNmJCVH2uRtQ5eEX
 jPg2kUpayx2kw9+OPmekrcrr5MPfD2QaS7Y1cCbMUAPm4UFEVBEJcELVSI8a10cnDGIq
 hRGQ==
X-Gm-Message-State: AOAM53220NYkF0GEOigzpQ+ngbg/ikNyvPCV7dJpFwzpvx6Aghu9lASp
 ELG8xQNDTQUuGx8vZciZlGHLTluG4qoALm6dsoo=
X-Google-Smtp-Source: ABdhPJx5y+REiVWpTN8/KCGaqEczTs3+N5K5rLtPFo1vdX3y5zxP3aMa4EKY52PQn2SllcV0iPV3L0Xp+OY0AVAPXjI=
X-Received: by 2002:a2e:6e13:: with SMTP id j19mr8652663ljc.292.1589159195013; 
 Sun, 10 May 2020 18:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200510210128.18343-1-f4bug@amsat.org>
 <20200510210128.18343-3-f4bug@amsat.org>
In-Reply-To: <20200510210128.18343-3-f4bug@amsat.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Mon, 11 May 2020 09:14:16 +0800
Message-ID: <CABDp7Vr=z0o7-G6fMOUfs7kRMvVW9SYitR==KQfG+iVXnuPPjQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] hw/mips/fuloong2e: Rename PMON BIOS name
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,  Philippe,

On Mon, May 11, 2020 at 5:05 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> I'm not sure where 'pmon_fulong2e.bin' comes from. As I always
> found this bios named 'pmon_2e.bin', rename the definition.
>
The Fuloong BIOS doesn't integrated in QEMU, so its name can be
anything. So, let's keep the old name (I think the old name more
distsinguishable)?

Huacai
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/mips_fulong2e.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index ef02d54b33..f067fa9720 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -69,7 +69,7 @@
>   * 2, use "Bonito2edev" to replace "dir_corresponding_to_your_target_har=
dware"
>   * in the "Compile Guide".
>   */
> -#define FULONG_BIOSNAME "pmon_fulong2e.bin"
> +#define FULONG_BIOSNAME "pmon_2e.bin"
>
>  /* PCI SLOT in fulong 2e */
>  #define FULONG2E_VIA_SLOT        5
> --
> 2.21.3
>
>


--=20
Huacai Chen

