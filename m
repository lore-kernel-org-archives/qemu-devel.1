Received: from eggs.gnu.org ([2001:4830:134:3::10]:35058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMRcJ-0004jy-2a
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMRcF-0001y9-Tg
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:19:47 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:40237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMRcF-0001xv-P2
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:19:43 -0400
Received: by mail-qk0-x244.google.com with SMTP id r66-v6so5678082qkr.7
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:19:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-3-f4bug@amsat.org> <876080oiky.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a88ad136-02b4-0997-696c-cde307b6983f@amsat.org>
Date: Sat, 26 May 2018 02:19:40 -0300
MIME-Version: 1.0
In-Reply-To: <876080oiky.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/8] docker: do not display deprecated
 images in 'make docker' help
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

On 01/17/2018 08:01 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> the 'debian' base image is deprecated since 3e11974988d8
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Can you also queue this patch?

> 
>> ---
>>  tests/docker/Makefile.include | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index ef95703cef..d5cf896966 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -4,7 +4,8 @@
>>
>>  DOCKER_SUFFIX := .docker
>>  DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
>> -DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker))))
>> +DOCKER_DEPRECATED_IMAGES := debian
>> +DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>>  DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>>  # Use a global constant ccache directory to speed up repetitive builds
>>  DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
>> @@ -63,7 +64,7 @@ docker-image-debian-win64-cross: docker-image-debian8-mxe
>>  docker-image-travis: NOUSER=1
>>
>>  # Expand all the pre-requistes for each docker image and test combination
>> -$(foreach i,$(DOCKER_IMAGES), \
>> +$(foreach i,$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES), \
>>  	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
>>  		$(eval .PHONY: docker-$t@$i) \
>>  		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
> 
> 
> --
> Alex Bennée
> 
