Received: from eggs.gnu.org ([2001:4830:134:3::10]:50103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gJf9T-000677-FH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gJeu4-0002Tu-DF
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:26:55 -0500
Received: from smtp43.i.mail.ru ([94.100.177.103]:42256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gJeu3-0001mO-TI
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:26:52 -0500
References: <20181105104524.933-1-jusual@mail.ru> <87va5bempd.fsf@linaro.org>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <e36f4d50-d76e-d7b6-e8dd-f961c4475eba@mail.ru>
Date: Mon, 5 Nov 2018 16:26:24 +0300
MIME-Version: 1.0
In-Reply-To: <87va5bempd.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] tests/microbit-test: Check nRF51 UART
 functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05.11.2018 15:24, Alex Bennée wrote:
> 
> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org> writes:
> 
>> Some functional tests for:
>>      Basic reception/transmittion
>>      Suspending
>>      INTEN* registers
>>
>> Based-on: <20181031002526.14262-1-contrib@steffen-goertz.de>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> ---
>> This patch was part of nRF51 UART patchset, but wasn't included in the latest
>> revision. Due to upcoming loader fixes, we need this test instead of
>> boot-serial-test, which doesn't support -device loader.
> 
> This didn't apply cleanly to master as the test isn't there yet. But the
> uart patches look partially merged. Can I have a reference for the
> series or tree please?

The patch is based on this patchset (patches 7 & 10):
	https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06718.html
Uart patchset was fully merged except this patch.

Best regards, Julia Suvorova.
