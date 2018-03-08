Received: from eggs.gnu.org ([2001:4830:134:3::10]:35585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etvHL-0004lY-MS
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etvHC-0006rs-8W
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:08:15 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:37607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etvHC-0006rW-35
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:08:06 -0500
Received: by mail-ot0-x22a.google.com with SMTP id t2so5315410otj.4
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 05:08:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223163354.GC7151@stefanha-x1.localdomain>
References: <20180213140029.8308-1-peter.maydell@linaro.org>
	<20180223163354.GC7151@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 13:07:45 +0000
Message-ID: <CAFEAcA-zpqnONjDXFXG4TBtrXDZXSJZ1wAth95X_kzk04sPcjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] log-for-trace.h: Split out parts of log.h
 used by trace.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 23 February 2018 at 16:33, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Tue, Feb 13, 2018 at 02:00:29PM +0000, Peter Maydell wrote:
>> A persistent build problem we see is where a source file
>> accidentally omits the #include of log.h. This slips through
>> local developer testing because if you configure with the
>> default (log) trace backend trace.h will pull in log.h for you.
>> Compilation fails only if some other backend is selected.
>>
>> To make this error cause a compile failure regardless of
>> the configured trace backend, split out the parts of log.h
>> that trace.h requires into a new log-for-trace.h header.
>> Since almost all manual uses of the log.h functions will
>> use constants or functions which aren't in log-for-trace.h,
>> this will let us catch missing #include "qemu/log.h" more
>> consistently.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  include/qemu/log-for-trace.h     | 35 +++++++++++++++++++++++++++++++++++
>>  include/qemu/log.h               | 18 ++++--------------
>>  scripts/tracetool/backend/log.py | 13 ++++++-------
>>  3 files changed, 45 insertions(+), 21 deletions(-)
>>  create mode 100644 include/qemu/log-for-trace.h
>
> Thanks, applied to my tracing tree:
> https://github.com/stefanha/qemu/commits/tracing

Are you planning to put in a pullreq before codefreeze?

thanks
-- PMM
