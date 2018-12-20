Received: from eggs.gnu.org ([2001:4830:134:3::10]:35805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZzKv-000770-2j
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZzGH-0008O3-Dz
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:25:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZzGG-0008MS-UP
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:25:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9C2789AE3
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 14:25:15 +0000 (UTC)
References: <20181220121100.21554-1-pbonzini@redhat.com>
	<490cbc41-0076-659a-9745-29881b9c95cc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9685dcbe-7236-c03d-47e9-9b1eb30d9a3c@redhat.com>
Date: Thu, 20 Dec 2018 15:25:02 +0100
MIME-Version: 1.0
In-Reply-To: <490cbc41-0076-659a-9745-29881b9c95cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/i386: Disable MPX support on named
 CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

On 20/12/18 15:18, Wainer dos Santos Moschetta wrote:
>=20
> On 12/20/2018 10:11 AM, Paolo Bonzini wrote:
>> MPX support is being phased out by Intel; GCC has dropped it, Linux
>> is also going to do that.=C2=A0 Even though KVM will have special code
>> to support MPX after the kernel proper stops enabling it in XCR0,
>> we probably also want to deprecate that in a few years.=C2=A0 As a sta=
rt,
>> do not enable it by default for any named CPU model starting with
>> the 4.0 machine types; this include Skylake, Icelake and Cascadelake.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> =C2=A0 include/hw/i386/pc.h | 29 +++++++++++++++++++++++++++++
>> =C2=A0 target/i386/cpu.c=C2=A0=C2=A0=C2=A0 | 14 +++++++-------
>> =C2=A0 2 files changed, 36 insertions(+), 7 deletions(-)
>=20
> Side question: I didn't find on QEMU's user manual any reference to
> deprecated features for CPU models. Does that information exists
> somewhere? If not, should it be documented for the users?

It's not deprecated yet, as it won't be removed until pc-*-3.1 is
deprecated.  It may be deprecated together with pc-*-3.1, or maybe not
since TCG does implement MPX.

Paolo
