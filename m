Received: from eggs.gnu.org ([2001:4830:134:3::10]:58860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cfsSQ-0004bt-Gj
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cfsSN-0001IM-DI
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:13:06 -0500
Received: from mail-db5eur01on0139.outbound.protection.outlook.com
	([104.47.2.139]:18896
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cfsSM-0001Fg-U7
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:13:03 -0500
References: <1487266760-80500-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1487266760-80500-2-git-send-email-anton.nefedov@virtuozzo.com>
	<6882690d-5972-8b42-61ad-302531dc6d7e@redhat.com>
	<1cc2dad1-8ffd-0b7a-1a2a-881db663488f@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <bfa8ba02-23a1-a30e-4d8a-8a86ed5943fe@openvz.org>
Date: Mon, 20 Feb 2017 19:12:48 +0100
MIME-Version: 1.0
In-Reply-To: <1cc2dad1-8ffd-0b7a-1a2a-881db663488f@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qmp-events: fix GUEST_PANICKED description
 formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 02/20/2017 07:10 PM, Paolo Bonzini wrote:
>
> On 16/02/2017 20:36, Eric Blake wrote:
>> On that grounds, you already need the 'if (info)' for more than just t=
he
>> free, so this code motion is no longer quite as important.  But now I'=
m
>> noticing that it looks weird because you are freeing an input paramete=
r.
>>  Generally, transfer semantics like that are screwy - it's probably
>> better if the caller of qemu_system_guest_panicked() is the one freein=
g
>> info, rather than requiring that the caller pass in malloc'd memory th=
at
>> gets freed as a side effect and must not be referenced afterwards in t=
he
>> caller.  In other words, I think the code motion is unnecessary, but
>> that the qapi_free_GuestPanicInformation() call is probably in the wro=
ng
>> function to begin with.
> Even better then would be to just pass a CPUState* and let
> qemu_system_guest_panicked get the GuestPanicInformation via the QOM
> property.
>
> But for 2.9, we only need to change the union.  Eric, can you do that
> for us since my QAPI-fu is limited?
>
> Paolo
>
give me 5 minutes, I have patches for that, received them today.

Den
