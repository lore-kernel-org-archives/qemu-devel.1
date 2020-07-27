Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EC120714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzAJep4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EC120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02ZO-0007Oz-DE
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k02Yk-0006sS-1u
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:48:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k02Yi-0001GD-BY
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595854127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OlNpwuBHQ7FrhWkY4tftl0NywQcDVKcwzg7+6ThFeLw=;
 b=PzAJep4DJGfrIHe44RcY3E/qkc/692YXXR6v+p14kce4K7sJL0T+wi7XqF1VXQFzp33Crh
 mECVaC/9Z93T7QCUUo+y26edMRuqYrf2WschV/er0Gb3iFcRqv722WiJa7H25msqV/+2mq
 OzxYbiPf4KPATag4BiqicSdMHsgcHtA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-ntllkeYxOTa86afcCfkwhw-1; Mon, 27 Jul 2020 08:48:44 -0400
X-MC-Unique: ntllkeYxOTa86afcCfkwhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBC438014D7;
 Mon, 27 Jul 2020 12:48:42 +0000 (UTC)
Received: from localhost (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 670955DA6A;
 Mon, 27 Jul 2020 12:48:42 +0000 (UTC)
Date: Mon, 27 Jul 2020 13:48:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 0/7] coroutines: generate wrapper code
Message-ID: <20200727124840.GC386429@stefanha-x1.localdomain>
References: <20200610100336.23451-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200610100336.23451-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2020 at 01:03:29PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> The aim of the series is to reduce code-duplication and writing
> parameters structure-packing by hand around coroutine function wrappers.
>=20
> Benefits:
>  - no code duplication
>  - less indirection

Please add documentation so others know when and how to use this.

I suggest adding a docs/devel/coroutine-wrapper.rst document and adding
a code comment to #define generated_co_wrapper pointing to the
documentation.

Please rename coroutine-wrapper.py to block-coroutine-wrapper.py since
it is specific to the block layer.

Stefan

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ezSgACgkQnKSrs4Gr
c8iUWgf/TFjNoDEmMJV1nA7SCdUZ892ygSkl6ct6DynPpigTOcTzuU9gN4g2l2X5
VW3TfkKvpDQDsYndiZClNpAGXI/FJY5O27r12MStJZwRwTuciXYZiMs/F1ToX2k1
/ydCu/CD+PA+nxcvlpHlAzBX/6cklVWBkV1oWZ21lBvbJ5yMDIo9ZVQ9eTMYQIfb
vCGMdNPAjHpasp+g5sLYhg9qHggoKLVzcwPPiMpesOiwWjn6pjnM0XW3lmgoIAxb
099BQUawKItXGyPEtE/OJAx/SnPpPROVKFYeAaRCXRCjkGvNNy6u+Gi/Ap2uAiYl
b6VTc+Xs7BTPmhOht5EuOQs5AHw1oA==
=kuek
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--


