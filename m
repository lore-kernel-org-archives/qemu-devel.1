Received: from eggs.gnu.org ([2001:4830:134:3::10]:38857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvNcB-00082w-3X
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvNc7-0000WO-9Y
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:03:31 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:48418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvNc7-0000Ve-2h
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:03:27 -0400
Received: by mail-wr0-x232.google.com with SMTP id 108so897181wra.5
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 06:03:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170921122528.GF32364@stefanha-x1.localdomain>
References: <20170921013821.1673-1-jsnow@redhat.com>
	<20170921122528.GF32364@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 14:03:05 +0100
Message-ID: <CAFEAcA_OLRBFYBW5-4_KEen=TuVoFghXYuCDCu3q-2M5s=2_FA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] ide: fix enum comparison for gcc 4.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 21 September 2017 at 13:25, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Wed, Sep 20, 2017 at 09:38:21PM -0400, John Snow wrote:
>> Apparently GCC gets bent over comparing enum values against zero.
>> Replace the conditional with something less readable.
>>
>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> ---
>>
>> v2: Second verse, same as the first.
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  hw/ide/ahci.c             | 2 +-
>>  hw/ide/core.c             | 2 +-
>>  include/hw/ide/internal.h | 3 +--
>>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied to master as a buildfix.

-- PMM
