Received: from eggs.gnu.org ([209.51.188.92]:59354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hAwbj-0008UJ-9d
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hAwbg-00063G-Em
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:04:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hAwbd-00062b-Uw
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:04:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so11926676wrq.8
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 06:04:05 -0700 (PDT)
References: <20190401082655.8272-1-aruna.15@cse.mrt.ac.lk>
	<20190401082655.8272-2-aruna.15@cse.mrt.ac.lk>
	<20190401093932.GC3524@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7cc37594-f222-dbb8-8a6f-d315d18e3647@redhat.com>
Date: Mon, 1 Apr 2019 15:04:02 +0200
MIME-Version: 1.0
In-Reply-To: <20190401093932.GC3524@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] Header cleanups- Tabs replaced with
 spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

On 4/1/19 11:39 AM, Daniel P. Berrangé wrote:
> On Mon, Apr 01, 2019 at 01:56:55PM +0530, Aruna Jayasena wrote:
>> Declarations were moved out of qemu-common.h for functions declared in utils/ files.
>> This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
>>
>> Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
>>
>> ---
>>  include/qemu/id.h       | 4 ++--
>>  include/qemu/readline.h | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/qemu/id.h b/include/qemu/id.h
>> index 3a651fb9d2..f3451344e2 100644
>> --- a/include/qemu/id.h
>> +++ b/include/qemu/id.h
>> @@ -1,8 +1,8 @@
>>  #ifndef QEMU_ID_H
>>  #define QEMU_ID_H
>>  
>> -#define qemu_isalnum(c)		isalnum((unsigned char)(c))
>> -#define qemu_isalpha(c)		isalpha((unsigned char)(c))
>> +#define qemu_isalnum(c)    isalnum((unsigned char)(c))
>> +#define qemu_isalpha(c)    isalpha((unsigned char)(c))
>>  
>>  typedef enum IdSubSystems {
>>      ID_QDEV,
>> diff --git a/include/qemu/readline.h b/include/qemu/readline.h
>> index 4cbf7ead5a..67859a3028 100644
>> --- a/include/qemu/readline.h
>> +++ b/include/qemu/readline.h
>> @@ -1,7 +1,7 @@
>>  #ifndef READLINE_H
>>  #define READLINE_H
>>  
>> -#define qemu_isspace(c)		isspace((unsigned char)(c))
>> +#define qemu_isspace(c)    isspace((unsigned char)(c))
>>  
>>  #define READLINE_CMD_BUF_SIZE 4095
>>  #define READLINE_MAX_CMDS 64
> 
> This should just be fixed when moving the macros out of qemu-common.h

Hmm I did a series following your suggestion of using g_ascii_*()
instead of qemu_* helpers, and plan to send it for 4.1. Eventually
Aruna's work can go on top...

> 
> Regards,
> Daniel
> 
