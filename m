Received: from eggs.gnu.org ([2001:4830:134:3::10]:60510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBc5v-0000jP-Lr
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBc5u-0006Ns-NY
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:17:35 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:43808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBc5u-0006NZ-I8
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:17:34 -0400
Received: by mail-ot0-x233.google.com with SMTP id y10-v6so15451106otg.10
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 01:17:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180418144433.GV27579@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
	<CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
	<20180418144433.GV27579@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 09:17:13 +0100
Message-ID: <CAFEAcA8jXwo35B7KVdVZEiqZTtMRvVXCP87iHKECjWPkHiTJ_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Olaf Hering <olaf@aepfle.de>, QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 18 April 2018 at 15:44, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
> On Wed, Apr 18, 2018 at 02:29:47PM +0100, Peter Maydell wrote:
>> Yes, my OSX build system is on glib 2.22. It's using 'fink' for 3rd
>> party library installations, and they somehow seem to have got stuck
>> on 2.22. Looking at the website the project seems to have basically
>> stagnated, and I guess I need to move to homebrew at some point
>> (likely after we get 2.12 out the door). But for the moment this
>> patch would break my pullrequest testing builds.
>
> Yeah that sounds reasonable as it would also align your build env with
> what we are testing via travis too.

I've now made the switch to homebrew, and so my OSX build tests
will be using glib 2.56. NB that this means that none of my merge
testing will catch "glib version too old" for our current setting
of "too old" -- I'm not sure what my current oldest version is in
the test machine set.

I've also upgraded Xcode, which means I now have a machine with
a clang that emits all the -Waddress-of-packed-member complaints.
I have configured the test build so those aren't fatal
(via --extra-cflags=3D'-Werror -Wno-error=3Daddress-of-packed-member
-Wno-error=3Ddeprecated-declarations') but I'm now more interested in
getting those cleaned up so they don't clutter up my logfiles :-)

thanks
-- PMM
