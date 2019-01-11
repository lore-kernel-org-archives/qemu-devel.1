Received: from eggs.gnu.org ([209.51.188.92]:53392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpa@zytor.com>) id 1ghkJh-0006BQ-Qb
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpa@zytor.com>) id 1ghkJg-0002Nt-Fw
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:04:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49611 helo=mail.zytor.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpa@zytor.com>) id 1ghkJg-0002Lb-8R
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:04:52 -0500
Date: Thu, 10 Jan 2019 16:04:34 -0800
In-Reply-To: <51071cba-c18f-e491-4d92-6a40130584a7@redhat.com>
References: <8e67afb3-46b4-9d04-552f-740331165f8f@cisco.com>
	<51071cba-c18f-e491-4d92-6a40130584a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: hpa@zytor.com
Message-ID: <E963C278-B479-41A0-B150-D1DBECFBE9CD@zytor.com>
Subject: Re: [Qemu-devel] KVM serial8250: too much work for irq3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Denys Zagorui <dzagorui@cisco.com>
Cc: qemu-devel@nongnu.org

On January 10, 2019 3:44:54 PM PST, Paolo Bonzini <pbonzini@redhat=2Ecom> w=
rote:
>On 22/09/17 15:28, Denys Zagorui wrote:
>> Hello
>>=20
>> This is known issue, it was mentioned at first time about 9 years
>ago=2E
>>=20
>> https://lkml=2Eorg/lkml/2008/2/5/401
>>=20
>> https://bugzilla=2Eredhat=2Ecom/show_bug=2Ecgi?id=3D986761
>
>The issue is simply that QEMU disregards the baud rate that the guest
>programs into the serial port=2E  H=2E Peter Anvin's patch, which you
>mention, is only a band aid that is geared specifically at avoiding
>Linux's error=2E
>
>It was fixed for real in commit
>6936bfe514bbac7af4b24fad9ed9688b78b5be69
>by implementing a baud rate timer (May 2008), but then undone in
>fcfb4d6aae611d1f804d486d3c998000912c4c81 (March 2013) when the serial
>port got flow control support=2E
>
>Part of the reason may have been laziness, but also there are reasons
>to
>keep it this way=2E  Basically, the baud rate timer was implemented also
>in order to mitigate the problem with losing characters sent by the
>guest on the serial console; and thanks to flow control, QEMU will
>already slow down the transmit so that the other side never loses
>characters=2E  And because looking at logs on a serial console bps is
>slow
>and mildly annoying even at 115200 bps, it was decided that the "too
>much work" error was the lesser evil=2E
>
>Thanks,
>
>Paolo

In the case of the lesser evil it would seem that the hack I did would be =
good enough=2E

A hardware high bandwidth UART simulating device would have to do the best=
 same in some way=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
