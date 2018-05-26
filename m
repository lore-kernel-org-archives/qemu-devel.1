Received: from eggs.gnu.org ([2001:4830:134:3::10]:52959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMZHP-0007TF-5E
	for qemu-devel@nongnu.org; Sat, 26 May 2018 09:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMZHO-0007Ak-6m
	for qemu-devel@nongnu.org; Sat, 26 May 2018 09:30:43 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fMZHO-0007AG-1a
	for qemu-devel@nongnu.org; Sat, 26 May 2018 09:30:42 -0400
Received: by mail-ot0-x241.google.com with SMTP id l22-v6so9056082otj.0
	for <qemu-devel@nongnu.org>; Sat, 26 May 2018 06:30:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ee73c66b-2a36-ffbc-ba2e-9b01386a54d0@amsat.org>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<b8019eac434b2e61813a2061090d85401c6c44c4.1527310210.git.keno@alumni.harvard.edu>
	<ee73c66b-2a36-ffbc-ba2e-9b01386a54d0@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 26 May 2018 14:30:20 +0100
Message-ID: <CAFEAcA-OfPdAY-DrM6G4xU1nh8FVSL5mO+nCppswi5U3RpUGdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/13] 9p: linux: Fix a couple Linux
 assumptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: keno@juliacomputing.com, QEMU Developers <qemu-devel@nongnu.org>, Keno Fischer <keno@alumni.harvard.edu>, Greg Kurz <groug@kaod.org>

On 26 May 2018 at 07:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Hi Keno,
>
> On 05/26/2018 02:23 AM, keno@juliacomputing.com wrote:
>> From: Keno Fischer <keno@alumni.harvard.edu>
>>
>>  - Guard two Linux only headers.
>>  - Define `ENOATTR` only if not only defined
>>    (it's defined in system headers on Darwin).
>>
>> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
>> ---
>>  fsdev/file-op-9p.h   | 2 ++
>>  hw/9pfs/9p-local.c   | 2 ++
>>  include/qemu/xattr.h | 4 +++-
>>  3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
>> index 3fa062b..a13e729 100644
>> --- a/fsdev/file-op-9p.h
>> +++ b/fsdev/file-op-9p.h
>> @@ -16,7 +16,9 @@
>>
>>  #include <dirent.h>
>>  #include <utime.h>
>> +#ifdef CONFIG_LINUX
>
> What about a less restrictive:
>
> #ifndef __APPLE__

In general I would recommend checking for specific
features (usually in configure), rather than adding
ifdef tests for particular OSes. In this case presumably
we're including these headers because we're after
a specific function or define or whatever, so we can
check in configure for what header that's in (or
if it's not available at all).

thanks
-- PMM
