Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2284FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7E8221E3
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzexD4D1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7E8221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkhm-0005Hc-Ud
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGkgn-0004NP-Sx
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGkgm-0002yk-9W
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599837011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVFkPNWstNVlF4oTtrMSbly2KwsAckH57gkw84vWhAw=;
 b=DzexD4D1Quo/JCjw8qrTIxJPitzepgjILCYkVRjzkjvechbRap7ZLc4hrvSle00yMSR2uz
 m3pmrkSuGrxbe23kPT+lhQrRYhIWKBAXJxrwiQIMtgEPsKv+JDvN4PO4lND85b/11h7IgI
 ABcJT7NlB+qcjye/AVnCWN3ho9mhDIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-fN8fH1vjNcuEQk92LxhfeQ-1; Fri, 11 Sep 2020 11:10:08 -0400
X-MC-Unique: fN8fH1vjNcuEQk92LxhfeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C87D188EF25;
 Fri, 11 Sep 2020 15:09:40 +0000 (UTC)
Received: from localhost (ovpn-113-177.ams2.redhat.com [10.36.113.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D2895D9E8;
 Fri, 11 Sep 2020 15:09:40 +0000 (UTC)
Date: Fri, 11 Sep 2020 16:09:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] Enable virtio-fs on s390x
Message-ID: <20200911150939.GN94280@stefanha-x1.localdomain>
References: <20200901150019.29229-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200901150019.29229-1-mhartmay@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="prC3/KjdfqNV7evK"
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--prC3/KjdfqNV7evK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2020 at 05:00:17PM +0200, Marc Hartmayer wrote:
> This patch series is about enabling virtio-fs on s390x. For that we need
>  + some shim code (first patch), and we need
>  + libvhost-user to deal with virtio endiannes for non-legacy virtio
>    devices as mandated by the spec.

Conny and Michael already posted R-bs so I've applied this:
https://github.com/stefanha/qemu/commits/block

Stefan

--prC3/KjdfqNV7evK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9bkzMACgkQnKSrs4Gr
c8g3iAf/bDiD2FZFbPphxwnEysaCWhvFapftZZnMyvf1yFg6Pvop3K8EDbT4fwBV
StpkU1z3Pp2s6bXrLmLUqkDx7+ik2SNwcKwi0Fum5LiOQ1/5coX7on1MUFZ8awY7
1h9IhjV47yFktQWpBJG7s0tQBUyOPy/McmRO8sC9BMagcxYj9zUMFWvCI5jvZppW
naImUpy4GIHVTcO1s8xQ7GX2Cx2RflIgBx1mvn7NkuXQvx3fRmP/+ApFIOowGe/F
AGpczOSQgM/SZNXfpGuNeXjGud3orMYbzmZwbUfkU+8grhbkO/PYeCj0pwMTYqMu
Pn+KBbR6IIukd59DEAMo0Ql4MkC1IA==
=PH/e
-----END PGP SIGNATURE-----

--prC3/KjdfqNV7evK--


