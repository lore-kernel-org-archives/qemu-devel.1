Received: from eggs.gnu.org ([2001:4830:134:3::10]:52124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eh4Qc-0002XH-Dy
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eh4QY-0007rs-E2
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:16:42 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:32906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1eh4QY-0007rI-7C
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:16:38 -0500
Received: by mail-wr0-f182.google.com with SMTP id s5so17194947wra.0
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 18:16:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5c8b634a-0edd-52af-3f9f-aef0205526c8@redhat.com>
References: <20180131032800.25578-1-famz@redhat.com>
	<5c8b634a-0edd-52af-3f9f-aef0205526c8@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Thu, 1 Feb 2018 10:16:06 +0800
Message-ID: <CAK1Eb9=HptwZkC3LPZ6Hex-siJN8OhVr7YgwksFGSVb1_2qVAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Wed, Jan 31, 2018 at 10:24 PM, Eric Blake <eblake@redhat.com> wrote:
> On 01/30/2018 09:28 PM, Fam Zheng wrote:
>> To make our efforts on QEMU testing easier to consume by contributors,
>> let's add a document. For example, Patchew reports build errors on
>> patches that should be relatively easy to reproduce with a few steps, and
>> it is much nicer if there is such a documentation that it can refer to.
>>
>> This focuses on how to run existing tests and how to write new test
>> cases, without going into the frameworks themselves.
>>
>> The VM based testing section is moved from tests/vm/README which now
>> is a single line pointing to the new doc.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>
>
>> +Testing with "make check"
>> +=========================
>> +
>> +The "make check" testing family includes most of the C based tests in QEMU. For
>> +a quick help, run ``make check-help`` from the source tree.
>> +
>> +The usual way to run these tests is:
>> +
>> +.. code::
>> +
>> +  make check
>> +
>> +which includes QAPI schema tests, unit tests, and QTests. Different sub-types
>> +of "make check" testings will be explained below.
>
> s/testings/tests/ or even s/testings//
>
>
>> +Since unit tests don't require environment variables, the simplest way to debug
>> +a unit test failure is often directly invoking it or even running it under
>> +``gdb``. However there can still be differences in behavior between ``make``
>> +invocations and your manual run, due to ``$MALLOC_PERTURB_`` environment
>> +variable (which affects memory reclaimation and catches invalid pointers
>
> s/reclaimation/reclamation/
>
>
>> +  $ sudo groupadd docker
>> +  $ sudo usermod $USER -G docker
>> +  $ sudo chown :docker /var/run/docker.sock
>> +
>> +Note that any one of above configurations makes it possible for the user to
>> +exploit the whole host with Docker bind mounting or other privileged
>> +operations.  So only do it on developement machines.
>
> s/developement/development/

Thank you! Will update. I should have run it through the Grammarly
check one more time. :)

Fam
