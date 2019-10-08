Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE638C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B41206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B41206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHoq1-0007kg-7y
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iHonq-0006Gd-Hj
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iHonn-0007pp-Sm
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:41:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1iHonn-0007nZ-J9; Tue, 08 Oct 2019 08:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3249E44BD1;
 Tue,  8 Oct 2019 12:41:18 +0000 (UTC)
Received: from redhat.com (ovpn-112-66.ams2.redhat.com [10.36.112.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B400160BE0;
 Tue,  8 Oct 2019 12:41:16 +0000 (UTC)
Date: Tue, 8 Oct 2019 13:41:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] Makefile: Remove generated files when doing
 'distclean' (and 'clean')
Message-ID: <20191008124113.GE1192@redhat.com>
References: <20191008082815.8267-1-thuth@redhat.com>
 <CAL1e-=gYkhM99Ee0LxZJ5dCjeEdC08G4_Tm3WCZpCSWvJ=b26Q@mail.gmail.com>
 <4bfea125-eb63-f4a2-bca0-bce462f73d89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4bfea125-eb63-f4a2-bca0-bce462f73d89@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 08 Oct 2019 12:41:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 08, 2019 at 02:35:20PM +0200, Thomas Huth wrote:
> On 08/10/2019 14.18, Aleksandar Markovic wrote:
> >=20
> >=20
> > On Tuesday, October 8, 2019, Thomas Huth <thuth@redhat.com
> > <mailto:thuth@redhat.com>> wrote:
> >=20
> >     When running "make distclean" we currently leave a lot of generat=
ed
> >     files in the build directory. These should be completely removed.
> >     Some of the generated files are removed in the "clean" target (wh=
ich
> >     is a prerequisite for the "distclean" target), since binary files
> >     should be removed in this step already.
> >=20
> >     Signed-off-by: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat=
.com>>
> >     ---
> >     =C2=A0v2:
> >     =C2=A0- Remove tests/qemu-iotests/common.env in "distclean", not =
in "clean"
> >     =C2=A0- Improved patch description
> >=20
> >     =C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 6 +++---
> >     =C2=A0tests/Makefile.include | 12 +++++++++++-
> >     =C2=A02 files changed, 14 insertions(+), 4 deletions(-)
> >=20
> >     diff --git a/Makefile b/Makefile
> >     index 30f0abfb42..767b1ffb25 100644
> >     --- a/Makefile
> >     +++ b/Makefile
> >     @@ -696,14 +696,14 @@ clean: recurse-clean
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -exec rm =
{} +
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f $(edk2-decompressed)
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f $(filter-out %.tlb,$(TOOLS)) $(=
HELPERS-y) TAGS
> >     cscope.* *.pod *~ */*~
> >     -=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f fsdev/*.pod scsi/*.pod
> >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f fsdev/*.pod scsi/*.pod docs/*.p=
od docs/*/*.pod
> >     docs/*/.buildinfo
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f qemu-img-cmds.h
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f ui/shader/*-vert.h ui/shader/*-=
frag.h
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 @# May not be present in generated-fi=
les-y
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f trace/generated-tracers-dtrace.=
dtrace*
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f trace/generated-tracers-dtrace.=
h*
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f $(foreach f,$(generated-files-y=
),$(f) $(f)-timestamp)
> >     -=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f qapi-gen-timestamp
> >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f qapi-gen-timestamp vhost-user-i=
nput
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf qga/qapi-generated
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f config-all-devices.mak
> >=20
> >     @@ -724,7 +724,7 @@ distclean: clean
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f tests/tcg/config-*.mak
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f config-all-devices.mak config-a=
ll-disas.mak config.status
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f $(SUBDIR_DEVICES_MAK)
> >     -=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f po/*.mo tests/qemu-iotests/comm=
on.env
> >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f po/*.mo
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f roms/seabios/config.mak roms/vg=
abios/config.mak
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f qemu-doc.info <http://qemu-doc.=
info> qemu-doc.aux
> >     qemu-doc.cp qemu-doc.cps
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f qemu-doc.fn qemu-doc.fns qemu-d=
oc.info
> >     <http://qemu-doc.info> qemu-doc.ky <http://qemu-doc.ky> qemu-doc.=
kys
> >     diff --git a/tests/Makefile.include b/tests/Makefile.include
> >     index 3543451ed3..694f193fb6 100644
> >     --- a/tests/Makefile.include
> >     +++ b/tests/Makefile.include
> >     @@ -1176,11 +1176,21 @@ check: check-block check-qapi-schema
> >     check-unit check-softfloat check-qtest chec
> >     =C2=A0check-clean:
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $(check-unit-y) tests/*.o $(QE=
MU_IOTESTS_HELPERS-y)
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $(sort $(foreach target,$(SYSE=
MU_TARGET_LIST),
> >     $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
> >     -=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/test-qapi-gen-timestamp
> >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $(TESTS_VENV_DIR) $(TESTS_RESU=
LTS_DIR)
> >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/test-qapi-gen-timestamp t=
ests/qht-bench$(EXESUF) \
> >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/fp/=
fp-test tests/fp/*.out
> >     tests/qapi-schema/*.test.*
> >=20
> >     =C2=A0clean: check-clean
> >=20
> >     +check-distclean:
> >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/qemu-iotests/common.env t=
ests/qemu-iotests/check.*
> >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/test-qapi-types*.c tests/=
test-qapi-visit*.c \
> >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/tes=
t-qapi-commands*.c tests/test-qapi-events*.c \
> >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/tes=
t-qapi-emit-events.[ch]
> >     tests/test-qapi-introspect.c \
> >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/inc=
lude/test-qapi-*.c
> >     +
> >     +distclean: check-distclean
> >     +
> >=20
> >=20
> > Sorry for bad email format, I have some difficultues with mail accoun=
ts
> > and =C2=A0mail clients.
> >=20
> > Thomas,
> >=20
> > If I remember well, QAPI-related c files are generated while doing
> > 'make'. If that is true, these files should be deleted by 'make clean=
',
> > shouldn't they?
>=20
> I think that's a philosophical question. Should "make clean" delete all
> files that have been generated by a Makefile (i.e. not by "configure"),
> or rather mainly the binary files?
>=20
> If you have a look at our main Makefile in the topmost directory, you
> can see that we remove lots of files that are obviously generated by
> "make" in the "distclean" target, so it seems we have no clear rule wha=
t
> should be deleted in each step...

Given that we're aiming to convert to meson, how much effort do we really
want to put into fixing this inconsistency ?

I'd argue the best way to fix "clean" and "distclean" is to delete them
entirely. Instead enforce that builddir !=3D srcdir when running configur=
e,
so cleaning up simply means deleting the builddir sub-tree entirely.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

