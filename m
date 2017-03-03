Received: from eggs.gnu.org ([2001:4830:134:3::10]:32906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjtOI-00044h-3s
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:01:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjtOF-0006uH-P6
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:01:26 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjtOF-0006u6-L5
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:01:23 -0500
Received: by mail-qk0-x243.google.com with SMTP id g129so1542752qkd.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 12:01:23 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <148856356236.7604.4296371092878661257.stgit@bahia.lan>
	<20170303175454.GN13631@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <57fa744d-c9d5-0a85-5cee-653dd658d38b@amsat.org>
Date: Fri, 3 Mar 2017 17:01:19 -0300
MIME-Version: 1.0
In-Reply-To: <20170303175454.GN13631@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix fd leak in local_opendir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

On 03/03/2017 02:54 PM, Daniel P. Berrange wrote:
> On Fri, Mar 03, 2017 at 06:52:42PM +0100, Greg Kurz wrote:
>> Coverity issue CID1371731
>>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
>> ---
>>  hw/9pfs/9p-local.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
>> index e31309a29c58..fe930300445a 100644
>> --- a/hw/9pfs/9p-local.c
>> +++ b/hw/9pfs/9p-local.c
>> @@ -435,6 +435,7 @@ static int local_opendir(FsContext *ctx,
>>
>>      stream = fdopendir(dirfd);
>>      if (!stream) {
>> +        close(dirfd);
>>          return -1;
>>      }
>>      fs->dir.stream = stream;
>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>
> Regards,
> Daniel
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
