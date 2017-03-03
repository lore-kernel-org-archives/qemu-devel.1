Received: from eggs.gnu.org ([2001:4830:134:3::10]:35945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjlzJ-0003Bd-OV
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjlzI-0007Xl-NT
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:07:09 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjlzI-0007Xh-GJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:07:08 -0500
Received: by mail-wm0-x235.google.com with SMTP id t193so13720857wmt.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 04:07:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <11a4ab90-650e-7f88-504c-d5ae3e6c5c94@redhat.com>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
	<11a4ab90-650e-7f88-504c-d5ae3e6c5c94@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 12:06:46 +0000
Message-ID: <CAFEAcA_KqCnxGprcz8yTYwANVqb73Jtm8aU6gXwmDD_P6N7XGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] A few VLAN-related bugfixes for RX
 packet abstraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Dmitry Fleytman <dmitry@daynix.com>, QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>, P J P <ppandit@redhat.com>

On 17 February 2017 at 03:04, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2017=E5=B9=B402=E6=9C=8816=E6=97=A5 20:29, Dmitry Fleytman wrote:
>>
>> This series fix a few issues related
>> to processing of RX packets with VLAN headers.
>>
>> See commit messages of specific patches
>> for information regarding affected devices.
>>
>> Dmitry Fleytman (5):
>>    eth: Extend vlan stripping functions
>>    NetRxPkt: Fix memory corruption on VLAN header stripping
>>    NetRxPkt: Do not try to pull more data than present
>>    NetRxPkt: Account buffer with ETH header in IOV length
>>    NetRxPkt: Remove code duplication in net_rx_pkt_pull_data()
>>
>>   hw/net/net_rx_pkt.c | 40 +++++++++++++++++++++-------------------
>>   include/net/eth.h   |  4 ++--
>>   net/eth.c           | 25 ++++++++++++++-----------
>>   3 files changed, 37 insertions(+), 32 deletions(-)
>>
>
> Applied. Thanks

Hi Jason -- what's the status of these patches? I don't
see them in master and I don't think you have them in a pull
request yet (though I may have missed it in the deluge of
freeze-deadline pulls...)

thanks
-- PMM
