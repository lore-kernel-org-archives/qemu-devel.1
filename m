Received: from eggs.gnu.org ([2001:4830:134:3::10]:56279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAa3H-0005pW-VT
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAa3E-0004zY-Qw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:22:19 -0400
References: <1509701953-8995-1-git-send-email-thuth@redhat.com>
	<20171103101341.GE20155@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2f044593-fb74-6633-3f94-9a6da1c6d9b5@redhat.com>
Date: Fri, 3 Nov 2017 12:22:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171103101341.GE20155@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: Run the test-crypto-block only if
 encryption is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 03.11.2017 11:13, Daniel P. Berrange wrote:
> On Fri, Nov 03, 2017 at 10:39:13AM +0100, Thomas Huth wrote:
>> The test-crypto-block currently fails if encryption has not been
>> compiled into QEMU
[...]
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 434a2ce..ac46aea 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -145,7 +145,7 @@ check-unit-$(if $(CONFIG_NETTLE_KDF),y,$(CONFIG_GCRYPT_KDF)) += tests/test-crypt
>>  check-unit-y += tests/test-crypto-ivgen$(EXESUF)
>>  check-unit-y += tests/test-crypto-afsplit$(EXESUF)
>>  check-unit-y += tests/test-crypto-xts$(EXESUF)
>> -check-unit-y += tests/test-crypto-block$(EXESUF)
>> +check-unit-$(call lor,$(CONFIG_NETTLE_KDF),$(CONFIG_GCRYPT_KDF)) += tests/test-crypto-block$(EXESUF)
> 
> This is disabling the entire test suite, even though only the LUKS part of
> the test suite has problems. Can you just extend the logic for setting the
> TEST_LUKS condition in the test source code instad. 

Ah, ok, that sounds of course like the better solution, I'll have a try...

 Thomas
