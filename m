Received: from eggs.gnu.org ([209.51.188.92]:51291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goUxq-0002SA-0j
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goUxZ-00052m-Sk
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:06:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goUxZ-000507-8t
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:05:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so18063957wmc.5
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 07:05:55 -0800 (PST)
References: <1548769067-20792-1-git-send-email-thuth@redhat.com>
	<20190129145156.6719b8a4.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f98acef2-90b7-6ae3-682a-504a29ad57b4@redhat.com>
Date: Tue, 29 Jan 2019 16:05:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190129145156.6719b8a4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Fix LGPL version in the file
 header comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 1/29/19 2:51 PM, Cornelia Huck wrote:
> On Tue, 29 Jan 2019 14:37:47 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> It's either "GNU *Library* General Public License version 2" or
>> "GNU Lesser General Public License version *2.1*", but there was
>> no "version 2.0" of the "Lesser" license. So assume that version
>> 2.1 is meant here.
> 
> I think we can assume that.
> 
> Given that there have been several of these cases (and that there's a
> lot of boilerplate in general): Should we adopt SPDX license
> identifiers for QEMU, as the Linux kernel did? They also discovered and
> fixed some problems/oddities while at it.

This might be cheaper than adding checkpatch rules to parse current
licenses to avoid miswritten one coming back...

>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  target/s390x/cc_helper.c   | 2 +-
>>  target/s390x/excp_helper.c | 2 +-
>>  target/s390x/fpu_helper.c  | 2 +-
>>  target/s390x/gdbstub.c     | 2 +-
>>  target/s390x/helper.c      | 2 +-
>>  target/s390x/int_helper.c  | 2 +-
>>  target/s390x/mem_helper.c  | 2 +-
>>  target/s390x/misc_helper.c | 2 +-
>>  target/s390x/translate.c   | 2 +-
>>  9 files changed, 9 insertions(+), 9 deletions(-)
> 
> Is this going through the trivial tree? If so,
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> 
> I can also take this through the s390x tree.
> 
