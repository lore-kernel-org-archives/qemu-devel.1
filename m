Received: from eggs.gnu.org ([2001:4830:134:3::10]:49489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dO3Ic-0000b9-QM
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dO3Ib-0003ox-Vv
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:41:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170621134744.8047-1-mreitz@redhat.com>
	<20170621134744.8047-2-mreitz@redhat.com>
	<87d19xwbpj.fsf@dusky.pond.sub.org>
	<4afa1020-22a7-c07e-3f73-36746644c77a@redhat.com>
Date: Thu, 22 Jun 2017 16:41:24 +0200
In-Reply-To: <4afa1020-22a7-c07e-3f73-36746644c77a@redhat.com> (Max Reitz's
	message of "Wed, 21 Jun 2017 23:43:29 +0200")
Message-ID: <87o9tggk4r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qapi/qnull: Add own header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> On 2017-06-21 18:24, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>> 
>>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  include/qapi/qmp/qnull.h   | 26 ++++++++++++++++++++++++++
>>>  include/qapi/qmp/qobject.h |  8 --------
>>>  include/qapi/qmp/types.h   |  1 +
>>>  qobject/qnull.c            |  1 +
>>>  target/i386/cpu.c          |  6 +-----
>>>  tests/check-qnull.c        |  2 +-
>>>  6 files changed, 30 insertions(+), 14 deletions(-)
>>>  create mode 100644 include/qapi/qmp/qnull.h
>>>
>>> diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
>>> new file mode 100644
>>> index 0000000..69555ac
>>> --- /dev/null
>>> +++ b/include/qapi/qmp/qnull.h
>>> @@ -0,0 +1,26 @@
>>> +/*
>>> + * QNull Module
>>> + *
>>> + * Copyright (C) 2009, 2017 Red Hat Inc.
>>> + *
>>> + * Authors:
>>> + *  Luiz Capitulino <lcapitulino@redhat.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
>>> + * See the COPYING.LIB file in the top-level directory.
>> 
>> Copy the boilerplate from qnull.c instead, factual correctness.
>
> Sorry, will do.

No need to be sorry!  Copying it from qobject.h along with the code was
the obvious thing to do.

[...]
