Received: from eggs.gnu.org ([2001:4830:134:3::10]:47513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJeTq-00023P-Oa
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJeTn-0006FB-KO
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:27:30 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJeTn-0006EH-DJ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:27:27 -0400
Received: by mail-wr0-x243.google.com with SMTP id w18-v6so5271955wrn.6
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 05:27:27 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-22-alex.bennee@linaro.org>
	<46d4512f-585e-073f-fbc1-857c4063df12@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <46d4512f-585e-073f-fbc1-857c4063df12@redhat.com>
Date: Fri, 18 May 2018 13:27:25 +0100
Message-ID: <87in7ldu8i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 21/49] tests/tcg/i386: add runner for
 test-i386-fprem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 17/05/2018 19:46, Alex Benn=C3=A9e wrote:
>> The runner needs to compare against a reference run. We also only run
>> this test when SPEED=3Dslow as it takes a while.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/i386/Makefile.target   | 11 +++++++++++
>>  tests/tcg/i386/test-i386-fprem.c | 12 +++++++++---
>>  2 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.ta=
rget
>> index 39a1627650..94fa50abbc 100644
>> --- a/tests/tcg/i386/Makefile.target
>> +++ b/tests/tcg/i386/Makefile.target
>> @@ -37,3 +37,14 @@ pi_10.com:
>>  run-runcom: runcom pi_10.com
>>  	$(call quiet-command, $(QEMU) ./runcom ./pi_10.com > runcom.out, "TEST=
", "$< on $(TARGET_NAME)")
>>
>> +ifeq ($(SPEED), slow)
>> +run-test-i386-fprem: test-i386-fprem
>> +	$(call quiet-command, \
>> +		$(QEMU) $< > $<.out && \
>> +		diff -u $(I386_SRC)/$<.ref $<.out, \
>> +		"TEST", "$< (default) on $(TARGET_NAME)")
>
> Where is the .ref file created?

Ooops, forgot to commit that.

I just manually ran it against real hardware ;-)

>
> Thanks,
>
> Paolo


--
Alex Benn=C3=A9e
