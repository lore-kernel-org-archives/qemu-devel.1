Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8F6C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C628920936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gdc47KGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C628920936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjTU-0001Qy-Sh
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLjRo-0000I1-1E
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLjRm-0005Pi-79
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:51:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601023877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nNk+NFqyEUd99B6oVX3e+DRmCKS0dtGyHIVXwI5ceao=;
 b=Gdc47KGPltteFiVDgpz7qZEAKcnZjYBQzPOLdu9+F6//mfhWZedDsQa3DY8ggJ+ycqfrI1
 5x1blYRJCQ8MkBlLnNt/r+S39SN06Y5aIZynMoDHgfDbA5pyDjJ/OL4eqdlkCTi7O9RGjV
 xDD0/h+iFIkuZ89jX9kzMPJ2iPSkQSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-07yVMxfbOP-DwHz0KJRPnw-1; Fri, 25 Sep 2020 04:51:15 -0400
X-MC-Unique: 07yVMxfbOP-DwHz0KJRPnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 348991084D77;
 Fri, 25 Sep 2020 08:51:14 +0000 (UTC)
Received: from localhost (ovpn-113-240.ams2.redhat.com [10.36.113.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5CA555784;
 Fri, 25 Sep 2020 08:51:13 +0000 (UTC)
Date: Fri, 25 Sep 2020 09:51:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 00/31] block/export: Add infrastructure and QAPI for
 block exports
Message-ID: <20200925085112.GD33068@stefanha-x1.localdomain>
References: <20200924152717.287415-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924152717.287415-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 05:26:46PM +0200, Kevin Wolf wrote:
> We are planning to add more block export types than just NBD in the near
> future (e.g. vhost-user-blk and FUSE). This series lays the ground for
> this with some generic block export infrastructure and QAPI interfaces
> that will allow managing all of them (for now add/remove/query).
>=20
> As a side effect, qemu-storage-daemon can now map --export directly to
> the block-export-add QMP command, similar to other command line options.
> The built-in NBD servers also gains new options that bring it at least a
> little closer to feature parity with qemu-nbd.
>=20
> v2:
> - Rebased on current master
> - Fixed assumption of &blk_exp_nbd instead of drv in generic code [Max]
> - Documented blk_exp_request_shutdown() better [Max]
> - iotests 140: Fixed race between QMP return value and event [Max]
> - Improved the commit message for patch 26
> - Removed copy&paste error in deprecated.rst [Max]
> - iotests: Take Sequence instead of positional arguments in
>   qemu_tool_pipe_and_status() [Max]
> - iotests: Separate patch for qemu_nbd_list_log [Max]
> - iotests 307: [Max]
>   * Allow more image formats
>   * Use sock_dir for the socket
>   * Use f-strings instead of % operator
>   * Log events after deleting an export
>   * Test force removing an export

I rebased and retested the vhost-user-blk-server block exports series on
top of this:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9tr4AACgkQnKSrs4Gr
c8j+Zwf+NOZY/1jKZ8ywOgCmp0GrXVEWFuSUDkiSmTOINK04zJDi1h0x9f7mVJ2G
coYiffPABqAL6pCyI6nnYL/osi+cwrzVr7RYt34hUfYeWpgNzV4jSXUMOS03MF9U
iEn304GMkVDopFt5V6AB1tXliqqEcFWRibkLu18eVRVJ4+E0PQ9BZ8TrQOI1TnPG
5iy3J4uP1FJWiFFcOE0RmF1cMvOAjLNjyYwnRtX3wLCOWG1l99leIu30lbJzp7DW
jmNnB9jiYZZ3RkQroshdFZT+TjVg9UKgISo/gO/re1nNAo2U+u+MrmDpZuLR3pYt
EYRNtreGfeWB1kWGyKiMRZ1hiiECsw==
=kDJC
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--


