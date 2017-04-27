Received: from eggs.gnu.org ([2001:4830:134:3::10]:51836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d3ZVD-0004wp-HB
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d3ZVA-0005Zf-Ev
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:49:55 -0400
Received: from [59.151.112.132] (port=24875 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d3ZVA-0005QQ-3W
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:49:52 -0400
References: <1493119568-15218-1-git-send-email-jasowang@redhat.com>
	<1493119568-15218-9-git-send-email-jasowang@redhat.com>
	<CAFEAcA81uAqOZHiXBiQgrKO5Mziq47dRr=R_t5PLMV9qVxbSZw@mail.gmail.com>
	<CAFEAcA8OxPhzymdFqRd78zVmLPkqXptXWUKYpmYahmwykGwamw@mail.gmail.com>
	<4c353e1f-dfeb-a482-1e0c-6799ca295beb@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <68c0c7e9-3185-dc23-6d84-d367b660b778@cn.fujitsu.com>
Date: Thu, 27 Apr 2017 10:50:23 +0800
MIME-Version: 1.0
In-Reply-To: <4c353e1f-dfeb-a482-1e0c-6799ca295beb@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL V2 8/8] COLO-compare: Optimize tcp compare
 trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: zhangchen.fnst@cn.fujitsu.com, QEMU Developers <qemu-devel@nongnu.org>



On 04/27/2017 10:28 AM, Jason Wang wrote:
>
>
> On 2017年04月26日 23:55, Peter Maydell wrote:
>> On 26 April 2017 at 16:18, Peter Maydell <peter.maydell@linaro.org> 
>> wrote:
>>> On 25 April 2017 at 12:26, Jason Wang <jasowang@redhat.com> wrote:
>>>> From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>>
>>>> Optimize two trace events as one, adjust print format make
>>>> it easy to read. rename trace_colo_compare_pkt_info_src/dst
>>>> to trace_colo_compare_tcp_info.
>>>>
>>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> Hi. This commit has broken building with the UST backend,
>>> because it is effectively reverting commit 2dfe5113b11,
>>> which split this trace line into two events because the
>>> UST backend has a limit on the number of arguments that
>>> a UST event can take.
>>>
>>> Could you revert it, please?
>> ...actually it looks like it reverts cleanly on master, so
>> I'll just revert it directly.
>>
>> thanks
>> -- PMM
>>
>
> Zheng Chen, consider the UST limitation, I think we can just leave the 
> two tracepoints as is (of course you can improve readability).

OK, I will send a independent patch to improve readability.

Thanks
Zhang Chen

>
> Thanks
>
>
>

-- 
Thanks
Zhang Chen
