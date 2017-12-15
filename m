Received: from eggs.gnu.org ([2001:4830:134:3::10]:38454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePnJP-0002MT-63
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePnJO-0005mY-D0
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:33:51 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePnJO-0005mG-7v
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:33:50 -0500
Received: by mail-ot0-x244.google.com with SMTP id q39so990358otb.8
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 02:33:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215112138.6040ee82.cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
	<CAFEAcA8tY9=jtsw-MtjWTceLizvpH8oui_+6xf7V6K5o5BLf-A@mail.gmail.com>
	<cf44ca76-d581-8d96-3e2b-78c698dda446@de.ibm.com>
	<20171215101135.447d9316.cohuck@redhat.com>
	<CAFEAcA_VaKua1qjyeX2Ve=JrSUJQbBqMQOJQZ7e3y92+gtxkMA@mail.gmail.com>
	<20171215112138.6040ee82.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 10:33:28 +0000
Message-ID: <CAFEAcA_+XYYGzTgJicvXr47YvnTiT=v-4QKDJUEvgB9Yj4D_uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL 00/46] First batch of s390x
 patches for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 15 December 2017 at 10:21, Cornelia Huck <cohuck@redhat.com> wrote:
> On Fri, 15 Dec 2017 09:51:32 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 15 December 2017 at 09:11, Cornelia Huck <cohuck@redhat.com> wrote:
>> > On Fri, 15 Dec 2017 09:35:10 +0100
>> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>> >
>> >> On 12/14/2017 08:05 PM, Peter Maydell wrote:
>> >> > (ram_addr_t can be a 32-bit type).
>> >
>> > This a 32 bit host, isn't it? I don't have regular access to one...
>>
>> Yes. Win32 cross compiler also gives this error.
>
> Hm, my mingw build on Fedora did not catch this. Setting up a 32bit vm.

Maybe your mingw build is mingw-w64 rather than -w32 ?

thanks
-- PMM
