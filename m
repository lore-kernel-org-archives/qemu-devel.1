Received: from eggs.gnu.org ([2001:4830:134:3::10]:57483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHzlA-00054Z-Gu
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 17:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHzl5-0000SB-Fw
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 17:14:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHzl5-0000QR-An
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 17:14:11 -0500
References: <1511276888-17834-1-git-send-email-peter.maydell@linaro.org>
	<7308e432-4cf5-04bd-4a22-f330dda1f933@amsat.org>
	<CAFEAcA_NK63LdJs=3Y6zvdrn2Vn7Vvq-CF=p_J4kq9+6VKDOXg@mail.gmail.com>
	<7c5ebc0b-c588-e405-58a4-783c357169b6@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95ccbe3d-9b4d-81ea-eaf0-0c0391fef1b2@redhat.com>
Date: Thu, 23 Nov 2017 23:14:06 +0100
MIME-Version: 1.0
In-Reply-To: <7c5ebc0b-c588-e405-58a4-783c357169b6@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 21/11/2017 17:04, Philippe Mathieu-Daud=C3=A9 wrote:
>> I'm not sure what you're suggesting. I definitely think the
>> s390 usage is pretty nasty but I guess it would need some
>> rework to get rid of. For everything else, it's nice
>> to have somewhere to share these things. You could argue
>> for splitting the header into two, one for 'between memory.c
>> and exec.c' and one for 'between memory.c and cputlb.c',
>> but is it worth the effort?
> Why not move memory_region_access_valid() + NotDirtyInfo in
> "exec/exec-all.h" and only use this to "share these things"?

exec/exec-all.h is for the TCG accelerator's runtime.  NotDirtyInfo and
notdirty_write_{prepare,complete} _might_ belong in there (they sit in
the middle between exec/exec-all.h and memory-internal.h), but
memory_region_access_valid certainly doesn't because it's used with KVM
as well.

In fact, memory_region_access_valid might as well be in memory.h.

Paolo
