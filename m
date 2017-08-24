Received: from eggs.gnu.org ([2001:4830:134:3::10]:55038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dl01q-0004fs-Ac
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 17:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dl01m-0000Ex-Dl
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 17:51:06 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:37052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dl01m-0000Ec-7p
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 17:51:02 -0400
Received: by mail-io0-x243.google.com with SMTP id j99so461053ioo.4
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 14:51:02 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
Date: Thu, 24 Aug 2017 17:50:59 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <9CE89958-B59C-4D3C-91C5-ECB4B153C43D@gmail.com>
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
	<74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
	<60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
Subject: Re: [Qemu-devel] Make test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org


> On Aug 24, 2017, at 4:41 PM, Cleber Rosa <crosa@redhat.com> wrote:
>=20
>=20
>=20
> On 08/24/2017 03:10 PM, Programmingkid wrote:
>> I think 'make test' is an abandoned testing option for QEMU so this =
report might be unimportant. Here is my results for running 'make test':
>>=20
>> $ make test
>> make -C tests/tcg test
>>  LINK    test_path
>> Undefined symbols for architecture x86_64:
>>  "_buffer_is_zero", referenced from:
>>      _qemu_iovec_is_zero in test_path.o
>> ld: symbol(s) not found for architecture x86_64
>> clang: error: linker command failed with exit code 1 (use -v to see =
invocation)
>> make[1]: *** [test_path] Error 1
>> make: *** [test] Error 2
>>=20
>>=20
>=20
> I went through the same experience, and reported it (in the form of
> patches) here:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg00378.html
>=20
> Although it looks like you're clang, so it'd be nice to check if these
> fixes work for you too.
>=20
> Regards,
>=20
> --=20
> Cleber Rosa
> [ Sr Software Engineer - Virtualization Team - Red Hat ]
> [ Avocado Test Framework - avocado-framework.github.io ]
> [  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
>=20

Thank you for the patches. I will test them. I was wondering what is the =
point to having both 'make check' and 'make test'. It looks like =
everyone is using 'make check'. Maybe we are better off removing the =
'make test' target.
