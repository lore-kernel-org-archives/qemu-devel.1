Received: from eggs.gnu.org ([2001:4830:134:3::10]:35927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewTup-00022y-4J
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewTul-0004BJ-5p
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:31:35 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewTuk-0004Al-V7
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:31:31 -0400
Received: by mail-wr0-x244.google.com with SMTP id d10so8543806wrf.3
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 07:31:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520942752-19449-1-git-send-email-pbonzini@redhat.com>
	<20180313123313.GI8326@lemon.usersys.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bd941562-08cb-1b1f-2b36-c2414d3924c2@amsat.org>
Date: Thu, 15 Mar 2018 15:31:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180313123313.GI8326@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] docker: fedora: test more components
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 03/13/2018 01:33 PM, Fam Zheng wrote:
> On Tue, 03/13 13:05, Paolo Bonzini wrote:
>> Install optional dependencies of QEMU to get better coverage.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  tests/docker/dockerfiles/fedora.docker | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
>> index 994a35a..0d9da45 100644
>> --- a/tests/docker/dockerfiles/fedora.docker
>> +++ b/tests/docker/dockerfiles/fedora.docker
>> @@ -1,9 +1,16 @@
>>  FROM fedora:27
>>  ENV PACKAGES \
>>      ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostname \
>> -    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
>> -    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
>> -    nettle-devel libasan libubsan \
>> +    gcc gcc-c++ clang make perl which bc findutils glib2-devel \
>> +    libaio-devel pixman-devel zlib-devel libfdt-devel libasan libubsan \
>> +    bluez-libs-devel brlapi-devel bzip2-devel \
>> +    device-mapper-multipath-devel glusterfs-api-devel gnutls-devel \
>> +    gtk3-devel libattr-devel libcap-devel libcap-ng-devel libcurl-devel \
>> +    libjpeg-devel libpng-devel librbd-devel libssh2-devel libusbx-devel \
>> +    libxml2-devel lzo-devel ncurses-devel nettle-devel nss-devel \
>> +    numactl-devel SDL2-devel snappy-devel spice-server-devel \
>> +    systemtap-sdt-devel usbredir-devel virglrenderer-devel vte3-devel \
>> +    xen-devel \
>>      mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
>>      mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
>>      mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
>> -- 
>> 1.8.3.1
>>
> 
> Queued, thanks. (Conflicts with Marc-Andre's "d8204b57c5 tests: make
> docker-test-debug@fedora run sanitizers" but easy enough to resolve.)

This is why I prefer one single package per line (like the Debian
Dockerfiles) so the diff is easier to review, and there is no merge
conflict (no performance penalty neither).

"sort dockerfiles" added to my 2.13 TODO.
