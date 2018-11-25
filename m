Received: from eggs.gnu.org ([2001:4830:134:3::10]:47099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQjAM-00027i-Kr
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 20:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQjAJ-0006AN-IY
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 20:24:54 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:38035)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQjAI-00063z-Rq
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 20:24:51 -0500
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-23-maozhongyi@cmss.chinamobile.com>
	<20181119233139.GO3807@habkost.net>
	<bb601691-a96d-8968-bb5b-0b15757285f6@cmss.chinamobile.com>
	<20181123181638.GO18284@habkost.net>
	<CAFEAcA8rcxJFtHxDJzcNurOoB7kAktNTFRbesy71Y=sEqsr5DQ@mail.gmail.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <79fa2496-65fb-89c3-6993-fe5f9b0a97ec@cmss.chinamobile.com>
Date: Sun, 25 Nov 2018 09:24:31 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8rcxJFtHxDJzcNurOoB7kAktNTFRbesy71Y=sEqsr5DQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/22] core/sysbus: remove the
 SysBusDeviceClass::initpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>



On 11/24/18 2:19 AM, Peter Maydell wrote:
> On Fri, 23 Nov 2018 at 18:16, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> I think this is good enough for now (as long as there's a comment
>> like Peter suggested).  Allowing parent_realize to be NULL would
>> be inconvenient to all code that uses parent_realize today.

It was done in v2, please review.

>>
>> Personally, I would love to get rid of parent_realize entirely.
>> We could simply provide a helper to let device subclasses call
>> the parent's realize function without the need to copy function
>> pointers around.

well, I will do it later.

> 
> Agreed -- parent_realize is a hack that is working around
> a deficiency in our object model, and it would be nice to
> deal with that. But let's do our cleanups one at a time :-)

OK, I see.

Thanks,
Mao

> 
> thanks
> -- PMM
> 
