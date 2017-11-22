Received: from eggs.gnu.org ([2001:4830:134:3::10]:43522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHW8k-0004Zu-Ch
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHW8f-00028D-Gh
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:36:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHW8f-000274-AP
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:36:33 -0500
References: <1510865080-32027-1-git-send-email-changpeng.liu@intel.com>
	<1510865080-32027-2-git-send-email-changpeng.liu@intel.com>
	<20171120162631.GK4516@stefanha-x1.localdomain>
	<20171120224001-mutt-send-email-mst@kernel.org>
	<776f5005-8bb8-773a-1f16-56b5675e7d74@redhat.com>
	<20171121051156-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e3d3c5a-c25d-3a0d-6bf5-b7b1db7c30b1@redhat.com>
Date: Wed, 22 Nov 2017 15:36:22 +0100
MIME-Version: 1.0
In-Reply-To: <20171121051156-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

On 21/11/2017 04:12, Michael S. Tsirkin wrote:
>> Fair enough, but I'd add nevertheless a 32-bit flags field to both
>> GET_CONFIG and SET_CONFIG, and document that the slave MUST check that
>> it is zero and otherwise fail.
>
> We generally just use protocol feature bits for extensions.
> But I have no problem with reserved padding if desired
> which seems to be what's described here.

Correct, you would still have a protocol feature bit, but the format
would be less susceptible to struct size changes which can simplify the
implementation a bit.

Paolo
