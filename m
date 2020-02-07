Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B9CC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE9120838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8z1Itmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE9120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0AQ9-00085G-S4
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 15:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1j0APE-0007aW-NQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1j0APC-0008S5-7i
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:39:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59118
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1j0APC-0008RP-0k
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581107953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aR5U8e12txbYysWvUNvJu7ZnJWNKZ/eRgJzf/jq+pDM=;
 b=g8z1Itmqdb34ub/HK0MpJqdJGPmnoqWeb0psN+BeULGCYCfJHdR3/5eVt3CrKYvDMJbh5e
 tJ/SRHUeMyy4qCi4OHBdENxgX5RtDmbRY20geD84f+oRjjD2stRn/EQAPs2grNxRLcVDuS
 1eHRwcRD9CVFHdr0mzhRu9hEeqsZkSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-m6AWNNBNPTO3_SOpBpZbqg-1; Fri, 07 Feb 2020 15:39:08 -0500
X-MC-Unique: m6AWNNBNPTO3_SOpBpZbqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A020B19251A3;
 Fri,  7 Feb 2020 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-208.rdu2.redhat.com
 [10.10.123.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5853A84DB4;
 Fri,  7 Feb 2020 20:38:58 +0000 (UTC)
Date: Fri, 7 Feb 2020 15:38:56 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] QEMU Gating CI
Message-ID: <20200207203856.GA17041@localhost.localdomain>
References: <20191202140552.GA5353@localhost.localdomain>
 <CAFEAcA--Rag8JzvPP+Pvkebv1ifeZkpcx7zSXdDBkpZWmpZwxQ@mail.gmail.com>
 <20200203032700.GA12127@localhost.localdomain>
 <CAFEAcA-h3fJaBm+DSn6VQ=sgdS4x67MT_biyeTohk__JzkACMw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-h3fJaBm+DSn6VQ=sgdS4x67MT_biyeTohk__JzkACMw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Jeff Nelson <jen@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 04:42:10PM +0000, Peter Maydell wrote:
>=20
> This all sounds like the right thing and great progress. So yes,
> I agree that the next step would be to get to a point where you
> can give me some instructions on how to say "OK, here's my staging
> branch" and run it through the new test process and look at the
> results.
>

IIUC the point you're describing, we must:

 * Have the rigth jobs defined in .gitlab-ci.yml (there are some
   questions to be answered on that thread)

 * Setup machines with:
   - gitlab-runner (with tags matching OS and arch)
   - packages needed for the actual job execution (compilers, etc)

At this point, the "parallel-buildtest" command[1], would be replaced
with something like:

 - git push git@gitlab.com:qemu-project/qemu.git staging:staging

Which would automatically generate a pipeline.  Checking the results can
be done with programmatically using the GitLab APIs[2].

Once the result is validated, you would run "git push publish-upstream
staging:master" as usual (as instructed by the script)[3].

So this leaves us with the "musts" above, and also with creating a
command line tool that uses the GitLab APIs to check on the status of
the pipeline associated with the staging branch.

> thanks
> -- PMM
>=20

Thanks for the feedback, and please please let me know if I got your
point.

Cheers,
- Cleber.

[1] - https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/app=
ly-pullreq#n125
[2] - https://docs.gitlab.com/ee/api/pipelines.html#list-project-pipelines
[3] - https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/app=
ly-pullreq#n136


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl49yt0ACgkQZX6NM6Xy
CfPwhA//TKV8iuIg7RjUUz7P6GxGSDSe9SVHb9Oga6784Tr7JTt4nhNsng5kcjCh
rtcGXaOKWu3Kpz7RAMR51PcihAHc4x+FGCOtrQvvBWvp3jxgua5u7FU2i/xZRfnQ
zFQus5wGvzulZKhP1ap62oNlWv7RJsrXtXt4veQfwVkhE+8QYikcgl9EMReKNjsT
9eZZbrEx/R8laJyko88xfesGI7ta6q36Uce3BukH7D/SMQqQr9W5qId69tpGy722
QPqTCQpPbI8QH6GZkt14gIBUqMcFv/Zkx5mi3rauOzO64B2J2pxQoMSNMAhtA8ay
hsOo+jsM+CF6zP+0/xS1D7LFeRPgl5MOwYLVmaFumDKEakxNuYKqZ946EGmtIG4i
wvACc9H2inX1NFgDxyWPsL/6IzJtY0aMufCpcX5HyXFq35svL/QMUIuw2Ge7FhjM
d6lzwDSBePZcd6jShsYIZ1ftgsfyRRvTNyKWSG3GiIMMiMpplzKb/wBSCFK1tYMK
bP5+Wox2CqSuhJQC2DyW7jVjcjvI+D2q4zkXTjrojcLG3dZ4VPP4qcBz9pRfwt1N
LdGoU2iDm6rrACXaK5DUVo9/AqzzbTU67+Q+zj7w74A5olk96wKev9GLGS3CsWSD
QAKy67ZYsTR/PynMsty/WvboVtZiBwbWYoztNwcFQ1e1LUNBeo8=
=i6YA
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--


