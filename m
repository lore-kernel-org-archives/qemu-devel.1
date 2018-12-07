Received: from eggs.gnu.org ([2001:4830:134:3::10]:37479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVLW1-0002ax-DR
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 14:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVLVy-0004wl-8Z
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 14:10:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gVLVy-0004vp-1v
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 14:10:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so4746106wrt.13
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 11:10:16 -0800 (PST)
References: <20181207161447.31314-1-philmd@redhat.com>
	<77cd62fe-4b9e-88ac-b048-1d4a6ee5ff83@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4d87dd89-cfe8-5f51-4f57-744a4a2e4846@redhat.com>
Date: Fri, 7 Dec 2018 20:10:13 +0100
MIME-Version: 1.0
In-Reply-To: <77cd62fe-4b9e-88ac-b048-1d4a6ee5ff83@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] util/error: Remove an unnecessary NULL
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On 12/7/18 7:16 PM, Thomas Huth wrote:
> On 2018-12-07 17:14, Philippe Mathieu-Daudé wrote:
>> This NULL check was required while introduced in 680d16dcb79f.
>> Later refactor added a NULL check in error_setv(), so this check
>> is now redundant.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  util/error.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/util/error.c b/util/error.c
>> index b5ccbd8eac..934a78e1b1 100644
>> --- a/util/error.c
>> +++ b/util/error.c
>> @@ -103,10 +103,6 @@ void error_setg_errno_internal(Error **errp,
>>      va_list ap;
>>      int saved_errno = errno;
> 
> Could the saved_errno now be removed, too, since err_setv does that again?

Yes, good idea, I'll send another patch.

> 
>  Thomas
> 
> 
>> -    if (errp == NULL) {
>> -        return;
>> -    }
>> -
>>      va_start(ap, fmt);
>>      error_setv(errp, src, line, func, ERROR_CLASS_GENERIC_ERROR, fmt, ap,
>>                 os_errno != 0 ? strerror(os_errno) : NULL);
>>
> 
> 
