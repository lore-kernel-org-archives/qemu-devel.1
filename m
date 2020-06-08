Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04D4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9837206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMWT1xnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9837206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiE55-00088U-1D
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jiE4M-0007V1-0F; Mon, 08 Jun 2020 05:27:50 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jiE4L-0008T5-D2; Mon, 08 Jun 2020 05:27:49 -0400
Received: by mail-pf1-x443.google.com with SMTP id j1so8124945pfe.4;
 Mon, 08 Jun 2020 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vV4fZGfYJ4eRcrwexfDLpAIPwReEjEGNDhORSq39EoI=;
 b=qMWT1xnQ2Ek/d41+2Oz6s6dzsjc1ad/1p0J7SirAtaGVYjAZwfWwWl+KFuZSOMLs3O
 8vnDROaCY7hmqFFMoaP8enBCN5s0tRiYaMaKTBBqrJ4AEwxnzSnasDADXokjcVdHl3xZ
 FDMa8MP9yf1FztKItmwGS5g0GrNOdVW5mjrwB0vgIcHipLossp6kfZy6BDQ6lW3b15XA
 WHiaKEJbg2cirM1D0Nz1lK50lP7uiV73eUs+zvyDSMDYVeL0xIlsURki5IKmop3HcsQC
 2w/79gOFepdCo+QebRKcI6OvuzdZ+Tk1fADaSrGHMORya6pR3Pvw2Iz1y9UNrjngVED/
 W3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vV4fZGfYJ4eRcrwexfDLpAIPwReEjEGNDhORSq39EoI=;
 b=m+EiDhm28F+U6j3Q+OFP60P3sLBD0M/NeGdnj5zMoEF1p/ht1FrFhQuVtqW8EoZ90q
 Qb9bUEJemRdkXFqTFHHX5U4a2zIItskyM43mv8rdhbCOXedkgDLNjp1pL1RdtIpxHBBB
 KdlWxTW7PdG3odZ6841+1QdVRVoRHX4koVaiY76IAqTv9YFmpaJ1Xiq+D4u+CrYNdPv3
 c5KbrpYHN5qFLM4mKfK2y+GEiiuIqJAlMXHMA+TGgP35qt2E1HnTZl0ulkwHkxT2FhpI
 M7+iMb6A9a8GFxJWGhlkpH8lWTMYQPOdexM6a8cbEh2jrCcnomAakU6Pv7TmSYZ6+sFZ
 JVyg==
X-Gm-Message-State: AOAM531V6uf/W4qGVAjRPqc7ywVGMn9NdHyfx6v4JnBDmkRLCkTHuMsi
 4e6X2RvNAP92p0YgirSRGYASx+DiG8yE4WCTV5o=
X-Google-Smtp-Source: ABdhPJxZdVvHKBP5SKFgOE+u46iVSD2aT941cvuMRffRZsa6epwruTrkE6TEliqEa+iVAfj56FlPnRHHqwPZhZzXSOw=
X-Received: by 2002:a62:3645:: with SMTP id d66mr7504745pfa.275.1591608467635; 
 Mon, 08 Jun 2020 02:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200608091508.19838-1-f4bug@amsat.org>
 <20200608091508.19838-3-f4bug@amsat.org>
In-Reply-To: <20200608091508.19838-3-f4bug@amsat.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 8 Jun 2020 02:27:36 -0700
Message-ID: <CAMo8BfLJrrAM9EL80SF36qLTO0Kut8ODOuDN5kC1LoVNjBKEYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/net/opencores_eth: Remove unnecessary address
 masking
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 2:15 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> The memory region is limited to 1 KiB, so the address is
> garantied to be in that range. No need to mask.
>
>   711 static const MemoryRegionOps open_eth_desc_ops =3D {
>   712     .read =3D open_eth_desc_read,
>   713     .write =3D open_eth_desc_write,
>   714 };
>   ...
>   725     memory_region_init_io(&s->desc_io, OBJECT(dev),
>   725                           &open_eth_desc_ops, s,
>   726                           "open_eth.desc", 0x400);
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/net/opencores_eth.c | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

