Received: from eggs.gnu.org ([209.51.188.92]:39798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gvlwe-0001tW-W4
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gvlwe-0007Yw-92
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:39:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gvlwd-0007Sy-1B
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:39:03 -0500
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
	<BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7f53b5d1-f0a7-6d51-a647-a1b98cd50a75@redhat.com>
Date: Mon, 18 Feb 2019 17:38:50 +0100
MIME-Version: 1.0
In-Reply-To: <BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: qemu-devel@nongnu.org

On 18/02/2019 17.02, Stephen Checkoway wrote:
> 
> 
> On Feb 18, 2019, at 08:43, Thomas Huth <thuth@redhat.com> wrote:
> 
>> I think you could use one of the machines that has a cfi02 on board. For
>> example: Write some random data to a temporary file. Run qemu with:
>>
>> QTestState *qts;
>> qts = qtest_initf(" qemu-system-arm -M musicpal,accel=qtest "
>>                "-drive if=pflash,file=%s,format=raw", filename);
> 
> If I do that, will it be possible for the test to override the properties set by pflash_cfi02_register? It looks like I should be able to use -global to set properties that aren't set explicitly.

Yes, I'm also not an expert in that area, but I think -global should do
the job here.

 Thomas
