Received: from eggs.gnu.org ([2001:4830:134:3::10]:54479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3PIj-0003pX-TX
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3PIi-0001GB-Pg
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:56:21 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:33546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3PIi-0001Fm-Hv
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:56:20 -0400
Received: by mail-wm0-x22a.google.com with SMTP id i137so27648wmf.0
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 08:56:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81uAqOZHiXBiQgrKO5Mziq47dRr=R_t5PLMV9qVxbSZw@mail.gmail.com>
References: <1493119568-15218-1-git-send-email-jasowang@redhat.com>
	<1493119568-15218-9-git-send-email-jasowang@redhat.com>
	<CAFEAcA81uAqOZHiXBiQgrKO5Mziq47dRr=R_t5PLMV9qVxbSZw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 16:55:58 +0100
Message-ID: <CAFEAcA8OxPhzymdFqRd78zVmLPkqXptXWUKYpmYahmwykGwamw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

On 26 April 2017 at 16:18, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 25 April 2017 at 12:26, Jason Wang <jasowang@redhat.com> wrote:
>> From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>
>> Optimize two trace events as one, adjust print format make
>> it easy to read. rename trace_colo_compare_pkt_info_src/dst
>> to trace_colo_compare_tcp_info.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Hi. This commit has broken building with the UST backend,
> because it is effectively reverting commit 2dfe5113b11,
> which split this trace line into two events because the
> UST backend has a limit on the number of arguments that
> a UST event can take.
>
> Could you revert it, please?

...actually it looks like it reverts cleanly on master, so
I'll just revert it directly.

thanks
-- PMM
