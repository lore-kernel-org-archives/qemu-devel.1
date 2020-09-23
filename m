Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAFFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA4F20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1tLrVyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA4F20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL45X-0005V2-Bn
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL43T-00049T-Fv
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL43R-0006Rn-Tp
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600864765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9IwgUA9Kc/6lzxx8FAKIpLV4fiO34KdALsMa2jWmgS4=;
 b=Z1tLrVyEmOm3AHGMJnk6kOx5EtLVSrYbvh1K/AJRNw4BdzVHld1Y4zSDgGpPBEtA7c6lJV
 JTKWqehfJScNsqY8pPFMGdOY9NejP2rp6j6EaANv9CdNicYCJX9tcUIUdJNnw+AE247k0F
 jKT5/iGYcUGl21gwia6VZzigmDkv8pM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-WM4aTfERPsaQz3XAVX27EQ-1; Wed, 23 Sep 2020 08:39:22 -0400
X-MC-Unique: WM4aTfERPsaQz3XAVX27EQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3DAE8ECE4B;
 Wed, 23 Sep 2020 12:39:21 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B47660BF1;
 Wed, 23 Sep 2020 12:39:21 +0000 (UTC)
Date: Wed, 23 Sep 2020 13:39:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v10 0/7] vhost-user block device backend implementation
Message-ID: <20200923123920.GE51019@stefanha-x1.localdomain>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200918080912.321299-1-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thanks for contributing this feature! I have replied with comments about
additional steps I'm taking (fixes, cleanups, etc).

This series looks good:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rQfgACgkQnKSrs4Gr
c8is8gf+JGVZ1yxqmDGSCtSlF45Pu0gdZ9Elf2L7+tFkdhSPXgX+TCDZFKXi1a5J
ZunoY4jh+3ijONYW0Usc8x1dNhSDIy2sJqS9ZlMdy6G8FVeKMcjxTEmD9VQ3LTi5
0XBrhTFn30nUBu4v3T/KwOPYuebEeQeHGRy14BKHheCt2MQYBzPbPz3EFFa3dLC4
Y1HudTIoDqwo0r4vsNUvmyxAr/+HZRxj6rMHlgn1LNHtFEhk967OOP8tEAcWrUr/
aUWhaNrKwmNwSKwQ8IBR12gRzvWkHxrKDa0jiIpmRsRe/4H3DAkDk1a7+fefJ6wI
7qVSdawXmXnnS//lBtufKkCXAv4XHQ==
=HhCt
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--


