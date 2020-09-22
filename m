Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD0C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D472722262
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pa/inlt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D472722262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlYD-0000Qp-S5
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKkol-0005C3-O3
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:06:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47641
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKkoj-0006IS-E5
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600790816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AXjMlwf5X7P8Pk572363HczdlWXD/rWfSyhCdTJtarA=;
 b=Pa/inlt7xMP/A8cfsI6ZrdEBYCyAFS2yZPdXboB6OvqhrPn1TNHCYFfgmUxdTUJEzZ36Fp
 4YeiIsn0jfJRO334XNRsPZsRVHN0tRa/X9blrqou4c5N+Gl/uqqZe69ldT+sF4xBPYITR9
 5C5MeBKw65ZdPhyCQDxmtODZtrY+dos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363--u8BkkJzO_Gbn2UPLeEJPA-1; Tue, 22 Sep 2020 12:06:47 -0400
X-MC-Unique: -u8BkkJzO_Gbn2UPLeEJPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D88D8064B4;
 Tue, 22 Sep 2020 16:06:46 +0000 (UTC)
Received: from localhost (ovpn-115-55.ams2.redhat.com [10.36.115.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2450960BF4;
 Tue, 22 Sep 2020 16:06:45 +0000 (UTC)
Date: Tue, 22 Sep 2020 17:06:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v10 0/7] vhost-user block device backend implementation
Message-ID: <20200922160645.GA294501@stefanha-x1.localdomain>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200918080912.321299-1-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2020 at 04:09:05PM +0800, Coiby Xu wrote:
> v10
>  - Use a linked list of VuFdWatch objects to keep kick info [Stefan]
>  - Merge improvements and fixes from Stefan
>  - Rename libvhost-user's vu_message_read to vu_message_read_default [Kevin]
>  - When shutting down the client, wait for the coroutine of processing
>    vhost-user messages to be finished [Kevin]
>  - Allocate struct req_data on the heap [Kevin]
>  - Improve coding of qtest case [Thomas]
>  - Fix several memory leaks detected by ASAN

Hi,
I have sent a patch series with cleanups and a conversion to the new
block exports API:
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg07946.html

I will do a final review of your series tomorrow. Thanks!

Stefan

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9qIRUACgkQnKSrs4Gr
c8hXWwgAnrme3FWQOuAwmbXZx8NQVGOUDDGsSyq7euqqqCxkB7uTqISaSf/DNcD3
DhboSKbpdLT+2TC6koGHreVrWO6xjs82Uw85u2LOcObOkxZJgG7HqDrP4jMoK6Md
GQzoqtXkZ7AbrH9amz81ABn2rJ9boCEKhS9ogv1mpVenif1ozmOA8phARW8rmpwI
FjXIrlekitF3WmcurRy3tYbSsylO5ef3E/Iqk1y7j/jsIWfifKeNricq99RnTtJ5
WmGR1JkQPVtetVrpemcku5yAKgkN6LLES/GDoXkRl+7A3rpmh74K5Lky4UxReN4i
vStto4U1+yaAPx+RKTwQlfcaLOi8uQ==
=ek40
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--


