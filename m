Received: from eggs.gnu.org ([2001:4830:134:3::10]:53861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlBMt-00011F-3n
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlBMq-0003PB-0o
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:57:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dlBMp-0003OT-Qg
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:57:31 -0400
References: <20170824123006.GK5379@umbus.fritz.box>
	<20170825083123.47432-1-aik@ozlabs.ru>
	<4608a2c1-5c74-efea-d901-3b5cfa0519e6@redhat.com>
	<CAFEAcA_Z3wWv3_x0kCqD0tEwP=GTV-uoCLmUr5YpWjdD1GyMew@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e7817c4-4189-c620-e71c-d935076286ad@redhat.com>
Date: Fri, 25 Aug 2017 11:57:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Z3wWv3_x0kCqD0tEwP=GTV-uoCLmUr5YpWjdD1GyMew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] exec: Destroy dispatch immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 25/08/2017 11:22, Peter Maydell wrote:
> On 25 August 2017 at 09:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> The solution is to: 1) share the FlatView structures if they refer to
>> the same root memory region; 2) have one AddressSpaceDispatch per
>> FlatView instead of one per AddressSpace, so that FlatView reference
>> counting takes care of clearing the AddressSpaceDispatch too.  Neither
>> is particularly hard.
> If we did this we could get rid of address_space_init_shareable(),
> right? (It's a bit of a cheesy hack aimed at avoiding having duplicate
> address space structures for the same root memory region, but if
> the underlying code is better at not duplicating all the data
> structures unless necessary then the benefit of having the
> separate API goes away I think.)

Yes, indeed.

Paolo
