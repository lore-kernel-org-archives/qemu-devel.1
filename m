Received: from eggs.gnu.org ([2001:4830:134:3::10]:36645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fk3RO-0008Bz-Su
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fk3RK-00082N-UC
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:22:06 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fk3RK-000824-Lp
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:22:02 -0400
Received: by mail-wm0-x243.google.com with SMTP id s12-v6so12126841wmc.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 01:22:02 -0700 (PDT)
References: <20180718100505.7546-1-alex.bennee@linaro.org>
	<20180718100505.7546-2-alex.bennee@linaro.org>
	<20180727075644.GC19416@lemon.usersys.redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180727075644.GC19416@lemon.usersys.redhat.com>
Date: Mon, 30 Jul 2018 09:22:00 +0100
Message-ID: <8736w19lqv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 01/10] docker: rename docker-amd64 to
 docker-host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Wed, 07/18 11:04, Alex Benn=C3=A9e wrote:
>> When building on non-x86 systems the base system will be correct so if
>> we avoid too many x86'isms in the install we can still use the image.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .../dockerfiles/{debian-amd64.docker =3D> debian-host.docker}   | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>  rename tests/docker/dockerfiles/{debian-amd64.docker =3D> debian-host.d=
ocker} (91%)
>>
>> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker=
/dockerfiles/debian-host.docker
>> similarity index 91%
>> rename from tests/docker/dockerfiles/debian-amd64.docker
>> rename to tests/docker/dockerfiles/debian-host.docker
>> index eb13f06ed1..3605cc4658 100644
>> --- a/tests/docker/dockerfiles/debian-amd64.docker
>> +++ b/tests/docker/dockerfiles/debian-host.docker
>> @@ -30,9 +30,9 @@ RUN cd /usr/src/virglrenderer && ./autogen.sh && ./con=
figure --with-glx --disabl
>>  # netmap
>>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>>      apt-get install -y --no-install-recommends \
>> -        linux-headers-amd64
>> +        linux-headers-$(dpkg --print-architecture)
>>  RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
>> -RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --ke=
rnel-dir=3D$(ls -d /usr/src/linux-headers-*-amd64) && make install
>> +RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --ke=
rnel-dir=3D$(ls -d /usr/src/linux-headers-*) && make install
>
> Curious: why isn't this "ls -d linux-headers-*-$(dpkg
> --print-architecture)", like above?

Well there are only one set of headers, but you are right it would be
cleaner to be explicit.

>
>>  ENV QEMU_CONFIGURE_OPTS --enable-netmap
>>
>>  # gcrypt
>> --
>> 2.17.1
>>


--
Alex Benn=C3=A9e
