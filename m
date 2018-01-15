Received: from eggs.gnu.org ([2001:4830:134:3::10]:42125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb4TJ-0000Ke-5j
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb4TD-0003np-Cb
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:06:41 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:40063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb4TD-0003nd-83
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:06:35 -0500
Received: by mail-qk0-x244.google.com with SMTP id d18so16689773qke.7
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 05:06:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115102621.9183-1-berrange@redhat.com>
	<20180115102621.9183-14-berrange@redhat.com>
	<3ea0dbad-1ec3-3a0f-957d-36fa3e262cbe@amsat.org>
	<20180115105357.GF8218@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9006a8a2-6c36-fffc-6463-25d28b0b0a1f@amsat.org>
Date: Mon, 15 Jan 2018 10:06:30 -0300
MIME-Version: 1.0
In-Reply-To: <20180115105357.GF8218@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 13/13] docker: change Fedora images to
 run with python3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 01/15/2018 07:53 AM, Daniel P. Berrange wrote:
> On Mon, Jan 15, 2018 at 07:47:29AM -0300, Philippe Mathieu-Daudé wrote:
>> Hi Daniel,
>>
>> On 01/15/2018 07:26 AM, Daniel P. Berrange wrote:
>>> Fedora has switched to Python 3 by default, so it makes sense to use that
>>> for testing QEMU builds, so we get testing of Python 3 compatibility.
>>
>> I'd rather keep Fedora 25 with Python 2, and use Python 3 in Fedora 27.
> 
> FYI, Fedora 25 went end of life 2 weeks ago, so I'm not sure it is worth
> keeping that around in QEMU CI all that much much longer.

I'm not sure were to stand with EOL product, since we have to support
Python 2.6 for the oldest CentOS release until 2020...

Since I'm not paid to work on QEMU, the only way to accept worrying
about Python 2.6 -> 3.0 was to consider it retrocomputing, like some
other enthusiast QEMU users.

> To your general point though - I just picked Fedora since all non-EOL
> versions of Fedora now ship with Python3 only by default. I'm happy to
> see any arbitrary combo of Docker images changed, as long as we get a
> nice mixture of python 2/3 versions covered across the set. So feel free
> to suggest anything that gets us good coverage of 2+3.

Yep, I'm considering use Python2 in the Debian8 images, and Python3 in
the Debian9 (which we use on Shippable CI).

>> If you agree, I can apply this patch once your series is merged, on top
>> of http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg02569.html
>>
>> relevant patches:
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg02574.html
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg02575.html
>>
>>>
>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>>> ---
>>>  tests/docker/dockerfiles/fedora.docker | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
>>> index 4b26c3aded..a22fe16157 100644
>>> --- a/tests/docker/dockerfiles/fedora.docker
>>> +++ b/tests/docker/dockerfiles/fedora.docker
>>> @@ -1,6 +1,6 @@
>>>  FROM fedora:latest
>>>  ENV PACKAGES \
>>> -    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
>>> +    ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostname \
>>>      glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
>>>      gcc gcc-c++ clang make perl which bc findutils libaio-devel \
>>>      nettle-devel \
>>> @@ -12,6 +12,7 @@ ENV PACKAGES \
>>>      mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
>>>      mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
>>>      mingw64-bzip2
>>> +ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
>>>  
>>>  RUN dnf install -y $PACKAGES
>>>  RUN rpm -q $PACKAGES | sort > /packages.txt
>>>
> 
> Regards,
> Daniel
> 
