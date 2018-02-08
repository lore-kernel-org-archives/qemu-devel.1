Received: from eggs.gnu.org ([2001:4830:134:3::10]:60197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ejmrb-0008VR-CY
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ejmrY-0006Rj-7o
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:07:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ejmrY-0006Ra-3Q
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:07:44 -0500
References: <20180205102659.60552-1-marcel@redhat.com>
	<CAFEAcA8OO7jEeAe5UWKBqSb_+tap7OVM2YxEsqWDVZV8jN7cmA@mail.gmail.com>
	<51f8addc-8c6c-4532-1a59-b4c0098f6c68@redhat.com>
	<20180208155418-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <0e80441d-6a29-6339-d208-3281eafc16d1@redhat.com>
Date: Thu, 8 Feb 2018 16:07:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180208155418-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/4] RDMA patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, yuval.shaia@oracle.com, dotanb@mellanox.com

On 08/02/2018 15:58, Michael S. Tsirkin wrote:
> On Thu, Feb 08, 2018 at 03:38:59PM +0200, Marcel Apfelbaum wrote:
>> We do not "use" the __u32 types, we just copied a kernel file
>> for structures used for communication between the guest driver
>> and the QEMU code. We had a look on how it is done and
>> we use the model that adds macros __u32 -> uint32_t,
>> so the "__types" do not really create such problems.
> 
> I don't think this is done like this anywhere in code.

It is used in vmxnet.

> Please take a look at how it's done for e.g. input.h
> 

I will use it as reference.

> I think that whenever a rule in HACKING, coding style,
> etc is ignored it should be accompanied by motivation
> in code comments, so this won't spread out any more.
> 

Agreed, I will update the code accordingly.
Thanks,
Marcel
