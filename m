Received: from eggs.gnu.org ([2001:4830:134:3::10]:51254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnvP-0008Ik-3x
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnvL-0001RH-6M
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:38:43 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:46483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnvK-0001Qk-W2
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:38:39 -0500
Received: by mail-qk0-x241.google.com with SMTP id l64so25145340qke.13
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 05:38:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180112125000.27256-1-f4bug@amsat.org>
	<20180112125000.27256-3-f4bug@amsat.org>
	<c90deebc-f06f-4d68-ed27-d210849eb5c0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <22982079-8433-ae79-7cc0-bcf99fcae289@amsat.org>
Date: Wed, 17 Jan 2018 10:38:34 -0300
MIME-Version: 1.0
In-Reply-To: <c90deebc-f06f-4d68-ed27-d210849eb5c0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/7] docker: do not display deprecated
 images in 'make docker' help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <fzheng@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 01/16/2018 11:10 PM, Fam Zheng wrote:
> On 01/12/2018 08:49 PM, Philippe Mathieu-Daudé wrote:
>> the 'debian' base image is deprecated since 3e11974988d8
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   tests/docker/Makefile.include | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/Makefile.include
>> b/tests/docker/Makefile.include
>> index ef95703cef..f0cd26c2b6 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -4,7 +4,8 @@
>>     DOCKER_SUFFIX := .docker
>>   DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
>> -DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard
>> $(DOCKER_FILES_DIR)/*.docker))))
>> +DOCKER_DEPRECATED_IMAGES := debian
>> +DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort
>> $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>>   DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>>   # Use a global constant ccache directory to speed up repetitive builds
>>   DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
> 
> While we are at it, could you please just spell out this list
> explicitly, consistent to how we build obj-y variables?

What I like with the current approach is one can have
more/different/specific images to run the tests, without having to
pollute upstream with plenty of more docker images (you just drop your
Dockerfile in DOCKER_FILES_DIR and 'make docker-test' run them all).
