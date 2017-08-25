Received: from eggs.gnu.org ([2001:4830:134:3::10]:49352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dlCQQ-0004Nd-3T
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dlCQK-0007OE-3o
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:05:18 -0400
MIME-Version: 1.0
In-Reply-To: <20170824211506.iygynkpevxemsyg2@postretch>
References: <20170822101535.4695-1-el13635@mail.ntua.gr>
	<20170822101535.4695-7-el13635@mail.ntua.gr>
	<20170824184308.GD4368@stefanha-x1.localdomain>
	<20170824211506.iygynkpevxemsyg2@postretch>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 25 Aug 2017 12:05:10 +0100
Message-ID: <CAJSP0QWN3R=kd9299ziiHa3OEdPGGvM+1M6ZO1hkjKEgvnFmoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 6/6] qemu-iotests: add 184 for throttle
 filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

On Thu, Aug 24, 2017 at 10:15 PM, Manos Pitsidianakis
<el13635@mail.ntua.gr> wrote:
> On Thu, Aug 24, 2017 at 07:43:08PM +0100, Stefan Hajnoczi wrote:
>>
>> On Tue, Aug 22, 2017 at 01:15:35PM +0300, Manos Pitsidianakis wrote:
>>>
>>> +_supported_fmt qcow2
>>
>>
>> What makes this test qcow2-specific?  With additional filtering for
>> IMGFMT it should be possible to run this on any image format.
>
>
> I think none of the available filters hide all of the image details in
> query-block and company. _filter_imgfmt hides the image extensions but not
> the image specific fields (eg virtual-size, actual-size and
> format-specific). Perhaps a new filter that hides everything but "format"
> and "filename" in the "image" subdict can be introduced later.

It's a little cumbersome to filter JSON in shell.  The filters do not
use jq(1) at the moment.

Tests written in Python have an easier time of filtering certain
fields.  I did that recently for QMP Event objects in 194.

Anyway, it's okay to keep this test qcow2-only for now.

Stefan
