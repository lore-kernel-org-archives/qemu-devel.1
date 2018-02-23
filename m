Received: from eggs.gnu.org ([2001:4830:134:3::10]:41236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGQy-0007ns-6E
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGQx-0003MA-73
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:42:56 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epGQw-0003La-Vo
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:42:55 -0500
Received: by mail-pl0-x243.google.com with SMTP id c11-v6so1777129plo.0
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 08:42:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223161723.GF31076@redhat.com>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
	<20180223154613.2096-5-alex.bennee@linaro.org>
	<20180223161723.GF31076@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 16:42:18 +0000
Message-ID: <CAFEAcA_NS2cod8=ymayZCca2KYaAJhV=mtujrQcfVn--YyWygA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 23 February 2018 at 16:17, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
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

It's the stock risu license (for historical reasons). Alex forgot
to mark this patchset as being a risu patchset not a qemu one...

thanks
-- PMM
