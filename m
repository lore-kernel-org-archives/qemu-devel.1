Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043CCC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4989D20708
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oby04/AG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4989D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQXMV-0002HV-1w
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kQXKv-0001EF-Bw
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kQXKr-0001Yt-5Q
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602168959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iWfIE4I0KlAgZ8tU8HocZq1+26WHpPm5a9jve5BZASk=;
 b=Oby04/AGxIueGbfVHSunaLtZqMLiZauFZBsSW6l+n9Jw2t9tXOBOAXje4wmKLE5/Jq9q9H
 J9qeDnW0f+pnsd1P6ZRspdJafwe1ODa/odxxHzlZ5K3TiQREUIlMwOES85v1gb2sckMROo
 91XL3RL3CaWSLNxpTjo/KuPyk3qasE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-I76J1zmXMD2Bq3mErfC7SA-1; Thu, 08 Oct 2020 10:55:56 -0400
X-MC-Unique: I76J1zmXMD2Bq3mErfC7SA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 432F381EE7F;
 Thu,  8 Oct 2020 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EEB75576E;
 Thu,  8 Oct 2020 14:55:44 +0000 (UTC)
Date: Thu, 8 Oct 2020 10:55:42 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v1 22/22] tests/acceptance: disable machine_rx_gdbsim on
 GitLab
Message-ID: <20201008145542.GI240186@localhost.localdomain>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
 <20201007160038.26953-23-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20201007160038.26953-23-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BWWlCdgt6QLN7tv3"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--BWWlCdgt6QLN7tv3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2020 at 05:00:38PM +0100, Alex Benn=E9e wrote:
> While I can get the ssh test to fail on my test setup this seems a lot
> more stable except when on GitLab. Hopefully we can re-enable both
> once the serial timing patches have been added.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--BWWlCdgt6QLN7tv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9/KG4ACgkQZX6NM6Xy
CfOp9xAAkAAdpD8TbpL+zmXgDhuj9YhGPYITSJBGHbVXQ6c7Mx7t4rkQTZb/RdDn
KiD18HTsmiq1IGzu/U1EFVJRuW5Gu48o5M8gnHCBeMMHjHdGpGocY999zLH8UJhk
aFz8O0YglHq1bo+EMpjfEVHHMNL1O8aF9PYuzei7/v2gr05AL8eNc6t01JGMriz2
SS301XnkDBo+72HGyFDs6ZwDZ1vCaoY9Nck4QGEitxIALVBnpw2d8tj3MpLFhtvw
6I1H1j+duDpML4GNI1FvEYHRpze9QkJOl3JqbVosOvppWb8wwilAwOshFSsxc1NC
7272qGatCI6UdyFbt2PwGr9mGntcWViSrka2NXsGtkyAkjGUUQnXs6RS3yn3/vIr
/iA2gxXvpGFeU5tCvVf0RenR4q4Ko09y5d2PXE5WeRnCattPTQxpljXfe2K+8akh
H0f/9U7BjsgPRWJk+g6X2jrv0SUQBbm7+Dpyjf2QscrgZsr7N2EqLJVEwMwQfxKG
zj4pJO8DXj4SorJlrwF/V8fKGpQdWu3Rn6h9wzMxj9Gj2hZ4ZQJ0NotZSzS5pSDs
JXi2XKHHcij2spoAkYdk8nvPTQOCU+nDOale5HtRta4g/oy5VKC81H8DSSZyX+X9
TIlD0Xkzoy4GcxxzNeEzFpUEANZxHIO0rCKsr2EDJtfcgU6wZuY=
=SX5D
-----END PGP SIGNATURE-----

--BWWlCdgt6QLN7tv3--


