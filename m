Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8121C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6032A20674
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbTI1L1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6032A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83me-00055y-IR
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k83Iw-0003ik-9k
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:13:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k83Iu-0007zd-KB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597763615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8sRqy8XuiSsxrvuSD+thwhrBHJ9SnwQDmZx4ZaWCGw=;
 b=TbTI1L1zjdZ/Uh619PWuZ4eJcsLxxB0oYXryvR4FBlrxFUPIAD2g9jfLwMMRH7hpMOKgT9
 KnyOXHGOOGJPEAOQHCotPI3XgluSnunK3PwKTy4iAjL7vSuK2628ifZdMTBgOgtndmgHRj
 YqyeGf1ocJrCxry1WuhX4lOaTh8AUew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-xPXQAc8HPZ-ecNBc5C2hyw-1; Tue, 18 Aug 2020 11:13:33 -0400
X-MC-Unique: xPXQAc8HPZ-ecNBc5C2hyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BFCD100CEC3;
 Tue, 18 Aug 2020 15:13:32 +0000 (UTC)
Received: from localhost (ovpn-114-160.ams2.redhat.com [10.36.114.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 094297A403;
 Tue, 18 Aug 2020 15:13:31 +0000 (UTC)
Date: Tue, 18 Aug 2020 16:13:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v9 0/5] vhost-user block device backend implementation
Message-ID: <20200818151330.GC311676@stefanha-x1.localdomain>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200614183907.514282-1-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2020 at 02:39:02AM +0800, Coiby Xu wrote:
> v9
>  - move logical block size check function to a utility function
>  - fix issues regarding license, coding style, memory deallocation, etc.

Great to see you are back, Coiby! Looking forward to reviewing v10.

Stefan

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl878BoACgkQnKSrs4Gr
c8gVlggAi6GIf2+9ZEENgTYfjdTyQJRfp7DbBIUaT8kXhsAXRUreSB1Uny0bxg93
WDXGUf29iy942WXiM1JUtCaMP1aCY2LLmKcCH/HPcs5YnbMz0q4nFkgVl4kjgcaC
WkY/vjMcz2lU8Ysw+3zYEx53TuH10QXwrFzbzq8PzafseQsQ9eYYHS+ybc9IgnGa
vQYTf+DzCJoM5Is8p4D++18usCvp6b+rZ/cIQeR8B2hZc6LImQitxmM4crJvch5P
gmgnqejvxmTEoSJ2h9cjX3h6qxUuvlwIpYIRVGMQFIL4lc3gvaS9gYZ4XKbTu0TF
LZ+efy0XypU8g87vMHR5eYH/yfi3gg==
=4R3h
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--


