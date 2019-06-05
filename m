Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F9DC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 18:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D5E20866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 18:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D5E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48073 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYaQQ-0007xO-GL
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 14:14:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYaPV-0007ao-RL
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYaPS-0007Xf-E6
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:13:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hYaPR-0007Oc-8U
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:13:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A7C73082141;
	Wed,  5 Jun 2019 18:13:11 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C76E1017E30;
	Wed,  5 Jun 2019 18:13:09 +0000 (UTC)
Date: Wed, 5 Jun 2019 15:13:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190605181308.GX22416@habkost.net>
References: <20190531192429.GH22103@habkost.net>
	<20190605154403.GH8956@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190605154403.GH8956@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 05 Jun 2019 18:13:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Deprecation policy and build dependencies
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 04:44:03PM +0100, Daniel P. Berrang=E9 wrote:
[...]
> Thus to answer your python 2 question, we should ask which of our build
> targets cannot support python 3 ?
>=20
> Obviously we know the answer to that is RHEL-7. Except there is some
> fuzziness in there because it depends on what you define "RHEL-7" to
> be. There are several possible answers
>=20
>  a. RHEL-7 covers only the stuff in the basic yum repos
>  b. RHEL-7 covers packages in any yum repos shipped by Red Hat
>  c. RHEL-7 covers packages in any yum repos shipped by Red Hat or EPEL
>  d. RHEL-7 covers packages in any yum repo available for use
>     with RHEL-7,  provided by any vendor
>=20
> The platform support policy has not documented which of these possiblit=
ies
> we're targetting.
>=20
> If we consider it to mean (a), then there's no way to use py3 with RHEL=
-7.
>=20
> With (b), (c), or (d) it is possible to get py3 available on RHEL-7 by
> enabling suitable repos.
>=20
> Personally I think it would be fine for use to consider (b) or (c) to b=
e
> our intended interpretation for platform support policy.

(c) sounds like the best option, to me.  Do we have any
reason to prefer (b) instead of (c)?

>=20
> In this interpretation it is possible for developers to get Python 3 on
> RHEL-7 by enabling the Red Hat Software collection repos:
>=20
>   https://developers.redhat.com/products/softwarecollections/hello-worl=
d/#fndtn-windows
>=20
> This implies we *can* drop python2 from QEMU *and* keep RHEL-7 as a
> supported target.
>=20
> Also note that the platform support policy didn't say anything about
> RHEL minor updates. ie it does not distinguish RHEL-7.0 from RHEL-7.6,
> despite fact that some packages get major version rebases. I think we
> should clarify that we mean "latest available updates" for our supporte=
d
> platforms. ie 7.6 is supported, 7.0 is *not* supported.

Agreed.

--=20
Eduardo

