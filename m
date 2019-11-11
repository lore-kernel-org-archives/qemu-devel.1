Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214F2C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE93E214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GU9EqbK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE93E214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUIVs-0001O7-1L
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 17:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iUIVD-0000rG-P6
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 17:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iUIVC-0004Dp-AA
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 17:49:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28214
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iUIVC-0004DA-5x
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 17:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573512581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBFNRcP1MlJc0rn+q3AqwqCBegxD/1JS9JC6G3OTk8o=;
 b=GU9EqbK8Zf8MJeIuICCyNz+fzRrKtGbog6/R+CKv9D9HF3sberFodSdMTK9E1ugVYY2jZ1
 vA0LLzq8fqprZ9szP/4920nBoF6/GaVyO+P7hhIbrCgkLQhNZnFqSvGod/0Va9JOaHAXCA
 9LF9QLWCAfxSlYpkszgJd4h6q7mEe2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-WVjNp8-SMkqUzOCVjQHV8Q-1; Mon, 11 Nov 2019 17:49:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46B03107ACC4;
 Mon, 11 Nov 2019 22:49:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 974548516;
 Mon, 11 Nov 2019 22:49:31 +0000 (UTC)
Date: Mon, 11 Nov 2019 17:49:29 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v7 6/8] Acceptance tests: add the build directory to the
 system PATH
Message-ID: <20191111224929.GF19559@localhost.localdomain>
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-7-crosa@redhat.com>
 <0660a16e-2ffc-fd3f-bfc7-cb0c43f1aef9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0660a16e-2ffc-fd3f-bfc7-cb0c43f1aef9@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: WVjNp8-SMkqUzOCVjQHV8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 05:46:13PM -0200, Wainer dos Santos Moschetta wrote=
:
>=20
> On 11/4/19 1:13 PM, Cleber Rosa wrote:
> > So that when binaries such as qemu-img are searched for, those in the
> > build tree will be favored.  As a clarification, SRC_ROOT_DIR is
> > dependent on the location from where tests are executed, so they are
> > equal to the build directory if one is being used.
> >=20
> > The original motivation is that Avocado libraries such as
> > avocado.utils.vmimage.get() may use the matching binaries, but it may
> > also apply to any other binary that test code may eventually attempt
> > to execute.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >   tests/acceptance/avocado_qemu/__init__.py | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >=20
> > diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> > index 17ce583c87..a4bb796a47 100644
> > --- a/tests/acceptance/avocado_qemu/__init__.py
> > +++ b/tests/acceptance/avocado_qemu/__init__.py
> > @@ -110,6 +110,12 @@ class Test(avocado.Test):
> >           return None
> >       def setUp(self):
> > +        # Some utility code uses binaries from the system's PATH.  For
> > +        # instance, avocado.utils.vmimage.get() uses qemu-img, to
> > +        # create a snapshot image.  This is a transparent way of
>=20
> Because PATH is changed in a transparent way, wouldn't be better to also
> self.log.info() that fact?
>

I don't have a problem with logging it, but because it will happen for
*every single* test, it seems like it will become noise.  I think it's
better to properly document this aspect of "avocado_qemu.Test" instead
(which is currently missing here).  Something like:

"Tests based on avocado_qemu.Test will have, as a convenience, the=20
QEMU build directory added to their PATH environment variable.  The goal
is to allow tests to seamless use matching built binaries, instead of
binaries installed elsewhere in the system".

How does it sound?

> > +        # making sure those utilities find and use binaries on the
> > +        # build tree by default.
> > +        os.environ['PATH'] =3D '%s:%s' % (SRC_ROOT_DIR, os.environ['PA=
TH'])
>=20
> I think PATH should be set only once at class initialization. Perhaps in
> setUpClass()?
>=20
> - Wainer
>

The Avocado test isolation model makes setUpClass() unnecessary,
unsupported and pointless, so we only support setUp().

Every test already runs on its own process, and with the nrunner
model, should be able to run on completely different systems.  That's
why we don't want to support a setUpClass() like approach.

- Cleber.


