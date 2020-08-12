Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7940C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F65206B2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IadV0mHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F65206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5rAp-0008Jb-0h
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 09:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5rAD-0007n5-Dk
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:51:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43495
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5rAA-0006Rh-Rn
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597240289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G4/WsRTlT2/ybWC157mEy/ov91AYCgTRIO1QmIE5kqk=;
 b=IadV0mHzYayJQ7hh92MOitjK9QRumwT5PKUP5CKmgsT4JueGWvNZ/4xBMlXkNY9g89BB5z
 NlxIJkz2G7CXSwvGeA3USYYQhV11AdvmFDDFrMkMahsMUev3jnw+AU+yCOMZ0V4xMIOIV6
 oZyv5+rAWlhDSE38NoxfU2ZTMwBe910=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-BEpKfTiNNYq0SuaUvNPD3A-1; Wed, 12 Aug 2020 09:51:25 -0400
X-MC-Unique: BEpKfTiNNYq0SuaUvNPD3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB37F106B244;
 Wed, 12 Aug 2020 13:51:24 +0000 (UTC)
Received: from localhost (ovpn-114-96.ams2.redhat.com [10.36.114.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6DE560CF9;
 Wed, 12 Aug 2020 13:51:17 +0000 (UTC)
Date: Wed, 12 Aug 2020 14:51:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
Message-ID: <20200812135116.GA112330@stefanha-x1.localdomain>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200810145246.1049-1-yezhenyu2@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 03:52:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, armbru@redhat.com,
 xiexiangyou@huawei.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 10:52:44PM +0800, Zhenyu Ye wrote:
> Before doing qmp actions, we need to lock the qemu_global_mutex,
> so the qmp actions should not take too long time.
>=20
> Unfortunately, some qmp actions need to acquire aio context and
> this may take a long time.  The vm will soft lockup if this time
> is too long.
>=20
> So add a timeout mechanism while doing qmp actions.

aio_context_acquire_timeout() is a workaround for code that blocks the
event loop. Ideally there should be no code that blocks the event loop.

Which cases have you found where the event loop is blocked?

I think they should be investigated and fixed (if possible) before
introducing an API like aio_context_acquire_timeout().

Stefan

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8z89QACgkQnKSrs4Gr
c8ieYQgAubmAb4DoSwkVCoqRWjo/u0np2Iq3OTJVStXx1Q7bYXNr7XQz8pMVPkWR
VdlxhfvLCu7lDyJbseWDkxn5DJJLdLI0A7tkmzh6eaG/jWJ2rG79l3xw/sxGXXnL
Rup3jHCZNDxlTEqzKz1WHWRS8cCn/shk5AI9dkh9BNhH8YuaT5eviJQ3ciqg3sql
VXUDHcQZwFgwMeFO76unAsKb/iMnVpTFkXejMTsjL/vovhyFshe9QCXvsNKnPBc3
Mri5Kd4TW0ZjCHKLj6xYf8NqdXngKmO2dLc/nUGsjQ7rhT1E3W83d9JBJmlXFuBf
mFVbf4LTGGJsU+EmHjYi2LiqEZplGw==
=oaxO
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--


