Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF103C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAD5216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAD5216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41156 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQq9-0000Mp-Sy
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:58:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOQp3-0008JT-Rz
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOQp2-0005Jb-Pq
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:57:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hOQp2-0005JG-IM
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:57:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D78F301EA93;
	Wed,  8 May 2019 17:57:39 +0000 (UTC)
Received: from localhost (ovpn-116-61.gru2.redhat.com [10.97.116.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D26A627D8;
	Wed,  8 May 2019 17:57:36 +0000 (UTC)
Date: Wed, 8 May 2019 14:57:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190508175734.GB4189@habkost.net>
References: <20190503193721.18459-1-ehabkost@redhat.com>
	<20190507103814.GF5808@localhost.localdomain>
	<20190507104754.GL27205@redhat.com>
	<87tve52jrb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87tve52jrb.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 08 May 2019 17:57:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Deprecate Python 2 support
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 08, 2019 at 02:50:00PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=E9 <berrange@redhat.com> writes:
>=20
> > On Tue, May 07, 2019 at 12:38:14PM +0200, Kevin Wolf wrote:
> >> Am 03.05.2019 um 21:37 hat Eduardo Habkost geschrieben:
> >> > Python 2 will reach end of life in January 1 2020.  Declare it as
> >> > deprecated.
> >> >=20
> >> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >> > ---
> >> >  configure            | 8 ++++++++
> >> >  qemu-deprecated.texi | 8 ++++++++
> >> >  2 files changed, 16 insertions(+)
> >> >=20
> >> > diff --git a/configure b/configure
> >> > index 5b183c2e39..50385061ed 100755
> >> > --- a/configure
> >> > +++ b/configure
> >> > @@ -6461,6 +6461,14 @@ if test "$supported_os" =3D "no"; then
> >> >      echo "us upstream at qemu-devel@nongnu.org."
> >> >  fi
> >> > =20
> >> > +# Note that if the Python conditional here evaluates True we will=
 exit
> >> > +# with status 1 which is a shell 'false' value.
> >> > +if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))';=
 then
> >> > +  echo
> >> > +  echo "WARNING: Python 2 support is deprecated" >&2
> >> > +  echo "WARNING: Python 3 will be required for building future ve=
rsions of QEMU" >&2
> >> > +fi
> >>=20
> >> While it's clear that we want to get rid of Python 2, did we actuall=
y
> >> discuss how to decide what the new minimum Python version is? I don'=
t
> >> think any major distribution uses 3.0, which was released in 2008, s=
o
> >> this doesn't seem to make a lot of sense to me as the new minimum.
>=20
> Good point.
>=20
> >> Currently, 3.6 seems to be a commonly available version. It looks li=
ke
> >> Debian stable is at 3.5 still, though it might become oldstable befo=
re
> >> the next QEMU release. Do we need to support anything older than tha=
t?
> >
> > Per our support build platform doc, the oldest distros we care about =
will
> > be RHEL-7 and Debian Jessie.  Except we can drop Jessie 2 years after
> > Stretch was released. IOW, we can drop Jessie in June this year, whic=
h
> > is before our next releasee. So we don't need to care about the 3.4
> > version in Jessie.
> >
> > RHEL-7 doesn't have py3 at all in standard distros, but it can be obt=
ained
> > via software collections and this has 3.6
> >
> > Debian Strech has 3.5.3, so 3.5 looks like our min viable version.
>=20
> Eduardo, care to update configure accordingly?

I'll do it as a separate patch, because updating the minimum
Python 3.x version (which is 3.0 right now) is independent from
Python 2 deprecation.

--=20
Eduardo

