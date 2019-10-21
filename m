Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F19CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33FE20684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFA1nUup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33FE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVrL-0001NU-UM
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iMVkN-0000pk-O7
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iMVkL-0000pU-GS
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:21:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47382
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iMVkL-0000p9-Cf
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571656867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iateztDZUhKbCzCy7cYypzMCA/StEUmryKzZnQFUX1c=;
 b=JFA1nUuppM8OjYYsOz1rRlqEqZuvt3cozIhzHSu3CaciQEkle03J6OKxcTTOaxXIP6OAuz
 IWPEolzrACT5zbt2TkAjQZPIr6DOgzRIiNcfAnpa6a3SBEH5V58nomwHiIwH56gYYxmzns
 LvryFcSxVqf9TFkxxcCXrAyS15LNKP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-Rd9Xp_zFODKmdP2gWQMyJg-1; Mon, 21 Oct 2019 07:21:04 -0400
X-MC-Unique: Rd9Xp_zFODKmdP2gWQMyJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 574B6107AD31;
 Mon, 21 Oct 2019 11:21:03 +0000 (UTC)
Received: from localhost (ovpn-116-128.ams2.redhat.com [10.36.116.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C273919C58;
 Mon, 21 Oct 2019 11:20:57 +0000 (UTC)
Date: Mon, 21 Oct 2019 12:20:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH] vhost-user-scsi: implement handle_output
Message-ID: <20191021112056.GG22659@stefanha-x1.localdomain>
References: <20191017163859.23184-1-felipe@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <20191017163859.23184-1-felipe@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 04:39:44PM +0000, Felipe Franciosi wrote:
> Originally, vhost-user-scsi did not implement a handle_output callback
> as that didn't seem necessary. Turns out it is.
>=20
> Depending on which other devices are presented to a VM, SeaBIOS may
> decide to map vhost-user-scsi devices on the 64-bit range of the address
> space. As a result, SeaBIOS will kick VQs via the config space. Those
> land on Qemu (not the vhost backend) and are missed, causing the VM not
> to boot. This fixes the issue by getting Qemu to post the notification.
>=20
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
>  hw/scsi/vhost-user-scsi.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 6a6c15dd32..13278ed151 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -62,8 +62,9 @@ static void vhost_user_scsi_set_status(VirtIODevice *vd=
ev, uint8_t status)
>      }
>  }
> =20
> -static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> +static void vhost_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
> +    event_notifier_set(virtio_queue_get_host_notifier(vq));
>  }

It would be nice to fix this in hw/virtio/virtio.c:virtio_queue_notify()
so that all devices are automatically covered.

I'll send a patch and CC you.

Stefan

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2tlJgACgkQnKSrs4Gr
c8hIdAf8DSDaLFu4fb8P3BcS9E7X2ekRHTVQAkYMqe78ywLpK++8cnIaW6wrAxsx
1fiNHq40DGQeRXpE4DPnPBw8d3F0I5Z9BCx7pxFBQnd2jjmWBgk4Era55BiB6W4Q
2T9YV6pNhgSszo+BGNL5PuMkwFpy6eZg1cXQfQg1L0brWStuoZdUt2ZsG5/vR5Kc
9H5bDN4u5ArVI/s78Tv8z6bd+urCoZbZNPvjmN2j0BIaZmQtrC+HP2pwc5kfVB2e
+aJc9l914Qhhrs8mzW9D8he/nlco5ZX+CPm8LcGCVurHpFHZDU98SCzCMei4bVpj
HgprUc3Mz5lY+dIqUNaedPYyyKY7gg==
=S5Hh
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--


