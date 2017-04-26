Received: from eggs.gnu.org ([2001:4830:134:3::10]:44504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3Oi2-0001cH-Fn
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3Oi1-0006Ab-6p
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:18:26 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3Oi1-0006AE-0E
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:18:25 -0400
Received: by mail-wr0-x235.google.com with SMTP id l9so2065380wre.1
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 08:18:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493119568-15218-9-git-send-email-jasowang@redhat.com>
References: <1493119568-15218-1-git-send-email-jasowang@redhat.com>
	<1493119568-15218-9-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 16:18:03 +0100
Message-ID: <CAFEAcA81uAqOZHiXBiQgrKO5Mziq47dRr=R_t5PLMV9qVxbSZw@mail.gmail.com>
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

On 25 April 2017 at 12:26, Jason Wang <jasowang@redhat.com> wrote:
> From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>
> Optimize two trace events as one, adjust print format make
> it easy to read. rename trace_colo_compare_pkt_info_src/dst
> to trace_colo_compare_tcp_info.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Hi. This commit has broken building with the UST backend,
because it is effectively reverting commit 2dfe5113b11,
which split this trace line into two events because the
UST backend has a limit on the number of arguments that
a UST event can take.

Could you revert it, please?

Travis failure log:
https://travis-ci.org/qemu/qemu/jobs/225628045

thanks
-- PMM
