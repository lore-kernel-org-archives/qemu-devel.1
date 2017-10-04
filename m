Received: from eggs.gnu.org ([2001:4830:134:3::10]:40787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzjKN-0006aF-Ki
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzjKI-00014F-3D
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:03:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-6-armbru@redhat.com>
	<CAJ+F1CLNTLXrqBWVCwvfHuGpC6fzpHB1QvnxSP3-D0j+oY+bJw@mail.gmail.com>
Date: Wed, 04 Oct 2017 15:02:53 +0200
In-Reply-To: <CAJ+F1CLNTLXrqBWVCwvfHuGpC6fzpHB1QvnxSP3-D0j+oY+bJw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 4 Oct 2017
	12:12:45 +0200")
Message-ID: <87bmlnm5fm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/8] qemu-options: Add missing -iscsi
 Texinfo documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, QEMU <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Mon, Oct 2, 2017 at 4:03 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: qemu-block@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> (that's very short doc)

No argument.  It's what I could do while cleaning up a mess that's
blocking my path to what I really want to do.  Patches welcome :)

>> ---
>>  qemu-options.hx | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index c647fdde62..8568ee388c 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1180,6 +1180,12 @@ DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
>>      "                iSCSI session parameters\n", QEMU_ARCH_ALL)
>>
>>  STEXI
>> +@item -iscsi
>> +@findex -iscsi
>> +Configure iSCSI session parameters.
>> +ETEXI
>> +
>> +STEXI
>>  @end table
>>  ETEXI
>>  DEFHEADING()
>> --
>> 2.13.6
>>
>>
