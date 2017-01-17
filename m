Received: from eggs.gnu.org ([2001:4830:134:3::10]:57885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTWqz-0000ZJ-MA
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 11:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTWqy-0005Vi-UH
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 11:43:25 -0500
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:33104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTWqy-0005VH-Oj
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 11:43:24 -0500
Received: by mail-vk0-x234.google.com with SMTP id k127so50388345vke.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 08:43:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <878tq93guz.fsf@dusky.pond.sub.org>
References: <1484559200-2301-1-git-send-email-armbru@redhat.com>
	<CAFEAcA_BBbHeQhWYf_qrL+TwxGT8w34SvUNG_gcNfpNnyaGCzg@mail.gmail.com>
	<87pojmjdep.fsf@dusky.pond.sub.org>
	<CAFEAcA9nhd6x+PT5bG0=YqvmUdxJVFPZ6ACiv-2OKrDFJhrqzg@mail.gmail.com>
	<87h94x99e4.fsf@dusky.pond.sub.org>
	<CAFEAcA8vRw=13Lj_98A+3NovSeTg6e0xBopdz9EcdEeUMjjZow@mail.gmail.com>
	<874m0x7ra2.fsf@dusky.pond.sub.org>
	<CAFEAcA_txNPj6JNDavmCREse98XTkQgiFAqx5Vf8KCCu9V-6mQ@mail.gmail.com>
	<878tq93guz.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 16:43:03 +0000
Message-ID: <CAFEAcA-zV8RWCXMCbAHLMEM1oEw7CWT_aDrTc49Xv_wSnMeAyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 000/180] QAPI patches for 2017-01-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <mlureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2017 at 14:23, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> As an aside, how useful is the PDF output anyway? In 2017
>> there seems to me quite a good argument for just creating
>> HTML...
>
> We do generate HTML.  We also generate PDF.  It's better for printing
> (if you're so inclined), and it costs us next to nothing: a couple of
> lines in the top-level Makefile.

Mmm, but in thinking about other possible document formats
it would be interesting to know whether not producing PDF
would be a dealbreaker or just dropping a feature that three
people use...

In any case, applied this pullreq to master. Interestingly
there were no signs of the "unlikely character" warnings
this time around.

thanks
-- PMM
