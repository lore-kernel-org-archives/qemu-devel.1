Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD84C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2590E2072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uihzrtfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2590E2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACjQ-00053t-C0
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jACio-0004cU-QJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jACin-0008RF-Mt
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:08:58 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jACin-0008JV-DR
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:08:57 -0500
Received: by mail-wm1-x344.google.com with SMTP id p9so2347161wmc.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 05:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=YI79KPeQMiqAjmTP5kXb/9g2Wdnldi1gzLXBCSsc7Jo=;
 b=uihzrtfgHX9sLr2Y6n2y9g4ns79Y+jQ2vsOy9xg6yPzBCmKQcU3SRMAJlWYLcTZg5Q
 40AwTYzaE/H8PbuVFIYHt1xuc5StowB44d+Mt+thIZ3LMKpvKWnPC02Af3/KfSLDXaIb
 pbP+FvjEUYcA3oRrLig7hFVqwW4W8VIo/HR+KhTcJCIzjvBYU5Q7X/ECQTzbRdX96NZr
 NwX4yAdXcQgVK71u5BptIJnJtS7Wl51ID6NbWdwDh3eJyOhPqzWX/gryasyxMI7DkrXv
 Z5anzurZR2eCFY1L6O4ZMzovbs12mW4d47APN0VkidwoFJd9FufMdREinuLNCib+9rm+
 +WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YI79KPeQMiqAjmTP5kXb/9g2Wdnldi1gzLXBCSsc7Jo=;
 b=tcVMoOeJW+56YWX8AHnUrrJtiiXaMGuszo0QTz+Ge1644SMOSBjVh/okWnQKr1dIV+
 P82iFiwKEPGgEGJ92VuKxiGMh7yn+cv0eDHGgz5uU1sLPvEeoi129hgETE1TVFrgU64V
 8aY02LbjlDc2CLacb7YNXeWrGWBliyM1BQJn9djm8Ixs7etTM1nxncrRqzho+j/YA2kL
 2Ko1gKeLzwDX8h9u6HJVXjIlX7qKnd2uWHOCYe8maJB68YGcfzMyrIU9B4J9TZ3cZPKt
 SP1CH4NabywjtAMx05lnc/te8YH/u4IRqw0E2U3SfhCfx2Ygg4tOaPuiDc5VZadfxtSL
 SebA==
X-Gm-Message-State: ANhLgQ0HN7nEMf/9FTFXkYPx25A488ZNvsoyjaS098uQtw5Rsz4O89Gm
 cWjEdrCLhB8BRUrAKvdadaE=
X-Google-Smtp-Source: ADFU+vtNoAHGnVz2yE+YdmXSRB3isEPlPVYRiXkkb7UTMrAMzwwkdGBip0lK8gDM/1LKXobxmPpGtA==
X-Received: by 2002:a05:600c:552:: with SMTP id
 k18mr4074920wmc.171.1583500136085; 
 Fri, 06 Mar 2020 05:08:56 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w8sm15081235wmm.0.2020.03.06.05.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 05:08:54 -0800 (PST)
Date: Fri, 6 Mar 2020 13:08:53 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v3 2/2] net: tulip: add .can_recieve routine
Message-ID: <20200306130853.GM1335569@stefanha-x1.localdomain>
References: <20200303104724.233375-1-ppandit@redhat.com>
 <20200303104724.233375-3-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x38akuY2VS0PywU3"
Content-Disposition: inline
In-Reply-To: <20200303104724.233375-3-ppandit@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <pangpei.lq@antfin.com>,
 Sven Schnelle <svens@stackframe.org>, Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--x38akuY2VS0PywU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2020 at 04:17:24PM +0530, P J P wrote:
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index fbe40095da..757f12c710 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -229,6 +229,18 @@ static bool tulip_filter_address(TULIPState *s, cons=
t uint8_t *addr)
>      return ret;
>  }
> =20
> +static int
> +tulip_can_receive(NetClientState *nc)
> +{
> +    TULIPState *s =3D qemu_get_nic_opaque(nc);
> +
> +    if (s->rx_frame_len || tulip_rx_stopped(s)) {
> +        return false;
> +    }
> +
> +    return true;
> +}

Are the required qemu_flush_queued_packets() calls in place so that
packet transfer wakes up again when .can_receive() transitions from
false to true?

(If qemu_flush_queued_packets() is missing then transmission hangs after
=2Ecan_receive() becomes false.)

Stefan

--x38akuY2VS0PywU3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5iS2QACgkQnKSrs4Gr
c8hXugf9GwMyICGs0Ch4MVbj5q6kR7jfeTdnm4nKPM+vej0m/2XMObOuBWdhHh1F
uv+RejKOsIvuMZ567v0FHjnk7n+0ShwvwKerCsDF95m/dKj/ZW9j3ZQWsJdLMILX
clQT8dtlVLlbAlxDCkJ6KcItbZSzhzSBocqlKuGmi4Nkfyzk9dfOifdV0otO9Fmw
2qtUKfl7KglfTztBr9J9GtGzcwgL1GW+Hp+oLG4oaBm3yzXBCfyIBBuPiaentwMc
7fOdFiicm+JZBWDCfcvB6qglQpnXLrtB3HwNzU/WJbgifeaxckYi9gIpsasQNWG8
d7Owq6UF0OlQ9opOmJqc/xiuzwSWwg==
=DY8b
-----END PGP SIGNATURE-----

--x38akuY2VS0PywU3--

