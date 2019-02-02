Received: from eggs.gnu.org ([209.51.188.92]:49512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpnHR-0001sS-1c
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 23:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpnHQ-0004XW-83
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 23:51:48 -0500
Received: from m50-111.126.com ([123.125.50.111]:34380)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpnHM-0004R9-JB
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 23:51:46 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: fei <lifei1214@126.com>
In-Reply-To: <877eej7gis.fsf@dusky.pond.sub.org>
Date: Sat, 2 Feb 2019 12:51:18 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <C66785C4-2ADD-4766-9FEF-1710A6AEF8EA@126.com>
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-8-lifei1214@126.com>
	<877eej7gis.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 07/11] qemu_thread: supplement
 error handling for iothread_complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>



> =E5=9C=A8 2019=E5=B9=B42=E6=9C=881=E6=97=A5=EF=BC=8C22:03=EF=BC=8CMarkus A=
rmbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Fei Li <lifei1214@126.com> writes:
>=20
>> From: Fei Li <fli@suse.com>
>>=20
>> For iothread_complete: utilize the existed errp to propagate the
>=20
> "For iothread_complete" is redundant, isn't it?
Emm, right. Will remove it in the next version.
>=20
>> error and do the corresponding cleanup to replace the temporary
>> &error_abort.
>>=20
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
Thanks!

Have a nice day
Fei=
