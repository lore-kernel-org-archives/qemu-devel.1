Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DAAC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9366621773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9366621773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT4IK-0007SX-Lv
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:55:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT4Hb-00079I-Mi
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT4Ha-0007kB-Io
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hT4Ha-0007j0-CM
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:54:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F8753082E6E;
	Tue, 21 May 2019 12:54:14 +0000 (UTC)
Received: from redhat.com (ovpn-112-26.ams2.redhat.com [10.36.112.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 62DEA66610;
	Tue, 21 May 2019 12:54:11 +0000 (UTC)
Date: Tue, 21 May 2019 13:54:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190521125408.GL25835@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
	<1557953433-19663-19-git-send-email-pbonzini@redhat.com>
	<20190521115259.GK25835@redhat.com>
	<f0d7e267-5f21-927a-ee38-2330fde5a419@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0d7e267-5f21-927a-ee38-2330fde5a419@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 21 May 2019 12:54:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 18/21] build: don't build hardware objects
 with linux-user
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 02:52:42PM +0200, Laurent Vivier wrote:
> On 21/05/2019 13:52, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, May 15, 2019 at 10:50:30PM +0200, Paolo Bonzini wrote:
> > > From: Laurent Vivier <lvivier@redhat.com>
> > >=20
> > > Some objects are only needed for system emulation and tools.
> > > We can ignore them for the user mode case
> > >=20
> > > Update tests to run accordingly: conditionally build some tests
> > > on CONFIG_BLOCK.
> > >=20
> > > Some tests use components that are only built when softmmu or
> > > block tools are enabled, not for linux-user. So, if these component=
s
> > > are not available, disable the tests.
> > >=20
> > > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> > > Message-Id: <20190401141222.30034-6-lvivier@redhat.com>
> > > ---
> > >   Makefile               |  4 +++
> > >   Makefile.objs          | 14 +++++---
> > >   tests/Makefile.include | 90 +++++++++++++++++++++++++------------=
-------------
> > >   3 files changed, 58 insertions(+), 50 deletions(-)
> > >=20
> > > diff --git a/Makefile b/Makefile
> > > index 1851f8c..155f066 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -87,6 +87,10 @@ endif
> > >   include $(SRC_PATH)/rules.mak
> > > +# notempy and lor are defined in rules.mak
> > > +CONFIG_TOOLS :=3D $(call notempty,$(TOOLS))
> > > +CONFIG_BLOCK :=3D $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
> >=20
> > IMHO calling this CONFIG_BLOCK is a really poor choice, as
> > the decision is completely unrelated to block modules. It
> > made really confused when trying to understand why all the
> > crypto or auth code had been made conditional on the block
> > drivers.  The block code is just one part of QEMU that
> > is used in tools & softmmu.
> >=20
> > It would be better as CONFIG_SOFTMMU_TOOLS, or
> > CONFIG_NOT_USER, or something else.
>=20
> Do you think it's worth a patch to change the name?

Personally I'd like to see a patch to give it a better name.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

