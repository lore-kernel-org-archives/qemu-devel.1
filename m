Received: from eggs.gnu.org ([2001:4830:134:3::10]:39488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHqXN-00049d-Ap
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHqXM-0006no-Ar
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:27:57 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHqXM-0006d8-3Q
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:27:56 -0400
Received: by mail-oi1-x243.google.com with SMTP id e3-v6so13577153oiy.6
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 06:27:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181031120049.GH9625@redhat.com>
References: <BN6PR2201MB1251EA1F1F5E486A889A827CC6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181031120049.GH9625@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Oct 2018 13:27:15 +0000
Message-ID: <CAFEAcA-20HUdGyNYFoqzhPdBbxpJ5iRH+F0WWNwgjs=JpsN7Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Question: Perfecting checkpatch.pl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>

On 31 October 2018 at 12:00, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> On Tue, Oct 30, 2018 at 12:35:15PM +0000, Aleksandar Markovic wrote:
>> Perhaps checkpatch.pl should make sure the commit messages do not contai=
n "address@hidden" and "Reviewed-off-by"?
>>
>> $ git log | grep address@hidden
>>     Signed-off-by: Michael S. Tsirkin <address@hidden>
>>     Signed-off-by: Ronald Hecht <address@hidden>
>>     Signed-off-by: Justin Chevrier <address@hidden>
>>     Signed-off-by: Justin Chevrier <address@hidden>
>>     Signed-off-by: Justin Chevrier <address@hidden>
>
> This makes sense...
>
>>
>> $ git log | grep Reviewed-off-by
>>     Reviewed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>>     Reviewed-off-by: Anthony Liguori <aliguori@us.ibm.com>
>
> but I'm not convinced it is worth doing this, because the set of
> mistakes people have made is enourmous, so it turns into a game
> of whack-a-mole.

You could have checkpatch whitelist the sensible ones:

>    3127 Acked-by
>    1834 Reported-by
>   30991 Reviewed-by
>   97837 Signed-off-by
>     660 Suggested-by
>    1951 Tested-by

and warn about the rest...

thanks
-- PMM
