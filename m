Received: from eggs.gnu.org ([2001:4830:134:3::10]:36759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fa36e-0002lP-4M
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fa36b-0000yA-20
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:59:20 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fa36a-0000wt-Js
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:59:16 -0400
Received: by mail-wr0-x243.google.com with SMTP id a12-v6so16409158wro.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:59:16 -0700 (PDT)
References: <20180702143021.18864-1-alex.bennee@linaro.org>
	<20180702143021.18864-10-alex.bennee@linaro.org>
	<19661f74-d44b-590f-2226-cdcab27ab82b@amsat.org>
	<9c899d98-3ee4-9315-f0d4-92a047bfddd0@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <9c899d98-3ee4-9315-f0d4-92a047bfddd0@amsat.org>
Date: Mon, 02 Jul 2018 18:59:14 +0100
Message-ID: <87woud8qod.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/20] linux-user: introduce
 preexit_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: famz@redhat.com, berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>, cota@braap.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 07/02/2018 01:22 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Using:
>>
>> 'configure' '--enable-gprof' '--enable-gcov' '--disable-pie' --static
>> [...]
>> C compiler        gcc-8
>> CFLAGS            -fprofile-arcs -ftest-coverage -g -g
>> LDFLAGS           -Wl,--warn-common -fprofile-arcs -ftest-coverage -m64
>> -static -g
>> gprof enabled     yes
>> static build      yes
>> PIE               no
>> gcov              gcov
>> gcov enabled      yes
>> docker            yes
>>
>> I get:
>>
>> $ make subdir-ppc-linux-user
>> [...]
>>   CC      ppc-linux-user/linux-user/exit.o
>> linux-user/exit.c: In function =E2=80=98preexit_cleanup=E2=80=99:
>> linux-user/exit.c:29:9: error: implicit declaration of function
>> =E2=80=98_mcleanup=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>>          _mcleanup();
>>          ^~~~~~~~~
>> linux-user/exit.c:29:9: error: nested extern declaration of =E2=80=98_mc=
leanup=E2=80=99
>> [-Werror=3Dnested-externs]
>> cc1: all warnings being treated as errors
>> make[1]: *** [rules.mak:69: linux-user/exit.o] Error 1
>> make: *** [Makefile:481: subdir-ppc-linux-user] Error 2
>>
>> I suppose gprof and static builds are exclusive.

Yeah I guess this must have always been there because I didn't change
the gprof code, just moved it.

>
> I just noticed we don't have --static builds covered by our continuous
> integration.
> Yet too many matrix cases to cover?
> We could ignore it for 'system' builds, but we should enable it for
> --linux-user which is used by various distributions for with the binfmt
> packages.

Yeah certainly a --disable-system --static build makes sense.

>
> Regards,
>
> Phil.


--
Alex Benn=C3=A9e
