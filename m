Received: from eggs.gnu.org ([2001:4830:134:3::10]:41874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dDv9A-0000CI-Au
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dDv97-0006ai-9d
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:57:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dDv97-0006ZD-3o
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:57:53 -0400
References: <20170524090520.321-1-maxime.coquelin@redhat.com>
	<20170525005724-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <3f613ef1-0d8b-3d68-ac9d-a3a5c019df26@redhat.com>
Date: Thu, 25 May 2017 17:57:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170525005724-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: pass message as a pointer
 to process_message_reply()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: zhiyong.yang@intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com, marcandre.lureau@redhat.com



On 05/24/2017 11:58 PM, Michael S. Tsirkin wrote:
> On Wed, May 24, 2017 at 11:05:20AM +0200, Maxime Coquelin wrote:
>> process_message_reply() was recently updated to get full message
>> content instead of only its request field.
>>
>> There is no need to copy all the struct content into the stack,
>> so just pass its pointer as const.
>>
>> Cc: Zhiyong Yang <zhiyong.yang@intel.com>
>> Fixes: 60cd11024f41 ("hw/virtio: fix vhost user fails to startup when MQ")
>> Reviewed-by: Jens Freimann <jfreiman@redhat.com>
>> Reviewed-by: Zhiyong Yang <zhiyong.yang@intel.com>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> 
> Why "Fixes"? It's not a bugfix, is it? Passing a pointer is
> slightly cleaner but it's not a big deal IMHO. I'll apply
> but would like to get clarification on this tag.

Right, this is not a bug fix.
I noticed this while rebasing my Vhost-user IOMMU series,
which will call this function much more often than currently.
That said, I haven't done any measurements, and I don't believe it
will have a noticeable impact.

Feel free to remove the "Fixes:" line when applying, or I can resend
if you prefer.

Maxime
