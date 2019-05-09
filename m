Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DC1C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4762089E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4762089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54431 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOiwh-0007Pw-HT
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:18:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOivd-00074n-BW
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOivb-0006am-Td
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:17:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOivb-0006Z6-NW
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:17:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1939753F5;
	Thu,  9 May 2019 13:17:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2273560CBB;
	Thu,  9 May 2019 13:17:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 1774BA1E0; Thu,  9 May 2019 15:17:30 +0200 (CEST)
Date: Thu, 9 May 2019 15:17:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190509131730.kkcjc654h4otbf6z@sirius.home.kraxel.org>
References: <20190508085645.11595-1-kraxel@redhat.com>
	<20190508085645.11595-14-kraxel@redhat.com>
	<99dc6f33-851c-cc01-89b9-44c68f07c199@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <99dc6f33-851c-cc01-89b9-44c68f07c199@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 09 May 2019 13:17:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 13/13] tests/vm: ubuntu.i386: apt proxy
 setup
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 02:12:11PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 5/8/19 10:56 AM, Gerd Hoffmann wrote:
> > Configure apt proxy so package downloads
> > can be cached and can pass firewalls.
>=20
> Yay \o/
>=20
> >=20
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  tests/vm/ubuntu.i386 | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> > index a22d137e76df..b869afd212fa 100755
> > --- a/tests/vm/ubuntu.i386
> > +++ b/tests/vm/ubuntu.i386
> > @@ -51,6 +51,10 @@ class UbuntuX86VM(basevm.BaseVM):
> >                            "    ssh-authorized-keys:\n",
> >                            "    - %s\n" % basevm.SSH_PUB_KEY,
> >                            "locale: en_US.UTF-8\n"])
> > +        proxy =3D os.environ.get("http_proxy")
>=20
> Some users only use 'https_proxy' (or FTP):
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08413.html

Well, this configures apt only, and the apt repos are configured
to use http.  So for package installs we are all set.

We might additionally setup AcceptEnv in sshd_config (i.e. basically do
the same thing console_sshd_config() in basevm.py does for serial
console installs) so proxy evironment pass-through works for ubuntu ssh
logins too.  I didn't see a strong need for that with package downloads
being covered already, so I didn't try ...

cheers,
  Gerd


