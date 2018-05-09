Received: from eggs.gnu.org ([2001:4830:134:3::10]:50063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fH42x-0002N1-E7
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fH42s-0002B2-Gk
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:09:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fH42s-0002At-B8
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:08:58 -0400
References: <fe42db47-7e7c-3ec5-ab5f-8e8653554a74@amsat.org>
	<c4082565-98f0-7bd7-4409-45af9d8823fb@redhat.com>
	<30ad3bab7ecc6acd713da0d945d35681@walle.cc>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0408ef88-bdcd-95ed-f8bc-75381d5fade1@redhat.com>
Date: Wed, 9 May 2018 17:57:44 +0200
MIME-Version: 1.0
In-Reply-To: <30ad3bab7ecc6acd713da0d945d35681@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] lm32: tcg_handle_interrupt: assertion failed:
 (qemu_mutex_iothread_locked())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 09/05/2018 17:06, Michael Walle wrote:
>>
>> All these calls into lm32_pic.c need to take the BQL.=C2=A0 They are a=
ll
>> wrong, but this one was unlucky (or lucky) enough to be caught.
>>
>> Paolo
>=20
> my patch [1] from the beginning of this year just take the lock in
> op_helper.c.

Yes, I agree that's the best way to do it.

> The only other places are the gdbstub.c and
> lm32_cpu_dump_state(). So these are still missing, right?

Those should be called with BQL taken.

Paolo

>=20
> -michael
>=20
> [1] http://lists.gnu.org/archive/html/qemu-devel/2018-01/msg01598.html
