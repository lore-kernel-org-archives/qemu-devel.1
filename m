Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADCCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D871020890
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbAz6nbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D871020890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvBq3-000716-6t
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 23:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvBpI-0006a3-7Z
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 23:41:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvBpG-0002tg-La
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 23:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594698093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nzine5zUTfzjHELM+7HT/+0ie1Fy0kEudiYsc2REOI8=;
 b=SbAz6nbmxBQkWXDsmQtEIiTa1f7QnCoDz2B8AHQovXjvRwXhAEifgPFmFWEfDGTqM8ojK8
 VRJUZZN60PoD2Xf1KmfvRp8BA30uqIag5XLFV1FyoPrxRGFktWdX5yowpyOEzEOu07rGPr
 Wybsb4YpjJZaUMWWuTDHa5QWB2JpUbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-NIzCAzXfNQmpZCnYpQ2mpw-1; Mon, 13 Jul 2020 23:41:28 -0400
X-MC-Unique: NIzCAzXfNQmpZCnYpQ2mpw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE1171080;
 Tue, 14 Jul 2020 03:41:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FCC178A41;
 Tue, 14 Jul 2020 03:41:24 +0000 (UTC)
Date: Mon, 13 Jul 2020 23:41:22 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 09/12] tests/acceptance: Don't test reboot on cubieboard
Message-ID: <20200714034122.GG2983508@localhost.localdomain>
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-10-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-10-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 01:06:46AM -0400, John Snow wrote:
> cubieboard does not have a functioning reboot, it halts and QEMU does
> not exit.
>=20
> vm.shutdown() is modified in a forthcoming patch that makes it less toler=
ant
> of race conditions on shutdown; tests should consciously decide to WAIT
> or to SHUTDOWN qemu.
>=20
> So long as this test is attempting to reboot, the correct choice would
> be to WAIT for the VM to exit. However, since that's broken, we should
> SHUTDOWN instead.
>=20
> SHUTDOWN is indeed what already happens when the test performs teardown,
> however, if anyone fixes cubieboard reboot in the future, this test will
> develop a new race condition that might be hard to debug.
>=20
> Therefore: remove the reboot test and make it obvious that the VM is
> still running when the test concludes, where the test teardown will do
> the right thing.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8NKWIACgkQZX6NM6Xy
CfNUpQ//QY8SUUpH17Y6hUdWDNFruBI5eubKDvcKy7XGUc11Il/mn06xW6ghSZ3l
f7GLgBlA8uKHghdKg4NpQlvkHhzNKrXVyLyfhnBcJ9CUREInn8CUWj+utIFR+Z6q
7izQq356zpdcisMW4wnYKWVfkayaXq4gsxF1Lz23229fSol9B8UPlnnQMsL6+maY
ZC+AyUKq+7IYkYFTQUAi7BqHjDkYnNq9UFC8Jy5vylKTvpAmsT6gVISMd/oboFn2
Re2av+rGOdnOyg6kB7pcZqDoqsDT/6edWhg35CfhZKdXk6Vhg+3LYl9Jjb+b2ABW
ZWIN0zJHcYmHjX52gYtAY2EZ7BsBqgmAvtkOv/JutQT2QHj1NaTTGIuXSAGqCTCp
hWp+bz39I3xh5emRSjpUVTDwAmCODqPv1UikvMJru7rdfMchDywl5rp7pbGXpIo8
JuMVY00SHXs0pOMZjwX8WeiSM95eibzZzn9ekEW/PMMqYlgtebdDyDjddBVqwmrA
1xUDQj1ANtR6uDTsVRyGfuZP/MaD6L0L0CZqeva6HETXtwm5KwGAqiewJ3xnXy0c
lHN6ZV+7QeHx+35MTdc461rZScuLsmBCNu6Gs9oG3E7+TZTjWkRsHvrl7veIfuG1
wDmOWRsypiq+jj1oHk6mE/4wEzOCL2/Uxyh+ukRjsVNbuLAhqCY=
=pwLV
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--


