Received: from eggs.gnu.org ([209.51.188.92]:43516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDNLO-00044p-4c
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDNLN-0000kP-4D
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:01:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDNLM-0000jl-Sl
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24DDD8AE41
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 06:01:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190404071421.4891-1-thuth@redhat.com>
	<298ccbd7-9af5-8303-e42b-33dd1cb94b9e@redhat.com>
	<158fe22a-5781-73e5-5955-2fe9db019236@redhat.com>
	<3ba3c765-589f-4c0a-38dc-d9126f515e7b@redhat.com>
	<fda6bc0b-9ea0-2770-f104-568b3f16ab90@redhat.com>
	<265f98b8-675c-99fb-0ef8-0dcc13c14a91@redhat.com>
	<02729d68-9714-141b-b221-74ff31dca977@redhat.com>
Date: Mon, 08 Apr 2019 08:01:13 +0200
In-Reply-To: <02729d68-9714-141b-b221-74ff31dca977@redhat.com> (Paolo
	Bonzini's message of "Fri, 5 Apr 2019 09:58:21 +0200")
Message-ID: <87ef6djas6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/input/pckbd: The i8042 device should
 not be user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 04/04/19 22:49, Philippe Mathieu-Daud=C3=A9 wrote:
>> While I wonder if someone still use the r4k machine, I have more doubts
>> about users running with more the 2 -serial options...
>
> I sort of remember ISA extension cards that had jumpers or dip switches
> to choose between COM1/COM2/COM3/COM4...

They still exist, with I/O ports and IRQ lines selectable via jumpers &
DIP switches.  Traditionally:

    COM1: I/O port 0x3F8, IRQ 4
    COM2: I/O port 0x2F8, IRQ 3
    COM3: I/O port 0x3E8, IRQ 4
    COM4: I/O port 0x2E8, IRQ 3
