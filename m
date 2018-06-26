Received: from eggs.gnu.org ([2001:4830:134:3::10]:46137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXiGm-0002ug-1h
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXiGi-0005x7-86
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:20:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180625165749.3910-1-f4bug@amsat.org>
	<20180625165749.3910-2-f4bug@amsat.org>
	<f7d3b79e-de4d-6591-02a3-04a82618cb95@redhat.com>
Date: Tue, 26 Jun 2018 09:19:55 +0200
In-Reply-To: <f7d3b79e-de4d-6591-02a3-04a82618cb95@redhat.com> (John Snow's
	message of "Mon, 25 Jun 2018 13:13:38 -0400")
Message-ID: <87efguovz8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/3] hw/block/fdc: Replace
 error_setg(&error_abort) by assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, "open list:Floppy" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>

John Snow <jsnow@redhat.com> writes:

> On 06/25/2018 12:57 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Use assert() instead of error_setg(&error_abort),
>> as suggested by the "qapi/error.h" documentation:
>>=20
>>     Please don't error_setg(&error_fatal, ...), use error_report() and
>>     exit(), because that's more obvious.
>>     Likewise, don't error_setg(&error_abort, ...), use assert().
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Acked-by: John Snow <jsnow@redhat.com>
>
> AIUI this series is to be merged by someone else currently, right?
> Nothing needed on my part?

Whatever doesn't get picked up by maintainers of patched code can go
through my tree.
