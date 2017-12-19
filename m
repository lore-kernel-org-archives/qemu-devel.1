Received: from eggs.gnu.org ([2001:4830:134:3::10]:59590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRK5X-00015E-Gr
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRK5W-0006fi-EX
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:45:51 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eRK5W-0006dA-7m
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:45:50 -0500
Received: by mail-wr0-x22c.google.com with SMTP id y21so19714381wrc.1
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 07:45:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0a657570-b763-558d-69cb-357e2cdf6c3f@redhat.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-4-marcandre.lureau@redhat.com>
	<0a657570-b763-558d-69cb-357e2cdf6c3f@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Dec 2017 16:45:48 +0100
Message-ID: <CAJ+F1C+kddTNemSB7yzf7uVpyrM3by2n3bscp56BTBRXuxoFZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/13] build-sys: add a rule to print a
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Fri, Dec 15, 2017 at 7:28 PM, Eric Blake <eblake@redhat.com> wrote:
> On 12/15/2017 09:06 AM, Marc-Andr=C3=A9 Lureau wrote:
>> $ make print-CFLAGS
>> CFLAGS=3D-fsanitize=3Daddress -Og -g
>>
>> Trick from various sources:
>> https://stackoverflow.com/questions/16467718/how-to-print-out-a-variable=
-in-makefile
>> https://www.cmcrossroads.com/article/printing-value-makefile-variable
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>  Makefile                    |  5 ++++-
>>  docs/devel/build-system.txt | 13 +++++++++++++
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>
>> +++ b/docs/devel/build-system.txt
>> @@ -510,3 +510,16 @@ default-configs/$TARGET-NAME file as input.
>>  This is the entrypoint used when make recurses to build a single system
>>  or userspace emulator target. It is merely a symlink back to the
>>  Makefile.target in the top level.
>> +
>> +
>> +Useful make targets
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +- help
>> +
>> +  Print a help message for the most common build targets.
>
> Except that this patch forgot to tweak 'make help' to mention 'make
> print-VAR' ;)

Well, I don't think print-VAR is a common build target, it's a
build-sys hack/debug imho, so having it described in build-system.txt
only make sense.

Do you agree?

thanks



--=20
Marc-Andr=C3=A9 Lureau
