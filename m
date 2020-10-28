Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41279C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 12:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7056524726
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 12:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3ZDxT86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7056524726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXkXt-0003KK-Cf
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 08:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXkTx-0000kr-Rw
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 08:23:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXkTs-0006Nr-Rt
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 08:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603887787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0c5jaeqAvJsqOLHk0lDGUfMD/ynsKF4v7cKOINcz95E=;
 b=S3ZDxT86Z+MTlc05dnWRqazOr5JhdlkiftQfQYTnLoIXsSg28d/2UsHM1ZL59CRTxBASHa
 9bbs6kG1t2KAee0hLp/cjheYgCOvaeC+GqMIT2Ma4zP9KVlLoDDRhAgzS/k02hiLosdgSC
 EuoPpWgE6pkt56yEjypjIGx8tos2RJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-MuybuRicNhaN5883EcisdA-1; Wed, 28 Oct 2020 08:23:05 -0400
X-MC-Unique: MuybuRicNhaN5883EcisdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E005640AA;
 Wed, 28 Oct 2020 12:23:04 +0000 (UTC)
Received: from localhost (ovpn-115-29.ams2.redhat.com [10.36.115.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B519C5B4C5;
 Wed, 28 Oct 2020 12:23:03 +0000 (UTC)
Date: Wed, 28 Oct 2020 12:05:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH v3 0/7] iOS and Apple Silicon host support
Message-ID: <20201028120534.GL221115@stefanha-x1.localdomain>
References: <20201028030701.14086-1-j@getutm.app>
MIME-Version: 1.0
In-Reply-To: <20201028030701.14086-1-j@getutm.app>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6CXocAQn8Xbegyxo"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6CXocAQn8Xbegyxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 08:06:54PM -0700, Joelle van Dyne wrote:
> Based-on: 20201026191540.12434-1-j@getutm.app
> ([PATCH RESEND 0/4] Mirror map JIT memory for TCG)
>=20
> These set of changes brings QEMU TCG to iOS devices and future Apple Sili=
con
> devices. They were originally developed last year and have been working i=
n the
> UTM app. Recently, we ported the changes to master, re-wrote a lot of the=
 build
> script changes for meson, and broke up the patches into more distinct uni=
ts.
>=20
> A summary of the changes:
>=20
> * `CONFIG_IOS` defined when building for iOS and iOS specific changes (as=
 well
>   as unsupported code) are gated behind it.
> * A new dependency, libucontext is added since iOS does not have native u=
context
>   and broken support for sigaltstack. libucontext is available as a new o=
ption
>   for coroutine backend.
> * On stock iOS devices, there is a workaround for running JIT code withou=
t
>   any special entitlement. It requires the JIT region to be mirror mapped=
 with
>   one region RW and another one RX. To support this style of JIT, TCG is =
changed
>   to support writing to a different code_ptr. This change is submitted in=
 a
>   different patch set and this one depends on it.
> * For (recent) jailbroken iOS devices as well as upcoming Apple Silicon d=
evices,
>   there are new rules for applications supporting JIT (with the proper
>   entitlement). These rules are implemented as well.

These patches are in pretty good shape. I have posted comments, the main
request is to add a ./MAINTAINERS file entry and to look into continuous
integration support.

Stefan

--6CXocAQn8Xbegyxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZXo4ACgkQnKSrs4Gr
c8h7/QgAhOzqJ/XbcYPXtM4++GUU+mzrdPHDtR+7oJsl8l4hQLSpOSdbwdj8VX8A
1sBDiqfh/V+YX9LsxDZqDfu8+brE2nw78tHeCaF4MV0wQa96cvoKycHqz8+wRNH8
cy0PnjVl24OeOIvNaJttd0Ig70ntWXIwag3RfZNDudOb8lzEoxgKlF9LQyLv345Y
Y0nXHKm1a3hq+M28AdgBwRaJTuUHAVdiU5WngNjbPT7LMoiIWIODEEPQUZqgnnMS
5MWWzXc80fSTYxW5PnllhUdW6IdkYYgHc5fe9jDBqJobKxfMkmtIELXI10/u4hyJ
5MdNSI3ExWzo/zc6PJLm6dblL2pcRQ==
=x2kV
-----END PGP SIGNATURE-----

--6CXocAQn8Xbegyxo--


