Received: from eggs.gnu.org ([2001:4830:134:3::10]:32997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGshH-0006eE-56
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGshG-0006r1-6H
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:01:55 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fGshF-0006qm-Uy
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:01:54 -0400
Received: by mail-lf0-x242.google.com with SMTP id r2-v6so4906724lff.4
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 14:01:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3c63d68b-20c2-8ac6-1b8d-6344d5e6de0b@amsat.org>
References: <90990df8024b287004e771ebd2370cc390e49106.1525723355.git.alistair.francis@wdc.com>
	<828d2efb-6cee-f4f5-138a-5fd7da3de675@amsat.org>
	<5d0f62c3-cfab-bd64-ee75-d0ce5e064e2d@amsat.org>
	<3c63d68b-20c2-8ac6-1b8d-6344d5e6de0b@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 10 May 2018 14:01:22 -0700
Message-ID: <CAKmqyKOZpmZmdLda-KcBwVUPdattj7+Tz-AjCFLFVeFmjKHjKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] tests/docker: Add a Avocado Docker
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Tue, May 8, 2018 at 8:49 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Hi Alistair,
>
> On 05/07/2018 09:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 05/07/2018 05:09 PM, Alistair Francis wrote:
> [...]>>> +++ b/tests/docker/test-avocado
>>>> @@ -0,0 +1,28 @@
>>>> +#!/bin/bash -e
>>>> +#
>>>> +# Avocado tests on Fedora, as these are a real pain on Debian systems
>>>
>>> Have been here... Then used the git version :/
>>>
>>>> +#
>>>> +# Copyright (c) 2018 Western Digital.
>>>> +#
>>>> +# Authors:
>>>> +#  Alistair Francis <alistair.francis@wdc.com>
>>>> +#
>>>> +# This work is licensed under the terms of the GNU GPL, version 2
>>>> +# or (at your option) any later version. See the COPYING file in
>>>> +# the top-level directory.
>>>> +#
>>>> +# Run this test: NETWORK=3D1 make docker-test-avocado@fedora
>>>> +
>>>> +. common.rc
>>>> +
>>>> +requires avocado
>>>> +
>>>> +cd "$BUILD_DIR"
>>>> +
>>>> +DEF_TARGET_LIST=3D"x86_64-softmmu"
>>>> +TARGET_LIST=3D${TARGET_LIST:-$DEF_TARGET_LIST} \
>>>> +build_qemu
>>>> +install_qemu
>>>> +export PATH=3D"${PATH}:$(pwd)"
>>>> +avocado vt-bootstrap --yes-to-all --vt-type qemu
>>
>> Can we do the bootstrapping in the Dockerfile?
>>
>> Testing your image it download big files (i.e. JeOS image) in my
>> ~avocado/data/avocado-vt/images which is internal to the volatile docker
>> instance, so I have to download again each time I run the tests...
>
> Do we need this JeOS image?
>
> http://avocado-vt.readthedocs.io/en/latest/DownloadableImages.html#jeos-i=
mage

I think that is the one that is pulled in.

Alistair

>
>>
>> We need to pass this cache path to the docker instance.
>> For example the vm-test use ~/.cache/qemu-vm/download.
>>
>>>> +avocado run boot --vt-qemu-bin ./x86_64-softmmu/qemu-system-x86_64
>>>
>>> So this script is for the VT version, specific to x86. I'd rather name
>>> the script accordingly "test-avocado-vt".
>
