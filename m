Received: from eggs.gnu.org ([209.51.188.92]:59994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gjx3J-00015X-PN
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 21:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gjx3I-0001jO-Sj
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 21:05:05 -0500
Received: from m15-113.126.com ([220.181.15.113]:44474)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gjx3H-0001Zb-JX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 21:05:04 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: fei <lifei1214@126.com>
In-Reply-To: <20190116150022.GC2351@work-vm>
Date: Thu, 17 Jan 2019 10:04:47 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <2AC36351-1745-4C62-942A-BC1A37578D48@126.com>
References: <20190113140849.38339-1-lifei1214@126.com>
	<6aa36ba5-1784-b927-b75f-b56ec8d96d4c@gmail.com>
	<c32370f9-41c0-49a2-920f-e7cc984237cd@redhat.com>
	<20190116150022.GC2351@work-vm>
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/5] fix some segmentation faults
 and migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fei Li <shirley17fei@gmail.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org



> =E5=9C=A8 2019=E5=B9=B41=E6=9C=8816=E6=97=A5=EF=BC=8C23:00=EF=BC=8CDr. Dav=
id Alan Gilbert <dgilbert@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
>>> On 1/16/19 5:50 AM, Fei Li wrote:
>>> Hi all,
>>>=20
>>> Kindly ping. :)
>>>=20
>>> As my v10 of qemu_thread_create partly rely on this patch series, I'd
>>> like to know
>>> when will these 5 patches be merged, or I join them with v10 of
>>> qemu_thread_create
>>> and send together. Could anyone shed light on me? Thanks for the advice
>>> in advance.
>>=20
>> This series would get merged quicker if you include the maintainers :)
>>=20
>> $ ./scripts/get_maintainer.pl -f migration/*
>> Juan Quintela <quintela@redhat.com> (maintainer:Migration)
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> (maintainer:Migration)
>>=20
>> Doing that for you by responding to this mail.
>=20
> We can do it via migration now the set is complete.
>=20
> Dave
>=20
Thanks all! :)

Have a nice day
Fei
>>=20
>> Regards,
>>=20
>> Phil.
>>=20
>>>=20
>>>=20
>>> Have a nice day
>>> Fei
>>>> =E5=9C=A8 2019/1/13 =E4=B8=8B=E5=8D=8810:08, Fei Li =E5=86=99=E9=81=93:=

>>>> All these five patches have gotten the Reviewed-by: the first patch
>>>> is to fix one segmentation fault and the other four are to fix some
>>>> migration issues.
>>>>=20
>>>> To be more detail, they are extracted from previous
>>>> "[PATCH for-4.0 v9 16/16] qemu_thread_create: propagate errors to
>>>> callers to handle.", but actually these five patches are derivative
>>>> and not relevant to the mentioned qemu_thread_create patch series.
>>>> Thus send them separately to make them be merged earlier.
>>>>=20
>>>> Fei Li (5):
>>>>    Fix segmentation fault when qemu_signal_init fails
>>>>    migration: fix the multifd code when receiving less channels
>>>>    migration: multifd_save_cleanup() can't fail, simplify
>>>>    migration: add more error handling for postcopy_ram_enable_notify
>>>>    migration: unify error handling for process_incoming_migration_co
>>>>=20
>>>>   migration/channel.c      | 11 ++++++-----
>>>>   migration/migration.c    | 40 +++++++++++++++++++++------------------=
-
>>>>   migration/migration.h    |  2 +-
>>>>   migration/postcopy-ram.c |  1 +
>>>>   migration/ram.c          | 28 ++++++++++++++++++----------
>>>>   migration/ram.h          |  4 ++--
>>>>   migration/savevm.c       |  1 +
>>>>   util/main-loop.c         |  8 ++++----
>>>>   8 files changed, 54 insertions(+), 41 deletions(-)
>>>>=20
>>>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
