Received: from eggs.gnu.org ([209.51.188.92]:47770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMtDs-0003Gt-NA
	for qemu-devel@nongnu.org; Sat, 04 May 2019 07:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMtDr-0003zD-LL
	for qemu-devel@nongnu.org; Sat, 04 May 2019 07:52:56 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMtDr-0003ym-FW
	for qemu-devel@nongnu.org; Sat, 04 May 2019 07:52:55 -0400
Received: by mail-wr1-f49.google.com with SMTP id l2so11083215wrb.9
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 04:52:55 -0700 (PDT)
References: <20190312234541.2887-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d5d84efd-ef8c-4e0d-d48a-6996d91832e7@redhat.com>
Date: Sat, 4 May 2019 13:52:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190312234541.2887-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Acceptance Tests: Test the
 Raspberry Pi 2 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>

On 3/13/19 12:45 AM, Philippe Mathieu-Daudé wrote:
> Add the raspi2 to the list of boards tested by the
> boot_linux_console Avocado test.
> 
> Based on "Acceptance Tests: target architecture support" v5:
> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04111.html
> Based-on: <20190312171824.5134-1-crosa@redhat.com>
> 
> Philippe Mathieu-Daudé (2):
>   BootLinuxConsoleTest: Let extract_from_deb handle various compressions
>   Boot Linux Console Test: add a test for the Raspberry Pi 2
> 
>  tests/acceptance/boot_linux_console.py | 34 ++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)

I was hoping this series would be included in "Acceptance Tests: target
architecture support" by Eduardo (removing the 'print' debug line) but I
just realized I forgot to Cc him :S
