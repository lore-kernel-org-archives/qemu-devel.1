Received: from eggs.gnu.org ([2001:4830:134:3::10]:35587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwveY-00043S-1D
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwveX-0007kM-AD
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:36:22 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:55658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwveX-0007jy-1y
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:36:21 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l39so14099910wrl.12
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 12:36:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170926223046-mutt-send-email-mst@kernel.org>
References: <1506049617-25716-1-git-send-email-thuth@redhat.com>
	<513bbb2d-280b-92f8-b45f-89963f7118e2@msgid.tls.msk.ru>
	<20170926223046-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2017 20:35:59 +0100
Message-ID: <CAFEAcA-dWVfX2i7ZYdHVg3G_kSSM6Gos8TRk=dfYYML4Jrn9HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests/boot-sector: Increase timeout to 600
 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>, Victor Kaplansky <victork@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 26 September 2017 at 20:31, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Sep 25, 2017 at 12:06:40AM +0300, Michael Tokarev wrote:
>> 22.09.2017 06:06, Thomas Huth wrote:
>> > If QEMU has been compiled with the flags --enable-tcg-interpreter and
>> > --enable-debug, the guest is running incredibly slow. The pxe boot test
>> > can take up to 400 seconds when testing the pseries ppc64 machine. While
>> > we should still look for ways to speed up the test on the pseries machine,
>> > it's better to increase the timeout in this test to 600 seconds anyway to
>> > allow the test to pass successfully now with this unusal configuration
>> > already.
>>
>> Applied to -trivial, thanks!
>>
>> /mjt
>
> Please do not apply this, trivial is not appropriate for functional
> changes like this.

It's not a functional change, it's just bumping a test timeout.
If you think we should be doing something else that's fine (as
with any other patch), but in principle I think this is totally
fine as a -trivial patch.

thanks
-- PMM
