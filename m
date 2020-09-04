Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D1DC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 21:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD81206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 21:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpMLg4fh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD81206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEJS1-0002kz-87
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 17:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kEJRG-0002FP-Ao
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 17:40:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26266
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kEJRE-00035J-29
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 17:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599255602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w1bm1Unu9nN2/KuMUPYOXpgvwuJl5o5tEq2q8ct7g0Q=;
 b=EpMLg4fhr5eBLJMpaQ4UFTuDirwiySJOKd6Fb76ufydMr302vEs8UVQz1ZwKtGT3csSgPB
 DFHtcatQj4vZJJgp+JLkJksZdNZZF0j8IIKQNR+428f8wjsKGukPcZUg30b+KNGcjew+jm
 ixb25wD1HWrVYkudXWydc3JBMD578PY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-DBARtyPnP86cBL8emDn6KA-1; Fri, 04 Sep 2020 17:39:57 -0400
X-MC-Unique: DBARtyPnP86cBL8emDn6KA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 823A51008304;
 Fri,  4 Sep 2020 21:39:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6874E5C1CF;
 Fri,  4 Sep 2020 21:39:50 +0000 (UTC)
Date: Fri, 4 Sep 2020 17:39:48 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 14/15] tests: bump avocado version
Message-ID: <20200904213948.GA275058@localhost.localdomain>
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903462803.28509.16851113546106095750.stgit@pasha-ThinkPad-X280>
MIME-Version: 1.0
In-Reply-To: <159903462803.28509.16851113546106095750.stgit@pasha-ThinkPad-X280>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 17:40:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 alex.bennee@linaro.org, mtosatti@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2020 at 11:17:08AM +0300, Pavel Dovgalyuk wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
>=20
> Reverse debugging test uses gdb remote client of avocado framework.
> This client was fixed since the currently used version 76.
> Therefore this patch bumps the version to 81 and fixes command
> line version compatibility issue.
>=20
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> ---
>  tests/Makefile.include |    2 +-
>  tests/requirements.txt |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

I'm queuing this patch on my queue.  Thanks!

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9StCIACgkQZX6NM6Xy
CfPCNA/8CUa3JkZu6G1lCjtdiWUIIYOnLJ6GJnfqtbUX4EEXhwVizS7whTdPofWG
NjUX45ke8Yg7KxtA2C4NK7jeH5Q/LcpwdvNhofUg7kSHPCqmxC+LTkR3tZqvp0Ho
4YT5WistszBYUYtleF/zKrd3JTqDhaknHMlsgPfPEap8heOtrWUamEmyh8haWot0
+ADAHErf2rRLNShYGs5xO31ad1bnPvPqFOnLudDcMyYz2SVw0hdWyVT+BelUU9Tb
KccTRqW1Y66wMKXyOwbk/Q4ZWDV2QEC/TiMtgBPOZLJ/iIBB4IMBng1geTkgx5W5
9ne7YioGBD9EsbG1PjEOzOtK59ddQIZ1pOQhcnIyqO8/wQJgQGkgVY5SJXnRoLOE
HNYA1hvO2t+e5e6gxNXEbjl06LaxVyK7+0DSH1BKSMkMYKFsfZyYEUQdRS94tGSn
QCn4qNsIeFrAIJIPlAPilouPM84e1XS1Wt32ru+qGslK/4mjMZ62YbX3DcD1n0mP
Ca8jEgd5TR6u9W+gdWWOVMP5wn+sFtZRdVUaVhXHqc8fp9AYO4nuGYz7Leiln/3j
DJhlj4G+i50dBi30FXHjs9vtOiFXY5qtyTp+KhpBxLQdJt7ubHub9yos0SYVb7+q
vxkuAUyIn/xousNEWdqGj4lgqdCewyCxuX36OToAQH6mIK3Fewo=
=6XaP
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--


