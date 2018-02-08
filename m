Received: from eggs.gnu.org ([2001:4830:134:3::10]:59805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ejmqW-00079R-2W
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ejmqO-0005zs-JE
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:06:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42744 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ejmqO-0005zg-Cj
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:06:32 -0500
References: <20180205102659.60552-1-marcel@redhat.com>
	<CAFEAcA8OO7jEeAe5UWKBqSb_+tap7OVM2YxEsqWDVZV8jN7cmA@mail.gmail.com>
	<51f8addc-8c6c-4532-1a59-b4c0098f6c68@redhat.com>
	<CAFEAcA8DCbrY-8efHAv9156oyOzwUacjcu9L9xGaoPGpkBObkg@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <60046441-8bf6-813d-f4cc-b850f55c22bf@redhat.com>
Date: Thu, 8 Feb 2018 16:06:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8DCbrY-8efHAv9156oyOzwUacjcu9L9xGaoPGpkBObkg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, yuval.shaia@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, dotanb@mellanox.com

On 08/02/2018 15:54, Peter Maydell wrote:
> On 8 February 2018 at 13:38, Marcel Apfelbaum <marcel@redhat.com> wrote:
>> Hi Peter,
>>
>> On 08/02/2018 14:59, Peter Maydell wrote:
>>> (3) Some of the new headers use kernel-internals __u32 etc types.
>>> This isn't portable. ('HACKING' has some suggestions for types you
>>> might want instead.)
>>>
>>
>> We do not "use" the __u32 types, we just copied a kernel file
>> for structures used for communication between the guest driver
>> and the QEMU code. We had a look on how it is done and
>> we use the model that adds macros __u32 -> uint32_t,
>> so the "__types" do not really create such problems.
> 
> If we're using kernel header files, I would recommend using
> the scripts/update-headers machinery for this, the way we do
> for other kernel headers. Among other things, the cp_portable
> function in that script will fix up the type names for you.
> 

I will use the mechanism.
Thanks,
Marcel

> thanks
> -- PMM
> 
