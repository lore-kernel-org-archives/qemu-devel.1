Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60939C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2940420721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR+Wy/pT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2940420721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKLfo-0006ME-7M
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 08:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jKLdw-0003zb-3B
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jKLdt-0005FT-Oc
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:41:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jKLdt-0005Eh-FX
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:41:49 -0400
Received: by mail-wm1-x342.google.com with SMTP id d77so7018791wmd.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NXmA2DljyO1ktC8QBGi/B1PQPmHUs4fI8yXzF8+sOh0=;
 b=cR+Wy/pTyg480rOJN2N4A4x3R/Mi0FYRdzRZp70lao6NX86p1BtyLza4FxQzfd9Mjd
 YlgrIF3c3rIiZf+3NPybEHD2+TQR/M+8UnTBCKPKia/PCDJIbpCpBccb9iDmmCj+a60p
 sgTKTPnoto9j2mIBe8Pv5mzm9GN8VN58Ro4ecxk4YTwDzYKoezFUoQY9bAI7dJ0fcJ0d
 uF6xSjybZp/FtbhFU/U8wBABNp9mauxelSJ78uz5P0w0Jc2gSTuUsQQwCfFqaGgidr6F
 4ix5ogYx00DdTZ/+jnUuGN1ec9czXu7DIoJzRPVhSpNtrbR5D0W5J1Jb/wDl8xDvRxMi
 g9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NXmA2DljyO1ktC8QBGi/B1PQPmHUs4fI8yXzF8+sOh0=;
 b=AVkhQ1frCmtbbKHWvHggKpgk7/rxlrRt/plK1DEf/Bw8GvlXjnkAuwM9oJqZhyq3wV
 hoHZS9LRr+8BQV5n9o6ghLzZPuOZZm88YzE7HCs1FkuhW0ISCJTnh9tHAN82rkoKfXKz
 iKKvLqgjY8U49pqxWIc6fKnp+syzLjjFle7i2mSdDdfQnNZbwnNyJwQPDUtj/8WVZYq9
 ioShFcXictDnPKLA6FHIZB43OUBu/csOlhJ3oqMhYKDnNRV7A4vq42iA+IuhP1yDZm+0
 tI4aYa7KVnjU2QbBJFfwMfOo7vnQTCFs5NspT7On3uuZfxKG1KLav3YvNaP7CdNedecj
 NOVA==
X-Gm-Message-State: AGi0PubznMFh9nteGSAm625w6QUDKd6RlAsLq1Tb+wtq/89PpSEfcRMP
 O59ZBlVfhVdmd5iaHW79OX8=
X-Google-Smtp-Source: APiQypJOEyLQeard6+Fv2J5f9yIOqtnZPjmTa3h94wJhG+odnAWpThnDGgIkipUx8NN4f1i/9sNs8w==
X-Received: by 2002:a1c:9dd3:: with SMTP id g202mr8492819wme.60.1585917708375; 
 Fri, 03 Apr 2020 05:41:48 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f25sm11133782wml.11.2020.04.03.05.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 05:41:47 -0700 (PDT)
Date: Fri, 3 Apr 2020 13:41:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: Question about scsi device hotplug (e.g scsi-hd)
Message-ID: <20200403124145.GC146016@stefanha-x1.localdomain>
References: <7302c0b9f2327b9b61b4adb465f166e339e46ac1.camel@redhat.com>
 <20200401150944.GA4500@stefanha-x1.localdomain>
 <4bc42bf2-939f-f6c4-ea45-0d08eb42fc2b@redhat.com>
 <ffa77fc719232b8dc0e6e78bd3781fd77c5adcf8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <ffa77fc719232b8dc0e6e78bd3781fd77c5adcf8.camel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 11:46:57AM +0300, Maxim Levitsky wrote:
> On Wed, 2020-04-01 at 18:36 +0200, Paolo Bonzini wrote:
> > On 01/04/20 17:09, Stefan Hajnoczi wrote:
> > > > What do you think about it?
> > >=20
> > > Maybe aio_disable_external() is needed to postpone device emulation
> > > until after realize has finished?
>=20
> Isn't that virtio specific? In theory this issue can touch any driver that
> behaves similar to scsi.

No, aio_disable_external() is a general solution for suspending file
descriptor handlers.  In practice virtio is the main user of external
fds (ioeventfd).  Devices that do not use ioeventfd will not perform
device emulation from the AioContext event loop and are therefore safe.

> Also due to racing, the request might already be in virtqueue and the vir=
tio-scsi iothread might have already
> fetched it when we place the device on the bus.
>=20
> In fact I don't see any locking in bus_add_child / scsi_device_find so in=
 fact if the timing is right
> and iothread calls the scsi_device_find while main thread adds the device=
 on the bus that will cause
> the whole thing go south.

Thread-safety with IOThreads is a separate issue and also worth fixing.
It requires a different and complementary solution from the
single-threaded ioeventfd bug we've been discussing so far.

It looks like virtio_scsi_acquire/release() were intended to provide
thread-safety for virtio-scsi:

  static bool virtio_scsi_data_plane_handle_cmd(VirtIODevice *vdev,
                                                VirtQueue *vq)
  {
      bool progress;
      VirtIOSCSI *s =3D VIRTIO_SCSI(vdev);

      virtio_scsi_acquire(s);
      assert(s->ctx && s->dataplane_started);
      progress =3D virtio_scsi_handle_cmd_vq(s, vq);
      virtio_scsi_release(s);
      return progress;
  }

If the monitor code calls virtio_scsi_acquire() then further request
processing will have to wait until the monitor code is finished.

> IMHO the right solution for this is first to realize the device and then =
place it
> on the bus, and even that I am not sure that will fix the race completely.
>
> IMHO the correct solution here is to stop querying the bus children on th=
e guest controlled IO path=20
> (scsi_device_find) but rather use the hotplug handlers to
> store the active luns of the scsi device in parallel (and with proper loc=
king).

It would be nice to have a general solution in qdev core that makes
thread-safe hotplug easy for all devices.

Stefan

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6HLwkACgkQnKSrs4Gr
c8gv4QgAxFe7UW0rVpnYkAVi40QggyE3l0qlumqbk83Vt97ua5YxStn7rJlasTQK
B4LhgGXmdE3lsthnqfmjKfnd1jXqH5RlCLPwuH0gb1uIQ59wRhOptRiQPMpP3j5z
mJlAaEikAunNuowWXxQe4Z5lVZJeV+EEdQlVBRAEHaOjfo/G7V5/TpNmT3LX+BnV
97o7NvBWhsHvrrcTq4az+mjQgONjs4nOqS+52yLZ/+rAzHhG05QTZNftS1vbm1WL
7OCDRVqCV/iGATy/l/hu2HYuzKZSzkPbGAWb1a0sKcD/0qKvqycnY/TBjP0JXIwo
c2KlNZMq2iGWNPi+rlpv5kt//6adiw==
=U1me
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--

