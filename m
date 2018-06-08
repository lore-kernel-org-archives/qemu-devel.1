Received: from eggs.gnu.org ([2001:4830:134:3::10]:42000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRJGc-0000AQ-1N
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRJGb-0006Bx-1T
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:25:30 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:46280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRJGa-0006Bc-Rb
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:25:28 -0400
Received: by mail-ot0-x243.google.com with SMTP id q1-v6so16104509oth.13
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 08:25:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9abdaa17-d6d1-0c34-2a20-43078b487bef@redhat.com>
References: <20180607210818.12727-1-f4bug@amsat.org>
	<9abdaa17-d6d1-0c34-2a20-43078b487bef@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Jun 2018 16:25:07 +0100
Message-ID: <CAFEAcA-QYnWOo2Hqdr-3tKDDxWDnR+tF4snd15Y1P6md04CogA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: Restore CR,LF on stdio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Patryk Olszewski <patryk@fala.ehost.pl>, BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Desnogues <laurent.desnogues@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 8 June 2018 at 06:47, Thomas Huth <thuth@redhat.com> wrote:
> On 07.06.2018 23:08, Philippe Mathieu-Daud=C3=A9 wrote:
>> Remove the 'stair-step output' on stdio.
>>
>> This partially reverts commit 12fb0ac05, which was correct
>> on the mailing list but got corrupted by the maintainer :p
>>
>> Introduced-by: 3b876140-c035-dd39-75d0-d54c48128fac@redhat.com
>> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> See:
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06202.html (b=
ug)
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg01309.html (r=
eport)
>>
>> Peter, Can this enters directly as bug-fix?
>>
>>  chardev/char-stdio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
>> index d83e60e787..96375f2ab8 100644
>> --- a/chardev/char-stdio.c
>> +++ b/chardev/char-stdio.c
>> @@ -59,7 +59,7 @@ static void qemu_chr_set_echo_stdio(Chardev *chr, bool=
 echo)
>>      if (!echo) {
>>          tty.c_iflag &=3D ~(IGNBRK | BRKINT | PARMRK | ISTRIP
>>                           | INLCR | IGNCR | ICRNL | IXON);
>> -        tty.c_oflag &=3D ~OPOST;
>> +        tty.c_oflag |=3D OPOST;
>>          tty.c_lflag &=3D ~(ECHO | ECHONL | ICANON | IEXTEN);
>>          tty.c_cflag &=3D ~(CSIZE | PARENB);
>>          tty.c_cflag |=3D CS8;
>>
>
> I think this is the right way to go.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Applied to master, thanks.

-- PMM
