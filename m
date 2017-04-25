Received: from eggs.gnu.org ([2001:4830:134:3::10]:43686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d2z4V-0006S4-Ac
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d2z4R-0000j2-TM
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:55:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1d2z4R-0000h3-Ki
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:55:51 -0400
References: <20170411101002.28451-1-maxime.coquelin@redhat.com>
	<20170411101002.28451-2-maxime.coquelin@redhat.com>
	<CAJ+F1CL8kK0XcMwueX8+kbDF=aVhBiRJ66gGoUNcUOmk=Yg7og@mail.gmail.com>
	<7dfc220c-b22b-bd7d-53af-caf49275b66c@redhat.com>
	<CAJ+F1C+SX0vqpAmyesgoyiWf1Fqncd6FaP2PemeUSHQq+GYLTw@mail.gmail.com>
	<58FDB1BD.4090601@intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <62b87247-b778-081f-c9c8-cb7bbc195987@redhat.com>
Date: Tue, 25 Apr 2017 13:55:40 +0200
MIME-Version: 1.0
In-Reply-To: <58FDB1BD.4090601@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Wei Wang <wei.w.wang@intel.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, mst@redhat.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, peterx@redhat.com, yuanhan.liu@linux.intel.com, virtio-comment@lists.oasis-open.org, qemu-devel@nongnu.org

Hi Wei,

On 04/24/2017 10:05 AM, Wei Wang wrote:
> On 04/14/2017 05:03 PM, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Tue, Apr 11, 2017 at 5:53 PM Maxime Coquelin=20
>> <maxime.coquelin@redhat.com <mailto:maxime.coquelin@redhat.com>> wrote=
:
>>
>>     Hi Marc-Andr=C3=A9,
>>
>>     On 04/11/2017 03:06 PM, Marc-Andr=C3=A9 Lureau wrote:
>>     > Hi
>>     >
>>     > On Tue, Apr 11, 2017 at 12:10 PM Maxime Coquelin
>>     > <maxime.coquelin@redhat.com <mailto:maxime.coquelin@redhat.com>
>>     <mailto:maxime.coquelin@redhat.com
>>     <mailto:maxime.coquelin@redhat.com>>> wrote:
>>     >
>>     >     This vhost-user specification update aims at enabling the
>>     >     slave to send requests to the master using a dedicated socke=
t
>>     >     created by the master.
>>     >
>>     >     It can be used for example when the slave implements a devic=
e
>>     >     IOTLB to send cache miss requests to the master.
>>     >
>>     >     The message types list is updated with an "Initiator" field =
to
>>     >     indicate for each type whether the master and/or slave can
>>     >     initiate the request.
>>     >
>>     >     Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com
>>     <mailto:maxime.coquelin@redhat.com>
>>     >     <mailto:maxime.coquelin@redhat.com
>>     <mailto:maxime.coquelin@redhat.com>>>
>>     >
>>     >
>>     > This is very similar to a patch I proposed for shutdown slave
>>     initiated
>>     > requests:
>>     > https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.h=
tml
>>
>>     Indeed, thanks for pointing this out, I wasn't aware of your serie=
s.
>>
>>     I find your proposal of having dedicated messages types
>>     (VHOST_USER_SLAVE_*) cleaner.
>>
>> ok
>>
>>     Are you ok if I handover your patch, and replace
>>     VHOST_USER_SET_SLAVE_FD to VHOST_USER_SET_SLAVE_REQ_FD?
>>
>>
>> They are very similar, I suggest you update your patch with the best=20
>> of both.
>>
>> I suppose you came to the same conclusion with me that trying to make=20
>> the communication both ways on the same fd would be quite difficult,=20
>> although it's a bit strange that the qemu implementation forces the=20
>> design of the protocol in some direction.
>> --=20
>>
>=20
> When would you get the implementation patch ready? Thanks.

I sent second version of the RFC on April 14th, which comprises the
implementation:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02467.html

Cheers,
Maxime
