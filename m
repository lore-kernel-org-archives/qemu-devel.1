Received: from eggs.gnu.org ([2001:4830:134:3::10]:38538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gCkho-0007Rl-36
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gCkhj-0007s2-Cm
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:13:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gCkhi-0007bv-Sw
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:13:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id q7-v6so1565109wrr.8
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 05:13:28 -0700 (PDT)
References: <20181012165347.2117-1-crosa@redhat.com>
	<20181012165347.2117-4-crosa@redhat.com>
	<f0f98dd7-a62b-1107-b7a9-ea4f6f76fd75@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <f0f98dd7-a62b-1107-b7a9-ea4f6f76fd75@redhat.com>
Date: Wed, 17 Oct 2018 13:13:25 +0100
Message-ID: <87ftx4ojoa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/3] Travis support for the acceptance
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Caio Carrara <ccarrara@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Cleber,
>
> On 12/10/2018 18:53, Cleber Rosa wrote:
>> This enables the execution of the acceptance tests on Travis.
>>
>> Because the Travis environment is based on Ubuntu Trusty, it requires
>> the python3-pip and python3.4-venv packages.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  .travis.yml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 95be6ec59f..f55f799c52 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -36,6 +36,8 @@ addons:
>>        - liburcu-dev
>>        - libusb-1.0-0-dev
>>        - libvte-2.90-dev
>> +      - python3-pip
>> +      - python3.4-venv
>
> I'd prefer not put Python specific version in the generic addons list...
>
>>        - sparse
>>        - uuid-dev
>>        - gcovr
>> @@ -117,6 +119,9 @@ matrix:
>>      - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
>>        python:
>>          - "3.6"
>> +    # Acceptance (Functional) tests
>> +    - env: CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64=
-softmmu"
>> +           TEST_CMD=3D"make AVOCADO_SHOW=3Dapp check-acceptance"
>
> ... but rather in the single test that requires it:
>
>          addons:
>            apt:
>              packages:
>                - python3-pip
>                - python3.4-venv
>
> Alex what do you prefer?

Out-of-band package managers can potentially add complexity to the build
environment so we should limit them to where they are needed.

We really need to transition to using docker for all out build
environments as the default Travis environment is getting steadily
crustier and out of date. We need to solve the caching/hub problem first
though.

With the move to the test:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
>>      # Using newer GCC with sanitizers
>>      - addons:
>>          apt:
>>
>
> Both configs:
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


--
Alex Benn=C3=A9e
