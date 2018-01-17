Received: from eggs.gnu.org ([2001:4830:134:3::10]:56757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebezn-0006Xr-2F
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 23:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebezj-0003Bo-3o
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 23:06:39 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ebezi-0003BU-T5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 23:06:35 -0500
Received: by mail-wm0-f66.google.com with SMTP id v71so12804545wmv.2
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 20:06:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <25b03edb-0db9-4ad4-538c-72255cf310cf@amsat.org>
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-7-f4bug@amsat.org>
	<20180115162728.GS8218@redhat.com>
	<25b03edb-0db9-4ad4-538c-72255cf310cf@amsat.org>
From: Fam Zheng <fzheng@redhat.com>
Date: Wed, 17 Jan 2018 12:06:01 +0800
Message-ID: <CAK1Eb9k4Ka0Lg_x=CB+ScRO=k5Fi_k5=sXS2G1-7Qk-xJsf=zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/8] docker: add the Fedora 27 base image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 16, 2018 at 12:38 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> On 01/15/2018 01:27 PM, Daniel P. Berrange wrote:
>> On Mon, Jan 15, 2018 at 11:34:57AM -0300, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> straight copy on Fedora 25 base.
>>>
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  tests/docker/dockerfiles/fedora27.docker | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>  create mode 100644 tests/docker/dockerfiles/fedora27.docker
>>>
>>> diff --git a/tests/docker/dockerfiles/fedora27.docker b/tests/docker/do=
ckerfiles/fedora27.docker
>>> new file mode 100644
>>> index 0000000000..7cba4dcc2c
>>> --- /dev/null
>>> +++ b/tests/docker/dockerfiles/fedora27.docker
>>> @@ -0,0 +1,18 @@
>>> +FROM fedora:27
>>> +ENV PACKAGES \
>>> +    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 host=
name \
>>> +    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
>>
>> Perhaps SDL2 here too
>>
>>> +    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
>>> +    nettle-devel \
>>> +    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-c=
onfig \
>>> +    mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-li=
btasn1 \
>>
>> Is there a reason we have both GTK2 and GTK3 installed ? We've deprecate=
d GTK2
>> and configure will pick GTK3 by default. IIUC there's no way to override
>> that in the docker builds to force GTK2, so it can possibly be dropped.
>
> No clue, Fam?
>

I think Dan is right here.

Fam
