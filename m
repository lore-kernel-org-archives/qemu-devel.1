Received: from eggs.gnu.org ([2001:4830:134:3::10]:56634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhd0p-0003W6-0M
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhd0o-0001pg-49
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:40:07 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhd0n-0001pO-T2
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:40:06 -0400
Received: by mail-wr0-x22d.google.com with SMTP id x43so3811651wrb.3
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 07:40:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170815133948.GA12671@stefanha-x1.localdomain>
References: <20170814231552.24593-1-pbonzini@redhat.com>
	<20170815133948.GA12671@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Aug 2017 15:39:44 +0100
Message-ID: <CAFEAcA-5VkbyT0zVwDEhB6z=BKAg7aKUjvwgbmPRyk4n8J8TEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.10?] qxl: call
 qemu_spice_display_init_common for secondary devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, ademaria@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

On 15 August 2017 at 14:39, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Aug 15, 2017 at 01:15:52AM +0200, Paolo Bonzini wrote:
>> Fixes this 2.10 regression:
>>
>>   $ qemu-system-x86_64  -cpu host -m 6144 -vga qxl -device qxl
>>   qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock: Assertion `mutex->initialized' failed.
>>
>> Reported-by: ademaria@redhat.com
>> Cc: kraxel@redhat.com
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hw/display/qxl.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I have audited the code and cannot see any bad side-effects.  Looks good
> to me!
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks; applied to master.

-- PMM
