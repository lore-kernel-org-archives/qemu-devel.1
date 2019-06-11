Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC46BC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E4A20820
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E4A20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54484 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hadPB-00035y-PG
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 05:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47826)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hadOA-0002bk-K7
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hadO9-0001xP-Hm
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:48:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hadO7-0001oz-6N; Tue, 11 Jun 2019 05:48:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59B803086272;
 Tue, 11 Jun 2019 09:48:02 +0000 (UTC)
Received: from localhost (unknown [10.36.118.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CF571001B00;
 Tue, 11 Jun 2019 09:47:55 +0000 (UTC)
Date: Tue, 11 Jun 2019 10:47:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190611094755.GP14257@stefanha-x1.localdomain>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-10-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A6Z7MKnLVMfR85kG"
Content-Disposition: inline
In-Reply-To: <20190610134905.22294-10-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 11 Jun 2019 09:48:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 09/12] block: add trace events for
 io_uring
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
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--A6Z7MKnLVMfR85kG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2019 at 07:19:02PM +0530, Aarushi Mehta wrote:
> @@ -294,6 +302,7 @@ LuringState *luring_init(Error **errp)
>      int rc;
>      LuringState *s;
>      s =3D g_malloc0(sizeof(*s));
> +    trace_luring_init_state((void *)s, sizeof(*s));

In C conversion to void * is automatic and doesn't need to be done
manually.

> diff --git a/block/trace-events b/block/trace-events
> index eab51497fc..c4564dcd96 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -60,6 +60,14 @@ qmp_block_stream(void *bs, void *job) "bs %p job %p"
>  file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int=
 type) "acb %p opaque %p offset %"PRId64" count %d type %d"
>  file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_=
t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset %=
"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId64
> =20
> +#io_uring.c
> +luring_init_state(void *s, size_t size) "s %p size %zu"
> +luring_cleanup_state(void) "s freed"
> +disable luring_io_plug(void) "plug"
> +disable luring_io_unplug(int blocked, int plugged, int queued, int infli=
ght) "blocked %d plugged %d queued %d inflight %d"
> +disable luring_do_submit(int blocked, int plugged, int queued, int infli=
ght) "blocked %d plugged %d queued %d inflight %d"
> +disable luring_do_submit_done(int ret) "submitted to kernel %d"

Why are these disabled?  "disable" compiles them out and they won't be
available at runtime.  "disable" should probably be dropped here.

Please include the LuringState *s pointer in trace events since there
can be multiple LuringStates at any given time and it should be possible
to correlate trace events.

--A6Z7MKnLVMfR85kG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz/eMoACgkQnKSrs4Gr
c8hr4AgAhIr2e58H0Fc9GaMNsZRoQnniB3+mgX+djve8Owujv9QrKyfVLgbf5LTM
deCmNJolTlJJTkY1LMER+kvzigfNeXw0YpQFZIkx/GyfYflYUOzCiLR+dTaNtSQf
kdBylyWfAjBrjKlled9fZSGNbzqmaInRJMYE9AQ0JwbH3bHRKCrmw3e6MtNV0WU0
EIbtEUbRxUz8iHzOgXou/0nX8QwP1AOD57V1SgAu6O/AjCeo26f5zVAil+e6oOYb
skIfqVaxfoVYMgcAFCAZkFaeOaw1Z1f5QBvzcVRrjKqMhbifyA6x/mSkESIq1/0+
1Ie1hiBcrMizcqacouFA4D0ZiysMCg==
=DIbQ
-----END PGP SIGNATURE-----

--A6Z7MKnLVMfR85kG--

