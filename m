Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73696C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD4520776
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssnAOwcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD4520776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdyLH-0001zL-Db
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdyK1-00011A-H2
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:50:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdyK0-0004rv-3z
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:50:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id f5so3561684wmh.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9j+GK4qY77wbCIPbK3zvbtD2Yq0qV/f9dozfE5p/5VQ=;
 b=ssnAOwcC/1E5L1DTv7ayF1QoRwNrDWooKUyrQdTe3Xlje6W99Whq3rzjmpVSAwMSVT
 AUTbYVFnT8wzu6AkWI0WdcyPfn+FskI366ii3ybZh9Mf2wgZ8ulHHKTkKDhcCgbpDvTw
 KwQkh7cxOMxVtMZApNFrSfP+v7K9NA7EOmGf8CM9hgpM30OLvPHIR6X6s+YtGW2PG1KR
 iJlo9nEwoWEIfo0NuXmIX1ZFevI7hX9cHeZtl39z0aEUaZkdAlHfWwsGYP/HXlSx+9jl
 GH70qtehEUjncDF173X1aWqqGv3lapFQcJnjGEQB9qTzkKwrDY+2twz1yXcJHcn8H+V1
 eiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9j+GK4qY77wbCIPbK3zvbtD2Yq0qV/f9dozfE5p/5VQ=;
 b=KC7wPFGF63PM70uLgGoD+wPPGzLExA9ppPNSa4vglxzg3muQ1ihflkfz0lky0AoIP4
 yzoCgVq/Qgkc2tMOx1KDSI7dpJYHCv0jxVwloXZbnG1dLv0tySDyY0ACWjlQcOs8/62N
 qeOIJ1hKuog2qmYbN/VXQ2B1eim+mWfyAmvGKebwI+hU+n/Vyffst7kuAokSqt0MFlxC
 NhR8jMIeviyFKZSiyJXb2kh6Y4vYYlDczfZptpIObrMOmu5fCb+S0pOlo8CH8cxxoVRn
 rdvPExh/J+f7lElS44jjxpo4Yfe7r4rA9MFyZcSlUT3+5KnQiaqY0wSQBrN2G1YID+VA
 CiQw==
X-Gm-Message-State: AOAM531BBEKFAXwzezkgKgWS4bO6hzoLCxmtmeADzBvSHiCNf/a9CeE5
 jC4cE+PV5xRU4p6iTt6GEUc=
X-Google-Smtp-Source: ABdhPJwhZWm9iPPJKUCn0V/NOticnvuK1Zk/aRLDVXvNrGer8d7k29YJIS0qqQj6EWa8bmahczsszg==
X-Received: by 2002:a1c:7703:: with SMTP id t3mr4627033wmi.113.1590594619275; 
 Wed, 27 May 2020 08:50:19 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q1sm3005243wmc.12.2020.05.27.08.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 08:50:18 -0700 (PDT)
Date: Wed, 27 May 2020 16:50:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 7/7] virtio-scsi: use scsi_device_get
Message-ID: <20200527155016.GN29137@stefanha-x1.localdomain>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-8-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Zl+NncWK+U5aSfTo"
Content-Disposition: inline
In-Reply-To: <20200511160951.8733-8-mlevitsk@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Zl+NncWK+U5aSfTo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 07:09:51PM +0300, Maxim Levitsky wrote:
> This will help us to avoid the scsi device disappearing
> after we took a reference to it.
>=20
> It doesn't by itself forbid case when we try to access
> an unrealized device
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Zl+NncWK+U5aSfTo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OjDgACgkQnKSrs4Gr
c8i3NQf9GukfNA9bh8Kl0CXemWms50DzbzZo/GHeVhpA/0D0v++wy7E3Zc/fYKbD
FSKHxBDPQnR9TE+lUfmg3m4KKu0sko7426OphjN96ObtZKBvq7A00KbATwnDhvVz
UQpXpqFbn/Ke2ujamEr/QN20fws7eHkDJTgmiapBzdwTCcj5MFlW1+/smFOG29iC
rD1b8E9e4yf774b1E1oHKKWAaL4HKGRlK8F99K2sLTT5YrCEfrSokLIJ06HkRvjK
s++gCarAFM4eGiWN7+07i+GA2/7WuPc19z4R4mQx1UPgYFT/Irkz2oiLuXUC5bA+
D33ZYl6pH+1Vk1n7L9v//+sncLIoFg==
=Q0ra
-----END PGP SIGNATURE-----

--Zl+NncWK+U5aSfTo--

