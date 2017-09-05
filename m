Received: from eggs.gnu.org ([2001:4830:134:3::10]:42190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpDci-0005EY-UZ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpDce-0006by-1E
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:10:36 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpDcd-0006bH-OU
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:10:31 -0400
Received: by mail-wr0-x235.google.com with SMTP id y15so8717272wrc.2
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 06:10:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504506678.18331.1.camel@redhat.com>
References: <20170901105023.11108-1-kraxel@redhat.com>
	<CAKmqyKMUVEb13Ffv5YsovOTRAaQ8g=Q2C=U4FzWWZuygAdMwdA@mail.gmail.com>
	<1504506678.18331.1.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 14:10:10 +0100
Message-ID: <CAFEAcA9+L+9TaN9YAqrpzD0LTELDyMD0xw1u-_aipfMvWTAzaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] pixman: drop submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 4 September 2017 at 07:31, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> > diff --git a/configure b/configure
>> > index dd73cce62f..73760430b0 100755
>> > --- a/configure
>> > +++ b/configure
>> > @@ -930,8 +930,6 @@ for opt do
>> >    ;;
>> >    --with-system-pixman) pixman="system"
>>
>> Is there any use case for '--with-system-pixman now?
>
> There is "--without-pixman" (so you can turn off pixman if you don't
> want build the system emulation).  So IMHO it makes sense to leave the
> opposite switch in.  The name is a bit strange now, but changing it
> might break build scripts, so I left it as-is.  Maybe configure should
> accept both "--with-pixman" and "--with-system-pixman"?

There's an argument that we don't need any configure options
for pixman any more:
 * if you're not building the system emulation then we can
   just automatically skip the pixman check
 * if you are building the system emulation then we need a
   pixman and have to complain if it doesn't exist

The usual reason for a --with-foo is for the "if foo doesn't
exist then we can still build but with some feature disabled",
in which case distros want to be able to say "fail if foo
not present rather than proceeding in degraded mode". That
doesn't apply for pixman. (We don't have a --with-glib flag
either).

This patch passed on all my build-test machines and configs,
which surprised me a bit but is good news as it suggests
that system pixman is present pretty much everywhere :-)

thanks
-- PMM
