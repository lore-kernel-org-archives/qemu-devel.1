Received: from eggs.gnu.org ([2001:4830:134:3::10]:40468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxLla-0004sL-UI
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 19:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxLla-0001Xm-5e
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 19:29:22 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:46782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dxLlZ-0001XF-Sx
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 19:29:22 -0400
Received: by mail-wr0-x229.google.com with SMTP id o42so19077824wrb.3
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 16:29:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170928020110-mutt-send-email-mst@kernel.org>
References: <1506049617-25716-1-git-send-email-thuth@redhat.com>
	<513bbb2d-280b-92f8-b45f-89963f7118e2@msgid.tls.msk.ru>
	<20170926223046-mutt-send-email-mst@kernel.org>
	<CAFEAcA-dWVfX2i7ZYdHVg3G_kSSM6Gos8TRk=dfYYML4Jrn9HQ@mail.gmail.com>
	<20170928020110-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Sep 2017 16:28:59 -0700
Message-ID: <CAFEAcA98PbN50zeR5guO4ZB3PXCwwb_65irQzkYzdtHfNR-33A@mail.gmail.com>
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

On 27 September 2017 at 16:14, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Sep 26, 2017 at 08:35:59PM +0100, Peter Maydell wrote:
>> On 26 September 2017 at 20:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > Please do not apply this, trivial is not appropriate for functional
>> > changes like this.
>>
>> It's not a functional change, it's just bumping a test timeout.
>> If you think we should be doing something else that's fine (as
>> with any other patch), but in principle I think this is totally
>> fine as a -trivial patch.

> OK. I'd rather not see it applied as-is though.

Oops, looks like it's already hit master (07897000194a).
I can revert it if you feel strongly about it, but my personal
feeling is that the timeout needs to be long enough that you
don't hit it in any configuration. Usually if you're running
tests yourself then you'll notice it's stuck before it
hits a timeout -- the timeout is just so that fully automated
test runs don't hang forever.

thanks
-- PMM
