Received: from eggs.gnu.org ([2001:4830:134:3::10]:39768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWKqX-0000x7-JO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWKqW-0002gU-TB
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:07:21 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWKqW-0002gM-OI
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:07:20 -0400
Received: by mail-ot0-x244.google.com with SMTP id c15-v6so7245985otl.3
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 05:07:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7de18b27-f711-3084-a073-0f9b490b8fbf@redhat.com>
References: <152966590354.870.11455841719190291898@d39dc562802a>
	<7de18b27-f711-3084-a073-0f9b490b8fbf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:06:59 +0100
Message-ID: <CAFEAcA9xkxCBWp_RwOcs4p6eB-fVsjUEyewGCE6CdEAsAA8U3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Auger Eric <eric.auger@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, jia.he@hxt-semitech.com, Jia He <hejianet@gmail.com>

On 22 June 2018 at 12:33, Auger Eric <eric.auger@redhat.com> wrote:

>> /tmp/qemu-test/src/nbd/server.c: In function 'nbd_trip':
>> /tmp/qemu-test/src/nbd/server.c:1980:19: error: 'end' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>      *length = end - offset;
>>                ~~~~^~~~~~~~
>> /tmp/qemu-test/src/nbd/server.c:1940:30: note: 'end' was declared here
>>      uint64_t begin = offset, end;
>
> Looks this does not relate to my series or do I miss something?

Yeah; a change in the nbd pullreq slipped through that confuses
the elderly gcc in this patchew config.

-- PMM
