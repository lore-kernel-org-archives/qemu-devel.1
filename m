Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F11C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224D323CD4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXFhuJ4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224D323CD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptJJ-0007Ec-9y
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jptHb-0005v9-3j
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:53:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jptHZ-0001Np-Eu
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:53:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id o11so16425686wrv.9
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vJz2j2erK/n057ht2fhySHadhUZ1mrxqQO9mEKA8f8Q=;
 b=OXFhuJ4PeYcuv5VJkAoWzdaxF43o6sYyzC6H0xr5mIzpNxeTpNUCTG56On2Q+oWMCZ
 5Ojtarsiw+6xeSOpP96T8BuOMhFRkqls+q0e4lqkLvZdQNFzufpXECn0q1A7ARCmrPOL
 dabNq+9LCP41uGX+VXSi47o/RllC1S1rhzAbfNnNL3KVk+GIjxQR6APUdpbCdIs2arOH
 P79mIvJXMrdxIsazbYEUrIbK92Oq1YNQD+wfFx5Ee4wJQ8HaruEaFHx3g+vn51Uzcz30
 yQL0dIezJsE8qR1VvNWKezI50/hi01FNJDtgMXr92acYA8gOvtQ81bSJlbkN7eL1KwDQ
 j8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vJz2j2erK/n057ht2fhySHadhUZ1mrxqQO9mEKA8f8Q=;
 b=P1lJVbs1C83cU8iKKLFTtAviYSyhp5wCo7qUvDqAI6JGPSVBQgENhjPvQOzrsyGOdV
 XVUZyVMueiXr3IdKvwkCcWtotqRxkLdaS08TmaGN0l2s2cGKF9bxVl6Bp/I+I3FpM/dk
 tfDby/RCL6HWFQuTZ3REw3DJdHPrzqkJmEf7b1PoeGtMgB7zkaltz3NsuiSHK8j63oZg
 x2ai6GeyYAp/jxTjgjk7wOe06MrUm4SuCOiKKWJvvlroK65vi57C1BEVr216yW9v6Ky9
 +w/Tw5C6yuMaJ9GzPqbk+1mRNehsRgIZkwXEus0QrkXH+zSML/exJrIAvZSuLB+zVwNB
 bGjw==
X-Gm-Message-State: AOAM532qRiLyE+ubBmmR3Ok6mtdQRUhDRQ4vNc3HHAmH1NmYi9TqBuSU
 Pr22Vhl+PpPD5JB+x7oTvpviUvM8dys=
X-Google-Smtp-Source: ABdhPJwh8h/SfODccHias3phh/nvlpJvM5PeBKjfBg8OJCfIpsND4/4TxhQIyXbR3nkXEdh9BPFmOw==
X-Received: by 2002:adf:df03:: with SMTP id y3mr16178951wrl.376.1593435187876; 
 Mon, 29 Jun 2020 05:53:07 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h13sm8864507wml.42.2020.06.29.05.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 05:53:06 -0700 (PDT)
Date: Mon, 29 Jun 2020 13:53:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [RFC 0/4] Enable virtio-fs on s390x
Message-ID: <20200629125305.GH31392@stefanha-x1.localdomain>
References: <20200625100430.22407-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aF3LVLvitz/VQU3c"
Content-Disposition: inline
In-Reply-To: <20200625100430.22407-1-mhartmay@linux.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--aF3LVLvitz/VQU3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 12:04:26PM +0200, Marc Hartmayer wrote:
> This RFC is about enabling virtio-fs on s390x. For that we need
>  + some shim code (first patch), and we need
>  + libvhost-user to deal with virtio endiannes as mandated by the spec.
> =20
> The second part is trickier, because unlike QEMU we are not certain
> about the guest's native endianness, which is needed to handle the
> legacy-interface appropriately. In fact, this is the reason why just
> RFC.
>=20
> One of the open questions is whether to build separate versions, one
> for guest little endian and one for guest big endian, or do we want
> something like a command line option? (Digression on the libvirt
> modeling)
>=20
> A third option would be to refuse legacy altogether.

I suggest the following:

1. Combinations that worked with libvhost-user in the past must not break.

2. New combinations should only support VIRTIO 1.0 and later.

This means continue to allow Legacy mode devices where they already run
today but don't add new code for the cases that didn't work.

Stefan

--aF3LVLvitz/VQU3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl755DEACgkQnKSrs4Gr
c8iwfAgAxHwXCs1FG7MEmZitv4rYxAq0onyBuCceA/YgQpM3VSaEnystNPYdpRkt
k4fYg9zsfE9+PzNqRHtG/5X3u55ZSa9O1m5e4/hgqxV3KV+o3DxPmW5xOzkTKHH8
R2b180c3TuILa7gS8grEL7aeZ6vq80XzMkZFyL6I6d5rXMBFJTyG11gf1fW9h9oq
++LkBLPF2qNDJDGwS0UWHKnH+xylQ5NQTGkvIv3bF795jbBrY9C5JXZMsA9NlC3b
4xXjC8IB/JekKzwn6dgciQOuvWb2MFfAsoqKejNiFSkBGOPQhoLHhqhLHUAn8GhJ
X65sfhFV9MmkClWRHyFa2reVOhQKIg==
=cyB6
-----END PGP SIGNATURE-----

--aF3LVLvitz/VQU3c--

