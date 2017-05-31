Received: from eggs.gnu.org ([2001:4830:134:3::10]:51977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dG48b-0003O1-Cx
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dG48Y-0003xw-Ov
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:13 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dG48Y-0003xX-Fw
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:10 -0400
Received: by mail-pf0-x244.google.com with SMTP id u26so2623618pfd.2
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:58:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <149623617700.4947.12490877660892961664.stgit@bahia.lan>
	<c7e20195-8fa4-c081-b63d-02e380e8b909@de.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f8165bd2-fb74-4ff9-65bf-fd0ed1a3ffaf@amsat.org>
Date: Wed, 31 May 2017 10:58:06 -0300
MIME-Version: 1.0
In-Reply-To: <c7e20195-8fa4-c081-b63d-02e380e8b909@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] pc-bios/s390-ccw: use STRIP variable in
 Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Fam Zheng <famz@redhat.com>, Alexander Graf <agraf@suse.de>

> On 05/31/2017 03:09 PM, Greg Kurz wrote:
>> The docker-run-test-build@debian-s390x-cross target fails with:
>>
>> strip --strip-unneeded s390-ccw.elf -o s390-ccw.img
>> strip: Unable to recognise the format of the input file `s390-ccw.elf'
>>
>> The configure script defines a STRIP makefile variable whose default
>> value is ${cross_prefix}strip. Let's use it.
>>
>> We default to using the non-prefixed strip command in case --enable-debug
>> or --disable-strip was passed to configure during a regular build.
>>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
>> ---
>> v2: - added default value
>>     - no longer Cc: qemu-trivial as it turned out to be not that trivial
>>
>> Philippe,
>>
>> Please give your Reviewed-by again if you're okay with this change.

I'm Ok but it got applied faster ;)

>> ---
>>  pc-bios/s390-ccw/Makefile |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
>> index 79a46b67356f..fb88c13bc742 100644
>> --- a/pc-bios/s390-ccw/Makefile
>> +++ b/pc-bios/s390-ccw/Makefile
>> @@ -21,8 +21,10 @@ build-all: s390-ccw.img
>>  s390-ccw.elf: $(OBJECTS)
>>  	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(TARGET_DIR)$@")
>>
>> +STRIP ?= strip
>> +
>>  s390-ccw.img: s390-ccw.elf
>> -	$(call quiet-command,strip --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
>> +	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
>>
>>  $(OBJECTS): Makefile
>>
>>
> applied, thanks.
