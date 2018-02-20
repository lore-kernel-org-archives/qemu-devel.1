Received: from eggs.gnu.org ([2001:4830:134:3::10]:51730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eo6oM-0003ma-JT
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eo6oL-0000In-Gu
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:14:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eo6oL-0000I9-CH
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:14:17 -0500
References: <1518598187-27169-1-git-send-email-whois.zihan.yang@gmail.com>
	<4f4fd107-e836-ad27-0778-aa13c9f93b23@redhat.com>
	<CAKwiv-gm39NU0Y5sWaWHoKq6_LBo2FR1RopXLSoi0tC_Ray71w@mail.gmail.com>
	<6681bcc4-d9f9-8b14-4463-9e93ec422f06@redhat.com>
	<CAFEAcA8urY-pXDeZ5Hq33O2JOfWiVkdL2XRwWoCnXxSM6Q4B3Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad515c08-346e-bc73-acf7-da8fdbc631bd@redhat.com>
Date: Tue, 20 Feb 2018 13:14:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8urY-pXDeZ5Hq33O2JOfWiVkdL2XRwWoCnXxSM6Q4B3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] RAMList: replace QemuMutex with
 CompatGMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16/02/2018 10:13, Peter Maydell wrote:
> On 14 February 2018 at 12:11, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 14/02/2018 12:43, Zihan Yang wrote:
>>>
>>>> I'm not sure what is the advantage of this change.  QEMU is more or less
>>>> uniformly using QemuMutex and QemuCond.
>>>
>>> I see. QEMU uses some glib functions, like g_new, g_free, g_hash_table ,
>>> g_assert and g_poll, so I thought there was a trend for making more use
>>> of glib.
>>> I get the point now.
>>
>> There are some plans about using priority inheritance mutexes for
>> QemuMutex.  GLib does not support anymore pluggable thread functions, so
>> we are stuck with our own implementation.
> 
> Should we remove the entry
> "Change QemuMutex and QemuCond to CompatGMutex and CompatGCond (these are
>  the same as GMutex and GCond, just with a different type). With this change,
>  qemu_mutex_init/qemu_cond_init becomes optional for global variables."
> from https://wiki.qemu.org/Contribute/BiteSizedTasks then?

Yes, good idea.

Paolo
