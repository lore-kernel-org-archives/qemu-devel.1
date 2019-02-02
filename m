Received: from eggs.gnu.org ([209.51.188.92]:54893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpnXu-0004AO-HK
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 00:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpnIm-0005PK-DR
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 23:53:13 -0500
Received: from m50-111.126.com ([123.125.50.111]:35693)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpnIj-0005MC-IJ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 23:53:10 -0500
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: fei <lifei1214@126.com>
Mime-Version: 1.0 (1.0)
Date: Sat, 2 Feb 2019 12:52:18 +0800
Message-Id: <EF6648C6-87F2-4E90-AE26-F377E1BE323D@126.com>
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-9-lifei1214@126.com>
	<87imy361hp.fsf@dusky.pond.sub.org>
In-Reply-To: <87imy361hp.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 08/11] qemu_thread: supplement
 error handling for qemu_signalfd_compat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com



> =E5=9C=A8 2019=E5=B9=B42=E6=9C=881=E6=97=A5=EF=BC=8C22:13=EF=BC=8CMarkus A=
rmbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Fei Li <lifei1214@126.com> writes:
>=20
>> From: Fei Li <shirley17fei@gmail.com>
>>=20
>> For qemu_signalfd_compat: set errno, do some cleanup, and return
>=20
> "For iothread_complete" is redundant, isn't it?
Yep, will remove it. Thanks for pointing this out. :)
>=20
>> -1 to replace the temporary &error_abort when failing to create
>> sigwait_compat.
>>=20
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Fei Li <shirley17fei@gmail.com>
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
Have a nice day
Fei=
