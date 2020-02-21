Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD7EC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED198208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpqQgU/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED198208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56Yk-0005tR-6b
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j56XX-0004Jn-Rz
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j56XS-0004VJ-Ss
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:32:15 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j56XS-0004UC-KC; Fri, 21 Feb 2020 06:32:10 -0500
Received: by mail-wr1-x443.google.com with SMTP id k11so1632935wrd.9;
 Fri, 21 Feb 2020 03:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=S2LLqNjkKZp3tcCr5xhwHx3e45TUNECm+i3cyzlSNFA=;
 b=dpqQgU/8C7Bk9Jo+wFWbn2qto1fJqkRXBxgV0yULQqvg7mfftgt8tn+EVze3v07xd0
 kwPy4loTi/UKL++7MiXjgyzsP+4LVe6p8orwlwWBBygxCOxvOOzSK4ULufhIkXLJNMmS
 U9C6ICapsGHzkVk433/Z8h//i7qGEWza2bms/d+h+Qy1e/snCWIBAHqEn0UXbImNBr5A
 tFRWCKKTbbbErY1wgndklfvzNDUzHTRuz48b/jM6eGBVNRzQvk0Oz1v4Tx/MbosKh2cK
 n0LGIyNQ4iiMRh6LlSuRaBa1Wg+eVyDJSGGTCLNAThVdvVTPZ1M8tcPqZXQ9AShefk65
 qn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S2LLqNjkKZp3tcCr5xhwHx3e45TUNECm+i3cyzlSNFA=;
 b=f7AqAT7mUsmoaoQ6hYg/gZPSO/X/g+bB/nnooncetJvEomCj/sr+nUerir95cRDevM
 WRo4NxxBF4wrgtPLAebccPuy4A0nUXgKQw4f4cz+ALILmaxpDaOtrYAnpaghMdlPpIH/
 4suoLL8R+yu+gAkSbqz+wQCc1NU88sVGagUvDb7aQOc2RpDcoPYtfFBRWVn16P9McvNa
 RoAA02Vf6Iw2hbFpKjUmdphZDxjFZUaFeU5mtKswYlYTjbwd9E3AT13FLJ7X6+GnEbmZ
 /zidiCUGhZQcF3H6N70K1OKdAjVpCQR6v4WXAaI6WOhKgEUyl6B66WhTkNYvDxkO7g6F
 MHqg==
X-Gm-Message-State: APjAAAWsHIc3cKeQiUrsU8OSO4y6Gz9u1VJbVUqrpPo3qL4B7BjIt5SL
 hk9scc1WL8gyYA3yWrX2rCc=
X-Google-Smtp-Source: APXvYqz93sdYL+Pn5i6PuKm+uEpWhpah7nbNmcguLW0+WXofmlYo+rFAHWz172rGlrToSANA2bt2pQ==
X-Received: by 2002:adf:fe83:: with SMTP id l3mr50336760wrr.41.1582284729135; 
 Fri, 21 Feb 2020 03:32:09 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v8sm3607511wrw.2.2020.02.21.03.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 03:32:08 -0800 (PST)
Date: Fri, 21 Feb 2020 11:32:07 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH 1/2] vhost-user-blk: delete virtioqueues in unrealize to
 fix memleaks
Message-ID: <20200221113207.GH1484511@stefanha-x1.localdomain>
References: <20200213012807.45552-1-pannengyuan@huawei.com>
 <20200213012807.45552-2-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
Content-Disposition: inline
In-Reply-To: <20200213012807.45552-2-pannengyuan@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 mst@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 09:28:06AM +0800, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> virtio queues forgot to delete in unrealize, and aslo error path in
> realize, this patch fix these memleaks, the leak stack is as follow:
>=20
> Direct leak of 114688 byte(s) in 16 object(s) allocated from:
>     #0 0x7f24024fdbf0 in calloc (/lib64/libasan.so.3+0xcabf0)
>     #1 0x7f2401642015 in g_malloc0 (/lib64/libglib-2.0.so.0+0x50015)
>     #2 0x55ad175a6447 in virtio_add_queue /mnt/sdb/qemu/hw/virtio/virtio.=
c:2327
>     #3 0x55ad17570cf9 in vhost_user_blk_device_realize /mnt/sdb/qemu/hw/b=
lock/vhost-user-blk.c:419
>     #4 0x55ad175a3707 in virtio_device_realize /mnt/sdb/qemu/hw/virtio/vi=
rtio.c:3509
>     #5 0x55ad176ad0d1 in device_set_realized /mnt/sdb/qemu/hw/core/qdev.c=
:876
>     #6 0x55ad1781ff9d in property_set_bool /mnt/sdb/qemu/qom/object.c:2080
>     #7 0x55ad178245ae in object_property_set_qobject /mnt/sdb/qemu/qom/qo=
m-qobject.c:26
>     #8 0x55ad17821eb4 in object_property_set_bool /mnt/sdb/qemu/qom/objec=
t.c:1338
>     #9 0x55ad177aeed7 in virtio_pci_realize /mnt/sdb/qemu/hw/virtio/virti=
o-pci.c:1801
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  hw/block/vhost-user-blk.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5Pv7YACgkQnKSrs4Gr
c8if6QgAsn1nlRKlA/+RLkur5XyskIg/Sid+6nNZ+6tWxCD5QzfCGF2HUqAHoNDf
C010JvBVp5WU48k75/KSVKDAm6DKwJj3Wdp46QuXWBk36NfkYty9XV2zEVWZpH53
HOvl7HaWLpChBvWJrYJoubf1WZW7xRagncMQFFolzblRlradq1Buy1GzsOma1CZ+
XIxe+fSjBGD1QgCnzGsOxX8p0YsFC4ZWIrDYm4RIuOZIV7j7vwJQikG1qQQxiOsk
IMQWU2Eqx+3+i0q6uW8DT0af2xBiHZ2BE6LB7yzuodYS/C6zj9/wYT4SS6ZTeGTP
Cbf9lsXjU9m7Mo9WEmTcIepk5aIjXQ==
=ameo
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--

