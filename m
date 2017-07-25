Received: from eggs.gnu.org ([2001:4830:134:3::10]:37970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da16w-00066D-JA
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da16s-0003Xv-F3
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:46:58 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1da16s-0003WN-6X
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:46:54 -0400
Received: by mail-wr0-x230.google.com with SMTP id k71so66551651wrc.2
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:46:54 -0700 (PDT)
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-35-f4bug@amsat.org>
	<87k22weh78.fsf@linaro.org> <20170725142217.GQ26394@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170725142217.GQ26394@redhat.com>
Date: Tue, 25 Jul 2017 15:46:51 +0100
Message-ID: <87h8y0efqc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 34/35] docker: add debian
 'bleeding' image with gcc7 and clang5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org


Daniel P. Berrange <berrange@redhat.com> writes:

> On Tue, Jul 25, 2017 at 03:15:07PM +0100, Alex Bennée wrote:
>>
>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>
>> > Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> > ---
>> >  .../docker/dockerfiles/debian-bleeding-dev.docker  | 94 ++++++++++++++++++++++
>> >  1 file changed, 94 insertions(+)
>> >  create mode 100644 tests/docker/dockerfiles/debian-bleeding-dev.docker
>> >
>> > diff --git a/tests/docker/dockerfiles/debian-bleeding-dev.docker b/tests/docker/dockerfiles/debian-bleeding-dev.docker
>> > new file mode 100644
>> > index 0000000000..d6ae20692c
>> > --- /dev/null
>> > +++ b/tests/docker/dockerfiles/debian-bleeding-dev.docker
>
>
>> > +RUN git clone git://anongit.freedesktop.org/virglrenderer /usr/src/virglrenderer
>> > +RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure
>> > --with-glx --disable-tests && make install
>>
>> There are a lot of moving parts basing this in debian unstable and
>> compiling extra bleeding edge stuff. What does this buy that the clang
>> and toolchain builds in Travis don't already cover?
>
> FWIW, the clang version in Travis is somewhat old compared to the version
> that Peter uses during merge testing. I recently had a pull request that
> passed travis tests, but failed with modern clang.
>
> Doesn't neccessarily mean we need debian bleeding edge though - a Fedora
> 26 image would have detected that since it has new clang.

Yeah I think from a compiler testing point of view it would be nice to
have two images, one for latest clang, one for latest gcc that are
pre-set up to build with them for QEMU_CONFIGURE_OPTS. I'd rather those
on a stable base distro than taking a potshot on the status of a rolling
distro on any given day.

The virgl and other tip of tree installs are done once and probably
don't need repeating in other trees.

--
Alex Bennée
