Received: from eggs.gnu.org ([2001:4830:134:3::10]:43505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4sJ-0000m2-1L
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4sE-0001wb-9V
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:49:59 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:43132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4sE-0001wK-4v
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:49:54 -0400
Received: by mail-qt0-x241.google.com with SMTP id f13-v6so31842309qtp.10
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:49:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <90990df8024b287004e771ebd2370cc390e49106.1525723355.git.alistair.francis@wdc.com>
	<828d2efb-6cee-f4f5-138a-5fd7da3de675@amsat.org>
	<5d0f62c3-cfab-bd64-ee75-d0ce5e064e2d@amsat.org>
Message-ID: <3c63d68b-20c2-8ac6-1b8d-6344d5e6de0b@amsat.org>
Date: Tue, 8 May 2018 12:49:50 -0300
MIME-Version: 1.0
In-Reply-To: <5d0f62c3-cfab-bd64-ee75-d0ce5e064e2d@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, alex.bennee@linaro.org, alistair23@gmail.com

Hi Alistair,

On 05/07/2018 09:02 PM, Philippe Mathieu-Daudé wrote:
>> On 05/07/2018 05:09 PM, Alistair Francis wrote:
[...]>>> +++ b/tests/docker/test-avocado
>>> @@ -0,0 +1,28 @@
>>> +#!/bin/bash -e
>>> +#
>>> +# Avocado tests on Fedora, as these are a real pain on Debian systems
>>
>> Have been here... Then used the git version :/
>>
>>> +#
>>> +# Copyright (c) 2018 Western Digital.
>>> +#
>>> +# Authors:
>>> +#  Alistair Francis <alistair.francis@wdc.com>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2
>>> +# or (at your option) any later version. See the COPYING file in
>>> +# the top-level directory.
>>> +#
>>> +# Run this test: NETWORK=1 make docker-test-avocado@fedora
>>> +
>>> +. common.rc
>>> +
>>> +requires avocado
>>> +
>>> +cd "$BUILD_DIR"
>>> +
>>> +DEF_TARGET_LIST="x86_64-softmmu"
>>> +TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
>>> +build_qemu
>>> +install_qemu
>>> +export PATH="${PATH}:$(pwd)"
>>> +avocado vt-bootstrap --yes-to-all --vt-type qemu
> 
> Can we do the bootstrapping in the Dockerfile?
> 
> Testing your image it download big files (i.e. JeOS image) in my
> ~avocado/data/avocado-vt/images which is internal to the volatile docker
> instance, so I have to download again each time I run the tests...

Do we need this JeOS image?

http://avocado-vt.readthedocs.io/en/latest/DownloadableImages.html#jeos-image

> 
> We need to pass this cache path to the docker instance.
> For example the vm-test use ~/.cache/qemu-vm/download.
> 
>>> +avocado run boot --vt-qemu-bin ./x86_64-softmmu/qemu-system-x86_64
>>
>> So this script is for the VT version, specific to x86. I'd rather name
>> the script accordingly "test-avocado-vt".
