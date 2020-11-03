Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECADC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B33C206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHOLCb+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B33C206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZz8n-0006AZ-DB
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZz86-0005VY-F2
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:25:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZz83-0003XB-QB
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604420749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZftfgeli89fv1UY2Os3UlP93CZApisIiGVl/9KuOu8=;
 b=HHOLCb+S/i1e3Q8OQCZgIGk5cOQCIFU9Klg8lZj/WM54jrXX+M9QCHTcrmSIgAIfh79Fwv
 viAo4qZSakYCYjOjTPQlXn4B+9HZKhJ7TPerbJA157i4W0622Xccu0mhsnLU9G01YP02aR
 8ZihlC2G6gGFLp3X/Dz+l8gaufsiYbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-0SLp213hOQGwBWn8vc3Z7g-1; Tue, 03 Nov 2020 11:25:46 -0500
X-MC-Unique: 0SLp213hOQGwBWn8vc3Z7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C03C80476D
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 16:25:40 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0576B1002382;
 Tue,  3 Nov 2020 16:25:39 +0000 (UTC)
Date: Tue, 3 Nov 2020 16:25:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] trace: remove argument from trace_init_file
Message-ID: <20201103162538.GD253848@stefanha-x1.localdomain>
References: <20201102115841.4017692-1-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201102115841.4017692-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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

--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 06:58:41AM -0500, Paolo Bonzini wrote:
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

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+hhIIACgkQnKSrs4Gr
c8iuCwgAx8U9Vix8MFSULmUpm8fGX2rELO5zEZnEQkEywJopZtygzf2S0QN4NVN5
4G2LR/CYXhCJV4KKt6G3fCNIHRJW1fZSUN8yqb3PKTyjpRcjzFvcyIHAiT5UNniO
r5gZZMCOoy5XQmzzKWRjnqaDU+w3aNK/+d5e+c1hv5b9O7dur2okeRYRmNpDeLbG
OoC4Rh2jVU3gebEo32TK8aayOArwWlRcBGIAitFxtdQGuyHyOi7TcTnQTZNgBpjw
rnpY53nUKpXeETQfLLLTT6lB8EoyU9S1UVwi+uRyqMqG+qxutzllb59Abon1Lt2u
vS8/u4MKsr5GntS+4z4EFyc8TzoqUA==
=mOhN
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--


