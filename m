Received: from eggs.gnu.org ([2001:4830:134:3::10]:57993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gSIPs-00051c-87
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gSIPo-00039s-4y
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:15:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:51138 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gSIPn-00038U-Rt
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:15:20 -0500
References: <20181128103308.26755-1-fli@suse.com>
	<20181128103308.26755-2-fli@suse.com>
	<87sgzle527.fsf@dusky.pond.sub.org>
	<13916895-daeb-15ad-5540-be15d1dd7e73@suse.com>
	<87ftvkcmdc.fsf@dusky.pond.sub.org>
From: Fei Li <fli@suse.com>
Message-ID: <8d282aca-57c3-422f-5186-2214f790721a@suse.com>
Date: Thu, 29 Nov 2018 17:15:12 +0800
MIME-Version: 1.0
In-Reply-To: <87ftvkcmdc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH RFC 1/5] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org



On 11/29/2018 04:35 PM, Markus Armbruster wrote:
> Fei Li <fli@suse.com> writes:
>
>> On 11/28/2018 08:53 PM, Markus Armbruster wrote:
>>> Fei Li <fli@suse.com> writes:
>>>
>>>> When qemu_signal_init() fails in qemu_init_main_loop(), we return
>>>> without setting an error.  Its callers crash then when they try to
>>>> report the error with error_report_err().
>>> Yes, that's a bug.  Broken in 2f78e491d7b, v2.2.0.  Has escaped notice
>>> since qemu_signalfd() is quite unlikely to fail.  Could go into 3.1 as a
>>> bug fix, but I think punting it to the next release is just fine.
>> Thanks. :) BTW, should I send the next version only includes patch 1/5
>> and 2/5 separately so that you can merge? (I guess Dave will help to
>> merge the other three migration related patches)
> I can pick patches out of a series for merging, and I trust Dave can,
> too.  But keeping unrelated fixes separate is a good idea.  I can see
> three groups: PATCH 1 (main loop), PATCH 2 (thread abstraction), PATCH
> 3-5 (migration).
>
> [...]
Ok, thanks for the detail explanation. I once thought the first two patches
are belong to one group, that's why I tried to separate them.
But considering too many groups they are belong to and maintainers are
willing to pick, I'd like to keep sending them within one patch series in
the next version. :)

Have a nice day, thanks a lot
Fei
