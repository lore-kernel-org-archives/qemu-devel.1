Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D11C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725E320878
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725E320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzZ6-0000tR-5L
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kRzYI-0000Ig-DS; Mon, 12 Oct 2020 11:15:56 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kRzYD-00053A-EW; Mon, 12 Oct 2020 11:15:54 -0400
Received: from [192.168.100.1] ([82.252.141.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M6VNX-1kYrAN1oUL-006vG8; Mon, 12 Oct 2020 17:15:42 +0200
Subject: Re: [PATCH] mingw: Fix builds on f33 mingw
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201008174359.157627-1-dgilbert@redhat.com>
 <7f8ffa77-cc95-b121-0da8-269d37c52830@redhat.com>
 <fa6c8769-b1d7-cd75-2c2e-d8bc74ebe51e@vivier.eu>
 <CAFEAcA9T-81tXcM1A0b-y-_ZkC_0sqJ8cQuEvDkfbobXJQr70Q@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <286fd85f-7a0e-faed-cec0-1ecb6605b4e3@vivier.eu>
Date: Mon, 12 Oct 2020 17:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9T-81tXcM1A0b-y-_ZkC_0sqJ8cQuEvDkfbobXJQr70Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SdLQBrDkl3sfwOtcOp1BK3wa9UG0YaKjK7qhSngh71/9yR1FSee
 sZgeILXpSwkyyxgvMTewwtVXv/I6VMaGxT6m3v9TQo56VLhQOjgmoJKvtE8+P1Dut1QEAu6
 lGAtao/o42U1yF90iK0X5K6s5hKeDqzCOTCl0/w8Tk9bGVcLEEXtzNyQF0Y1rEcUGN2gt+3
 OfmYQnn7mPVzR2syPKUZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uA/0cMjuxl4=:6EyW8JwiEsYbJBZbzajQG6
 oqn8XijJN4j7LP+Bp4Pjv/33QFG2rCxNtPREAGVz/L4a832rN7Njlc0cli4K0un5YybO4vVhr
 EK7dLKEqjSSKUxD8ukcFmfRfp2g839u0rXBcT1mNlm+VVTUGyWWIrLeeg3rsNNDkKlp+kthmx
 X83CInVcaDTKhBSI2SHGcciA8/Y+5i+tovXX8f3p8gq5Ag6GZ1D3Y1+ayqi9CcsyP3pUi8+x3
 Ubv3CPjMe7l1BurVTaXldFXHcvGtamcCviTiGMebPcrxgSPjPrP3UQJAcMX9+6NkgOkGC1VBO
 ZPIX2qf1zZcd80rt2ruUzuZn6MhnuycKaW2f4d+cQM+h4Q359QmDeevgSWEiQKPkmIZP8Dczu
 wGy57sCLQenNAaUxLKpTY2ZAyz8idHU05xZfCobTFurRpdAw7QJJSWmjctm+4Brt652qPHbrS
 PhJ6yvLDcCh5P/H3CYrpDeBCQ+bsJ6ahyxE+wjw09PQ0E7qjtXHf3zGRfo+5xJ/bQDu4kf1I/
 XYrZAQfsUXvpaf+WFkNSoLeY03nUxQ6OEYsoV3HT/Hher0SSqQDDFLHDx5ouaWPHqB258/nxu
 p3jycrRgoKP/9wjpGpg4tuOqIqSmLIHCDykZJVNITpwzQbEZILqxlXfcvJ2rX13CIYr6thaK6
 c7Glw3uACEbHnBtt61TU0R8rHm0uHdudIfAE8xSrxt9YVOHbDJu3WTzWBw+v4gZ0iL4ri965Z
 GYoa2FicBev++pvQJvBJdSXi7bhcjZMl5umXud7ou/64l9TjcXUs6Y+7bIrDGFqzXD+dyOVoe
 TTsRGIWUDhkHJV0QraR3YkdgeSTELXlKyShnGo2UCTKVzAivipTa4MVssZtAMxz2B6/JjKt
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 10:12:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/10/2020 à 17:05, Peter Maydell a écrit :
> On Mon, 12 Oct 2020 at 15:39, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 08/10/2020 à 19:46, Thomas Huth a écrit :
>>> On 08/10/2020 19.43, Dr. David Alan Gilbert (git) wrote:
>>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>>
>>>> Fedora 33's mingw moans about:
>>>>
>>>> In file included from ../tests/test-bitmap.c:12:
>>>> /home/dgilbert/git/migpull/include/qemu/osdep.h:76: error: "__USE_MINGW_ANSI_STDIO" redefined [-Werror]
>>>>    76 | #define __USE_MINGW_ANSI_STDIO 1
>>>>       |
>>>>
>>>> the fix is to make sure osdep.h is the first include - which is our
>>>> rule anyway; but one we broke in a couple of places.
>>>>
>>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> ---
>>>>  migration/dirtyrate.c | 2 +-
>>>>  tests/test-bitmap.c   | 2 +-
>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>>>> index ab9e1301f6..42b71e771e 100644
>>>> --- a/migration/dirtyrate.c
>>>> +++ b/migration/dirtyrate.c
>>>> @@ -10,8 +10,8 @@
>>>>   * See the COPYING file in the top-level directory.
>>>>   */
>>>>
>>>> -#include <zlib.h>
>>>>  #include "qemu/osdep.h"
>>>> +#include <zlib.h>
>>>>  #include "qapi/error.h"
>>>>  #include "cpu.h"
>>>>  #include "qemu/config-file.h"
>>>> diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
>>>> index 2f5b71458a..c3c9d79667 100644
>>>> --- a/tests/test-bitmap.c
>>>> +++ b/tests/test-bitmap.c
>>>> @@ -8,8 +8,8 @@
>>>>   * Author: Peter Xu <peterx@redhat.com>
>>>>   */
>>>>
>>>> -#include <stdlib.h>
>>>>  #include "qemu/osdep.h"
>>>> +#include <stdlib.h>
>>>>  #include "qemu/bitmap.h"
>>>>
>>>>  #define BMAP_SIZE  1024
>>>>
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>
>>>
>>
>> Applied to my trivial-patches branch.
> 
> This is the wrong version of this patch -- can you take
> Marc-André's instead, please?

Yes, queueing instead:

"[PATCH v2] mingw: fix error __USE_MINGW_ANSI_STDIO redefined"

Thanks,
Laurent



