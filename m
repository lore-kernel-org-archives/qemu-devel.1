Received: from eggs.gnu.org ([2001:4830:134:3::10]:42935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epGU1-0001Zi-5s
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epGTy-0006MV-Fd
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:46:05 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epGTy-0006Kd-0G
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:46:02 -0500
Received: by mail-wm0-x241.google.com with SMTP id x7so3439860wmc.0
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 08:46:01 -0800 (PST)
References: <20180223154613.2096-1-alex.bennee@linaro.org>
	<20180223154613.2096-5-alex.bennee@linaro.org>
	<20180223161723.GF31076@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180223161723.GF31076@redhat.com>
Date: Fri, 23 Feb 2018 16:45:58 +0000
Message-ID: <878tbjac3d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/8] new contrib/generate_all.sh: batch
 risugen script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Feb 23, 2018 at 03:46:09PM +0000, Alex Benn=C3=A9e wrote:
>> This is a simple script for generating all instructions in a given
>> RISU file. You can split up the batch size by passing a -n N command
>> line options. For example:
>>
>>   ./contrib/generate_all.sh -n 2 hp.risu testcases.armv8.2_hp
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  contrib/generate_all.sh | 96 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 96 insertions(+)
>>  create mode 100755 contrib/generate_all.sh
>>
>> diff --git a/contrib/generate_all.sh b/contrib/generate_all.sh
>> new file mode 100755
>> index 0000000..1e6b847
>> --- /dev/null
>> +++ b/contrib/generate_all.sh
>> @@ -0,0 +1,96 @@
>> +#!/bin/bash
>> +#
>> +# Generate all patterns in a given RISU file
>> +#
>> +# Copyright (c) 2017 Linaro Limited
>> +# All rights reserved. This program and the accompanying materials
>> +# are made available under the terms of the Eclipse Public License v1.0
>> +# which accompanies this distribution, and is available at
>> +# http://www.eclipse.org/legal/epl-v10.html
>
> Really ? Why this license not our standard GPLv2+, or BSD if it is wanted
> to be a public-domain-ish license ?

I just chose what RISU is licensed under - but there is no reason I
couldn't make it something else.

>
> Regards,
> Daniel


--
Alex Benn=C3=A9e
