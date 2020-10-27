Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D4CC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2C322284
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSgRmuqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2C322284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNz0-000202-8w
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXN4I-00044l-HH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXN4G-0005Cj-AQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603797787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KuHtg5DPV7fM/u8ITYa4IOEd+hP5MPv/+F+SuJZ8V5I=;
 b=WSgRmuqz+4vC3yVGY4oRogo+EsqZuWqKBGUDADpmiP1ZnMJhiU6yIjCuEla/MecRPFylW7
 8iOF1FRN/CTiTyR2HVSMucU8jupBx/1M2rWZL6+H1avKANrZajfxGQ+gfX5McncT6oFt7D
 E0IIhZFx4Gg/OzFZIb2L3nJlQjyCo20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-zhw_Slz_Muqy69NxyAb7IA-1; Tue, 27 Oct 2020 07:23:04 -0400
X-MC-Unique: zhw_Slz_Muqy69NxyAb7IA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFA121019626
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 11:23:03 +0000 (UTC)
Received: from localhost (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6939B6115F;
 Tue, 27 Oct 2020 11:23:03 +0000 (UTC)
Date: Tue, 27 Oct 2020 11:23:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] trace: remove argument from trace_init_file
Message-ID: <20201027112302.GG79063@stefanha-x1.localdomain>
References: <20201026144019.3044362-1-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026144019.3044362-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RDS4xtyBfx+7DiaI"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 10:40:19AM -0400, Paolo Bonzini wrote:
> It is not needed, all the callers are just saving what was
> retrieved from -trace and trace_init_file can retrieve it
> on its own.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  bsd-user/main.c                      |  6 ++----
>  linux-user/main.c                    |  6 ++----
>  qemu-img.c                           |  6 ++----
>  qemu-io.c                            |  6 ++----
>  qemu-nbd.c                           |  6 ++----
>  scsi/qemu-pr-helper.c                |  6 ++----
>  softmmu/vl.c                         |  6 ++----
>  storage-daemon/qemu-storage-daemon.c |  9 +++------
>  trace/control.c                      | 10 ++++------
>  trace/control.h                      | 12 +++---------
>  10 files changed, 24 insertions(+), 49 deletions(-)

Thanks, applied to my tracing-next tree:
https://gitlab.com/stefanha/qemu/commits/tracing-next

Stefan

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+YAxYACgkQnKSrs4Gr
c8jv7QgAg6MYI6nTG/obnoOi6y6aDmOUAeN3j7jB7mW1h3zvaSW2DHtWnhCUDpf0
c1d4s9VfdBGQoQ49pNpetGwcl0YeCb4Xaz4MVoFFIqcSQuoKXwNDV5ZV+A/eBl8C
z9UgDox34Kjv3duZb1GOUJl6Y0vjyD03/A26W8LzluSCOG2P+IDyw3XAAQLgiTqb
fR98IUXt8dkkZ/CO3BdR1OMv/vSeFi/9tQXtzdsFddc0aACMlY4YZyGn2Wu991nr
e25s9eE93R3WTKnnvWWK2XWCwi7lqf5NCQmNJ6C7tFJNXra/owIRVdBsmSRugkFO
DAGpXBYcBl0vXRjGwdyVGVbWCE+39g==
=+H+0
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--


