Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F921C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AE820644
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AE820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36572 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOM2I-0003v6-Dw
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 08:51:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOM1S-0003Y1-Ng
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOM1R-0004qI-Ki
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:50:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hOM1R-0004oI-FL
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:50:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD71033025B;
	Wed,  8 May 2019 12:50:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CE12D5D9C8;
	Wed,  8 May 2019 12:50:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 4E94D1132B35; Wed,  8 May 2019 14:50:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190503193721.18459-1-ehabkost@redhat.com>
	<20190507103814.GF5808@localhost.localdomain>
	<20190507104754.GL27205@redhat.com>
Date: Wed, 08 May 2019 14:50:00 +0200
In-Reply-To: <20190507104754.GL27205@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Tue, 7 May 2019 11:47:54 +0100")
Message-ID: <87tve52jrb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 08 May 2019 12:50:08 +0000 (UTC)
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
	Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, May 07, 2019 at 12:38:14PM +0200, Kevin Wolf wrote:
>> Am 03.05.2019 um 21:37 hat Eduardo Habkost geschrieben:
>> > Python 2 will reach end of life in January 1 2020.  Declare it as
>> > deprecated.
>> >=20
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> > ---
>> >  configure            | 8 ++++++++
>> >  qemu-deprecated.texi | 8 ++++++++
>> >  2 files changed, 16 insertions(+)
>> >=20
>> > diff --git a/configure b/configure
>> > index 5b183c2e39..50385061ed 100755
>> > --- a/configure
>> > +++ b/configure
>> > @@ -6461,6 +6461,14 @@ if test "$supported_os" =3D "no"; then
>> >      echo "us upstream at qemu-devel@nongnu.org."
>> >  fi
>> >=20=20
>> > +# Note that if the Python conditional here evaluates True we will exit
>> > +# with status 1 which is a shell 'false' value.
>> > +if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
>> > +  echo
>> > +  echo "WARNING: Python 2 support is deprecated" >&2
>> > +  echo "WARNING: Python 3 will be required for building future versio=
ns of QEMU" >&2
>> > +fi
>>=20
>> While it's clear that we want to get rid of Python 2, did we actually
>> discuss how to decide what the new minimum Python version is? I don't
>> think any major distribution uses 3.0, which was released in 2008, so
>> this doesn't seem to make a lot of sense to me as the new minimum.

Good point.

>> Currently, 3.6 seems to be a commonly available version. It looks like
>> Debian stable is at 3.5 still, though it might become oldstable before
>> the next QEMU release. Do we need to support anything older than that?
>
> Per our support build platform doc, the oldest distros we care about will
> be RHEL-7 and Debian Jessie.  Except we can drop Jessie 2 years after
> Stretch was released. IOW, we can drop Jessie in June this year, which
> is before our next releasee. So we don't need to care about the 3.4
> version in Jessie.
>
> RHEL-7 doesn't have py3 at all in standard distros, but it can be obtained
> via software collections and this has 3.6
>
> Debian Strech has 3.5.3, so 3.5 looks like our min viable version.

Eduardo, care to update configure accordingly?

