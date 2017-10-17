Received: from eggs.gnu.org ([2001:4830:134:3::10]:35795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1e4VnF-0007IY-Tq
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 13:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1e4VnE-0007y1-U2
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 13:36:41 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:51189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1e4VnE-0007xm-Nc
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 13:36:40 -0400
Received: by mail-wm0-x241.google.com with SMTP id u138so5370405wmu.5
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 10:36:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5496192f-4fef-ef16-2769-81a9d31775d7@vivier.eu>
References: <20170925231924.31303-1-carenas@gmail.com>
	<20170925231924.31303-2-carenas@gmail.com>
	<20170925231924.31303-3-carenas@gmail.com>
	<20170925231924.31303-4-carenas@gmail.com>
	<20170925231924.31303-5-carenas@gmail.com>
	<20170925231924.31303-6-carenas@gmail.com>
	<20170925231924.31303-7-carenas@gmail.com>
	<5496192f-4fef-ef16-2769-81a9d31775d7@vivier.eu>
From: Carlo Arenas <carenas@gmail.com>
Date: Tue, 17 Oct 2017 10:36:39 -0700
Message-ID: <CAPUEspi9fL33R=mscXxYGfB55HWS9DqzYZN+Vdti2sccPsV16w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/6] linux_user: consolidate sock_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi

On Wed, Oct 11, 2017 at 6:23 AM, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 26/09/2017 =C3=A0 01:19, Carlo Marcelo Arenas Bel=C3=B3n a =C3=A9crit =
:
>> remove unnecessary sock_type enum and other unused surrounding code to
>> allow for per arch sockbits to mirror better linux headers for maintenan=
ce
>>
>> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>> ---
>>  linux-user/alpha/sockbits.h | 36 ----------------------------
>>  linux-user/hppa/sockbits.h  | 30 -----------------------
>>  linux-user/mips/sockbits.h  | 35 ---------------------------
>>  linux-user/socket.h         | 58 ++++++++++++++++++++++----------------=
-------
>>  linux-user/sparc/sockbits.h | 35 ---------------------------
>>  5 files changed, 29 insertions(+), 165 deletions(-)
>
> I think it's not a good idea to mix again what we have just unmixed.

do you object to the fact it was done in 2 steps (first moving out
from socket.h and then added it back as a single block)?  it was done
that way to reuse as much as possible the code that was already
reviewed.

the end result is the important part, though; and it is a sockbits.h
for those 4 architectures (and a socket.h for the rest) that could be
automatically generated or compared with the corresponding linux
headers and therefore hopefully be easier to maintain going forward.

since we are going to redo the series anyway, could we get some
discussion/agreement on the design of it?, have to admit I am a little
surprised by all the patches flying by the list but not many
conversations, and being new to qemu linux-user I think I could have
benefited from it to avoid some of the mistakes made.

Carlo
