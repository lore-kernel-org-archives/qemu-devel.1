Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE45FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9947E20838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDzht5xY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9947E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wRX-0007D6-Ob
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5wQc-0005Xr-AS
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 15:28:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22922
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5wQZ-00019c-5C
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 15:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597260525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zdwUfeOgBNQxPcGO3QBxYzTdUnQTfX8XEc6Xh/qiWXc=;
 b=DDzht5xYknhkWgEPqH3gmW/AKkxzd7Gey3U2s/3O2z4/P489t7c+moiwUamp2lmEtQKp0c
 dfAxfd/z6S7y2LQp/Mmi/hkYfGJwLrivr1C4X2v25QOQz2Bwbc8gvpQxb5UPwWd8FQ4bTc
 VPUc/ZI/la/J0FtBywjYl+sCwbZbxpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-XMRWQpTDPje7J4sdDH4_jw-1; Wed, 12 Aug 2020 15:28:41 -0400
X-MC-Unique: XMRWQpTDPje7J4sdDH4_jw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DFC41005504;
 Wed, 12 Aug 2020 19:28:40 +0000 (UTC)
Received: from localhost (ovpn-114-96.ams2.redhat.com [10.36.114.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA1F25D9E8;
 Wed, 12 Aug 2020 19:28:33 +0000 (UTC)
Date: Wed, 12 Aug 2020 20:28:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] softmmu: Add missing trace-events file
Message-ID: <20200812192832.GD112330@stefanha-x1.localdomain>
References: <20200805130221.24487-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805130221.24487-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:50:17
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 03:02:20PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Commit c7f419f584 moved softmmu-only files out of the root
> directory, but forgot to move the trace events, which should
> no longer be generated to "trace-root.h". Fix that by adding
> softmmu/trace-events.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  Makefile.objs        |  1 +
>  softmmu/balloon.c    |  2 +-
>  softmmu/ioport.c     |  2 +-
>  softmmu/memory.c     |  2 +-
>  softmmu/vl.c         |  2 +-
>  softmmu/trace-events | 28 ++++++++++++++++++++++++++++
>  trace-events         | 27 ---------------------------
>  7 files changed, 33 insertions(+), 31 deletions(-)
>  create mode 100644 softmmu/trace-events

Thanks, applied to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl80QuAACgkQnKSrs4Gr
c8hlpQf/cBhwYE9HJ6pPoctfxuBoZRow50VziSg5JAs7Zf1/V9oKVujGa/XIeoAj
6aDm/u1485SzDDow04vzxQgBRIfvafMPP7Ifu1TYSAAT28DmvaAypCEeqORL9dYN
Fe37HFglNT49frRE3DxIthehKH/6vpY14oyWTHJNmCHhPTs5KjUsrq8Mlqdihogu
s8y3iW+iL4VA67Lgjvpt4DgiAN+vmPAfseuVVdAf+i/nI1uwnlGzbUfdRDTa+So1
t0oE6NlTtmRiiF0JSEzVeLNnXkZcICRae2lNZRWPwIx7dv42pir4E0Ga/+bHJwdp
qBkiG6pDm0g2Rks8ODdRBk3cL7eVRg==
=TZPY
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--


