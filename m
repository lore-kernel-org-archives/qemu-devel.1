Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F260C2D0F1
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C5E20781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C5E20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIY7-0004lX-Ea
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jJIX2-0003D4-Qv
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jJIX1-0001CU-14
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:10:24 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:61729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jJIWz-0001Bk-U5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:10:22 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E5D75747E0F;
 Tue, 31 Mar 2020 17:10:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A51F97475F6; Tue, 31 Mar 2020 17:10:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A371574638A;
 Tue, 31 Mar 2020 17:10:19 +0200 (CEST)
Date: Tue, 31 Mar 2020 17:10:19 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] configure: warn if not using a separate build
 directory
In-Reply-To: <042a22e2-5be5-ba57-1c35-8f210d9718fd@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003311707100.73689@zero.eik.bme.hu>
References: <20200331103758.370644-1-berrange@redhat.com>
 <042a22e2-5be5-ba57-1c35-8f210d9718fd@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1014521963-1585667234=:73689"
Content-ID: <alpine.BSF.2.22.395.2003311707180.73689@zero.eik.bme.hu>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-15?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1014521963-1585667234=:73689
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-ID: <alpine.BSF.2.22.395.2003311707181.73689@zero.eik.bme.hu>
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Mar 2020, Eric Blake wrote:
> On 3/31/20 5:37 AM, Daniel P. Berrang=E9 wrote:
>> Running configure directly from the source directory is a build
>> configuration that will go away in future. It is also not currently
>> covered by any automated testing. Display a deprecation warning if
>> the user attempts to use an in-srcdir build setup, so that they are
>> aware that they're building QEMU in an undesirable manner.
>>=20
>> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
>> ---
>>   configure | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>=20
>
> It sounds like you already have a v2 coming up to address Phillipe's=20
> comments, but I'd be happy to see this concept make it into v5.0.
>
>> diff --git a/configure b/configure
>> index e225a1e3ff..1ab7492ab5 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3,6 +3,19 @@
>>   # qemu configure script (c) 2003 Fabrice Bellard
>>   #
>>   +BUILDDIR=3D$(pwd)
>
> Why fork out to 'pwd', when we can rely on $PWD for the same answer? No=
te=20
> that both $(pwd) and $PWD $BUILDDIR always give an absolute (but no=20
> necessarily canonical) path, which means...
>
>> +SRCDIR=3D$(dirname "$0")
>> +
>> +ABS_BUILDDIR=3D$(realpath $BUILDDIR)
>
> ...calling this ABS_BUILDDIR is a misnomer (it was already absolute). W=
hat it=20
> is really doing is chasing through symlinks to result in a canonical na=
me,=20
> particularly since unless you have absolute names, using only string=20
> comparison to see if two filenames are equivalent will have false negat=
ives=20
> (/tmp vs. /tmp/., for example).
>
>> +ABS_SRCDIR=3D$(realpath $SRCDIR)
>
> Not robust if there are spaces in the directory names.  Safer would be
> ABS_BUILDDIR=3D$(realpath -- "$BUILDDIR")
> and similarly for ABS_SRCDIR.
>
>> +
>> +in_srcdir=3Dno
>> +if [ "$ABS_SRCDIR" =3D=3D "$ABS_BUILDDIR" ]
>
> Bashism. You MUST spell this '=3D', not '=3D=3D', since configure is ru=
n under=20
> /bin/sh which might be dash which does not understand =3D=3D.
>
>> +then
>> +    in_srcdir=3Dyes
>> +fi
>> +
>> +
>>   # Unset some variables known to interfere with behavior of common to=
ols,
>>   # just as autoconf does.
>>   CLICOLOR_FORCE=3D GREP_OPTIONS=3D
>> @@ -6799,6 +6812,23 @@ if test "$supported_os" =3D "no"; then
>>       echo "us upstream at qemu-devel@nongnu.org."
>>   fi
>>   +if test "$in_srcdir" =3D "yes"; then
>> +    echo
>> +    echo "WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED"
>> +    echo
>> +    echo "Support for running the 'configure' script directly from th=
e"
>> +    echo "source directory is deprecated and will go away in a future=
"
>> +    echo "release. In source dir builds are not covered by automated"
>> +    echo "testing and are liable to break without warning. Users are"
>> +    echo "strongly recommended to switch to a separate build director=
y:"
>> +    echo
>> +    echo "  $ mkdir build"
>> +    echo "  $ cd build"
>> +    echo "  $ ../configure"
>> +    echo "  $ make"
>> +    echo
>> +fi
>
> You know, it WOULD be possible to further enhance this to actually crea=
te=20
> 'build' as well as a shim GNUmakefile that would auto-forward on to bui=
lding=20
> directly in build, so that you maintain the illusion of an in-place bui=
ld=20
> (other than all the build artifacts now living in a different location)=
, and=20
> muscle memory for in-tree 'make' still works; I've posted elsewhere and=
 will=20
> repeat here the contents of my GNUmakefile:
>
> # Hack for redirecting while reminding myself to use distinct builddir
> ifeq ($(MAKECMDGOALS),)
> recurse: all
> endif
> %: force
> 	@echo 'changing directory to build...'
> 	@sleep 2

Right, just drop all the 14 line warning above, this one line here should=
=20
be enough to remind people (maybe reworded to say that build results are=20
found there and move it after the $(MAKE) so it's printed last and drop=20
the sleep 2 and this should work.

Regards,
BALATON Zoltan

> 	@$(MAKE) -C build -f Makefile $(MAKECMDGOALS)
> force: ;
> .PHONY: force
> GNUmakefile: ;
>
>
> But we could do that as a patch on top of yours.
>
>
--3866299591-1014521963-1585667234=:73689--

