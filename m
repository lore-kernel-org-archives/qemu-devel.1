Received: from eggs.gnu.org ([2001:4830:134:3::10]:35608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdYiZ-0005er-AN
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdYiV-0004EL-Ak
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:20:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdYiU-0004Cn-Q6
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:20:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id a3-v6so11903320wrt.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 03:20:54 -0700 (PDT)
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-10-alex.bennee@linaro.org>
	<20180710070446.GM17581@lemon.usersys.redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180710070446.GM17581@lemon.usersys.redhat.com>
Date: Thu, 12 Jul 2018 11:20:52 +0100
Message-ID: <87r2k8dabf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.0 09/10] docker: add test-unit runner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Mon, 07/09 16:21, Alex Benn=C3=A9e wrote:
>> This test doesn't even build QEMU, it just runs all the unit tests.
>> Intended to make checking unit tests on all docker images easier.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/docker/test-unit | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>  create mode 100755 tests/docker/test-unit
>>
>> diff --git a/tests/docker/test-unit b/tests/docker/test-unit
>> new file mode 100755
>> index 0000000000..be0d90d748
>> --- /dev/null
>> +++ b/tests/docker/test-unit
>> @@ -0,0 +1,19 @@
>> +#!/bin/bash
>> +#
>> +# Build and run the unit tests
>> +#
>> +# Copyright (c) 2018 Linaro Ltd.
>> +#
>> +# Authors:
>> +#  Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2
>> +# or (at your option) any later version. See the COPYING file in
>> +# the top-level directory.
>> +
>> +. common.rc
>> +
>> +cd "$BUILD_DIR"
>> +
>> +configure_qemu
>
> This reads a bit unusual and counter-intuitive: how could configure_qemu =
succeed
> when the env cannot actually build it? Does configure_qemu fail but the s=
ide
> effects needed to run build and run unit tests are done anyway?  Either w=
ay,
> please add a comment explaining what is happening here.

Although we are not building QEMU itself we still need a configured
build environment as we build sub-modules of QEMU to bind into the unit
tests. I'll add a comment.

>
> Also, should we test the exit code of configure_qemu?

Or maybe just make the script -e?

>
>> +check_qemu check-unit
>> --
>> 2.17.1
>>


--
Alex Benn=C3=A9e
