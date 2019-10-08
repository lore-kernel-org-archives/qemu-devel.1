Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A53C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9025620673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9025620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHpe5-0005aN-G4
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iHpd3-0004yj-WA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iHpd2-0003rX-Cd
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:34:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iHpd2-0003r0-3Z; Tue, 08 Oct 2019 09:34:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 533ED3061211;
 Tue,  8 Oct 2019 13:34:15 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3522C196AE;
 Tue,  8 Oct 2019 13:34:14 +0000 (UTC)
Subject: Re: [PATCH v2] Makefile: Remove generated files when doing
 'distclean' (and 'clean')
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191008082815.8267-1-thuth@redhat.com>
 <CAL1e-=gYkhM99Ee0LxZJ5dCjeEdC08G4_Tm3WCZpCSWvJ=b26Q@mail.gmail.com>
 <4bfea125-eb63-f4a2-bca0-bce462f73d89@redhat.com>
 <20191008124113.GE1192@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <8f86679f-64f5-d9f4-ec61-e69da2bb5426@redhat.com>
Date: Tue, 8 Oct 2019 15:34:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008124113.GE1192@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 08 Oct 2019 13:34:15 +0000 (UTC)
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/2019 14.41, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Oct 08, 2019 at 02:35:20PM +0200, Thomas Huth wrote:
>> On 08/10/2019 14.18, Aleksandar Markovic wrote:
>>>
>>>
>>> On Tuesday, October 8, 2019, Thomas Huth <thuth@redhat.com
>>> <mailto:thuth@redhat.com>> wrote:
>>>
>>>     When running "make distclean" we currently leave a lot of generat=
ed
>>>     files in the build directory. These should be completely removed.
>>>     Some of the generated files are removed in the "clean" target (wh=
ich
>>>     is a prerequisite for the "distclean" target), since binary files
>>>     should be removed in this step already.
>>>
>>>     Signed-off-by: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat=
.com>>
>>>     ---
>>>     =C2=A0v2:
>>>     =C2=A0- Remove tests/qemu-iotests/common.env in "distclean", not =
in "clean"
>>>     =C2=A0- Improved patch description
>>>
>>>     =C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 6 +++---
>>>     =C2=A0tests/Makefile.include | 12 +++++++++++-
>>>     =C2=A02 files changed, 14 insertions(+), 4 deletions(-)
>>>
>>>     diff --git a/Makefile b/Makefile
>>>     index 30f0abfb42..767b1ffb25 100644
>>>     --- a/Makefile
>>>     +++ b/Makefile
>>>     @@ -696,14 +696,14 @@ clean: recurse-clean
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -exec rm =
{} +
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f $(edk2-decompressed)
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f $(filter-out %.tlb,$(TOOLS)) $(=
HELPERS-y) TAGS
>>>     cscope.* *.pod *~ */*~
>>>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f fsdev/*.pod scsi/*.pod
>>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f fsdev/*.pod scsi/*.pod docs/*.p=
od docs/*/*.pod
>>>     docs/*/.buildinfo
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f qemu-img-cmds.h
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f ui/shader/*-vert.h ui/shader/*-=
frag.h
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 @# May not be present in generated-fi=
les-y
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f trace/generated-tracers-dtrace.=
dtrace*
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f trace/generated-tracers-dtrace.=
h*
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f $(foreach f,$(generated-files-y=
),$(f) $(f)-timestamp)
>>>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f qapi-gen-timestamp
>>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f qapi-gen-timestamp vhost-user-i=
nput
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf qga/qapi-generated
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f config-all-devices.mak
>>>
>>>     @@ -724,7 +724,7 @@ distclean: clean
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f tests/tcg/config-*.mak
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f config-all-devices.mak config-a=
ll-disas.mak config.status
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f $(SUBDIR_DEVICES_MAK)
>>>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f po/*.mo tests/qemu-iotests/comm=
on.env
>>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f po/*.mo
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f roms/seabios/config.mak roms/vg=
abios/config.mak
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f qemu-doc.info <http://qemu-doc.=
info> qemu-doc.aux
>>>     qemu-doc.cp qemu-doc.cps
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f qemu-doc.fn qemu-doc.fns qemu-d=
oc.info
>>>     <http://qemu-doc.info> qemu-doc.ky <http://qemu-doc.ky> qemu-doc.=
kys
>>>     diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>     index 3543451ed3..694f193fb6 100644
>>>     --- a/tests/Makefile.include
>>>     +++ b/tests/Makefile.include
>>>     @@ -1176,11 +1176,21 @@ check: check-block check-qapi-schema
>>>     check-unit check-softfloat check-qtest chec
>>>     =C2=A0check-clean:
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $(check-unit-y) tests/*.o $(QE=
MU_IOTESTS_HELPERS-y)
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $(sort $(foreach target,$(SYSE=
MU_TARGET_LIST),
>>>     $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
>>>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/test-qapi-gen-timestamp
>>>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $(TESTS_VENV_DIR) $(TESTS_RESU=
LTS_DIR)
>>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/test-qapi-gen-timestamp t=
ests/qht-bench$(EXESUF) \
>>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/fp/=
fp-test tests/fp/*.out
>>>     tests/qapi-schema/*.test.*
>>>
>>>     =C2=A0clean: check-clean
>>>
>>>     +check-distclean:
>>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/qemu-iotests/common.env t=
ests/qemu-iotests/check.*
>>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/test-qapi-types*.c tests/=
test-qapi-visit*.c \
>>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/tes=
t-qapi-commands*.c tests/test-qapi-events*.c \
>>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/tes=
t-qapi-emit-events.[ch]
>>>     tests/test-qapi-introspect.c \
>>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/inc=
lude/test-qapi-*.c
>>>     +
>>>     +distclean: check-distclean
>>>     +
>>>
>>>
>>> Sorry for bad email format, I have some difficultues with mail accoun=
ts
>>> and =C2=A0mail clients.
>>>
>>> Thomas,
>>>
>>> If I remember well, QAPI-related c files are generated while doing
>>> 'make'. If that is true, these files should be deleted by 'make clean=
',
>>> shouldn't they?
>>
>> I think that's a philosophical question. Should "make clean" delete al=
l
>> files that have been generated by a Makefile (i.e. not by "configure")=
,
>> or rather mainly the binary files?
>>
>> If you have a look at our main Makefile in the topmost directory, you
>> can see that we remove lots of files that are obviously generated by
>> "make" in the "distclean" target, so it seems we have no clear rule wh=
at
>> should be deleted in each step...
>=20
> Given that we're aiming to convert to meson, how much effort do we real=
ly
> want to put into fixing this inconsistency ?

I don't think that we'll convert to meson within the next release, I
rather assume that this will take quite a bit of additional time, so
fixing this now seems reasonable to me.

> I'd argue the best way to fix "clean" and "distclean" is to delete them
> entirely. Instead enforce that builddir !=3D srcdir when running config=
ure,
> so cleaning up simply means deleting the builddir sub-tree entirely.

I could agree with "distclean", but as long as nobody cares to get such
a "builddir !=3D srcdir"  merged, we should not remove it.
And I don't agree for removing the "clean" target. Sometimes you want to
recompile without destroying your "config.status", and for these cases
it's quite useful.

 Thomas

