Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5638C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4395246CC
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRNzuAiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4395246CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXk3Y-0002SO-En
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 07:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXk2K-0001wn-00
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXk1m-0004Y6-VM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603886045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTgWFmORlOKpMHDq/NfOFss1wKARobNkogp5hotR+mk=;
 b=BRNzuAiRh0MPvVn7TF3toi83LKanJcaUfVWL1wegEVINUaDicWBU0mGzffO7oiLlnszZKQ
 pJSxyooNTA8ABWMnh6ROywK9Dnd1jXVZUqXY1pMS/9evLEAjJGwR20r71Z8DN2w0iDGHOg
 aVPX2wjQrBI0NzLfflRSTD/Ss8CIchw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-dd3VPb30MgiY42eg1VtxeA-1; Wed, 28 Oct 2020 07:54:01 -0400
X-MC-Unique: dd3VPb30MgiY42eg1VtxeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 878FD801F95;
 Wed, 28 Oct 2020 11:54:00 +0000 (UTC)
Received: from localhost (ovpn-113-87.ams2.redhat.com [10.36.113.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20C7560FC2;
 Wed, 28 Oct 2020 11:53:59 +0000 (UTC)
Date: Wed, 28 Oct 2020 11:53:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH v3 6/7] tcg: implement JIT for iOS and Apple Silicon
Message-ID: <20201028115358.GJ221115@stefanha-x1.localdomain>
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-7-j@getutm.app>
MIME-Version: 1.0
In-Reply-To: <20201028030701.14086-7-j@getutm.app>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+Hr//EUsa8//ouuB"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+Hr//EUsa8//ouuB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 08:07:00PM -0700, Joelle van Dyne wrote:
> On iOS, we cannot allocate RWX pages without special entitlements. As a
> workaround, we can allocate a RX region and then mirror map it to a separ=
ate
> RX region. Then we can write to one region and execute from the other one=
.

"separate RW region"? The sentence doesn't seem to make sense if both
regions are RX.

>=20
> When entitlements are available (macOS or jailbroken iOS), a hardware
> feature called APRR exists on newer Apple Silicon that can cheaply mark J=
IT
> pages as either RX or RW. Reverse engineered functions from
> libsystem_pthread.dylib are implemented to handle this.

What does "Reverse engineered functions" mean? We cannot accept code
into QEMU that is a potential liability if Apple could claim it has been
copied, derived, etc without permission. If libsystem_pthread.dylib is
open source, especially under a permissive license, then it's probably
okay.

Can you clarify?

--+Hr//EUsa8//ouuB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZW9YACgkQnKSrs4Gr
c8g0QQf+McjominYiFOzB1gvUcWtWOEMcpKQF8N0Qxb8wlElmwUNDLOs746w8EfH
UvdqKBrL1nW8+uMQy0xgc+J8xL3DQ9rR6adLPx1uNHQIQuxpLLJyFt5vnvrDNU2b
8DSVcu0aFYGAfVUOKCUzlzVawXz9Q4DaxW8D5dV40u+YlLnoQUaA+fY03uiEbmTf
hL1tMzQYbtLbJk8aZVkFM5jHB10vgsuDCq5G3LzVNB6fNYMmdRXa8jzd3ftgUkMN
nfwWUvYKWh3Wh7vT6vldYgfE8UP7nNov2zlxvEUrIsRrFRpR+rP2azhFxPQCmWBK
ZoWjaHYQH25Jz1VfH5qNI+xB5+JOMQ==
=fO3f
-----END PGP SIGNATURE-----

--+Hr//EUsa8//ouuB--


