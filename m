Received: from eggs.gnu.org ([2001:4830:134:3::10]:41329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHrjh-0002W2-55
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHrje-0002lP-PG
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:44:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHrjc-0002hs-O2
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:44:41 -0400
References: <20180718104836.18488-1-michael@walle.cc>
	<20180718104836.18488-2-michael@walle.cc>
	<34069906-b8f8-05da-477e-b2b81fc0fd58@redhat.com>
	<dcf671031ff70a7a18b65f5f7dd79f64@walle.cc>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf798e0a-0031-90ca-216c-c7364745b9bf@redhat.com>
Date: Wed, 31 Oct 2018 15:44:35 +0100
MIME-Version: 1.0
In-Reply-To: <dcf671031ff70a7a18b65f5f7dd79f64@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qtest: new functions for pulsed IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 31/10/2018 15:30, Michael Walle wrote:
>>
>> Just one thing, I think an atomic test-and-clear is a better API.=C2=A0=
 I
>> understand that what you have works, because
>> get_irq_latched+clear_irq_latch don't have any intervening access to t=
he
>> qtest socket.
>=20
> Ok thanks, like get_and_clear_irq_latched()? Do you think of we still
> need the get_irq_latched() to get the state without actually clearing
> it? I mean my simple test case won't need it, but there might be some
> cases where you may want peek at the state.

Maybe - it's easy enough to add it, so if your test doesn't need it you
can certainly leave it out.

Paolo
