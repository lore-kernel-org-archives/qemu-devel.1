Received: from eggs.gnu.org ([2001:4830:134:3::10]:41260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d3ZB1-0007zW-24
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d3ZAx-0003dM-4Z
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:29:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d3ZAw-0003dG-Tq
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:28:59 -0400
References: <1493119568-15218-1-git-send-email-jasowang@redhat.com>
	<1493119568-15218-9-git-send-email-jasowang@redhat.com>
	<CAFEAcA81uAqOZHiXBiQgrKO5Mziq47dRr=R_t5PLMV9qVxbSZw@mail.gmail.com>
	<CAFEAcA8OxPhzymdFqRd78zVmLPkqXptXWUKYpmYahmwykGwamw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4c353e1f-dfeb-a482-1e0c-6799ca295beb@redhat.com>
Date: Thu, 27 Apr 2017 10:28:52 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8OxPhzymdFqRd78zVmLPkqXptXWUKYpmYahmwykGwamw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>



On 2017=E5=B9=B404=E6=9C=8826=E6=97=A5 23:55, Peter Maydell wrote:
> On 26 April 2017 at 16:18, Peter Maydell <peter.maydell@linaro.org> wro=
te:
>> On 25 April 2017 at 12:26, Jason Wang <jasowang@redhat.com> wrote:
>>> From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>
>>> Optimize two trace events as one, adjust print format make
>>> it easy to read. rename trace_colo_compare_pkt_info_src/dst
>>> to trace_colo_compare_tcp_info.
>>>
>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> Hi. This commit has broken building with the UST backend,
>> because it is effectively reverting commit 2dfe5113b11,
>> which split this trace line into two events because the
>> UST backend has a limit on the number of arguments that
>> a UST event can take.
>>
>> Could you revert it, please?
> ...actually it looks like it reverts cleanly on master, so
> I'll just revert it directly.
>
> thanks
> -- PMM
>

Zheng Chen, consider the UST limitation, I think we can just leave the=20
two tracepoints as is (of course you can improve readability).

Thanks
