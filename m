Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE08BC43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D482086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D482086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54938 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hadYT-0000FO-Qn
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 05:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50754)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hadWy-0007Nf-LY
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hadWv-0008P8-RK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hadWp-00083c-8d; Tue, 11 Jun 2019 05:57:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8ADE81E00;
 Tue, 11 Jun 2019 09:56:57 +0000 (UTC)
Received: from localhost (unknown [10.36.118.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37C555D704;
 Tue, 11 Jun 2019 09:56:55 +0000 (UTC)
Date: Tue, 11 Jun 2019 10:56:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190611095654.GS14257@stefanha-x1.localdomain>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hEarWVD7htqb1VxP"
Content-Disposition: inline
In-Reply-To: <20190610134905.22294-1-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 11 Jun 2019 09:56:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Add support for io_uring
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


--hEarWVD7htqb1VxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2019 at 07:18:53PM +0530, Aarushi Mehta wrote:
> This patch series adds support for the newly developed io_uring Linux AIO
> interface. Linux io_uring is faster than Linux's AIO asynchronous I/O cod=
e,
> offers efficient buffered asynchronous I/O support, the ability to do I/O
> without performing a system call via polled I/O, and other efficiency enh=
ancements.
>=20
> Testing it requires a host kernel (5.1+) and the liburing library.
> Use the option -drive aio=3Dio_uring to enable it.
>=20
> v5:
> - Adds completion polling
> - Extends qemu-io
> - Adds qemu-iotest

Flush is not hooked up.  Please use the io_uring IOURING_OP_FSYNC that
you've already written and connect it to file-posix.c.

When doing this watch out for the qiov->size check during completion
processing.  Flush doesn't have a qiov so it may be NULL.

Stefan

--hEarWVD7htqb1VxP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz/euUACgkQnKSrs4Gr
c8jOOwf9HW0ydaU+UU0mya3fGTH1BHvQH+wPa9vnx23y4PNW9hniKp5fd/SoQqKH
nB0p/pYkPVjti5iDVtYHsMc+9NhkeLxfSdQaa+lHgmkJmInLYHxExz37ldyzRL9l
2VEHaKkcL3EA2rJkSuaUw0YlqHsTo7iLqY8nku/Knh3aMI7KjWAlJfWWlvvKm/Ba
STFntaUCRmxR0wxMCdgo6NNmpxCFzWCoaDTfnmxhzHsSEuYWyx6hPmvM1cxhFW9n
MFJpVTEwLR+ABLFGszA0UwzScdRAWR8vUw/1KG/JCU6Ck2U7cLqp435FxXnsTego
GL+Jm5DuI7WJfHULTBOkGsD6PNDvJQ==
=Nv06
-----END PGP SIGNATURE-----

--hEarWVD7htqb1VxP--

