Received: from eggs.gnu.org ([2001:4830:134:3::10]:42394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYUJY-00019T-0C
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYUJT-0000QB-2o
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:38:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYUJS-0000Om-Ss
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:38:06 -0400
References: <1526977831-31129-1-git-send-email-thuth@redhat.com>
	<f5537d6c-b213-b982-0a63-1c9c397f807e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <82420aa0-cae3-2244-3f4e-62e0e1136c14@redhat.com>
Date: Thu, 28 Jun 2018 12:38:03 +0200
MIME-Version: 1.0
In-Reply-To: <f5537d6c-b213-b982-0a63-1c9c397f807e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/boot-serial: Do not delete the
 output file in case of errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

On 27/06/2018 12:16, Thomas Huth wrote:
> On 22.05.2018 10:30, Thomas Huth wrote:
>> Peter reported that the boot-serial tester sometimes runs into timeouts
>> with SPARC guests. It's currently completely unclear whether this is due
>> to too much load on the host machine (so that the guest really just ran
>> too slow), or whether there is something wrong with the guest's firmware
>> boot. For further debugging, we need the serial output of the guest in
>> case of errors, so instead of unlinking the file immediately, this is
>> now only done in case of success. In case of error, print the name of the
>> file with the serial output via g_error() (which then also calls abort()
>> internally to mark the test as failed).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/boot-serial-test.c | 17 +++++++++--------
>>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> Ping!
> 
> Paolo, could you take this patch through your misc / character devices
> tree, please?
> 
>  Thanks,
>   Thomas
> 

Done, thanks.

Paolo
