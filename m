Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372F5C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CCB920758
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fx/HvrOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCB920758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGgD5-0001VW-KO
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 06:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGgCJ-00016f-DF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGgCH-0007U7-HQ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599819744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BiN3QKH3xhjBObVlIlxdalatqEgCiH5hB+A7NcWue/A=;
 b=Fx/HvrOv2Wg6HS2Kvb5AKCjYpxuiCuaCFUz7Vf34g9Gvt2zUvkJT2UNZFlOq7/TGp5SFw9
 dh4O3XNeXWn3ikHmUVIn7NWny08j1ZHWJEWg0azwf7NZS8RyWM+3CNSgZRROTua8iBxewm
 D+a0YJZBdAFf5Kg+z7uksSl/KNHfV2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-d838-wpVMC-Zyo0_DPPz2w-1; Fri, 11 Sep 2020 06:22:22 -0400
X-MC-Unique: d838-wpVMC-Zyo0_DPPz2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FC2F425D1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 10:22:21 +0000 (UTC)
Received: from localhost (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBCA875131;
 Fri, 11 Sep 2020 10:22:17 +0000 (UTC)
Date: Fri, 11 Sep 2020 11:22:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 0/8] virtiofsd: Announce submounts to the guest
Message-ID: <20200911102216.GB94280@stefanha-x1.localdomain>
References: <20200909184028.262297-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200909184028.262297-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 09, 2020 at 08:40:20PM +0200, Max Reitz wrote:
> We want to (be able to) announce the host mount structure of the shared
> directory to the guest so it can replicate that structure.  This ensures
> that whenever the combination of st_dev and st_ino is unique on the
> host, it will be unique in the guest as well.

Great, thank you for solving the long-standing inode collision problem!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9bT9gACgkQnKSrs4Gr
c8hNGwgAg4Xh++jzhmM9iDbsA9LVl1TcM7KBkySTROkWPcU0j/PlOWTfwrJTkZkd
4fkxoPOQnBoNUPEsAX06Y2UOQvCRWtRZu/m/JyrIIy/UNgffTta5FjCEgyZbOcFA
qSeb1iihUSkU8AMneplFis4yosc/R849IgrXCICNjSh6HtE8GkXWyOi3qW0ZLbPF
S4y9HZCBUW30kGDk80F2Y6lyvcVggyHJuHwOJWsD+tE5jGO0iFBpL7b9V7EpQJ3o
raNBl4SxueutlbTCvG0/r9Qvy/hin+NKB4v5sclGy7laBsHMwYPIM5yTCg1zeY23
s+I2eDcPpLSd6kaPjF7/Y2Imj2gm6w==
=je+o
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--


