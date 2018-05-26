Received: from eggs.gnu.org ([2001:4830:134:3::10]:34734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMRaR-0003uw-1h
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMRaN-0000sD-SA
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:17:51 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:38720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMRaN-0000rw-My
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:17:47 -0400
Received: by mail-qk0-x241.google.com with SMTP id c23-v6so5669940qkb.5
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:17:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-2-f4bug@amsat.org> <878tcwomfm.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <56ff485a-7f6e-353a-b232-f5370e851923@amsat.org>
Date: Sat, 26 May 2018 02:17:42 -0300
MIME-Version: 1.0
In-Reply-To: <878tcwomfm.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/8] docker: sort images list displayed
 by 'make docker'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi Alex,

On 01/17/2018 06:37 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> we can now directly see different version sort consecutively.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> I of course meant:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Can you queue this patch please?

> 
> 
>> ---
>>  tests/docker/Makefile.include | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index de87341528..ef95703cef 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -4,7 +4,7 @@
>>
>>  DOCKER_SUFFIX := .docker
>>  DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
>> -DOCKER_IMAGES := $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))
>> +DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker))))
>>  DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>>  # Use a global constant ccache directory to speed up repetitive builds
>>  DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
> 
> 
> --
> Alex Bennée
> 
