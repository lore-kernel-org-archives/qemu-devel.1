Received: from eggs.gnu.org ([2001:4830:134:3::10]:39270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da4kb-0002af-61
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da4ka-0003Xi-CJ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:40:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170725061158.10745-1-f4bug@amsat.org>
	<865f533b-8fe7-dd3d-be79-c2852ef0508d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0f4e83c9-c0bf-d5a3-45f9-2a95839b0581@amsat.org>
Date: Tue, 25 Jul 2017 15:39:57 -0300
MIME-Version: 1.0
In-Reply-To: <865f533b-8fe7-dd3d-be79-c2852ef0508d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Makefile: add
 all-user/all-linux-user/all-softmmu meta-targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On 07/25/2017 06:49 AM, Paolo Bonzini wrote:
> On 25/07/2017 08:11, Philippe Mathieu-Daudé wrote:
>> Useful to build a whole set at once.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   Makefile | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 5f18243d05..da899522e4 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -814,6 +814,11 @@ endif
>>   # Dependencies in Makefile.objs files come from our recursive subdir rules
>>   -include $(wildcard *.d tests/*.d)
>>   
>> +.PHONY: subdir-all-user subdir-all-linux-user subdir-all-softmmu
>> +subdir-all-user: $(patsubst %,subdir-%,$(filter %-user,$(TARGET_DIRS)))
>> +subdir-all-linux-user: $(patsubst %,subdir-%,$(filter %-linux-user,$(TARGET_DIRS)))
>> +subdir-all-softmmu: $(patsubst %,subdir-%,$(filter %-softmmu,$(TARGET_DIRS)))
> 
> I'm not sure why you need subdir-all-linux-user.  I think it's okay to

Indeed, subdir-all-user is enough.

> add these, but please add "romsubdir-all" too.  This way "all" can use
> "subdir-all-user subdir-all-softmmu romsubdir-all" and you can remove
> "recurse-all".

Ok.

> 
> Paolo
> 
>>   include $(SRC_PATH)/tests/docker/Makefile.include
>>   
>>   .PHONY: help
>> @@ -827,7 +832,7 @@ help:
>>   	@echo  ''
>>   	@$(if $(TARGET_DIRS), \
>>   		echo 'Architecture specific targets:'; \
>> -		$(foreach t, $(TARGET_DIRS), \
>> +		$(foreach t, $(TARGET_DIRS) all-user all-linux-user all-softmmu, \
>>   		printf "  %-30s - Build for %s\\n" $(patsubst %,subdir-%,$(t)) $(t);) \
>>   		echo '')
>>   	@echo  'Cleaning targets:'
>>
> 
