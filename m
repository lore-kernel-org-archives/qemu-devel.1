Received: from eggs.gnu.org ([2001:4830:134:3::10]:58259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fw4fJ-0000KS-03
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fw4ek-0006v4-N3
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:05:40 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fw4ek-0006us-ID
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:05:34 -0400
Received: by mail-it0-f67.google.com with SMTP id p79-v6so10383731itp.3
	for <qemu-devel@nongnu.org>; Sat, 01 Sep 2018 05:05:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87o9dhiiuj.fsf@dusky.pond.sub.org>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-11-marcandre.lureau@redhat.com>
	<87o9dhiiuj.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 1 Sep 2018 14:05:33 +0200
Message-ID: <CAMxuvazFSTzR_2fZpLCVciHnBcJKTAmnUto81Z7Tup+m6T_CHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

On Sat, Sep 1, 2018 at 12:59 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Let qmp_dispatch() copy the 'id' field. That way any qmp client will
>> conform to the specification, including QGA. Furthermore, it
>> simplifies the work for qemu monitor.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> ---
>>  monitor.c           | 33 ++++++++++++---------------------
>>  qapi/qmp-dispatch.c | 10 ++++++++--
>>  tests/test-qga.c    | 13 +++++--------
>>  3 files changed, 25 insertions(+), 31 deletions(-)
>
> Let's squash in
>
> diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
> index 8f7da0245d..5fdfb2a4d0 100644
> --- a/docs/interop/qmp-spec.txt
> +++ b/docs/interop/qmp-spec.txt
> @@ -109,6 +109,7 @@ or
>    command execution, it is optional and will be part of the response
>    if provided.  The "id" member can be any json-value.  A json-number
>    incremented for each successive command works fine.
> +- Older versions of the QEMU Guest agent do not support "id".

Good idea. Are you taking and updating the patch, or Michael?

thanks
