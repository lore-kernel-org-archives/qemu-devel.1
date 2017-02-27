Received: from eggs.gnu.org ([2001:4830:134:3::10]:55789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciNIi-0005Xi-NO
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:33:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciNIi-00043k-0X
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:33:24 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:33022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciNIh-00043Y-QF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:33:23 -0500
Received: by mail-wm0-x22b.google.com with SMTP id t18so18864434wmt.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:33:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170227133531.31874-1-berrange@redhat.com>
References: <20170227133531.31874-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 15:33:02 +0000
Message-ID: <CAFEAcA-BMy5nu1yUTRu0uZYuZSzH_Ri8YFkhNRbmFo9KEtAZRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 0/3] Merge qio 2017/02/27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2017 at 13:35, Daniel P. Berrange <berrange@redhat.com> wrot=
e:
> The following changes since commit d992f2f1368ceb92e6bfd8efece174110f4236=
ff:
>
>   Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170226' =
into staging (2017-02-26 22:40:23 +0000)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qio-2017-02-27-1
>
> for you to fetch changes up to acd22400d1dce27bffc94be7663e1ff1c716abe8:
>
>   tests: fix leaks in test-io-channel-command (2017-02-27 12:42:21 +0000)
>
> ----------------------------------------------------------------
> Merge qio 2017/02/27 v1
>
> ----------------------------------------------------------------

Fails to build, w32:

/home/petmay01/linaro/qemu-for-merges/io/channel-websock.c: In
function =E2=80=98qio_channel_websock_handshake_entry=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/io/channel-websock.c:118:13:
error: implicit declaration of function =E2=80=98strcasestr=E2=80=99
[-Werror=3Dimplicit-function-declaration]
     begin =3D strcasestr(handshake, line);
             ^
/home/petmay01/linaro/qemu-for-merges/io/channel-websock.c:118:5:
error: nested extern declaration of =E2=80=98strcasestr=E2=80=99
[-Werror=3Dnested-externs]
     begin =3D strcasestr(handshake, line);
     ^
/home/petmay01/linaro/qemu-for-merges/io/channel-websock.c:118:11:
error: assignment makes pointer from integer without a cast
[-Werror=3Dint-conversion]
     begin =3D strcasestr(handshake, line);
           ^
cc1: all warnings being treated as errors

mingw doesn't have strcasestr(), I think.

thanks
-- PMM
