Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AD7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D96720772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAzGi4+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D96720772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqz6O-00080z-65
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqz5B-0007Le-SR
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:16:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30937
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqz59-0000Mt-CE
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593695810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pElkViXaUP8uJGcjrbiy6aUfdw6FvPTe5WwpcZeLkgw=;
 b=XAzGi4+BjwgOaZ1S0r82uFhrNGqu5vhmVPpA6io3gT5QITHT39vAf7VU1BYDlCqGg71/s5
 PSBm0Xu7Qz6POFmfNzkQIrCvyvpsiU4eYUW3M5Sz+Eg7zj6yM+dPmDo4u9SuF2G8RH1B1k
 9QSjlg0NOChBDJ6KUOxNjh6ojRIZc1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-fy0ylaZeO-eypoKxn95Q6g-1; Thu, 02 Jul 2020 09:16:45 -0400
X-MC-Unique: fy0ylaZeO-eypoKxn95Q6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C31F3EC1A2;
 Thu,  2 Jul 2020 13:16:43 +0000 (UTC)
Received: from localhost (ovpn-114-216.ams2.redhat.com [10.36.114.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3BA060BE1;
 Thu,  2 Jul 2020 13:16:33 +0000 (UTC)
Date: Thu, 2 Jul 2020 14:16:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 18/21] multi-process: heartbeat messages to remote
Message-ID: <20200702131632.GC152912@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <c93ff92180d1e5a1bcb620331bc57f6ae9c5447c.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <c93ff92180d1e5a1bcb620331bc57f6ae9c5447c.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:09:40AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> In order to detect remote processes which are hung, the
> proxy periodically sends heartbeat messages to confirm if
> the remote process is alive. The remote process responds
> to this heartbeat message to confirm it is alive.
>=20
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  hw/i386/remote-msg.c     | 14 ++++++++++
>  hw/pci/proxy.c           | 58 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/pci/proxy.h   |  2 ++
>  include/io/mpqemu-link.h |  1 +
>  io/mpqemu-link.c         |  1 +
>  5 files changed, 76 insertions(+)
>=20

This patch seems incomplete since no action is taken when the device
fails to respond. vCPU threads that access the device will still get
stuck.

The simplest way to make this useful is to close the connection when a
timeout occurs. Then the G_IO_HUP handler for the UNIX domain socket
should perform connection cleanup. At that point there are a few
choices:

1. Stop guest execution and wait for the host admin to restore the
   mplink so execution can resume. This is similar to how -drive
   rerror=3Dstop pauses the guest when a disk I/O error is encountered.

2. Stop guest execution but defer it until this stale device is actually
   accessed. This maximizes guest uptime. Guests that rarely access the
   device may not notice at all.

3. Return 0 from MemoryRegion read operations and ignore writes. The
   guest continues executing but the device is broken. This is risky
   because device drivers inside the guest may not be ready to deal with
   this. The result could be data loss or corruption.

4. Raise a bus-level event. Maybe PCI error reporting can be used to
   offline the device.

5. Terminate the guest with an error message.

6. ?

Until the heartbeat is fully implemented and tested I suggest dropping
it from this patch series. Remember the G_IO_HUP will happen anyway if
the remote device process terminates.

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl793jAACgkQnKSrs4Gr
c8i2hwf+K//RYX5BrDmIiAORSVIE2sqVoVRmZd7FxWt+dqQDUqU08/6sZjrsbz1D
FLEjSrynnGikYzz1mpVRt4KfCJD5vz0kfLTllaO2BKSJ18MJbqwqiggA4w54ce7b
MVpmneZv0rVw10veyOhUVUjclznZYTI5sb9zZWBAVTwg9VYoptL+OxilQZRYHCM3
ihle/xDqa0cMfb1AhcMk8vJkWu2almt9tZ9QbDdziTqrEHoqfXqvoljuxAeHTDIe
UGwgPUeLQbEcNsBFgVSyTPfjOHJdkbI2rEACtjGVVcB3ixaQqK37MneqfP9hyVzT
L4Shp2tKyNibnel/aXFWL6EB8b3MTQ==
=nqDt
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--


