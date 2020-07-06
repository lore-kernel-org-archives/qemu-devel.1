Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ED4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40F62070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40F62070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUxE-0006ug-US
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jsUY6-0008RZ-W7; Mon, 06 Jul 2020 13:04:59 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jsUY5-0006y8-4a; Mon, 06 Jul 2020 13:04:58 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M58vU-1jtb0f1Vy8-001ATT; Mon, 06 Jul 2020 19:04:49 +0200
Subject: Re: [PATCH] net/tap-solaris.c: Include qemu-common.h for TFR macro
To: Michele Denber <denber@mindspring.com>, Thomas Huth <thuth@redhat.com>
References: <20200704092317.12943-1-peter.maydell@linaro.org>
 <c247fc94-f8f7-efe1-017f-fc1c03fee811@redhat.com>
 <5F00C6D6.8010001@mindspring.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <239dfc36-404f-3439-3f1e-5d8750d31f5b@vivier.eu>
Date: Mon, 6 Jul 2020 19:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5F00C6D6.8010001@mindspring.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xhA1Ng56Q5KT+QSG8CDOkYFxyUYQZD6ZLBTwj3XnBU98OraeHKy
 I0oP8nQ3Ov8yLlDLV87LqGH7TQvpCxWmSsz+ljyOavB/y0JGneAlgV+aTBrQ3v89RY03Yp0
 NcQQGs3ByEBMZRxkea++vYJuYLtDmuCdDreh1xaJj3feu1mUZujaBVI0xMEannZcurNHFpm
 kSMf+QWmf/CqH3YBHWCdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U6E4iiTQ5NY=:Ro9bbPJ8hOTLs/7DcNIFTs
 p4fynjthnP+Z2mlBfV+rFk0JvybaU1HLRhK6hG29XmoWZMqmKubUrpx2eqxZFaxt1qk+ajESY
 r7jLiCY7gZW4xAr+/Eg9I8Q8HGguVz+NaCoWtcFqw86KbuPnzxA7FmPdjqgVwc1JOhQQ5rkgT
 sJQaTTp+Hjw7wvZWZ2ANPfLomQQNXEz+LIpRFnsAx5HUnolUt1dR6SD8x/VrMlg8G7JnpfSug
 fKmzQ5WnM9lB4gfEZYO4e/7BczIFBHai8wbbAg1jxVx+BA5K1m1ENEcYjIfMDI43QjjkWBZqP
 q5+jCDAYcwblj5PbTDRK0qCZlasvubLrGc0wT5f9UcCKcXSSLCx66VHPs6GahehA+sbwWVGSr
 KZ+d8GKR+SAZR8pFTkIm7iE+Ytye9LpuRzV2LT1CdlNIN8NqXS82Wjxq0TFpWR0/nW7mKJvhi
 rGWXQFPoW0UU2kag1BbQZuUB+D85kE+tjD5DluilEFwMls/MwybH45q/j03jWfH5JLK/4EoS0
 Ebrf55rzKKZJypJYU/l9XLsTtF8Ivge/YnamMZP7QQo2q1gkh5JYs8LKw1S2dCJ0a8jHWO7P2
 h4Ro/tGdOYH7mVG4oS8jcoO7sYSePlvrgbFMinRK4EWLDmYWJBCufqmt8XtRJIK6y4UZxNYKM
 F++VIPF/5UQ8b6e1BkeSKAZAwMBY9zwZ5XXpiDaHMwdQPriBDar2TFnNLVx+JRW7NUGAKaetc
 QubeFOkCuFmsT2tumJKAOeVEa3Dr1d/moSn1wPjt39EN6M1d4txljlhVbN7FOpeKaXe51rP9a
 1GXmsa8PZwFz5L9x5uEJ5TdthviGxWyvhugTMwQdqITl4zIMxXUHS9QevbF9rZaV9oGL8+U
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 12:24:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/07/2020 à 20:13, Michele Denber a écrit :
> On 07/04/20 13:11, Thomas Huth wrote:
>> On 04/07/2020 11.23, Peter Maydell wrote:
>>> In commit a8d2532645cf5ce4 we cleaned up usage of the qemu-common.h header
>>> so that it was always included from .c files and never from other .h files.
>>> We missed adding it to net/tap-solaris.c (which previously was pulling it
>>> in via tap-int.h), which broke building on Solaris hosts.
>>>
>>> Fixes: a8d2532645cf5ce4
>>> Reported-by: Michele Denber <denber@mindspring.com>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> Untested: Michele, could you give this a try?
>>> ---
>>>  net/tap-solaris.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
>>> index 4725d2314ee..d03165c57c9 100644
>>> --- a/net/tap-solaris.c
>>> +++ b/net/tap-solaris.c
>>> @@ -27,6 +27,7 @@
>>>  #include "tap_int.h"
>>>  #include "qemu/ctype.h"
>>>  #include "qemu/cutils.h"
>>> +#include "qemu-common.h"
>>>  
>>>  #include <sys/ethernet.h>
>>>  #include <sys/sockio.h>
>>>
> I can confirm that this works in Solaris 11.4:
> 
> root@hemlock:~/qemu-5.0.0# gpatch -p1 < tap-solaris.patch.diff
> patching file net/tap-solaris.c
> root@hemlock:~/qemu-5.0.0#

Do you mean building on Solaris hosts works well now?

In this case, you can add a "Tested-by:" tag.

Thanks,
Laurent


