Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3287C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3984F207E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3984F207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54560 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hadTd-0005J6-9l
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 05:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48634)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hadRo-0004He-PY
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hadRn-0004u4-SG
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:52:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hadRl-0004sH-OM; Tue, 11 Jun 2019 05:52:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8062585A03;
 Tue, 11 Jun 2019 09:51:59 +0000 (UTC)
Received: from localhost (unknown [10.36.118.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF956608E4;
 Tue, 11 Jun 2019 09:51:54 +0000 (UTC)
Date: Tue, 11 Jun 2019 10:51:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190611095153.GQ14257@stefanha-x1.localdomain>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-11-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bEjdSXxHv0Az5++U"
Content-Disposition: inline
In-Reply-To: <20190610134905.22294-11-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 11 Jun 2019 09:52:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 10/12] block/io_uring: adds userspace
 completion polling
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


--bEjdSXxHv0Az5++U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2019 at 07:19:03PM +0530, Aarushi Mehta wrote:
> +static bool qemu_luring_poll_cb(void *opaque)
> +{
> +    LuringState *s = opaque;
> +    struct io_uring_cqe *cqes;
> +
> +    if (io_uring_peek_cqe(&s->ring, &cqes) == 0) {
> +        if (!cqes) {
> +            qemu_luring_process_completions_and_submit(s);
> +            return true;
> +        }

Is this logic inverted?  We have a completion when cqes != NULL.

--bEjdSXxHv0Az5++U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz/ebkACgkQnKSrs4Gr
c8h30AgAgzekxFZbbK6ZclDsvSDswqyxj/8zBvwY0sKl230sbhj8qxMSaTKp8gn9
J9UFwP0BIG/81ib00avSZUVzvI2lMTkduaJM+qo99rIan4eIctxw3sOn5YRGsKjm
q3ynqj7MCCNWMxGmx9z7WaOu1MH/UZyxohC8+lhbnhRFUhrX9RVYeEBsgh9vA98k
+RXUyBEwvgApMNq/Uwa3AaG3828WPJUEKKio3yt/FgUoa1eBE58oRgxPUC0vnPQK
mEaB007RUU+xhM46txQB+vrkuh387MLUV3981j7mGQMrnFA0R6SSomshrhvNUYcV
df0CISQaJwA03EH1xzOBkkqtqLQJdQ==
=AN0N
-----END PGP SIGNATURE-----

--bEjdSXxHv0Az5++U--

