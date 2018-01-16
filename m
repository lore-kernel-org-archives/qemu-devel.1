Received: from eggs.gnu.org ([2001:4830:134:3::10]:35510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebXiz-0000mA-3J
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebXiu-0004s9-3z
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:20:49 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebXit-0004s1-V6
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:20:44 -0500
Received: by mail-qt0-x242.google.com with SMTP id s3so19843104qtb.10
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 12:20:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-7-f4bug@amsat.org>
	<20180115162728.GS8218@redhat.com>
	<25b03edb-0db9-4ad4-538c-72255cf310cf@amsat.org>
Message-ID: <96410715-6dce-252a-33c1-0772a43b195b@amsat.org>
Date: Tue, 16 Jan 2018 17:20:39 -0300
MIME-Version: 1.0
In-Reply-To: <25b03edb-0db9-4ad4-538c-72255cf310cf@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/8] docker: add the Fedora 27 base image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 01/15/2018 01:38 PM, Philippe Mathieu-Daudé wrote:
> On 01/15/2018 01:27 PM, Daniel P. Berrange wrote:
>> On Mon, Jan 15, 2018 at 11:34:57AM -0300, Philippe Mathieu-Daudé wrote:
>>> straight copy on Fedora 25 base.
>>>
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  tests/docker/dockerfiles/fedora27.docker | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>  create mode 100644 tests/docker/dockerfiles/fedora27.docker
>>>
>>> diff --git a/tests/docker/dockerfiles/fedora27.docker b/tests/docker/dockerfiles/fedora27.docker
>>> new file mode 100644
>>> index 0000000000..7cba4dcc2c
>>> --- /dev/null
>>> +++ b/tests/docker/dockerfiles/fedora27.docker
>>> @@ -0,0 +1,18 @@
>>> +FROM fedora:27
>>> +ENV PACKAGES \
>>> +    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
>>> +    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
>>
>> Perhaps SDL2 here too
>>
>>> +    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
>>> +    nettle-devel \
>>> +    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
>>> +    mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
>>
>> Is there a reason we have both GTK2 and GTK3 installed ? We've deprecated GTK2
>> and configure will pick GTK3 by default. IIUC there's no way to override
>> that in the docker builds to force GTK2, so it can possibly be dropped.
> 
> No clue, Fam?

This series no longer applies since the c08d08b27cad "Build fedora image
with ASAN/UBSan", I'll respin.

Now since GTK2+3 are use in this docker image since it's origin, I'll
wait for Fam to confirm we can drop GTK2.

>>> +    mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
>>> +    mingw32-bzip2 \
>>> +    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-config \
>>> +    mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
>>
>> Repeated here.
>>
>>> +    mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
>>> +    mingw64-bzip2
>>> +
>>> +RUN dnf install -y $PACKAGES
>>> +RUN rpm -q $PACKAGES | sort > /packages.txt
>>> +ENV FEATURES mingw clang pyyaml
