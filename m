Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72163C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467C62070B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467C62070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49319 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcLt-0007ta-EL
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:17:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYcI5-0005Ho-UO
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYcI3-00026p-Je
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hYcI3-00023i-Bh
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:13:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F4C481DE0;
	Wed,  5 Jun 2019 20:13:42 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8DD3B19C6F;
	Wed,  5 Jun 2019 20:13:37 +0000 (UTC)
Date: Wed, 5 Jun 2019 17:13:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190605201335.GD22416@habkost.net>
References: <20190531192429.GH22103@habkost.net>
	<93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com>
	<871s0asvli.fsf@dusky.pond.sub.org>
	<20190605155006.GI8956@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190605155006.GI8956@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 05 Jun 2019 20:13:42 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 04:50:06PM +0100, Daniel P. Berrang=E9 wrote:
> On Mon, Jun 03, 2019 at 02:26:49PM +0200, Markus Armbruster wrote:
> > John Snow <jsnow@redhat.com> writes:
> >=20
> > > On 5/31/19 3:24 PM, Eduardo Habkost wrote:
> > >> Long story short: I would really like to drop support for Python
> > >> 2 in QEMU 4.1.
> >=20
> > The sooner, the better, as far as I'm concerned.
> >=20
> > >> What exactly prevents us from doing this?  Does our deprecation
> > >> policy really apply to build dependencies?
> > >>=20
> > >
> > > Normally I'd say it's only nice to also follow the depreciation pol=
icy
> > > for tooling as well to give people a chance to switch away, but wit=
h
> > > regards to Python2, I feel like we're in the clear to drop it for t=
he
> > > first release that will happen after the Python2 doomsday clock.
> > >
> > > (So, probably 4.2.)
> >=20
> > In addition to our feature deprecation policity, we have a "Supported
> > build platforms" policy (commit 45b47130f4b).  The most common holdba=
ck
> > is this one:
> >=20
> >     For distributions with long-lifetime releases, the project will a=
im
> >     to support the most recent major version at all times. Support fo=
r
> >     the previous major version will be dropped 2 years after the new
> >     major version is released. For the purposes of identifying suppor=
ted
> >     software versions, the project will look at RHEL, Debian, Ubuntu
> >     LTS, and SLES distros. Other long-lifetime distros will be assume=
d
> >     to ship similar software versions.
> >=20
> > RHEL-7 has Python 3 only in EPEL.  RHEL-8 came out last month.  Unles=
s
> > we interpret our policy to include EPEL, this means supporting Python=
 2
> > for some 16 months after upstream Python retires it.  My personal
> > opinion: nuts.
>=20
> We've not said whether this refers to only base repos, or whether addon
> repos are accepted. IMHO, we are reasonably justified in saying RHEL-7
> as a build platform covers any repo provided by Red Hat, which would
> give us Python3 via software collections. I think it would be reasonabl=
e
> to also state it covers EPEL, since EPEL is such a commonly used repo
> with RHEL.
>=20
> IOW, I don't think RHEL-7 support as a build platform blocks us from
> dropping py2. We merely need to tweak our build platforms doc to clarif=
y
> our intent wrt add-on yum repos.

If we clarify the docs in QEMU 4.1, is there anything that
prevents us from removing Python 2 support in QEMU 4.1 too?

--=20
Eduardo

