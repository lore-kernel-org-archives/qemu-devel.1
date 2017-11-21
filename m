Received: from eggs.gnu.org ([2001:4830:134:3::10]:56029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eGwEo-0000vf-5t
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eGwEj-0000P7-Tq
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:16:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eGwEj-0000Ou-NK
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:16:25 -0500
References: <1510865080-32027-1-git-send-email-changpeng.liu@intel.com>
	<1510865080-32027-2-git-send-email-changpeng.liu@intel.com>
	<20171120162631.GK4516@stefanha-x1.localdomain>
	<20171120224001-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <776f5005-8bb8-773a-1f16-56b5675e7d74@redhat.com>
Date: Tue, 21 Nov 2017 01:16:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171120224001-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

On 20/11/2017 21:44, Michael S. Tsirkin wrote:
> Live migrations is supposed to be migrating guest writeable state too.
> If you mean migrating RO fields like size, then
> I don't think it's a good idea to reuse SET_CONFIG for that.
> SET_CONFIG should obey exactly the virtio semantics.
> 
> And I agree, it should say that slave must treat it as a write,
> and get config as a read according to virtio semantics.
> 
> If someone needs to pass configuration from qemu to
> slave, let's add specific messages with precisely defined semantics.

Fair enough, but I'd add nevertheless a 32-bit flags field to both
GET_CONFIG and SET_CONFIG, and document that the slave MUST check that
it is zero and otherwise fail.

Paolo
