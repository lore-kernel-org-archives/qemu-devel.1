Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7C3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184D720770
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvtfTjaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184D720770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqf7-0000bA-45
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 05:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIqda-0007Tz-RP
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIqdY-0001Rb-VS
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600336531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k3ivdWlVH51bOprNNwoWnBrOts3OHR1dHAjQdgenODs=;
 b=IvtfTjafdvMBu+mn3XjCXHEaSfmGJqA76amBbE9+YoyfutOZ3NKdjs2ipDdZJYa97h6Cam
 4anL2r4ctZgMey87+tpJ6PSqr6Bkps/EOdkcK3kEJSMfAPC8nwsRpIOqkiLmk3m3OaJfDc
 DzSL67UO5dlJVLFFsM3T921MZeZ9vq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-dtHvwprGP-Sx-JwKeV8Cxg-1; Thu, 17 Sep 2020 05:55:26 -0400
X-MC-Unique: dtHvwprGP-Sx-JwKeV8Cxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1E896408F;
 Thu, 17 Sep 2020 09:55:25 +0000 (UTC)
Received: from localhost (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47B017CD34;
 Thu, 17 Sep 2020 09:55:22 +0000 (UTC)
Date: Thu, 17 Sep 2020 10:55:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/3] block/nvme: Initialize constant values with
 const_le32()
Message-ID: <20200917095521.GC809514@stefanha-x1.localdomain>
References: <20200916204004.1511985-1-philmd@redhat.com>
 <20200916204004.1511985-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200916204004.1511985-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 10:40:02PM +0200, Philippe Mathieu-Daud=E9 wrote:
> To avoid multiple endianess conversion, as we know the device
> registers are in little-endian, directly use const_le32() with
> constant values.

Can cpu_to_X() be extended to handle constant expressions? That way the
programmer doesn't need to remember the const_X() API exists.

Maybe __builtin_constant_p() can be used:
https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuil=
tin_005fconstant_005fp

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9jMokACgkQnKSrs4Gr
c8i1awgAjnNvpuF59Jr1eh5dnuwDw7NOtcTyO2NNx03NhPJfNzO3oykphWbPZ9wc
EnIJYupTHTkakx3g6oFbbGLY+mYOpuwKkgWunKyOP0cNF57tc84PllXDMXIoRJcS
6KSJ/l7/V1h8U2nKBfjaQMp6BBX59215ruHzZFKdccQTX70gjE35YgsuoIrQXOuX
d9v1RBc6Q8u+86FIKXRzDzjzhRKPYDON5K9ENpw+9AI92jqMdFzaFmxO7dPZosnn
A+iFsik0kk6O5NFSwg/vKbnRK2z+DzpGTphqmc9bzFARpgZpDcFLPYd3fNxVpBho
9ufYA9OyulSLJThPZftIXKJCypdPtg==
=qSK8
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--


