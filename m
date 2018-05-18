Received: from eggs.gnu.org ([2001:4830:134:3::10]:54635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJkRx-00074h-5p
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJkRw-0000TN-AD
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:49:57 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:33338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJkRw-0000S7-5v
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:49:56 -0400
Received: by mail-ot0-x243.google.com with SMTP id l22-v6so10268417otj.0
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 11:49:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <jpg1se87qru.fsf@linux.bootlegged.copy>
References: <20180507094448.32386-1-kraxel@redhat.com>
	<20180507094448.32386-2-kraxel@redhat.com>
	<CAFEAcA9Edg2pk0x05mvfDwa8F4OjKmG-WTcnt9v17o3YVPQiWg@mail.gmail.com>
	<jpgr2maq7rs.fsf@linux.bootlegged.copy>
	<jpga7swygak.fsf_-_@linux.bootlegged.copy>
	<CAFEAcA_QOHPbhmEAqaDvSVgBiktBkh06uA623bNzgK16msBAXQ@mail.gmail.com>
	<jpg1se87qru.fsf@linux.bootlegged.copy>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 19:49:35 +0100
Message-ID: <CAFEAcA-nkNNK3M+yboxZ4yY6Y2JESEHaAfKiy0hBv76MQoveVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: Assert on suspicious TYPE_DATA
 packet from initiator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 18 May 2018 at 19:38, Bandan Das <bsd@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 18 May 2018 at 19:22, Bandan Das <bsd@redhat.com> wrote:
>>>
>>> CID 1390604
>>> If the initiator sends a packet with TYPE_DATA set without
>>> initiating a CMD_GET_OBJECT_INFO first, then usb_mtp_get_data
>>> can trip on a null s->data_out.
>>>
>>> Signed-off-by: Bandan Das <bsd@redhat.com>
>>
>> I think you said this can be provoked by the guest?
>
> Yes, this can only be initated by the guest as far as I
> understand.
>
>> Misbehaving or malicious guests should never be able
>> to provoke assertions.
>
> I am not sure, I thought it's better to kill a misbehaving guest rather
> than silently letting it run. Anyway, it's possible to send a
> No_Valid_ObjectInfo as well and we wouldn't have to mark it as a
> false positive either.

Broadly speaking, where we're emulating hardware we should do
what the hardware does when the guest does wrong things to it.
A real server doesn't suddenly vanish leaving behind a
message saying "assertion failed" :-)

thanks
-- PMM
