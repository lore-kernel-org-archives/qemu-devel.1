Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16573C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDA520693
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDA520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ0DK-0005HR-Qm
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:32:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0CH-0004VQ-RB
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0CF-0002Gz-Ab
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:31:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hJ0CF-0002DQ-1n
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:31:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACB91307EA9D;
	Tue, 23 Apr 2019 18:31:07 +0000 (UTC)
Received: from [10.36.116.61] (ovpn-116-61.ams2.redhat.com [10.36.116.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66D625D706;
	Tue, 23 Apr 2019 18:30:56 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190417053225.27505-1-richard.henderson@linaro.org>
	<20190417053225.27505-2-richard.henderson@linaro.org>
	<fb4917eb-4ff3-7a93-cbcd-39d1800827e8@redhat.com>
	<20190423100101.GD6022@redhat.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <cc1481bc-5f80-2792-2a36-a31a42357825@redhat.com>
Date: Tue, 23 Apr 2019 20:30:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423100101.GD6022@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 23 Apr 2019 18:31:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/1] util/path: Do not cache all filenames
 at startup
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, evgreen@chromium.org, laurent@vivier.eu,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423183055.k4ikWUWXbLqhbM5T5utWAjt3EAfdn6wBLIZ71Zm4gb0@z>

On 23.04.19 12:01, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 23, 2019 at 11:54:53AM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Hi Richard, Daniel,
>>
>> On 4/17/19 7:32 AM, Richard Henderson wrote:
>>> If one uses -L $PATH to point to a full chroot, the startup time
>>> is significant.  In addition, the existing probing algorithm fails
>>> to handle symlink loops.
>>>
>>> Instead, probe individual paths on demand.  Cache both positive
>>> and negative results within $PATH, so that any one filename is
>>> probed only once.
>>>
>>> Use glib filename functions for clarity.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  util/path.c | 211 ++++++++++++++------------------------------------=
--
>>>  1 file changed, 57 insertions(+), 154 deletions(-)
>=20
>=20
>>> +#if GLIB_CHECK_VERSION(2, 58, 0)
>>
>> Should we raise GLIB_VERSION_MAX_ALLOWED in "glib-compat.h"?
>>
>> Currently it is:
>>
>>   /* Ask for warnings if code tries to use function that did not
>>    * exist in the defined version. These risk breaking builds
>>    */
>>   #define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_40
>=20
> Use of 2.40 is set in accordance with our targetted platform support
> policy. If Peter has stopped using the Ubuntu 14.04 build host, we
> could bump it to 2.42. Once our dev tree opens up we could in fact
> drop Jessie since we'll be supporting Buster by the time next QEMU
> is released. That would still only take us upto perhaps Glib 2.48
>=20
> Glib 2.58 is waaaay to new to rely on.
>=20
> commit e7b3af81597db1a6b55f2c15d030d703c6b2c6ac
> Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Date:   Fri May 4 15:34:46 2018 +0100
>=20
>     glib: bump min required glib library version to 2.40
>    =20
>     Per supported platforms doc[1], the various min glib on relevant di=
stros is:
>    =20
>       RHEL-7: 2.50.3
>       Debian (Stretch): 2.50.3
>       Debian (Jessie): 2.42.1
>       OpenBSD (Ports): 2.54.3
>       FreeBSD (Ports): 2.50.3
>       OpenSUSE Leap 15: 2.54.3
>       SLE12-SP2: 2.48.2
>       Ubuntu (Xenial): 2.48.0
>       macOS (Homebrew): 2.56.0
>    =20
>     This suggests that a minimum glib of 2.42 is a reasonable target.
>    =20
>     The GLibC compile farm, however, uses Ubuntu 14.04 (Trusty) which o=
nly
>     has glib 2.40.0, and this is needed for testing during merge. Thus =
an
>     exception is made to the documented platform support policy to allo=
w for
>     all three current LTS releases to be supported.
>    =20
>     Docker jobs that not longer satisfy this new min version are remove=
d.
>    =20
>     [1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-plat=
forms
>    =20
>     Reviewed-by: Thomas Huth <thuth@redhat.com>
>     Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>=20
>>
>> From commit e71e8cc035558eabd6b3e19f6d3254c754c027ef:
>>
>>  glib: enforce the minimum required version and warn about old APIs
>>
>>  There are two useful macros that can be defined before including
>>  glib.h that are related to the min required glib version
>>
>>   - GLIB_VERSION_MIN_REQUIRED
>>
>>     When this is defined, if code uses an API that was deprecated
>>     in this version, or older, a compiler warning will be emitted.
>>     This alerts maintainers to update their code to whatever new
>>     replacement API is now recommended best practice.
>>
>>   - GLIB_VERSION_MAX_ALLOWED
>>
>>     When this is defined, if code uses an API that was introduced
>>     in a version that is newer than the declared version, a compiler
>>     warning will be emitted. This alerts maintainers if new code
>>     accidentally uses functionality that won't be available on some
>>     supported platforms.
>>
>>  The GLIB_VERSION_MAX_ALLOWED constant makes it a bit harder to opt
>>  in to using specific new APIs with a GLIB_CHECK_VERSION conditional.
>>  To workaround this Pragmas can be used to temporarily turn off the
>>  -Wdeprecated-declarations compiler warning, while a static inline
>>  compat function is implemented. This workaround is illustrated with t=
he
>>  implementation of the g_strv_contains method to satisfy the test suit=
e.
>>
>>> +    base =3D g_canonicalize_filename(prefix, NULL);
>>> +#else
>>> +    if (prefix[0] !=3D '/') {
>>> +        char *cwd =3D g_get_current_dir();
>>> +        base =3D g_build_filename(cwd, prefix, NULL);
>>> +        g_free(cwd);
>>> +    } else {
>>> +        base =3D g_strdup(prefix);
>>> +    }
>>> +#endif
>=20
> To use functionality from newer glib releases we can't put the #ifdef
> conditionals inline in the main source files.
>=20
> They have to be put into glib-compat.h instead. There's a detailed
> comment in that file illustrating how todo this without triggering
> the compile warnings about deprecations.
>=20
>=20
> Regards,
> Daniel
>=20

Trying to build (Richard's tcg-vec-next branch) on Fedora29 I get

util/path.c: In function 'init_paths':
util/path.c:24:5: error: 'g_canonicalize_filename' is deprecated: Not
available before 2.58 [-Werror=3Ddeprecated-declarations]
     base =3D g_canonicalize_filename(prefix, NULL);
     ^~~~
In file included from /usr/include/glib-2.0/glib.h:48,
                 from /home/dhildenb/git/qemu/include/glib-compat.h:32,
                 from /home/dhildenb/git/qemu/include/qemu/osdep.h:140,
                 from util/path.c:6:
/usr/include/glib-2.0/glib/gfileutils.h:176:8: note: declared here
 gchar *g_canonicalize_filename (const gchar *filename,
        ^~~~~~~~~~~~~~~~~~~~~~~
util/path.c: In function 'path':
util/path.c:60:9: error: 'g_canonicalize_filename' is deprecated: Not
available before 2.58 [-Werror=3Ddeprecated-declarations]
         full_name =3D g_canonicalize_filename(g_path_skip_root(name), ba=
se);
         ^~~~~~~~~
In file included from /usr/include/glib-2.0/glib.h:48,
                 from /home/dhildenb/git/qemu/include/glib-compat.h:32,
                 from /home/dhildenb/git/qemu/include/qemu/osdep.h:140,
                 from util/path.c:6:
/usr/include/glib-2.0/glib/gfileutils.h:176:8: note: declared here
 gchar *g_canonicalize_filename (const gchar *filename,
        ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
  CC      backends/rng-egd.o
make: *** [/home/dhildenb/git/qemu/rules.mak:69: util/path.o] Error 1
make: *** Waiting for unfinished jobs....
  CC      backends/rng-random.o


--=20

Thanks,

David / dhildenb

