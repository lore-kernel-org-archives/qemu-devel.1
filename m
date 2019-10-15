Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41A0ECE58E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD292089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD292089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKIV4-0007mN-G9
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 04:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iKISs-00062f-E8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iKISr-0000Nc-Cr
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:45:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iKISp-0000Mh-5C; Tue, 15 Oct 2019 04:45:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 283087FDCD;
 Tue, 15 Oct 2019 08:45:54 +0000 (UTC)
Received: from localhost (ovpn-116-252.ams2.redhat.com [10.36.116.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8D8E1048128;
 Tue, 15 Oct 2019 08:45:51 +0000 (UTC)
Date: Tue, 15 Oct 2019 09:45:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PULL 1/2] trace: add --group=all to tracing.txt
Message-ID: <20191015084550.GA16745@stefanha-x1.localdomain>
References: <20191014085709.26812-1-stefanha@redhat.com>
 <20191014085709.26812-2-stefanha@redhat.com>
 <b1cbc282-7ad2-e542-c573-3f5e115b5ab5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <b1cbc282-7ad2-e542-c573-3f5e115b5ab5@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 15 Oct 2019 08:45:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2019 at 11:08:25AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Stefan,
>=20
> On 10/14/19 10:57 AM, Stefan Hajnoczi wrote:
> > tracetool needs to know the group name ("all", "root", or a specific
> > subdirectory).  Also remove the stdin redirection because tracetool.py
> > needs the path to the trace-events file.  Update the documentation.
> >=20
> > Fixes: 2098c56a9bc5901e145fa5d4759f075808811685
> >         ("trace: move setting of group name into Makefiles")
> > Launchpad: https://bugs.launchpad.net/bugs/1844814
>=20
> Sorry I didn't noticed that earlier, but on https://wiki.qemu.org/Contrib=
ute/SubmitAPatch#Write_a_meaningful_commit_message
> we recommend using the 'Buglink' tag.
> Not sure it's worth resending another pull request...

Sure, it hasn't been merged yet so I can send a v2.

Stefan

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2lhz0ACgkQnKSrs4Gr
c8guxwf+LJgYtK8SN1UnLoEu7waEuV18LKp9Hv0JOGCjHXL0RKa0wjwAOAM44U51
8OjkuVqsxJ5BzeM+9XG2m1HI0Wjxzfh+qOmiZbAov1NpdbHaIkpCl4cBWJ38S0HV
76kTU92hJEQDTL8GTAsk8XHlFT8TATBMmhnAZtJ5oQeKFlbNU2OUHDjMJgS3bMUK
vLc1yvDUmPnoZ8DpxvjQDsyzmVvbTh4M7NL2xdWXmEN+l6h6HIvPUYZGkb/d38Q1
1esJCgdWDRLdxm7Pefip1SJx0ZSDxIhZanXvCQdQw2jJCbI4C+FuVvZh+U0ZtaRD
QamOdo7J1+7fwXhdpJlMFPhDY74+zw==
=H/tZ
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

