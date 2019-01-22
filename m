Received: from eggs.gnu.org ([209.51.188.92]:37544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gm2dR-0006Hm-10
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gm2dO-000813-Tx
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:27:00 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gm2dL-0007yW-5W
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:26:56 -0500
Received: by mail-pf1-x444.google.com with SMTP id w73so12309227pfk.10
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:26:54 -0800 (PST)
References: <cover.1547166960.git.balaton@eik.bme.hu>
	<86de9750-304d-dc0f-3c09-76667ad3c643@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e2c30f65-1d58-608e-0b1d-a8373a406cc3@linaro.org>
Date: Tue, 22 Jan 2019 12:26:50 -0800
MIME-Version: 1.0
In-Reply-To: <86de9750-304d-dc0f-3c09-76667ad3c643@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] Refactor common PCI IDE functions from
 CMD646
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

On 1/21/19 5:44 PM, John Snow wrote:
>> BALATON Zoltan (5):
>>   cmd646: Remove unused variable
>>   cmd646: Remove IDEBus from CMD646BAR
>>   cmd646: Move PCI IDE specific functions to ide/pci.c
>>   ide: Get rid of CMD646BAR struct
>>   sii3112: Remove duplicated code and use PCI IDE ops instead
>>
>>  hw/ide/cmd646.c      | 102 ++++++++-------------------------------------------
>>  hw/ide/pci.c         |  65 ++++++++++++++++++++++++++++++++
>>  hw/ide/sii3112.c     |  52 ++++----------------------
>>  include/hw/ide/pci.h |  14 ++-----
>>  4 files changed, 93 insertions(+), 140 deletions(-)
>>
> 
> Richard, any strong feelings on this? I'm inclined to pull it this weekend.

Please do.


r~
