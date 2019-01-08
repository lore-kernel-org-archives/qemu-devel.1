Received: from eggs.gnu.org ([209.51.188.92]:39470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ggtmf-0000L6-Bz
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ggtmO-0000B2-Pr
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:59:07 -0500
Received: from m15-114.126.com ([220.181.15.114]:43509)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ggtmL-0008Q4-Ca
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:59:00 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: fei <lifei1214@126.com>
In-Reply-To: <878szwo1j6.fsf@dusky.pond.sub.org>
Date: Tue, 8 Jan 2019 23:58:54 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8A3E2AB-FEEB-4689-94AC-8147ED6AD77B@126.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-4-fli@suse.com>
	<878szwo1j6.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 03/16] migration: remove unused
 &local_err parameter in multifd_save_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>



> =E5=9C=A8 2019=E5=B9=B41=E6=9C=888=E6=97=A5=EF=BC=8C00:50=EF=BC=8CMarkus A=
rmbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Fei Li <fli@suse.com> writes:
>=20
>> Always call migrate_set_error() to set the error state without relying
>> on whether multifd_save_cleanup() succeeds.  As the passed &local_err
>> is never used in multifd_save_cleanup(), remove it. And make the
>> function be: void multifd_save_cleanup(void).
>>=20
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>=20
> The commit message is confusing.  Suggest:
>=20
>    migration: multifd_save_cleanup() can't fail, simplify
>=20
>    multifd_save_cleanup() takes an Error ** argument and returns an
>    error code even though it can't actually fail.  Its callers
>    dutifully check for failure.  Remove the useless argument and return
>    value, and simplify the callers.
Nice, thanks for the clearer comment. :)

Have a nice day=20
Fei
>=20
> I think multifd_load_cleanup() has exactly the same issue.  Should we
> clean it up, too?  Juan, what do you think?
