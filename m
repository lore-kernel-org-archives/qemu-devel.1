Received: from eggs.gnu.org ([2001:4830:134:3::10]:53650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJy4W-0000p2-Ba
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJxvW-0005Je-8s
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:45:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gJxvS-0005CZ-C0
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:45:36 -0500
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
	<1539894735-14232-4-git-send-email-pbonzini@redhat.com>
	<01124fd1-83b2-c0c8-21d7-1f031a21ff3b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <329ff5d5-77a2-66ba-8930-cce79f4b8085@redhat.com>
Date: Tue, 6 Nov 2018 10:45:23 +0100
MIME-Version: 1.0
In-Reply-To: <01124fd1-83b2-c0c8-21d7-1f031a21ff3b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 03/48] qemu-timer: introduce timer attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>

On 06/11/2018 00:16, Eric Blake wrote:
> On 10/18/18 3:31 PM, Paolo Bonzini wrote:
>> From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
>>
>> Attributes are simple flags, associated with individual timers for the=
ir
>> whole lifetime.=C2=A0 They intended to be used to mark individual time=
rs for
>> special handling when they fire.
>>
>> New/init functions family in timer interface updated and refactored (n=
ew
>> 'attribute' argument added, timer_list replaced with
>> timer_list_group+type
>> combinations, comments improved to avoid info duplication).=C2=A0 Also
>> existing
>> aio interface extended with attribute-enabled variants of functions,
>> which create/initialize timers.
>>
>> Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
>> Message-Id:
>> <f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisar=
enko@gmail.com>
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>=20
> git bisect points to this patch as the reason that 'make check' is
> failing for me with:

I think you have a stale file somewhere, because "git grep timer_init_tl
89a603a0c80ae3d6a8711571550b2ae9a01ea909" shows no occurrences.

Paolo
