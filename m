Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1798C54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED5220753
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naCHOSZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED5220753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGOQ9-0003LH-GC
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 10:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jGOP4-0002ad-QY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jGOP3-0002K8-PO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:50:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jGOP3-0002J1-GL
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:50:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id 31so11416033wrs.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=g0+tPwdBRpPGcuPH/3R2+AnsW3DYs4XGmhemVGqcBvo=;
 b=naCHOSZRwHC273ltDqnEiUAGc0RwAHqxWbxn2pYm4JpQbgrYUaI7AtW2PUg/AFbCqC
 6EVf/aTRszThhZxyshFLxw9tzVMf7tia4bppG+gAo9Vsfh0+78KAbdhy5eUaPG2hzoW3
 xLTBQzLY15BHlT+5avUJdx/+am3V/QEdGHEsZOsSbMtED6fqR0xyRS09foj+CSz/h+F/
 R+ppKCKKEk1NxBVrSOPTikk5ZDIjPLfSr2uEl+FGbdQpmwTavmB1sHANxBlg4AZ94/+A
 3NOD3QZDJsmEnI8EyFIHOasEB5WqFM4lMylNLo0KJBCI1OOKbgphvgcwVIqYP/ZBEzlH
 bmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g0+tPwdBRpPGcuPH/3R2+AnsW3DYs4XGmhemVGqcBvo=;
 b=aka/0effmHKhz5S8tZR9boN+6F3vUoJXi/npiMA78Ktm8I5QUH4seF+AXWuyiK61GC
 GcDx3kT/ntmYRFJB/cDva2CodXNxbzTIMZ8Y8TJ9AxgBdqBqJ0rMN1+Q4xnBTylyHLzG
 UwC21oRUdVyLx0m4EtGZJvnOM0DuzzB2ukCXcZliSMMjZi2Vjt7xUDXa9U3og6Sw9MMp
 DEg0diDLjzZoUx5OH5U0DsdzJVpHSwO8i/wq/ytm6ouIDpStWCVn13j9ki5NEbuHboyJ
 /w63ZCOccOG+1rciJQiZLbaEl+jVtdzB8WBhBlgxVnJI1+8WIph9Ra7eQAgB1VAOzmiy
 Af/A==
X-Gm-Message-State: ANhLgQ2aTS9NS/sAavJOMPVnyUlWA9A50kchgPl2WEhm6X0B638eYQB6
 LT0YvE6C1J/bZ0MQ4sKiSs4=
X-Google-Smtp-Source: ADFU+vs2RRIP4Lm+Rg6fq4EwQLO1ZnOY4uYlNhKLlWdlGZYcH5wzKfiKZKh6zO9YejiDkcbhZG3eXQ==
X-Received: by 2002:adf:f7cf:: with SMTP id a15mr25435171wrq.224.1584975008415; 
 Mon, 23 Mar 2020 07:50:08 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w9sm1256676wrk.18.2020.03.23.07.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 07:50:06 -0700 (PDT)
Date: Mon, 23 Mar 2020 14:50:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v5 1/5] allow vu_message_read to be replaced
Message-ID: <20200323145005.GA313555@stefanha-x1.localdomain>
References: <20200309100342.14921-1-coiby.xu@gmail.com>
 <20200309100342.14921-2-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20200309100342.14921-2-coiby.xu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2020 at 06:03:38PM +0800, Coiby Xu wrote:
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 6fc8000e99..7e3f0c8598 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -30,6 +30,8 @@
>=20
>  #define VHOST_MEMORY_MAX_NREGIONS 8
>=20
> +#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
> +
>  typedef enum VhostSetConfigType {
>      VHOST_SET_CONFIG_TYPE_MASTER =3D 0,
>      VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,
> @@ -205,6 +207,7 @@ typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
>  typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
>  typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
>                                    int *do_reply);
> +typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg=
);
>  typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool star=
ted);
>  typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx);
>  typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t l=
en);
> @@ -373,6 +376,8 @@ struct VuDev {
>      bool broken;
>      uint16_t max_queues;
>=20
> +    /* allowing vu_read_msg_cb to be replaced */
> +    vu_read_msg_cb read_msg;

Please document this function pointer fully so it's clear how custom
implementations of this function should behave.  The return value should
be explained.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl54zJ0ACgkQnKSrs4Gr
c8jCjwf9GywWNRVA/vYfR0T7Ru89m18jQPm0pvgBvdO28w33oZUD87xOrhAvJLrt
d6IzDXZhCUjE3m4o0Gg7OIKqwJSuBy3KWUe5mxbxvp/bKFM1RJr+eGfI+WA9Rbry
vUz26/X6DvzwctDeyBOtWSEko0pIuhqQvwlvDR2Ckm+2QrwdlhQmdG/imhQ9smr4
sPACo/i6VbBKIhOjTSVgwtt6YC9sqDl3jdMQYC0EcjvKph4p9lTyO4cf6OzUuRrr
g9PdBDoz/PtmWdpZx+AEL4zImdaqH5WFjt4wCGOQqYWQOkJwnFOh7aSwi8GA1EvJ
Hz2QipAd1PAvg8JigppbsAQ5XWOPNQ==
=vaDd
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

