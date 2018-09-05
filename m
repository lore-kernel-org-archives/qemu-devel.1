Received: from eggs.gnu.org ([2001:4830:134:3::10]:56782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fxPIh-0004Km-76
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 00:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fxPIc-0005XP-Vt
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 00:20:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:38526 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fxPIc-0005PX-De
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 00:20:14 -0400
References: <20180904110822.12863-1-fli@suse.com>
	<20180904110822.12863-5-fli@suse.com>
	<20180904111822.GD22349@redhat.com>
From: Fei Li <fli@suse.com>
Message-ID: <2dd320c6-7cf1-1cfc-4580-b588f4e9d1db@suse.com>
Date: Wed, 5 Sep 2018 12:20:08 +0800
MIME-Version: 1.0
In-Reply-To: <20180904111822.GD22349@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] qemu_thread_create: propagate the
 error to callers to check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org



On 09/04/2018 07:18 PM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Sep 04, 2018 at 07:08:21PM +0800, Fei Li wrote:
>> Add a new Error paramater for qemu_thread_create() to indicate if it
>> succeeds rather than failing with an error. And propagate the error
>> to let the callers check it.
>>
>> Besides, directly return if thread->data is NULL to avoid the
>> segmentation fault in qemu_thread_join in qemu-thread-win32.c.
>>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   include/qemu/thread.h    |  2 +-
>>   util/qemu-thread-posix.c | 15 +++++++++++----
>>   util/qemu-thread-win32.c | 12 +++++++++---
>>   3 files changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
>> index dacebcfff0..71d8be5851 100644
>> --- a/include/qemu/thread.h
>> +++ b/include/qemu/thread.h
>> @@ -137,7 +137,7 @@ void qemu_event_destroy(QemuEvent *ev);
>>  =20
>>   void qemu_thread_create(QemuThread *thread, const char *name,
>>                           void *(*start_routine)(void *),
>> -                        void *arg, int mode);
>> +                        void *arg, int mode, Error **errp);
> You've changed the API signature in this patch, but don't update any of
> the callers until the next patch. This means that the build will fail o=
n
> this patch.
>
> In order to ensure that "git bisect" can be usable we require that the
> code is able to build sucessfully on every patch in a series.
>
> So I think you'll have to merge patch 5 into this patch to ensure the
> build succeeds.
>
> Regards,
> Daniel
Oops, thanks for the reminder! Will merge them into one in the next versi=
on.

Have a nice day
Fei
