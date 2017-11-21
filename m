Received: from eggs.gnu.org ([2001:4830:134:3::10]:45870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eH5D2-00079C-E7
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eH5Cz-00058T-CL
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:51:16 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171121032119.14442-1-f4bug@amsat.org>
	<20171121060102.GB28270@lemon>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9fe7a88d-29ec-f268-9e6d-9ba7583e9fea@amsat.org>
Date: Tue, 21 Nov 2017 06:51:06 -0300
MIME-Version: 1.0
In-Reply-To: <20171121060102.GB28270@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] Makefile: use $(MAKE) variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On 11/21/2017 03:01 AM, Fam Zheng wrote:
> On Tue, 11/21 00:21, Philippe Mathieu-Daudé wrote:
>> @@ -904,7 +904,7 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
>>  		echo $$? >$*.test.exit, \
>>  		"TEST","$*.out")
>>  	@diff -q $(SRC_PATH)/$*.out $*.test.out
>> -	@# Sanitize error messages (make them independent of build directory)
>> +	@# Sanitize error messages ($(MAKE) them independent of build directory)
> 
> This doesn't look like a good candidate, does it?

Oops...
