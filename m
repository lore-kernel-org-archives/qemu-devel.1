Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2B4C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607F1247D7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bL0OSNMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607F1247D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnlS-0006A0-BP
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXngj-0001cC-Ok
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXnge-0002Bb-Ta
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603900111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jzy689zMdd2C+OT8M849KhwktNYl1LEUErX2JU9wJgk=;
 b=bL0OSNMS4Aj1jp3nN0dH+pgl709zcwWyAa/GyqK3Qt5Va0z6SomdPf+LdGSk0NGW5cNLT9
 JRKiHsoegBDGPuXNa/wNHtEZZGj7KfpNWpC583N8idDswgMx/8RDlWanvSv0ZTZiLMhA1x
 Dxc5TY4qv93KMR+hxAm4uWsTN/BkePo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-50Me8IQwNFi3h5KbKAgZbw-1; Wed, 28 Oct 2020 11:48:26 -0400
X-MC-Unique: 50Me8IQwNFi3h5KbKAgZbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42EC61084C94;
 Wed, 28 Oct 2020 15:48:25 +0000 (UTC)
Received: from localhost (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C30B5DA33;
 Wed, 28 Oct 2020 15:48:21 +0000 (UTC)
Date: Wed, 28 Oct 2020 15:48:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 06/25] block/nvme: Improve nvme_free_req_queue_wait()
 trace information
Message-ID: <20201028154820.GW231368@stefanha-x1.localdomain>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-7-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-7-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XQSDX3NWE02rtiZq"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--XQSDX3NWE02rtiZq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 02:55:28PM +0100, Philippe Mathieu-Daud=E9 wrote:
> What we want to trace is the block driver state and the queue index.
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c       | 2 +-
>  block/trace-events | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XQSDX3NWE02rtiZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZksQACgkQnKSrs4Gr
c8j4ZAgAinXhlHvtcn/IUnvcBOvJ233KAtBoeiAMOUKhbD0bSQ0LITryTY39TomO
qUTOuYrOsTTlDEAVq2mzVIIwLHA90R7YMKw9xIP2rD8YXhS/f4iI8bqNktXabO0U
VLpiA/nOJChxyQ76G0B4SUZdsxykZUs+172WMzed9+UvXI6C0t+nKAcxMfZowvJC
A3dqUDfyxPQkkAXsjT3quxHWNneVmoLtlfL+3jBQxLjq0dfjCF4NkauuwInbnXUQ
GYtit8sJD9sqVd74MLsnfyMJCVYspy4a4V+1a6ly1ocoZWfJwXLoGqwLkYNQTlEA
JHPcp1wl9TVxsvG9SpUP2e8Tv0LzFA==
=3kZD
-----END PGP SIGNATURE-----

--XQSDX3NWE02rtiZq--


