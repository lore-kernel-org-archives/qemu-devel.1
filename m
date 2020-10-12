Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C620BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC6420797
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8f6+1SB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC6420797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0QD-0007k8-6u
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS05o-0003P1-Uo
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS05m-0000oN-7T
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602517828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tF6uuA9c+EqbEKwqFMvHj4jDO4Rr7905jpEPfQEeWbo=;
 b=Q8f6+1SBRbBRQraaPEWlxsL2eS19TM+lCXXla0GXLKjKuxLHdpA33CkFrGRe/Lz0VXpfoe
 rR1nPZx3vnn+wYco5XB67jX2HVky8Kohf3Je4J7hC6m/vqcJFtmip+5lKUDSvKlgqdXcQX
 uDWWZ38luFrjGm+F7xwEMC9naoe9IMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-Xu-G6s3yOBiU9G3JKnyfew-1; Mon, 12 Oct 2020 11:50:24 -0400
X-MC-Unique: Xu-G6s3yOBiU9G3JKnyfew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52A3EAFD09;
 Mon, 12 Oct 2020 15:50:23 +0000 (UTC)
Received: from localhost (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D362D10013D7;
 Mon, 12 Oct 2020 15:50:22 +0000 (UTC)
Date: Mon, 12 Oct 2020 16:50:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/30] Block patches
Message-ID: <20201012155021.GD145304@stefanha-x1.localdomain>
References: <20201009193529.322822-1-stefanha@redhat.com>
 <CAFEAcA98=xnV0H_RmFqbfCONiOGC070M0-JjvmR_5drtpd1=xQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98=xnV0H_RmFqbfCONiOGC070M0-JjvmR_5drtpd1=xQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Coiby Xu <Coiby.Xu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2020 at 07:32:58PM +0100, Peter Maydell wrote:
> On Fri, 9 Oct 2020 at 20:35, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > The following changes since commit 497d415d76b9f59fcae27f22df1ca2c3fa4d=
f64e:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-2=
0201008-1' into staging (2020-10-08 21:41:20 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> >
> > for you to fetch changes up to e969c7b045c90368bc3a5db3479e70b6f0ecb828=
:
> >
> >   iotests: add commit top->base cases to 274 (2020-10-09 14:32:24 +0100=
)
> >
> > ----------------------------------------------------------------
> > Pull request
> >
> > This pull request includes the vhost-user-blk server by Coiby Xu, the b=
lock
> > coroutine code generator by Vladimir Sementsov-Ogievskiy, nvme block dr=
iver
> > statistics by Philippe Mathieu-Daud=E9, and cleanups/fixes/additions to=
 the
> > vhost-user-blk server by me.
> >
>=20
> Hi; this seems to have a conflict in qemu-nbd.c with something
> that landed in the latest nbd pullreq. Could you fix up and
> resend, please?

Thanks for letting me. I will send a v2.

Stefan

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+Eez0ACgkQnKSrs4Gr
c8hgjAf9E8O+CFy7nepQzhjMw5irqQokPyyPjYFR2xFhEgO4o0rAqJHH5xxuIFv5
HvYc3YSsfE77n2U+aiUYVRRbfaT+79S4ra/nW20g2Id5eyNxbA9UtRcbgbE6Zflq
3PjKWRkZ2Ez8u+PlBI562JRDQN2YFAim+RxsosJIWu7kNZz7zEXK81eglp5Uky8y
xxLws+brCS1QnI3uEcdpKM3kA22JdrNjVAHNq48/YuOAmRrx08hG9+zlil/pJvdb
emjVaK+g2fwxyFpNsfLPxet/CfN8qgo+cBFIxquLAyYmYEvSRxXBBSITzLBBC3QP
oNb6p8J9Si4sdJHgiMLjWJ9YqIt9Aw==
=2VqU
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--


