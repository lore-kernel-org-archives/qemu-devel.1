Received: from eggs.gnu.org ([2001:4830:134:3::10]:42292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewokn-000715-4X
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewokk-0001Dk-2O
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:46:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ewokj-0001DM-QQ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:46:33 -0400
References: <20180316122540.28409-1-pbonzini@redhat.com>
	<20180316122540.28409-3-pbonzini@redhat.com>
	<20180316124505.GH3066@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3dc55f7-df1e-ba87-761f-cf783d167c15@redhat.com>
Date: Fri, 16 Mar 2018 13:46:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180316124505.GH3066@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] docker: fedora: include more build
 dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, f4bug@amsat.org

On 16/03/2018 13:45, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Mar 16, 2018 at 01:25:40PM +0100, Paolo Bonzini wrote:
>> Install optional dependencies of QEMU to get better coverage.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  tests/docker/dockerfiles/fedora.docker | 67 +++++++++++++++++++++++++=
+++------
>>  1 file changed, 55 insertions(+), 12 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/doc=
kerfiles/fedora.docker
>> index be3566325c..6d810f6a92 100644
>> --- a/tests/docker/dockerfiles/fedora.docker
>> +++ b/tests/docker/dockerfiles/fedora.docker
>> @@ -1,18 +1,61 @@
>>  FROM fedora:27
>>  ENV PACKAGES \
>>      ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hos=
tname \
>> -    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
>> -    gcc gcc-c++ llvm clang make perl which bc findutils libaio-devel =
\
>> -    nettle-devel libasan libubsan \
>> -    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL2 mingw32-pkg=
-config \
>> -    mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
>> -    mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2=
 \
>> -    mingw32-bzip2 \
>> -    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL2 mingw64-pkg=
-config \
>> -    mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
>> -    mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2=
 \
>> -    mingw64-bzip2
>> -ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
>> +    gcc gcc-c++ llvm clang make perl which bc findutils libasan libub=
san \
>> +    alsa-lib-devel \
>> +    bluez-libs-devel \
>> +    brlapi-devel \
>> +    bzip2-devel mingw32-bzip2 mingw64-bzip2 \
>> +    cyrus-sasl-devel \
>> +    device-mapper-multipath-devel \
>> +    glib2-devel mingw32-glib2 mingw64-glib2 \
>=20
> No need for glib as that's pulled in automatically by gtk

We use it, so (unlike nettle-devel and nss-devel) I think it should be
added anyway.

>> +    nettle-devel mingw32-nettle mingw64-nettle \
>=20
> nettle should be pulled in automatically by gnutls
> if it were needed - we automatically link against
> whatever gnutls pulls in.
>=20
>> +    nss-devel \
>=20
> nss-devel is not required by anything.

Yeah, libcacard uses it but we install its own devel package.

Paolo
