Received: from eggs.gnu.org ([2001:4830:134:3::10]:56923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvQXW-00066s-Pv
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvQXU-00061y-PC
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:10:54 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:53434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvQXU-00060Q-4T
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:10:52 -0400
Received: by mail-wr0-x229.google.com with SMTP id l22so1296132wrc.10
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:10:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e9861b1a-296c-6233-4e47-6af3f8dc37e7@redhat.com>
References: <CAEgYsbFZGT3GARy7LEkU7uvb4__Xg6AdA2oU9wHtctmKhewkmw@mail.gmail.com>
	<CAFEAcA_UDk4cwtq4G_XArGCH4LC3hLUnmVHO28RJnm+7=YD_BA@mail.gmail.com>
	<e9861b1a-296c-6233-4e47-6af3f8dc37e7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 17:10:30 +0100
Message-ID: <CAFEAcA-WjGn1VdkFsHfNZBpoaV5hzunZLHtVaU3=K_fbjTuUEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] SunOS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Tribble <peter.tribble@gmail.com>, Kamil Rytarowski <n54@gmx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 22 September 2017 at 16:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 22/09/2017 14:05, Peter Maydell wrote:
>> On 20 September 2017 at 19:50, Peter Tribble <peter.tribble@gmail.com> wrote:
>>> To introduce myself: I'm a member of the illumos community (the successor
>>> to OpenSolaris, to those unfamiliar with us), and I maintain my own illumos
>>> distribution.
>>>
>>> Having seen the scary 'SUPPORT FOR THIS HOST OS WILL GO AWAY'
>>> message, I'm reaching out to see what needs to be done so that support for
>>> SunOS (not just illumos, I include Oracle's Solaris in the same family)
>>> needs to be kept and, where possible, enhanced.
>>>
>>> I'm willing to act as a contact in this effort, and can work with others in
>>> the illumos community to see if there are other resources we can bring to bear.
>>
>> Hi; thanks for getting in touch with us. Kamil Rytarowski (who I've
>> cc'd) is also interested in keeping Solaris-variant support working.
>>
>> Essentially what we need as upstream is:
>>  * access to a machine which we can use for our continuous
>>    integration build testing, so we don't break compile
>>    support for the platform. This is ideally a machine that
>>    somebody else admins and we just use (because we don't
>>    want to become solaris/illumos admins ;-)), but failing
>>    that, instructions on how to get a VM running under
>>    KVM on Linux would also be OK (that's how we've ended
>>    up handling the BSDs)
>
> I would even reverse the order since now we're handling the BSDs using
> the VM test infrastructure.  Let's say having both would be best.

I only have the one beefy machine to run VMs on, so the more
OSes we handle via VMs the more overloaded it gets. Also,
everything we have as a VM is another thing I have to maintain
and presumably update from time to time...

thanks
-- PMM
