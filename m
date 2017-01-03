Received: from eggs.gnu.org ([2001:4830:134:3::10]:48099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOLSe-0004Cz-5J
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOLSb-0008Kn-2q
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:32:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cOLSa-0008Kj-TE
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:32:49 -0500
References: <1482358659-4288-1-git-send-email-felipe@nutanix.com>
	<1482358659-4288-3-git-send-email-felipe@nutanix.com>
	<71ac8a1a-e527-0f99-120d-ad8386eecc8f@redhat.com>
	<32782693-D91F-4920-82B5-FBE7AC22B739@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cb1de694-c254-266e-016e-4bae883a5207@redhat.com>
Date: Tue, 3 Jan 2017 10:32:43 +0100
MIME-Version: 1.0
In-Reply-To: <32782693-D91F-4920-82B5-FBE7AC22B739@nutanix.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] vus: Introduce vhost-user-scsi host
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 02/01/2017 19:07, Felipe Franciosi wrote:
> 
>> On 2 Jan 2017, at 10:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>
>>
>> On 21/12/2016 23:17, Felipe Franciosi wrote:
>>> To use it, one must configure Qemu with --enable-vhost-user-scsi and
>>> start Qemu with a command line equivalent to:
>>>
>>> qemu-system-x86_64 \
>>>       -chardev socket,id=vus0,path=/tmp/vus.sock \
>>>       -device vhost-user-scsi-pci,chardev=vus0,bus=pci.0,addr=...
>>>
>>> A separate commit presents a sample application linked with libiscsi to
>>> provide a backend for vhost-user-scsi.
>>
>> Please place CONFIG_VHOST_USER_SCSI=$(CONFIG_POSIX) symbol in
>> default-configs/ (so that it is enabled by default on non-Windows hosts)
>> instead of having the configure option.  Otherwise, the patches look good!
> 
> Thanks, will do that and send a v4.
> 
> Do you want any entries on MAINTAINERS for this code or are you happy to take care of it under hw/scsi/* ?

It's okay to have it under hw/scsi/*.

Paolo
