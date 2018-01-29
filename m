Received: from eggs.gnu.org ([2001:4830:134:3::10]:43360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eg45f-0007vl-6L
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 02:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eg45c-0005dN-2m
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 02:42:55 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1eg45b-0005cX-T2
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 02:42:52 -0500
Received: by mail-wm0-f49.google.com with SMTP id v71so31722230wmv.2
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 23:42:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f090e697-424b-6ce6-4517-3e16c728958f@redhat.com>
References: <20180129033133.31288-1-famz@redhat.com>
	<f090e697-424b-6ce6-4517-3e16c728958f@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Mon, 29 Jan 2018 15:42:20 +0800
Message-ID: <CAK1Eb9mjV4KV2N8=yOdUVeg+P0sHnqER0BUYg5kb_FjVcmzXnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Mon, Jan 29, 2018 at 2:56 PM, Thomas Huth <thuth@redhat.com> wrote:
> On 29.01.2018 04:31, Fam Zheng wrote:
> [...]
>> +1. Create a new source file. For example, ``tests/test-foo.c``.
> [...]
>> +1. Create a new source file for the test. (More than one file can be added as
>> +   necessary.) For example, ``tests/test-foo-device.c``.  2. Write the test
>> +   code with the glib and libqtest/libqos API. See also existing tests and the
>> +   library headers for reference.
>
> Can you please name the examples tests/foo-test.c and
> tests/foo-device-test.c instead? Then the binaries will be covered by
> the wildcard in tests/.gitignore automatically. Otherwise the list in
> that gitignore file will grow and grow... Maybe it's also worth to
> mention the naming scheme in this doc file?

Yeah, I can do it. It's just I fail to find a definitive guideline on
test-* vs *-test for the names, and the numbers are neck-and-neck:

fam@lemon:~/work/qemu [master]$ ls tests/*test.c | wc -l
67
fam@lemon:~/work/qemu [master]$ ls tests/test-*.c | wc -l
68

>
>> +Image fuzzier testing
>> +=====================
>> +
>> +An image fuzzier was added to exercise format drivers. Currently only qcow2 is
>> +supported. To start the fuzzier, run
>
> s/fuzzier/fuzzer/g ?

Okay.

Thanks for reviewing!

Fam
