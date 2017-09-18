Received: from eggs.gnu.org ([2001:4830:134:3::10]:59922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dtxMf-0004Mk-Vi
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dtxMc-00026B-QM
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:49:38 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:37999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dtxMc-00024w-Ks
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:49:34 -0400
Received: by mail-it0-x244.google.com with SMTP id 85so686933ith.5
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 07:49:33 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170918092811.GB2951@redhat.com>
Date: Mon, 18 Sep 2017 10:49:30 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7EDAC47-6D42-47FE-91C5-D52AECB1DD79@gmail.com>
References: <E7665638-9EE7-45B0-AF95-BC37863AC0DA@gmail.com>
	<20170918092811.GB2951@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 08/12] char: convert the escc device to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Sep 18, 2017, at 5:28 AM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> On Fri, Sep 15, 2017 at 02:32:14PM -0400, Programmingkid wrote:
>> Sorry but I saw this error when I tried your patches:
>>=20
>>  OBJC    ui/cocoa.o
>>  CC      ui/curses.o
>> ui/input-keymap.c:17:10: fatal error: =
'ui/input-keymap-qcode-to-sun.c' file not
>>      found
>> #include "ui/input-keymap-qcode-to-sun.c"
>>         ^
>> 1 error generated.
>> make: *** [ui/input-keymap.o] Error 1
>> make: *** Waiting for unfinished jobs....
>>=20
>>=20
>> I could not find this file.
>=20
> Yes, its a bug in this series - just build without the sparc system
> emulators to avoid it.

I did not build with the spare system emulator. My configure command =
looks like this:
./configure --target-list=3Di386-softmmu,ppc-softmmu

Thank you.=
