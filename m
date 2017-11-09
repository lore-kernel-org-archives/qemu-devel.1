Received: from eggs.gnu.org ([2001:4830:134:3::10]:55385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <namhyung@gmail.com>) id 1eCnvs-0001dc-DH
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <namhyung@gmail.com>) id 1eCnvr-0008Fk-HA
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:35:52 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:48013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <namhyung@gmail.com>) id 1eCnvr-0008FK-Cg
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:35:51 -0500
Received: by mail-ot0-x243.google.com with SMTP id s88so5450300ota.4
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 06:35:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171109104202.GA17101@stefanha-x1.localdomain>
References: <20171107153136.19426-1-namhyung@gmail.com>
	<20171109104202.GA17101@stefanha-x1.localdomain>
From: Namhyung Kim <namhyung@gmail.com>
Date: Thu, 9 Nov 2017 23:35:29 +0900
Message-ID: <CAM9d7chD5-dA9NiLL_V+45+QCAq0G2PhMAV4iqcSDk+XEm4Wfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] trace: Simplify find_debugfs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hello,

On Thu, Nov 9, 2017 at 7:42 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Wed, Nov 08, 2017 at 12:31:34AM +0900, Namhyung Kim wrote:
>> The return vale of find_debugfs() is 1 if it could find a mount point of
>> debugfs.  It can be saved in the while loop instead of checking it again.
>>
>> Signed-off-by: Namhyung Kim <namhyung@gmail.com>
>> ---
>>  trace/ftrace.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> Thanks, applied all to my tracing-next tree:
> https://github.com/stefanha/qemu/commits/tracing-next
>
> Please send multi-patch series with a cover letter in the future (git
> format-patch --cover-letter).  Continuous integration tools may ignore
> multi-patch series without a cover letter.

OK.  I usually use a cover letter when a patch series has 5+
patches.  But will add it for small series too in the future.

>
> qemu.git/master is currently frozen for the QEMU 2.11 release so you
> won't see your patches in master until QEMU 2.11 has been released.
> Once the development window opens again your patches will be merged into
> qemu.git/master.

Understood.

Thanks
Namhyung
