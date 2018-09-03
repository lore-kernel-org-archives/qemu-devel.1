Received: from eggs.gnu.org ([2001:4830:134:3::10]:35046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fwhH3-0006eC-Ry
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 01:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fwhGy-0004hN-MJ
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 01:19:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fwhGy-0004gR-GA
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 01:19:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-11-marcandre.lureau@redhat.com>
	<87o9dhiiuj.fsf@dusky.pond.sub.org>
	<CAMxuvazFSTzR_2fZpLCVciHnBcJKTAmnUto81Z7Tup+m6T_CHg@mail.gmail.com>
Date: Mon, 03 Sep 2018 07:19:30 +0200
In-Reply-To: <CAMxuvazFSTzR_2fZpLCVciHnBcJKTAmnUto81Z7Tup+m6T_CHg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Sat, 1 Sep 2018
	14:05:33 +0200")
Message-ID: <871sabf999.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/10] qmp: common 'id' handling & make
 QGA conform to QMP spec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> On Sat, Sep 1, 2018 at 12:59 PM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>>> Let qmp_dispatch() copy the 'id' field. That way any qmp client will
>>> conform to the specification, including QGA. Furthermore, it
>>> simplifies the work for qemu monitor.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>>> ---
>>>  monitor.c           | 33 ++++++++++++---------------------
>>>  qapi/qmp-dispatch.c | 10 ++++++++--
>>>  tests/test-qga.c    | 13 +++++--------
>>>  3 files changed, 25 insertions(+), 31 deletions(-)
>>
>> Let's squash in
>>
>> diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
>> index 8f7da0245d..5fdfb2a4d0 100644
>> --- a/docs/interop/qmp-spec.txt
>> +++ b/docs/interop/qmp-spec.txt
>> @@ -109,6 +109,7 @@ or
>>    command execution, it is optional and will be part of the response
>>    if provided.  The "id" member can be any json-value.  A json-number
>>    incremented for each successive command works fine.
>> +- Older versions of the QEMU Guest agent do not support "id".
>
> Good idea. Are you taking and updating the patch, or Michael?

I left the QGA stuff out of my "[PULL 0/6] Monitor patches for
2018-09-01".  If it's still pending when I do my next pull request for
QMP stuff, I can include it.  Of course, Michael is welcome to take it
earlier.
