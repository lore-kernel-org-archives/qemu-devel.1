Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE65C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D262206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiSMLHDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D262206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN7AR-000230-1t
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 00:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN79s-0001bE-GG
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN79q-0000F8-KV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:22:32 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601353349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDGINeFU3Q+7Kz09epGxvjOeaedDndmflFyoAJsK4gs=;
 b=eiSMLHDzoWoa9LK5SOedrwYlF3EJc/z5R1GqGf3jnCuhQ/zAFzDPY3PEtm42yCGaLY9Oja
 jBx8XApvD0N/ZPyGhwdsIXE3GiQ6aa+OpCPB3LPBgzMIRbGmvs4zBAsYjg7Dd9JcvmMdfo
 BULhzNeIv+5yk1Q8SR5UgoK9wMgu5Zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-A4bmu44VOCiHNlo4Ofd1Lw-1; Tue, 29 Sep 2020 00:22:26 -0400
X-MC-Unique: A4bmu44VOCiHNlo4Ofd1Lw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9148E1005E61
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:22:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AC4F5C1BD;
 Tue, 29 Sep 2020 04:22:25 +0000 (UTC)
Date: Tue, 29 Sep 2020 00:22:23 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 31/47] qapi/gen.py: Fix edge-case of _is_user_module
Message-ID: <20200929042223.GM700868@localhost.localdomain>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-32-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925002900.465855-32-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RNRUMt0ZF5Yaq/Aq"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 23:30:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--RNRUMt0ZF5Yaq/Aq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:28:44PM -0400, John Snow wrote:
> The edge case is that if the name is '', this expression returns a
> string instead of a bool, which violates our declared type.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--RNRUMt0ZF5Yaq/Aq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9ytn8ACgkQZX6NM6Xy
CfOvLA//WXBkR/bcUw+nOAM3RceRTpMlAwcJAasxQwNKj5tO7U/6Pu75cK3+FSPz
AkrLCbjrgFiq+RIrcIH7iMgN1j+JWWeQ9EICf2YcMhSwRUBTwjRrUrcuePIRq0sZ
FV+Obyv9YFWWpJeuu12fz7q2ofPdDkKGuEOMiqeX2MkQucMf9ICtVZqsz1EIv5w8
x6H6l6diLXSgVmd01BCw2tsreYJmsAkz/T/zzAuVm0ppXlG753nsstRKeEgEdaka
EdW8+neo3SBNC/uBRLaThy/hJgNz3dXnz+hcw9pgzxhCrX7UE3cu55GpLqJ3DG8M
xTrdH8vlI4Y2BhMmgpGqtweN9scWdBNrWwbNIxsCjiDnJtiuNo2y2tnX44xQSK3H
8xq6+SwwZJxHOHofkrS3zxU3GeYViOaAUJofq6609Rb4Auqx004Qu2EfCs/Dt56z
VAEuJAUuLUbEIOtcawRDUhxcWYDGtiJFsuaew+nSXbR0CzcoT9n49upl/71lqYzf
gsPT8nLJi0uLe5FOOzHGTrXoVZQnui1vvTQsKvwCqNH/03ZJySDwZHiqB/p9gwB+
5V9f60Q/JQX6xo7KI56upvfyYVYzJRs1/9sKSb0msnrs+HrNCjkgOr8hTmk+12xD
2DJKXZKW5BxW/ANkjjelW+HFZcOZE7Y0nsT+kXqiYgZG/7GyusY=
=J+Qm
-----END PGP SIGNATURE-----

--RNRUMt0ZF5Yaq/Aq--


