Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A579C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F77420791
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxeCEfqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F77420791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcGW-00010r-Pq
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLc9J-0007qJ-4Z
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 21:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLc9H-0004EW-2S
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 21:03:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600995822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+0adTjZOnLzLQl5iK+M7OgaHQl/j5U/j7s9kWIkNk3M=;
 b=TxeCEfqemgewUYXjcTWxRFIbemMBC3FaSE0PxhK44YTWkrrwthXcxzZfzhitjDAgh1Nb9n
 yThS3Ny+UIhIfvsCP7PuFXAgx5pvv8J7ndiglMxkUV2YalFAosl3Wf8UQO76VaONXXpWbT
 QagOsa5LEwjtEaj8dmZDu4JZV9jF1qA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-JVAzzufjNYigsTOBD9QZRA-1; Thu, 24 Sep 2020 21:03:39 -0400
X-MC-Unique: JVAzzufjNYigsTOBD9QZRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD49C801AAB;
 Fri, 25 Sep 2020 01:03:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE29910013C1;
 Fri, 25 Sep 2020 01:03:37 +0000 (UTC)
Date: Thu, 24 Sep 2020 21:03:36 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 14/16] qapi/expr.py: Use tuples instead of lists for
 static data
Message-ID: <20200925010336.GG368253@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-15-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-15-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QWpDgw58+k1mSFBj"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--QWpDgw58+k1mSFBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 05:13:11PM -0400, John Snow wrote:
> It is -- maybe -- possibly -- three nanoseconds faster.
>

Kevin O'Leary would clearly say here: "stop the madness!" :)

> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--QWpDgw58+k1mSFBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tQegACgkQZX6NM6Xy
CfMyqRAA0c1j26OCVdy598PcmEZHMWaBnd4a/yuoquIvL4N3V5IQFaJuQA/Cy45e
bHkOVeB/V2QZKIWRWR/5TfGQZ4HqCZpglrjf3xDXMAVVcq8LX2EpjSQGusETYE0g
xz2HfoFd/a6fdzS8KNYnpBfEnToQ+EeYvntHIZtcWuYRFmcmXNoJRjMKKPzkwe1Q
Qn1GAuk9KISjSUxgrHLHaR0p/nPBDixv7FzRTOzLghzlvJ8bG6QDMhrgG1XnwZR4
CHZdtAUkHaoS27NrvmlIJ7cjRQHYe/Qpg4BnnHBoA0H2v90lRmnlgkXhfW0/kg9+
F+DKXuOqzhL/3HYtbrpJ+RnFnbKst8apYvFUr8HCA9nLXZYEWUCD862w2Azphcre
i88B4OCFhFqAZO5Dx5qHAiB0+dc1eEx3scj0nP0K5D0twCBKpg8I9sr46bN5TYas
Q52XD8SiGWEitEaTc6Ld1hhoOyBqz+f3P5UwaO7UmSyCqWPSF8+wrFrKtnK9wxxq
LhjpyCfSijpavrLzGO8ZFWhBLEguPywximgxQhuxtH6/uNqP6RdH2ubMxrgrNa4y
JjLt2ddIcywjs1Qa+Wx5yUpqIppC/W3GQFwocpBNR4o7cd5xbHcVkuFlyKGltqS2
WMAYg4ifbHZHrEf6fce2DqHdhAQvtNNAQ7NvB1Gybmmsi4v6WzQ=
=VVeR
-----END PGP SIGNATURE-----

--QWpDgw58+k1mSFBj--


