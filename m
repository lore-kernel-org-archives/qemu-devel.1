Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4E2C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B2C206FC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGmJEXU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B2C206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLMgM-0004QS-88
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLMeh-0003OG-5b
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLMee-0007Xx-Ov
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600936263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5GIGTqRX7PElpnEgI9NFkzIsp71UVk0t290OJmsq4/s=;
 b=PGmJEXU96XOb0gZCEqamhdE4DTqfz4WVtgCAhzeK/BJcYTXUcdS4EzEgADYT/1LGVOqGdU
 UTP/GX684oQU9VE0OmHoASMeX2XvX9a59hkCrHhiVW4ugPE8q/pc8tynmPzVkby4SiJVdH
 gxtFDEG433D4icmtaOUXGz3SW8a7/QE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-GOSE-9NkO0ij6RRdIcVAMQ-1; Thu, 24 Sep 2020 04:30:59 -0400
X-MC-Unique: GOSE-9NkO0ij6RRdIcVAMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D602A6408A;
 Thu, 24 Sep 2020 08:30:57 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CF175C1C7;
 Thu, 24 Sep 2020 08:30:50 +0000 (UTC)
Date: Thu, 24 Sep 2020 09:30:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v9 17/20] multi-process: Retrieve PCI info from remote
 process
Message-ID: <20200924083049.GM62770@stefanha-x1.localdomain>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200827181231.22778-18-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200827181231.22778-18-elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UeXZ3FjlYZvuln/G"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UeXZ3FjlYZvuln/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2020 at 11:12:28AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Retrieve PCI configuration info about the remote device and
> configure the Proxy PCI object based on the returned information
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  hw/pci/proxy.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UeXZ3FjlYZvuln/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9sWTkACgkQnKSrs4Gr
c8gNAggAjCb0vvP289i/P2++7nrBfwL3jyiMGn3B6XnamYvfjh0tQmLSfmC5513i
xsc0p5SHo/1ECZh9otVQ1xxgFeMufkFVbvL/ozHghMVKmvR6FeI8RjkzgDw/Zv9t
AZDUWIlpiTQbltVx958BYMQAs1KAi+a66D0Wk2NO1Bl9WoCyyxg9kHSztjanxgyL
RLeu9zMdeJBih2mKeO19CUFVEjmf/kCzvTvsE5YuKKdG4nSIwugjJM1+2gysZr1b
GGmoibnfL/KRiUyE/v5GNjV6I++dokDuKMau7Xz9mYYyXdqvm28PPUjlb2OJLqGt
JsWSnhvQ8q4ErqlCQKgr5fYv3hIqug==
=+rFE
-----END PGP SIGNATURE-----

--UeXZ3FjlYZvuln/G--


