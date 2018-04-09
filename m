Received: from eggs.gnu.org ([2001:4830:134:3::10]:54650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5ar7-00018e-5G
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5ar6-0008KX-3X
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:45:25 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:34691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5ar5-0008Jr-R9
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:45:23 -0400
Received: by mail-ot0-x22e.google.com with SMTP id m7-v6so9599646otd.1
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 10:45:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cff268ec-b55a-3bcc-0ced-a4feca36dd37@redhat.com>
References: <1523285990-37457-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA_uDg+7U=5++9MVU1WXz6V28Tb-c-bi2UK4cgOHMOts1g@mail.gmail.com>
	<cff268ec-b55a-3bcc-0ced-a4feca36dd37@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Apr 2018 18:45:02 +0100
Message-ID: <CAFEAcA_=k+zvTrRYcjNSGNxTs0FY7tz92Xaa=Wr2QpL-6TSpNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/20] Miscellaneous patches for QEMU
 2.12-rc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 April 2018 at 18:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 09/04/2018 19:21, Peter Maydell wrote:
>> On 9 April 2018 at 15:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> The following changes since commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca62d:
>>>
>>>   Update version for v2.12.0-rc2 release (2018-04-04 20:37:20 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>>
>>> for you to fetch changes up to e0014d4b3a955cfd8d517674703bfa87f340290a:
>>>
>>>   Add missing bit for SSE instr in VEX decoding (2018-04-09 16:36:40 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Miscellaneous bugfixes, including crash fixes from Alexey, Peter M. and
>>> Thomas.
>>>
>>> ----------------------------------------------------------------
>>
>> SPARC guest boottest, SPARC host:
>>
>> TEST: tests/boot-serial-test... (pid=99658)
>>   /sparc/boot-serial/LX:                                               **
>> ERROR:/srv/pm215/qemu/tests/boot-serial-test.c:139:check_guest_output:
>> assertion failed: (output_ok)
>> FAIL
>> GTester: last random seed: R02Sec8351c4b01f899a24e5f71f6615a712
>> (pid=100565)
>>   /sparc/boot-serial/SS-4:                                             **
>> ERROR:/srv/pm215/qemu/tests/boot-serial-test.c:139:check_guest_output:
>> assertion failed: (output_ok)
>> FAIL
>> GTester: last random seed: R02Scdc4c1568274a87c76f6e37e7c72f44b
>> (pid=101395)
>>   /sparc/boot-serial/SS-600MP:                                         OK
>> FAIL: tests/boot-serial-test
>>
>> Apparently intermittent, I did a couple of by-hand reruns of
>> that test case and they were fine...
>
> What about before my patch?

Yes, I think we've seen this particular intermittent before;
eg https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg04003.html
though that was on a different host.

thanks
-- PMM
