Received: from eggs.gnu.org ([2001:4830:134:3::10]:54046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHAyL-00005k-33
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHAyF-00037h-Fa
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:00:29 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:41692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHAyF-00037Q-7t
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:00:23 -0500
Received: by mail-oi0-x22c.google.com with SMTP id h81so8840890oib.8
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 08:00:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7308e432-4cf5-04bd-4a22-f330dda1f933@amsat.org>
References: <1511276888-17834-1-git-send-email-peter.maydell@linaro.org>
	<7308e432-4cf5-04bd-4a22-f330dda1f933@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 16:00:01 +0000
Message-ID: <CAFEAcA_NK63LdJs=3Y6zvdrn2Vn7Vvq-CF=p_J4kq9+6VKDOXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory-internal.h: Remove obsolete claim
 that header is obsolete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 21 November 2017 at 15:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Hi Peter,
>
> On 11/21/2017 12:08 PM, Peter Maydell wrote:
>> The memory-internal.h header claims that it is for "obsolete
>> exec.c functions" which "will be removed soon". This statement
>> was added in 2011, six years ago, but the header is still here.
>> (Admittedly none of the prototypes added in commit 67d95c153bef55f6
>> are still in the header.)
>>
>> It's convenient to have a place to put prototypes for functions
>> which are used internally to the various .c files of the memory
>> system or by the accel/tcg code, which is inevitably fairly
>> closely coupled. So keep the header but update the comments to
>> reflect what we're actually using it for.
>
> Until your NotDirtyInfo addition, the only prototype used was
> memory_region_access_valid() (in s390-pci-inst.c).
>
> Since "none of the prototypes added in commit 67d95c153bef55f6 are still
> in the header" we could restrict it out of include/exec/ (kinda 'revert'
> 022c62cbbc) and only keep memory_region_access_valid() + NotDirtyInfo
> exposed in include/exec/.

I'm not sure what you're suggesting. I definitely think the
s390 usage is pretty nasty but I guess it would need some
rework to get rid of. For everything else, it's nice
to have somewhere to share these things. You could argue
for splitting the header into two, one for 'between memory.c
and exec.c' and one for 'between memory.c and cputlb.c',
but is it worth the effort?

thanks
-- PMM
