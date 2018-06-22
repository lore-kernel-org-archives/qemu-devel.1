Received: from eggs.gnu.org ([2001:4830:134:3::10]:33333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWFzk-00064o-VB
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 02:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWFzg-0007mS-4R
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 02:56:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45192 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fWFzf-0007ls-WB
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 02:56:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<87y3f8hyse.fsf@dusky.pond.sub.org>
	<CAJ+F1CKp_Q9eH84rB0O9btShLD1VOp2mKDiD0TEm7HHGNxJuug@mail.gmail.com>
Date: Fri, 22 Jun 2018 08:56:25 +0200
In-Reply-To: <CAJ+F1CKp_Q9eH84rB0O9btShLD1VOp2mKDiD0TEm7HHGNxJuug@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 21 Jun 2018
	19:18:19 +0200")
Message-ID: <87bmc3fgx2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/49] qapi: add #if pre-processor
 conditions to generated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Jun 21, 2018 at 6:47 PM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>> I think we can bite off a digestible part of this series:
>> target-independent top-level conditionals.  I think that's PATCH
>> 01-14,31 and applicable parts of 35-37.  The idea is to merge that part
>> quickly, then deal with the (less daunting) remainder.  Marc-Andr=C3=A9,=
 if
>> you agree with that plan, please respin just that part.  I can continue
>> review of the remainder without a rebase.
>>
>
> That's ok with me, I'll work on it.
> thanks

Great!

The next part could be target-dependend top-level conditionals, or
member conditionals (enum members are tied to union variants, which may
make further splitting impractical).  This series does members first.  I
guess we stick to that order to avoid unnecessary patch reordering work.
