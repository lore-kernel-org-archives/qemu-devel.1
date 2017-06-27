Received: from eggs.gnu.org ([2001:4830:134:3::10]:57925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPgJa-000549-Mb
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPgJZ-0000bB-Kc
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:33:18 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:33906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPgJZ-0000ZV-Ef
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:33:17 -0400
Received: by mail-io0-x22a.google.com with SMTP id r36so10784147ioi.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 19:33:15 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170627021734.GS12152@localhost.localdomain>
References: <20170625192950.17677-1-f4bug@amsat.org>
	<20170625192950.17677-4-f4bug@amsat.org>
	<20170627021734.GS12152@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 26 Jun 2017 23:33:13 -0300
Message-ID: <CAAdtpL5_jjFT8SXj3yc+=nZR6Re-sTGAjtO=Z4OXKVCgPqZpxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] coccinelle: script to run them all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On Mon, Jun 26, 2017 at 11:17 PM, Eduardo Habkost <ehabkost@redhat.com> wro=
te:
> On Sun, Jun 25, 2017 at 04:29:49PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
[...]
>> +test -z "$(${SUDO} docker images -q ${SPATCH_IMAGE})" && ${SUDO} docker=
 pull ${SPATCH_IMAGE}
>> +
>
> Can the docker magic be made optional (and disabled by default), so
> people who already have Coccinelle installed can run this script more
> quickly?

Ok. Actually I didn't even think about running out of docker, the list
of ocaml requisites scared me a bit.
Using a dockerized spatch allow to stick to a common version (so I
know the scripts I run locally will run exactly the same on Travis).
But it makes sens ;)
I tried the multi-threaded options and for some reason they did not
work within docker, but I did not try out of it.

Regards,

Phil.
