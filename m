Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4FFC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA1F2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA1F2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNrD-0008Ur-O4
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 11:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jKNq6-0007tp-N4
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jKNq3-0001aw-Vy
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:02:33 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:32640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jKNq2-0001Qb-QF
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:02:31 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id CAA1D74637E;
 Fri,  3 Apr 2020 17:02:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A2FAA7461AE; Fri,  3 Apr 2020 17:02:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A134E745953;
 Fri,  3 Apr 2020 17:02:19 +0200 (CEST)
Date: Fri, 3 Apr 2020 17:02:19 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 for-5.0] configure: warn if not using a separate build
 directory
In-Reply-To: <93fbf486-d1c3-ec03-ea8d-163bb2374260@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2004031657250.61599@zero.eik.bme.hu>
References: <20200403135306.665493-1-berrange@redhat.com>
 <93fbf486-d1c3-ec03-ea8d-163bb2374260@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1115009642-1585926139=:61599"
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
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1115009642-1585926139=:61599
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Apr 2020, Eric Blake wrote:
> On 4/3/20 8:53 AM, Daniel P. Berrang=C3=A9 wrote:
>> Running configure directly from the source directory is a build
>> configuration that will go away in future. It is also not currently
>> covered by any automated testing. Display a deprecation warning if
>> the user attempts to use an in-srcdir build setup, so that they are
>> aware that they're building QEMU in an undesirable manner.
>>=20
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>=20
>> Changed in v4:
>>    - Adopted Eric's suggested wording
>
>> +if test "$in_srcdir" =3D "yes"; then
>> +    echo
>> +    echo "WARNING: SUPPORT FOR BUILDING IN THE SOURCE DIR IS DEPRECAT=
ED"
>> +    echo
>> +    echo "Support for running the 'configure' script directly from th=
e"
>> +    echo "source directory is deprecated. In-tree builds are not cove=
red"
>> +    echo "by automated testing and thus may not correctly build QEMU.=
"
>> +    echo "Users are recommended to use a separate build directory:"
>> +    echo
>> +    echo "  $ mkdir build"
>> +    echo "  $ cd build"
>> +    echo "  $ ../configure"
>> +    echo "  $ make"
>
> Late question, but:
>
> Since this is just a warning, we still manage to complete the ./configu=
re=20
> run, including whatever generated files it leaves in-tree. Is there any=
=20
> additional step we need to recommend prior to 'mkdir build' that will c=
lean=20
> up the in-tree artifacts, so that the user then attempting the VPATH bu=
ild=20
> won't still have a broken build due to the leftovers from the in-tree=20
> attempt?  'make distclean', perhaps?
>
> /me starts testing; I'll reply back once it finishes...

You proabably also need make distclean before going to use build dir.=20
Since in-tree build continues to work as before and hopefully even after=20
it won't some convenience functions will take care of it without the user=
=20
having to do it by hand I wonder if such a long warning is really needed=20
in configure now. Other than uselessly annoying users, what does this=20
patch achieve? The recommended way to build may change again when build=20
system is replaced and I won't change my usual way until it works and=20
going to just ignore this warning and I guess others who like in-tree=20
builds will do the same. But I've already said that so probably won't=20
mention it again.

Regards,
BALATON Zoltan
--3866299591-1115009642-1585926139=:61599--

