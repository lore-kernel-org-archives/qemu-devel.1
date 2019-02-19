Received: from eggs.gnu.org ([209.51.188.92]:36588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw5eN-000566-6L
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw5eL-0002wJ-8F
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:41:31 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-2-armbru@redhat.com>
	<095c8b8c-d33a-e972-d38f-b22b39d5c4b0@redhat.com>
Date: Tue, 19 Feb 2019 14:41:22 +0100
In-Reply-To: <095c8b8c-d33a-e972-d38f-b22b39d5c4b0@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	19 Feb 2019 13:49:13 +0100")
Message-ID: <87o977uc8t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/10] pflash: Rename pflash_t to
 PFlashCFI01, PFlashCFI02
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, lersek@redhat.com, mreitz@redhat.com, qemu-ppc@nongnu.org, alex.bennee@linaro.org

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/18/19 1:56 PM, Markus Armbruster wrote:
>> flash.h's incomplete struct pflash_t is completed both in
>> pflash_cfi01.c and in pflash_cfi02.c.  The complete types are
>> incompatible.  This can hide type errors, such as passing a pflash_t
>> created with pflash_cfi02_register() to pflash_cfi01_get_memory().
>>=20
>> Furthermore, POSIX reserves typedef names ending with _t.
>>=20
>> Rename the two structs to PFlashCFI01 and PFlashCFI02.
>
> Why not ParallelFlashCFIxx?

Feels a bit long, and we abbreviate to pflash pretty consistently.  That
said, I'm not particularly enamored with my choice of name :)

> Ideally ParallelFlashCFI would be an InterfaceInfo...

You mean TYPE_CFI_PFLASH0{1,2} should be children of an abstract parent?
