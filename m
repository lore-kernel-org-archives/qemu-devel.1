Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4798DC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C29E20776
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb7M43yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C29E20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJf0g-0000DU-4O
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 11:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jJf03-000890-EI
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jJf01-0000nU-Py
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:09:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44375)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jJf01-0000lt-JK
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:09:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id m17so420411wrw.11
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 08:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cLluM/9K0G98s84ODKjhGtGlfBsm5BDtxcKk/LW00l4=;
 b=gb7M43yqdId3PMG1kzP3ikMw03Z0fwjyhRRDEr244pD05wry7LPcSnRH9XTSyY+lcO
 R8Re1mVaNifeknXQFYDg7IFYMj5QuCCQBda1UQXsiRAhmVpwC0CnBvJn2FuZx16fivF/
 jTOtJ5CTtcW3nRMHuRhWOVYyJSgBEKwmXRl8eDcZKQRkNbQy9Z8qcdEL1pm8Qvd0p93q
 K3tCpOIpExzwDKmxqpyq9bsVRVo4DXfjryF6ls0vXkJV1421qnq2eIUj8DHYdonqGdHw
 fgMXNNQrWjymg8gogQhogwbAjxgO6lBkirqQjDFoZu1UH7EQkPNL0xpnTEQL4u0qC4eW
 iZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cLluM/9K0G98s84ODKjhGtGlfBsm5BDtxcKk/LW00l4=;
 b=bxInOelywgu4whIyVDp2gzl8+8cRqtesnX2jmiMAQSSFvHWDxCdq/omoynvliyV3ZE
 bEsa2zxIgqKcZTIPUU/cxKQh4M4AeMSjnrk2LaxlCgYh/WUi1lLQFeqzHtqPyIh+a+RM
 ymdKYzyV/iDiObCXG5N6IXKhjRCRT4ZsGSfXD8ZUWRMJjFMK/qeMyWEMhz86CkhryDYf
 PtiNpf0OnNs4aAbhJhuECNlsN4h/a7q85QpNVSL6ZYOJodtKhQxBPawlWFfF1dtsXRHh
 PPT+LCi0NvpXEaX5ckI4Ewp5VETekJP2/CDTvC2PFn0LkLzadm2L/0YziBFFXvLrrW8e
 0RvA==
X-Gm-Message-State: AGi0PuYsmk9y2O3oRaoDkFe22J8KjK0V4bxdI3NklehS4gyWsyGgomvI
 jfbdmkSH9w0w8DjU3jTk9rw=
X-Google-Smtp-Source: APiQypIfQyYv2stS+tB+RUdvacqdhzDV3x/nOisNm1hdPIfm3c+XwvJmzlN3MPgnB61jHJ3Oz3mPUQ==
X-Received: by 2002:a5d:4cc7:: with SMTP id c7mr5344596wrt.375.1585753787836; 
 Wed, 01 Apr 2020 08:09:47 -0700 (PDT)
Received: from localhost (114.9.90.146.dyn.plus.net. [146.90.9.114])
 by smtp.gmail.com with ESMTPSA id v186sm2994121wme.24.2020.04.01.08.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 08:09:46 -0700 (PDT)
Date: Wed, 1 Apr 2020 16:09:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: Question about scsi device hotplug (e.g scsi-hd)
Message-ID: <20200401150944.GA4500@stefanha-x1.localdomain>
References: <7302c0b9f2327b9b61b4adb465f166e339e46ac1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <7302c0b9f2327b9b61b4adb465f166e339e46ac1.camel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2020 at 07:16:23PM +0300, Maxim Levitsky wrote:
> Hi!
>=20
> I recently investigated an interesting issue related to repeated scsi-hd =
hotplug/hotunplug.
> The bugzilla for it is here:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1812399
>=20
> In nutshell the issue that I think that I found and I would like to ask y=
our opinion on it,
> since I don't have enough experience to be 100% sure that I didn't miss s=
omething  is this:
>=20
> When a new device is hotplugged via monitor, the qdev_device_add first pu=
ts the device on
> the bus where the user requested it to be, and then calls the device's .r=
ealize.
>=20
> However for scsi bus, each time a new request is sent from the guest, the=
 scsi adapter drivers
> (e.g virtio-scsi) call scsi_device_find to find the LUN's driver to dispa=
tch the request to,
> and scsi_device_find will return the added device as soon as it is placed=
 on the bus.
>=20
> Thus between the point when the new device is placed on the bus and until=
 the end of the .realize,
> the device can be accessed by the guest when it is not yet realized or pa=
rtially realized as
> happens in the bugreport.
>=20
> What do you think about it?

Maybe aio_disable_external() is needed to postpone device emulation
until after realize has finished?

Virtqueue kick ioeventfds are marked "external" and won't be processed
while external events are disabled.  See also
virtio_queue_aio_set_host_notifier_handler() ->
aio_set_event_notifier().

Stefan

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6ErrgACgkQnKSrs4Gr
c8jb2Af9FXO6LpiY7KoNp7ln5dscYzHwtT/6UQXgDmr547hXu4SdpzGALtFsL5dN
KoNIH+v6w7l9j8F1xoB5GfBWwZgDb0r/jEr/2QTWJEarnBVzQl+v52Y27Rc8hsZy
DP6h1T+ltia6fMwyqkQqAKm1sNg8gsEwD3KKeapcSrxdldn9zDZx2YM/HdPSOY9r
lpjIWCb04YXlZEGy1wqV3EoFZEUoQFPq/jy0YkbCL/TEcB3MH/Pr2mbypAJudyyD
MX5UDLtMN1t9LFUoaQNuta6IlQK9YnpzhXAT4deg1h3QY7iMXGDJpQUJ+QQ28pHI
UwjNZmWxl1jgfT00CDveaczZZ48fVA==
=UJsu
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

