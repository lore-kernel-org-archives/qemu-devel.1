Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE0C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A249521527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSEq+FHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A249521527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVxLI-0006dk-Ie
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVxK9-0005LI-Ay
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVxK7-00043f-8b
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603460497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ih0+E/CL8EuV4vGTKRBpCl3T+F4ucIndPKkaeQE7GI0=;
 b=aSEq+FHuQoedleWfp0TEEhhCKg7ffT2vZwszjgCAXxV5wa63S6Oz/c3rmbrjrW/QXu9bPJ
 3dBrTOm4Dec0HtLv08OJVRckB5rNfQ1m0XKmNvuM+9xkIs0TUElcQZ+CV2vTz+Dc8gEW77
 1zYbhEH7zWzuRPFBzN+5HK+koWS03Mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-fQF1T6tyPq-8mjsXRi8XtQ-1; Fri, 23 Oct 2020 09:41:33 -0400
X-MC-Unique: fQF1T6tyPq-8mjsXRi8XtQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B275119080A6;
 Fri, 23 Oct 2020 13:41:14 +0000 (UTC)
Received: from localhost (ovpn-114-178.ams2.redhat.com [10.36.114.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E4206EF42;
 Fri, 23 Oct 2020 13:41:14 +0000 (UTC)
Date: Fri, 23 Oct 2020 14:41:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC] Using gitlab for upstream qemu repo?
Message-ID: <20201023134113.GA812157@stefanha-x1.localdomain>
References: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
 <9f6c63c6-599b-ac15-42e2-b9c1991fc7ee@redhat.com>
 <20201023085131.GC445638@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201023085131.GC445638@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 09:51:31AM +0100, Daniel P. Berrang=E9 wrote:
> Not commonly known is that GitLab also has support for Git push options,
> which let you create merge requests using a plain "git push":
>=20
>   https://docs.gitlab.com/ee/user/project/push_options.html
>=20
> eg if you have a remote called "gitlab", you can open a MR from the CLI
> using
>=20
>  $ git push -o merge_request.create \
>             -o merge_request.title=3D"Do awesome thing" \
>             gitlab my-branch
>=20
> This is something that I could see being easily wired up into a
> "git-publish" like tool for example.

Nice, thanks for mentioning this GitLab feature.

Stefan

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+S3XgACgkQnKSrs4Gr
c8giYAf+PwdpgEiSHg3ArhN0wmQmxMEWXOfM5LXR5EBRdmb9uwYyfMDPx6E2oyPG
XAn2o9xR1M1jLlpd9nVhBhh4CvbTLUp7zaESDB0RPTDIzSaF59ba9iQKsds9sw3I
ov9E2xhCFSot+CMT56wKYLmjkeDo1JaUr51FZNCxJGXIjpChBAzHAwLUZVI0tr8+
D6VvrssFwQBmqjS86O9zsLo0hTSnMsxF43ZKWVRIkjoNHr+7/qK0O0zAA2007K5/
H6ZaHKL6tUlCPlwO60gJLC94wgvMJvZjdg/zDpaG9jYUuzSN5tnIjPalk/5g6C5H
f2Dq/uZYlDuN6dJt4SA6vj4Fa6cfBg==
=4aot
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--


