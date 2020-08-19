Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702ECC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395C12072D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9WCZEGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395C12072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Oqm-0000HQ-EY
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8Ooh-0006ye-Jr
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:11:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8Oof-0006Px-TY
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597846309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Hcol+djmeF8F34UJe7ANhCMctvZH25bf1ee7e0vk+Y=;
 b=g9WCZEGZQm1olnSa1JDe+1C1YQTIBRvyzml5ss0m/29vC4fPapJEgrkPsm48xyRrE9GPD1
 H9O0xVdB/R7gcRMewg7WaQxRGQmAZSh8rUyW3qaNdMULOAnT/FlBMlOwZmdNzuggQMa2Fu
 BzjompfuvafxzXYwwxtXvhdRoQuhxRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-NPTtnWzDPJ6jejnKpH4QiQ-1; Wed, 19 Aug 2020 10:11:44 -0400
X-MC-Unique: NPTtnWzDPJ6jejnKpH4QiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92C158030A5;
 Wed, 19 Aug 2020 14:11:43 +0000 (UTC)
Received: from localhost (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA49267CEE;
 Wed, 19 Aug 2020 14:11:38 +0000 (UTC)
Date: Wed, 19 Aug 2020 15:11:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Edmondson <david.edmondson@oracle.com>
Subject: Re: [RFC PATCH 0/9] block/curl: Add caching of data downloaded from
 the remote server
Message-ID: <20200819141137.GC366841@stefanha-x1.localdomain>
References: <20200818110845.3825105-1-david.edmondson@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200818110845.3825105-1-david.edmondson@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2020 at 12:08:36PM +0100, David Edmondson wrote:
> When using qemu-img to convert an image that is hosted on an HTTP
> server to some faster local (or pseudo-local) storage, the overall
> performance can be improved by reading data from the HTTP server in
> larger blocks and by caching and re-using blocks already read. This
> set of patches implements both of these, and adds a further patch
> allowing an offset to be added to all of the HTTP requests.

Hi David,
Thanks for posting this! Kevin and Max are the maintainers in this area,
but I wanted to ask an initial question:

Is caching curl-specific or could this be implemented as a block filter
driver so that it can be stacked on top of other network protocols too?

Thanks,
Stefan

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl89MxkACgkQnKSrs4Gr
c8jdNAf9FucmktZY7RVYduexMFd3UPakCzSb+OWb2u3AsWY/p2ZXu4GLuY2ALagP
vak41fCMhFyzzCZHdegGlD7zTpZb0QAEjrjAo55l6bvyKGzwEDkz4FzHryF1vYqU
VgF2mzHearI9OtHbhNN1UOiS3M2MY3X8LLzRoPdUuqY8Awl5mFeoYbMgRG5fIvzs
pgBGw4NfY8anWNlbvUoku98EWsAjIXZXZurjVf+tO7PNEU70cU1ibRQL7UpvtH61
mc6oUWPS8qt1T/mhxWehdRytWk+BmpAafAIJQphhO0RuqmjpPYiJzrpvNJX1wuC4
y6eyqC3a/KjwJWQKDWPcEtbchYfCPg==
=r06g
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--


