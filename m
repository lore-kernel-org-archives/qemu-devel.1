Received: from eggs.gnu.org ([2001:4830:134:3::10]:50411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dUwhE-0007zG-VJ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dUwhA-0000Qy-6e
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dUwhA-0000QZ-0w
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:03:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BD48120FB
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 15:03:22 +0000 (UTC)
References: <20170706101611.27031-1-marcandre.lureau@redhat.com>
	<20170706101611.27031-7-marcandre.lureau@redhat.com>
	<c661a649-e438-e80b-baf4-b44ee6612ca3@redhat.com>
	<145552423.49242900.1499767479720.JavaMail.zimbra@redhat.com>
	<2f412e1e-88b2-9d30-db7e-0bd5e84b58e5@redhat.com>
	<1172399972.49364035.1499780122770.JavaMail.zimbra@redhat.com>
	<51e56450-313f-a9c1-b733-ea7ace838f8d@redhat.com>
	<1874757733.49371845.1499781500590.JavaMail.zimbra@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4b3a17ed-0cf5-fcf2-0938-f52f518c45e9@redhat.com>
Date: Tue, 11 Jul 2017 17:03:09 +0200
MIME-Version: 1.0
In-Reply-To: <1874757733.49371845.1499781500590.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/7] scripts/dump-guest-memory.py: add
 vmcoreinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, anderson@redhat.com, imammedo@redhat.com

On 07/11/17 15:58, Marc-Andr=C3=A9 Lureau wrote:

>>> How do you access a static inside a function? Gdb can look it up but
>>> complains that it's not in current context.
>>>
>>
>> According to <https://sourceware.org/gdb/onlinedocs/gdb/Variables.html=
>,
>> the magic incantation is
>>
>>   function::variable
>>
>=20
> Thanks that works! I'll update the patch

Great!

>=20
>> If this doesn't work (in case the realize function isn't on the stack =
at
>> all), then I agree the variable should be made file scope.
>>
>=20
> Why would it matter if realize is on the stack? It's likely not :)

I agree the realize function will likely not be on the stack, and I also
agree that it should not matter. However, the gdb docs seemed a bit
unclear to me regarding this, so I wasn't 100% sure without trying.

Thanks
Laszlo
