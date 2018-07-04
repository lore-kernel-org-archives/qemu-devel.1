Received: from eggs.gnu.org ([2001:4830:134:3::10]:40536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fakXT-0004XG-Vl
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fakXP-0000bX-Te
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:21:55 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fakXP-0000b5-Cw
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:21:51 -0400
Received: by mail-wm0-x243.google.com with SMTP id l15-v6so9700wmc.1
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 09:21:51 -0700 (PDT)
References: <20180704143014.8670-1-f4bug@amsat.org>
	<87va9v80ut.fsf@linaro.org> <20180704154831.GM32267@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180704154831.GM32267@redhat.com>
Date: Wed, 04 Jul 2018 17:21:49 +0100
Message-ID: <87tvpf7yzm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Do not display host compilers
 as cross-compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jul 04, 2018 at 04:41:30PM +0100, Alex Benn=C3=A9e wrote:
>>
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>
>> > This silent (since d75402b5ee2):
>> >
>> >   ./configure
>> >   [...]
>> >   NOTE: cross-compilers enabled:  'cc'
>> >
>> > Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> > Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> > ---
>> >  configure | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/configure b/configure
>> > index b99ebdde24..fbb53ab6bb 100755
>> > --- a/configure
>> > +++ b/configure
>> > @@ -7328,7 +7328,7 @@ echo "QEMU_CFLAGS+=3D$cflags" >> $config_target_=
mak
>> >
>> >  done # for target in $targets
>> >
>> > -if test -n "$enabled_cross_compilers"; then
>> > +if test -n "$target_compiler" -a -n "$enabled_cross_compilers"; then
>> >      echo
>> >      echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
>> >  fi
>>
>> I had also added:
>>
>> -    echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
>> +    echo "NOTE: compilers enabled for TCG tests: $enabled_cross_compile=
rs"[
>>
>> to make things clearer.
>
> I think we should also 's/NOTE: //', because everything printed by
> configure at the end is a note. Also get rid of the extra blank
> line before it.

*shrugs* I made the original decision because:

WARNING: Use of SDL 1.2 is deprecated and will be removed in
WARNING: future releases. Please switch to using SDL 2.0
compilers enabled for TCG tests:  'aarch64-linux-gnu-gcc' 'arm-linux-gnueab=
ihf-gcc' 'cc' 'aarch64-linux-gnu-gcc' 'arm-linux-gnueabihf-gcc' 'cc'

offended my eye, but I'm happy either way really.

>
>>
>> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>>
>> --
>> Alex Benn=C3=A9e
>
> Regards,
> Daniel


--
Alex Benn=C3=A9e
