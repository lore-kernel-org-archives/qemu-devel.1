Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90CFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E322078D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yn+UaeEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E322078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonZk-0004xx-Tz
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonYR-0003nn-BN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:34:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44922
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonYP-0006yI-CW
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593174840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zCOBjSCmi9RE26Eu41WJ6JdgoXMuCsefufpdMv6ShFk=;
 b=Yn+UaeEU4o3uQi9wtGWjpsaoaB4ALtOM43WwVEN3cRzMlfBO672X9DqUxEjXI8FborOwVj
 k7SNAP7gXbeL3mmVD5qko68HZjPIAeA6RVwpQBryk43v72TKqN7Ji/S68EOP8G1bd8Hd/w
 EGZ8T0Re6A4EjnLxOul/NDy9vbK2nr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-NU8LUM6tP-K-Ec2TnKsJhw-1; Fri, 26 Jun 2020 08:33:57 -0400
X-MC-Unique: NU8LUM6tP-K-Ec2TnKsJhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76D758031F6;
 Fri, 26 Jun 2020 12:33:56 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0541D5D9CA;
 Fri, 26 Jun 2020 12:33:55 +0000 (UTC)
Date: Fri, 26 Jun 2020 13:33:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 12/17] block/nvme: Simplify nvme_kick trace event
Message-ID: <20200626123354.GS281902@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-13-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625184838.28172-13-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PkEWctFf+8E2rcii"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 02:19:36
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PkEWctFf+8E2rcii
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:48:33PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The queues are tied to the hardware, logging the block
> driver using them is irrelevant.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c       | 2 +-
>  block/trace-events | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 1b7b23cea4..4d2f31a9b3 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -249,7 +249,7 @@ static void nvme_kick(BDRVNVMeState *s, NVMeQueuePair=
 *q)
>      if (s->plugged || !q->need_kick) {
>          return;
>      }
> -    trace_nvme_kick(s, q->index);
> +    trace_nvme_kick(q->index);
>      assert(!(q->sq.tail & 0xFF00));
>      /* Fence the write to submission queue entry before notifying the de=
vice. */
>      smp_wmb();
> diff --git a/block/trace-events b/block/trace-events
> index 29dff8881c..f0c476110b 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -154,7 +154,7 @@ vxhs_close(char *vdisk_guid) "Closing vdisk %s"
>  vxhs_get_creds(const char *cacert, const char *client_key, const char *c=
lient_cert) "cacert %s, client_key %s, client_cert %s"
> =20
>  # nvme.c
> -nvme_kick(void *s, int queue) "s %p queue %d"
> +nvme_kick(int queue) "queue %d"

BDRVNVMeState is included so it's possible to differentiate between
multiple nvme driver instances. Simply tracing the queue number is not
enough if you have multiple nvme driver instances.

I suggest leaving this change until there is a hardware state object
that can be traced instead of the BDRVNVMeState.

--PkEWctFf+8E2rcii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl716zIACgkQnKSrs4Gr
c8jJ9Qf9HJuZXu8kmqsveZ+UvkYrGOXOhhCuNp9pztMlP/Hmn5Pks2HooNz7wFqE
hY69WpKDBeugM9TCCGXYArTkuQWoGCULSAu6dUuXWN15jKu1aa2qkY08NVEIbefn
lFvhCGgNfO8q08/Ggu0LOI6YuxlkGqdilW0CEKNmLd+c5ETcu+/NX19/RAIdxKXa
tm/Mb1f22NvUlQ5qPfCC9YuX4RNo+GL8gYCHpWo9qBJLUu7zoHTb/x314+E6bv0O
+aBBWZtba4GsDGlc3iNskP9Pyr3MTKfpr42CmlfWB6JK9MTFsAS4oURP5EwaVLKq
2rmiCY9DfWcGQia/6JCKKY0tJF9yMw==
=SXYF
-----END PGP SIGNATURE-----

--PkEWctFf+8E2rcii--


