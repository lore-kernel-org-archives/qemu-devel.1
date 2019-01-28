Received: from eggs.gnu.org ([209.51.188.92]:55454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go4hQ-0001q2-HA
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go4hP-0003EQ-6c
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:03:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1go4hO-0003C4-W2
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:03:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so13512447wmj.1
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 03:03:23 -0800 (PST)
References: <20190125192719.15339-1-philmd@redhat.com>
	<20190125192719.15339-4-philmd@redhat.com>
	<154f8a45-723d-6f3c-a278-1767361bc94e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6c12ece7-96c8-b96a-edb6-b7ef376ebf6a@redhat.com>
Date: Mon, 28 Jan 2019 12:03:21 +0100
MIME-Version: 1.0
In-Reply-To: <154f8a45-723d-6f3c-a278-1767361bc94e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] WIP tests/vm: Run tests on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 1/28/19 9:44 AM, Thomas Huth wrote:
> On 2019-01-25 20:27, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  tests/vm/openbsd | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>> index cfe0572c59..de907dd21c 100755
>> --- a/tests/vm/openbsd
>> +++ b/tests/vm/openbsd
>> @@ -25,9 +25,7 @@ class OpenBSDVM(basevm.BaseVM):
>>          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>>          tar -xf /dev/rsd1c;
>>          ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
>> -        gmake --output-sync -j{jobs} {verbose};
>> -        # XXX: "gmake check" seems to always hang or fail
>> -        #gmake --output-sync -j{jobs} check {verbose};
>> +        gmake --output-sync -j{jobs} check {verbose};
>>      """
>>  
>>      def build_image(self, img):
>>
> 
> Please add a proper patch description and remove the WIP from the subject.

Oops :/ I thought about renaming this also NOTFORMERGE.

The description could be:

  OpenBSD tests are still failing, but this patch help to test
  the improvement of the previous 2 patches (disable W^X, disable
  assert(fcntl)).
