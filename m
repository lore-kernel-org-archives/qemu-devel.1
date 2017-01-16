Received: from eggs.gnu.org ([2001:4830:134:3::10]:55187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTANL-0002q5-5E
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTANI-00047M-0m
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:43:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTANH-00045P-R0
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:43:15 -0500
References: <1482358659-4288-1-git-send-email-felipe@nutanix.com>
	<1482358659-4288-3-git-send-email-felipe@nutanix.com>
	<71ac8a1a-e527-0f99-120d-ad8386eecc8f@redhat.com>
	<1978274A-C134-4C88-9D3C-0C38A6DDDFA9@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <07592284-a3e2-190d-96b8-c2d0c955cd65@redhat.com>
Date: Mon, 16 Jan 2017 17:43:10 +0100
MIME-Version: 1.0
In-Reply-To: <1978274A-C134-4C88-9D3C-0C38A6DDDFA9@nutanix.com>
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



On 13/01/2017 01:31, Felipe Franciosi wrote:
>> Please place CONFIG_VHOST_USER_SCSI=$(CONFIG_POSIX) symbol in
>> default-configs/ (so that it is enabled by default on non-Windows hosts)
>> instead of having the configure option.  Otherwise, the patches look good!
>
> Which architectures would you like me to add this to? How about putting it in "pci.mak"?

I think it should be in every configuration that includes virtio-scsi.

> And when you say "instead", do you mean on top of? I imagine having a --disable switch is at least desirable, so I'd rather not remove the commands from 'configure'.

No, I really meant "instead".  Even though the default-configs/
mechanisms is not very user-friendly, having two ways to do
configuration is messy.  Generally --disable is left for features that
require a third-party library.

Paolo
