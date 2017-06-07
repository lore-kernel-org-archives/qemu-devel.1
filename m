Received: from eggs.gnu.org ([2001:4830:134:3::10]:45298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIdBD-0003Ea-1i
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIdBC-0001B9-9k
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:47:31 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIdBC-0001B1-2X
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:47:30 -0400
Received: by mail-wm0-x234.google.com with SMTP id d73so14111721wma.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:47:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8229C6EB-56EA-475E-99D4-6D9B36B5D0A7@nutanix.com>
References: <20170607152825.12081-1-pbonzini@redhat.com>
	<20170607152825.12081-2-pbonzini@redhat.com>
	<CAFEAcA8CppP6YEPkGxVEyLnO=Kk1qirpGk2sh0bXedscxct8Jg@mail.gmail.com>
	<8229C6EB-56EA-475E-99D4-6D9B36B5D0A7@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 16:47:08 +0100
Message-ID: <CAFEAcA-r6uC0zO6uYH38XztZfWqLVphRUXA5ffgGw-cFKL+QHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 18/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 7 June 2017 at 16:39, Felipe Franciosi <felipe@nutanix.com> wrote:
>
>> On 7 Jun 2017, at 16:37, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On 7 June 2017 at 16:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> From: Felipe Franciosi <felipe@nutanix.com>
>>>
>>> This commit introduces a vhost-user device for SCSI. This is based
>>> on the existing vhost-scsi implementation, but done over vhost-user
>>> instead. It also uses a chardev to connect to the backend. Unlike
>>> vhost-scsi (today), VMs using vhost-user-scsi can be live migrated.
>>>
>>> To use it, start Qemu with a command line equivalent to:
>>>
>>> qemu-system-x86_64 \
>>>       -chardev socket,id=vus0,path=/tmp/vus.sock \
>>>       -device vhost-user-scsi-pci,chardev=vus0,bus=pci.0,addr=...
>>>
>>> A separate commit presents a sample application linked with libiscsi to
>>> provide a backend for vhost-user-scsi.
>>>
>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>>> Message-Id: <1488479153-21203-4-git-send-email-felipe@nutanix.com>
>>> [Disable migration for now, since it does not support bdrv_drain. - Paolo]
>>
>> I was expecting this to mean a VMStateDescription with a
>> ".unmigratable = 1" field, but it doesn't seem to have one.
>> Does it disable migration some other way?
>
> Hi Peter,
>
> vhost-user-scsi supports migration.

Paolo's change comment in the commit message quoted above
says it does not, which is what I was remarking on.

(Your original patches use register_savevm(), which is a function
that has just gone away. They'd need to use VMStateDescription
structs instead to support migration.)

thanks
-- PMM
