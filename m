Received: from eggs.gnu.org ([2001:4830:134:3::10]:34832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDMU-0001dD-HB
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDMT-0004mJ-A4
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:46:54 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftDMT-0004lp-3r
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:46:53 -0400
Received: by mail-oi0-x241.google.com with SMTP id y207-v6so15688088oie.13
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 07:46:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180824144341.GU3430@redhat.com>
References: <20180824012126.22721-1-famz@redhat.com>
	<8d039be4-486e-e017-88ca-5cb6ebd89519@comstyle.com>
	<20180824144341.GU3430@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 15:46:31 +0100
Message-ID: <CAFEAcA-r4CrL91gk0JhD4_iEZEOR=02Aa+noo3H3sed==P+6WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 24 August 2018 at 15:43, Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:
> On Fri, Aug 24, 2018 at 10:36:30AM -0400, Brad Smith wrote:
>> I very much appreciate the effort to bump up to 6.3 as I was going
>> to suggest doing that at some point. But bumping up to 6.3 at the
>> moment will fail with the configure script. We've switched from GCC 4.2
>> to Clang. The TLS check will fail with Clang's emulated TLS. We've
>> had a local patch for awhile to fix the test but I don't think it is
>> appropriate to upstream as is.
>>
>> Index: configure
>> --- configure.orig
>> +++ configure
>> @@ -1876,7 +1876,7 @@ static __thread int tls_var;
>>  int main(void) { return tls_var; }
>>  EOF
>> -if ! compile_prog "-Werror" "" ; then
>> +if ! compile_prog "-Werror" "-pthread" ; then
>>      error_exit "Your compiler does not support the __thread specifier f=
or " \
>>       "Thread-Local Storage (TLS). Please upgrade to a version that does=
."
>>  fi
>
> Later on in the configure script there's a check for pthreads that
> sets $PTHREAD_LIB to the desired arg.
>
> Best is probably to move that check higher up, and then use $PTHREAD_LIB
> as the argument to the compile_prog call you show.

Is emulated TLS a sufficiently complete/performant TLS
implementation for our purposes?

(I think it would be better if OpenBSD just implemented real TLS
like every other host OS we support.)

thanks
-- PMM
