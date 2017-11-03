Received: from eggs.gnu.org ([2001:4830:134:3::10]:54228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAbiF-0008Qa-OQ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAbiE-00089I-S7
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:08:43 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:57159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAbiE-00088x-M8
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:08:42 -0400
Received: by mail-wr0-x22f.google.com with SMTP id r79so2442798wrb.13
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 06:08:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509697171.31823.9.camel@redhat.com>
References: <1509697171.31823.9.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 13:08:20 +0000
Message-ID: <CAFEAcA8LWHP-yWZxSQmnL_U2f_RAk-_ZfSERF8U48zqRE+bq0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] capstone broke mingw cross build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 3 November 2017 at 08:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> see $subject
>
> make: Entering directory `/home/kraxel/projects/qemu/build-win64'
> mkdir -p dtc/libfdt
> mkdir -p dtc/tests
> make[1]: `/home/kraxel/projects/qemu/build-win64/capstone/capstone.lib'
> is up to date.
>   LINK    qemu-ga.exe
>   LINK    qemu-img.exe
> /home/kraxel/projects/qemu/build-win64/capstone/capstone.lib: error
> adding symbols: Archive has no index; run ranlib to add one
> collect2: error: ld returned 1 exit status
>   LINK    qemu-io.exe
> make: *** [qemu-img.exe] Error 1
> make: *** Waiting for unfinished jobs....
> /home/kraxel/projects/qemu/build-win64/capstone/capstone.lib: error
> adding symbols: Archive has no index; run ranlib to add one
> collect2: error: ld returned 1 exit status
> make: *** [qemu-io.exe] Error 1
> make: Leaving directory `/home/kraxel/projects/qemu/build-win64'

Works for me for the crossbuild I do with mingw64, so I wonder
what's different about your setup?

thanks
-- PMM
