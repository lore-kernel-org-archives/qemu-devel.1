Received: from eggs.gnu.org ([2001:4830:134:3::10]:54396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etaLA-0006o5-J4
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etaL5-000786-JV
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:46:48 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etaL5-00077k-Dk
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:46:43 -0500
Received: by mail-wm0-f65.google.com with SMTP id s206so23059781wme.0
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 06:46:43 -0800 (PST)
References: <20180306161728.20890-1-marcandre.lureau@redhat.com>
	<20180307013831.GF13844@lemon.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2dc92ab1-b655-ba85-76cd-dd433bfe643f@redhat.com>
Date: Wed, 7 Mar 2018 15:46:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180307013831.GF13844@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] build-sys: make help could have 'modules'
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 07/03/2018 02:38, Fam Zheng wrote:
> On Tue, 03/06 17:17, Marc-André Lureau wrote:
>> Available when configure --enable-modules.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>  Makefile | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index 9a75c48ae0..5d9ef3b8fd 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1046,6 +1046,9 @@ include $(SRC_PATH)/tests/vm/Makefile.include
>>  help:
>>  	@echo  'Generic targets:'
>>  	@echo  '  all             - Build all'
>> +ifdef CONFIG_MODULES
>> +	@echo  '  modules         - Build all modules'
>> +endif
> 
> Hi Marc-André,
> 
> I'd just remove the 'ifdef' condition and include the line everywhere, since
> this is the help. The behavior is fine even without running ./configure:
> 
> $ make modules
> make: Nothing to be done for 'modules'.
> $ make all
> make: Nothing to be done for 'all'.
> 
> Fam
> 

Queued, thanks.

Paolo
