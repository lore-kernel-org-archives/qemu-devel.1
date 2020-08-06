Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3BCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:01:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9252075A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="YC2LsDIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9252075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3poq-0004f6-Mz
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 20:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pls-0003jG-Qf; Thu, 06 Aug 2020 19:58:05 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:42431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3plr-0005j6-BU; Thu, 06 Aug 2020 19:58:04 -0400
Received: by mail-ed1-x543.google.com with SMTP id df16so20061859edb.9;
 Thu, 06 Aug 2020 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dwPzxmLXN+yX/OQMLKEPCt0XuTuduWedD+g/vwJBqqA=;
 b=YC2LsDIh6v/4VF3IFjVvpBWQqcTUQKSj2BLFN3jfDAUpWh3Kv3dhh/7sDtEIvG9+Hy
 hMGmKsos1q3S0IpqqxjvP55HdhjORp98N8QBNSkiHcucky+4o7PygpB3Ij0IPRp+BX13
 eATAWNQh7FJ2eCFBh6Bz46aoeuS4tQPipYPKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dwPzxmLXN+yX/OQMLKEPCt0XuTuduWedD+g/vwJBqqA=;
 b=INFIt0KQytlLqJh3KRjE0QNDvSRe6TD6ACcTvqoZFC86mKGRyifR3bqM1eSYcLM1YC
 GNJ/NkSZ09L0Hfeh7pyzltACwPYB7p73uo2IhAebHBWR1b/hD6XBJx0e+rQVRAJpLdhs
 197W0wv/NQ9k6Zn8TckfIsBxcKdh9d96PxpbrkWwMtAzmAL+c1juKmC/HEZwL4mVYDcK
 8UmlG64RB3X42r0Oa97HfbVpY3KmXP7Bpn2oVsCUeXtJaP4NxTZUKHGfBzcejZKQkCCo
 BUac5IIVCaCzWTKp2dlvYzO7OH0stMFdf2bxLAqax2o9lqfz4sXI6CB/alExVn8/SwyX
 JVyw==
X-Gm-Message-State: AOAM5315zrqaeZBKZGk1BNOLqK/JgusIDtVY5Toe558OwCJBmyOs3fOR
 K6Uvlaru8TvGgGK6ZVhaknos6eSMT1zYiEWi4D8=
X-Google-Smtp-Source: ABdhPJxqTSfJQZmvWaz3URj8mfYOEevjsgk6ScVyH35a4q+zV4Q9e54oaqupugqNI7/yP0X6HxH3/Ztj5losqvai8DY=
X-Received: by 2002:aa7:ce90:: with SMTP id y16mr6503479edv.325.1596758279088; 
 Thu, 06 Aug 2020 16:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-15-clg@kaod.org>
In-Reply-To: <20200806132106.747414-15-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Aug 2020 23:57:46 +0000
Message-ID: <CACPK8Xcr3j=egQChJiNs+y++qac3_ekODPasnV_z59nxzR0Nyw@mail.gmail.com>
Subject: Re: [PATCH for-5.2 14/19] ftgmac100: Fix integer overflow in
 ftgmac100_do_tx()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, Andrew Jeffery <andrew@aj.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 13:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> When inserting the VLAN tag in packets, memmove() can generate an
> integer overflow for packets whose length is less than 12 bytes.
>
> Check length against the size of the ethernet header (14 bytes) to
> avoid the crash and return FTGMAC100_INT_XPKT_LOST status. This seems
> like a good modeling choice even if Aspeed does not specify anything
> in that case.
>
> Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
> Cc: Mauro Matteo Cascella <mcascell@redhat.com>
> Reported-by: Ziming Zhang <ezrakiez@gmail.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/net/ftgmac100.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 280aa3d3a1e2..987b843fabc4 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -540,10 +540,21 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint=
32_t tx_ring,
>                  s->isr |=3D FTGMAC100_INT_XPKT_LOST;
>                  len =3D  sizeof(s->frame) - frame_size - 4;
>              }
> -            memmove(ptr + 16, ptr + 12, len - 12);
> -            stw_be_p(ptr + 12, ETH_P_VLAN);
> -            stw_be_p(ptr + 14, bd.des1);
> -            len +=3D 4;
> +
> +            if (len < sizeof(struct eth_header)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                         "%s: frame too small for VLAN insertion : %d by=
tes\n",
> +                         __func__, len);
> +                s->isr |=3D FTGMAC100_INT_XPKT_LOST;
> +            } else {
> +                uint8_t *vlan_hdr =3D ptr + (ETH_ALEN * 2);
> +                uint8_t *payload =3D vlan_hdr + sizeof(struct vlan_heade=
r);
> +
> +                memmove(payload, vlan_hdr, len - (ETH_ALEN * 2));
> +                stw_be_p(vlan_hdr, ETH_P_VLAN);
> +                stw_be_p(vlan_hdr + 2, FTGMAC100_TXDES1_VLANTAG_CI(bd.de=
s1));
> +                len +=3D sizeof(struct vlan_header);
> +            }
>          }
>
>          ptr +=3D len;
> --
> 2.25.4
>

