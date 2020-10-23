Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E397EC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4041720FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYTBoqJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4041720FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVxNE-0008Il-8K
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVxL6-0006cX-FY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVxL4-00049O-LF
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603460558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sq0B16YKFx3uaqcT4qNPZlKGu85eJDGwd1foV2dBtrQ=;
 b=iYTBoqJmJGmkIO2EHgWCJsPRf4Pj2BCuVsQRxqRAF5+frrJzusg2p8WwuVGqzXjkdmQxhd
 r2FioRBQazFsKqbxkCR/U8ucSBZqVQi0Io/EsAfPiwhaRg0iY5STGM30LDQ2ur2x/1pP/K
 y/WiWByBruDizhH/RewLzXyId8RZuLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-GmhwO4dyMdO6wr6aB-tZaA-1; Fri, 23 Oct 2020 09:42:32 -0400
X-MC-Unique: GmhwO4dyMdO6wr6aB-tZaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F04192864F;
 Fri, 23 Oct 2020 13:42:21 +0000 (UTC)
Received: from localhost (ovpn-114-178.ams2.redhat.com [10.36.114.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97A061002D4B;
 Fri, 23 Oct 2020 13:41:56 +0000 (UTC)
Date: Fri, 23 Oct 2020 14:41:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] Using gitlab for upstream qemu repo?
Message-ID: <20201023134155.GB812157@stefanha-x1.localdomain>
References: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2020 at 06:47:55PM +0200, Paolo Bonzini wrote:
> Hi all,
>=20
> now that Gitlab is the primary CI infrastructure for QEMU, and that all
> QEMU git repositories (including mirrors) are available on Gitlab, I
> would like to propose that committers use Gitlab when merging commits to
> QEMU repositories.
>=20
> There are four reasons for this:
>=20
> - this would be a step towards ensuring that all commits go through the
> CI process, and it would also provide a way to run the deployment of the
> web site via .gitlab-ci.yml.
>=20
> - right now Gitlab pulls from upstream repos and qemu.org pulls from
> gitlab, but this is not true for the qemu, qemu-web and openbios
> repositories where Gitlab pulls from qemu.org and qemu.org is the main
> repository.  With this switch, all the main repositories would be on
> Gitlab and then mirrored to both qemu.org and GitHub.  Having a
> homogeneous configuration makes it easier to document what's going on.
>=20
> - it would limit the number of people with access to qemu.org, since
> committers would no longer need an account on the machine.
>=20
> - by treating gitlab as authoritative, we could include it in the
> .gitmodules file and remove load on the qemu.org server
>=20
> Nothing would change for developers, who would still have access to all
> three sets of repositories (git.qemu.org, gitlab.com and github.com).
> Committers however would need to have an account on the
> https://gitlab.com/qemu-project organization with access to the
> repositories they care about.  They would also lose write access to
> /srv/git on qemu.org.
>=20
> Of course this is just starting a discussion, so I'm not even proposing
> a date for the switch.

Thanks, this sounds good. It will simplify qemu.org administration.

Stefan

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+S3aMACgkQnKSrs4Gr
c8hsgggAjYSAfuym1VOzjXP+ig/bTkxmgd0tBGtldN9yEQ7lwnmshrG3WfsTZBRE
90DOjeP6OUFpffOTpGpNC18toXlOt/OncS9pb0hRupbdkSHxfl9hsMyYL7x9Suao
wTMVtkaD9gIHeJbCv5d8eKCnHuKKM8jdLtnUbWI3vn8upj0evZMc+x1wWzzEWafx
kn1n732kz4pbPEbwOksM6P5DNYee9nZwYUnoR6znhoDfO1heq0FFU+1o8xDIJH7Y
bXJ0UJkVtBGMgvg+wZnukZV8giBSgpOf+l5PK3ktDWEqxMmwKzI0djIG/k40Pooe
er4JhWvPHnbdcsruQ8mlZiLmzIfl0Q==
=PHnH
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--


