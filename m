Received: from eggs.gnu.org ([209.51.188.92]:34990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1goxps-0003rv-9q
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 16:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1goxpr-0006Kb-HC
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 16:55:56 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-6-crosa@redhat.com>
	<20190118142830.GB24013@localhost.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <5a978376-1fdd-46eb-8876-fecf8497effa@redhat.com>
Date: Wed, 30 Jan 2019 16:49:35 -0500
MIME-Version: 1.0
In-Reply-To: <20190118142830.GB24013@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/18] Acceptance tests: introduce arch
 parameter and attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Caio Carrara <ccarrara@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>



On 1/18/19 9:28 AM, Caio Carrara wrote:
> Hi, Cleber.
> 
> On Thu, Jan 17, 2019 at 01:56:15PM -0500, Cleber Rosa wrote:
>> It's useful to define the architecture that should be used in
>> situations such as:
>>  * the intended target of the QEMU binary to be used on tests
>>  * the architecture of code to be run within the QEMU binary, such
>>    as a kernel image or a full blown guest OS image
>>
>> This commit introduces both a test parameter and a test instance
>> attribute, that will contain such a value.
>>
>> Now, when the "arch" test parameter is given, it will influence the
>> selection of the default QEMU binary, if one is not given explicitly
>> by means of the "qemu_img" parameter.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  docs/devel/testing.rst                    | 18 ++++++++++++++++++
>>  tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++++---
>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>> index 44c9b3ae74..60a16c5834 100644
>> --- a/docs/devel/testing.rst
>> +++ b/docs/devel/testing.rst
>> @@ -689,6 +689,17 @@ vm
>>  A QEMUMachine instance, initially configured according to the given
>>  ``qemu_bin`` parameter.
>>  
>> +arch
>> +~~~~
>> +
>> +The architecture that will be used on a number of different
>> +scenarios.  For instance, when a QEMU binary is not explicitly given,
>> +the one selected will depend on this attribute.
>> +
>> +The ``arch`` attribute will be set to the test parameter of the same
>> +name, and if one is not given explicitly, it will default to the
>> +system architecture (as given by ``uname``).
> 
> Would you think it's important to make explicit that it's the *host*
> system architecture? Just like you did in the docstrings of
> pick_default_qemu_bin().
> 

Yes, you're right.  Adding that.
