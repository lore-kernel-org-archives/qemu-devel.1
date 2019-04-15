Received: from eggs.gnu.org ([209.51.188.92]:48826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hFsJj-0005QF-JX
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 23:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hFsJi-0002Mw-Mu
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 23:29:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hFsJi-0002MH-Cu
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 23:29:58 -0400
References: <1554391286-26981-1-git-send-email-mark.kanda@oracle.com>
	<20190405103105.c2ohp53bitfgamax@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c2f53410-b1ea-d2a4-d28a-ffb8f1ccdd6d@redhat.com>
Date: Mon, 15 Apr 2019 11:29:46 +0800
MIME-Version: 1.0
In-Reply-To: <20190405103105.c2ohp53bitfgamax@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] e1000: Never increment the RX undersize
 count register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, Mark Kanda <mark.kanda@oracle.com>
Cc: Chris Kenna <chris.kenna@oracle.com>, bhavesh.davda@oracle.com, qemu-devel@nongnu.org


On 2019/4/5 =E4=B8=8B=E5=8D=886:31, Stefano Garzarella wrote:
> On Thu, Apr 04, 2019 at 10:21:26AM -0500, Mark Kanda wrote:
>> From: Chris Kenna <chris.kenna@oracle.com>
>>
>> In situations where e1000 receives an undersized Ethernet frame,
>> QEMU increments the emulated "Receive Undersize Count (RUC)"
>> register when padding the frame.
>>
>> This is incorrect because this an expected scenario (e.g. with
>> VLAN tag stripping) and not an error. As such, QEMU should not
>> increment the emulated RUC.
>>
>> Fixes: 3b2743017749 ("e1000: Implementing various counters")
>>
>> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
>> Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
>> Signed-off-by: Chris Kenna <chris.kenna@oracle.com>
>> ---
>>   hw/net/e1000.c | 1 -
>>   1 file changed, 1 deletion(-)
> CCing Jason.
>
> LGTM, if we don't discard it, we shouldn't increase the RUC counter.
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
> Thanks,
> Stefano
>

Applied.

Thanks
