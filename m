Received: from eggs.gnu.org ([2001:4830:134:3::10]:34498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d2Yy8-0007oR-Tz
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d2Yy5-0007vT-PL
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:03:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:57807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d2Yy5-0007vJ-HS
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:03:33 -0400
Message-ID: <58FDB1BD.4090601@intel.com>
Date: Mon, 24 Apr 2017 16:05:17 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20170411101002.28451-1-maxime.coquelin@redhat.com>
	<20170411101002.28451-2-maxime.coquelin@redhat.com>
	<CAJ+F1CL8kK0XcMwueX8+kbDF=aVhBiRJ66gGoUNcUOmk=Yg7og@mail.gmail.com>
	<7dfc220c-b22b-bd7d-53af-caf49275b66c@redhat.com>
	<CAJ+F1C+SX0vqpAmyesgoyiWf1Fqncd6FaP2PemeUSHQq+GYLTw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+SX0vqpAmyesgoyiWf1Fqncd6FaP2PemeUSHQq+GYLTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-comment] Re: [RFC 1/2] spec/vhost-user:
 Introduce secondary channel for slave initiated requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, peterx@redhat.com, yuanhan.liu@linux.intel.com, virtio-comment@lists.oasis-open.org, qemu-devel@nongnu.org

On 04/14/2017 05:03 PM, Marc-André Lureau wrote:
> Hi
>
> On Tue, Apr 11, 2017 at 5:53 PM Maxime Coquelin 
> <maxime.coquelin@redhat.com <mailto:maxime.coquelin@redhat.com>> wrote:
>
>     Hi Marc-André,
>
>     On 04/11/2017 03:06 PM, Marc-André Lureau wrote:
>     > Hi
>     >
>     > On Tue, Apr 11, 2017 at 12:10 PM Maxime Coquelin
>     > <maxime.coquelin@redhat.com <mailto:maxime.coquelin@redhat.com>
>     <mailto:maxime.coquelin@redhat.com
>     <mailto:maxime.coquelin@redhat.com>>> wrote:
>     >
>     >     This vhost-user specification update aims at enabling the
>     >     slave to send requests to the master using a dedicated socket
>     >     created by the master.
>     >
>     >     It can be used for example when the slave implements a device
>     >     IOTLB to send cache miss requests to the master.
>     >
>     >     The message types list is updated with an "Initiator" field to
>     >     indicate for each type whether the master and/or slave can
>     >     initiate the request.
>     >
>     >     Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com
>     <mailto:maxime.coquelin@redhat.com>
>     >     <mailto:maxime.coquelin@redhat.com
>     <mailto:maxime.coquelin@redhat.com>>>
>     >
>     >
>     > This is very similar to a patch I proposed for shutdown slave
>     initiated
>     > requests:
>     > https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.html
>
>     Indeed, thanks for pointing this out, I wasn't aware of your series.
>
>     I find your proposal of having dedicated messages types
>     (VHOST_USER_SLAVE_*) cleaner.
>
> ok
>
>     Are you ok if I handover your patch, and replace
>     VHOST_USER_SET_SLAVE_FD to VHOST_USER_SET_SLAVE_REQ_FD?
>
>
> They are very similar, I suggest you update your patch with the best 
> of both.
>
> I suppose you came to the same conclusion with me that trying to make 
> the communication both ways on the same fd would be quite difficult, 
> although it's a bit strange that the qemu implementation forces the 
> design of the protocol in some direction.
> -- 
>

When would you get the implementation patch ready? Thanks.

Best,
Wei
