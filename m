Received: from eggs.gnu.org ([2001:4830:134:3::10]:41576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWL1X-0007QZ-Gc
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWL1W-0007EE-OD
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:18:43 -0400
References: <152966590354.870.11455841719190291898@d39dc562802a>
	<7de18b27-f711-3084-a073-0f9b490b8fbf@redhat.com>
	<CAFEAcA9xkxCBWp_RwOcs4p6eB-fVsjUEyewGCE6CdEAsAA8U3Q@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <552ade80-4287-6383-393d-dfb34fd3752a@redhat.com>
Date: Fri, 22 Jun 2018 14:18:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9xkxCBWp_RwOcs4p6eB-fVsjUEyewGCE6CdEAsAA8U3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/4] ARM SMMUv3: IOTLB Emulation and
 VHOST Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, jia.he@hxt-semitech.com, Jia He <hejianet@gmail.com>

Hi Peter,

On 06/22/2018 02:06 PM, Peter Maydell wrote:
> On 22 June 2018 at 12:33, Auger Eric <eric.auger@redhat.com> wrote:
> 
>>> /tmp/qemu-test/src/nbd/server.c: In function 'nbd_trip':
>>> /tmp/qemu-test/src/nbd/server.c:1980:19: error: 'end' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>>      *length = end - offset;
>>>                ~~~~^~~~~~~~
>>> /tmp/qemu-test/src/nbd/server.c:1940:30: note: 'end' was declared here
>>>      uint64_t begin = offset, end;
>>
>> Looks this does not relate to my series or do I miss something?
> 
> Yeah; a change in the nbd pullreq slipped through that confuses
> the elderly gcc in this patchew config.

ouch. sweat.

Thank you for the confirmation.

Eric
> 
> -- PMM
> 
