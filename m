Received: from eggs.gnu.org ([2001:4830:134:3::10]:60406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1eyK9N-00080D-TB
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1eyK9K-00088T-Pl
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:30:13 -0400
Received: from mail-eopbgr30104.outbound.protection.outlook.com
	([40.107.3.104]:22169
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1eyK9J-00086l-B5
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:30:10 -0400
References: <41b63d9b-c551-4e22-28f5-1144724dff2e@virtuozzo.com>
	<b446d661-f0f1-2fcb-ada1-b08af58a9c27@redhat.com>
From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Message-ID: <618a6c6e-ab1a-1c55-d44d-847c0e3729f4@virtuozzo.com>
Date: Tue, 20 Mar 2018 19:30:04 +0300
MIME-Version: 1.0
In-Reply-To: <b446d661-f0f1-2fcb-ada1-b08af58a9c27@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Some thoughts about per-queue iothreads in
 VirtIOBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, "Denis V. Lunev" <den@openvz.org>


On 3/20/18 6:34 PM, Paolo Bonzini wrote:
> On 20/03/2018 15:45, Edgar Kaziakhmedov wrote:
>
>> As I understood from
>> Stefan description, it is expected to change significantly
>> the approach we use to interact with BlockDriverState.
> I don't think the change is very large actually, at least for on-disk
> devices.  I haven't yet considered network devices such as libiscsi or ceph.

Well, in that case, I will keep working on per-queue iothreads with an 
existing interface.
I asked because it might be reasonable to create BlockBackend device for 
each queue context and
use them independently to avoid some additional locks and 
synchronization. On the other hand, it can lead to multiple
opening of the same image, but as I said it doesn't seem to be a problem 
for the simplest formats such as raw.

>
> Paolo
> .
>
