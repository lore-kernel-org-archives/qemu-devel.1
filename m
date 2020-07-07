Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C387FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D942082E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="UdnePe6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D942082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspTf-0000f1-RN
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jspRP-0005cK-NK; Tue, 07 Jul 2020 11:23:28 -0400
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:34792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jspRM-0006iC-IE; Tue, 07 Jul 2020 11:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1594135404; bh=uHzcXWkanjDGXsdATJqbJLqiQPlekOd/41+y
 2sw7x5g=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP; b=UdnePe6
 uB8B9hxIBFglzalpokPQ5UA4sFYiE7C48uZb8U2yHi9T4k9jP3DkPuqX0gZoz/ZDDH1
 8opVRFad0wyJJnSKl78sXPIs8GnoiaeNm3xqUwGJwQyXgPtry3Chk5kfYOifDMm+wSv
 EC8TRzHZwYf0QaW1GtEq07+abXbWD9KZAcwlf9udh+9CRX7oAQRihKPfhk/g1xRDK83
 m+R1OFF2k7t7yclUfyRHCTxwXIS1J52CgzdWQLVyn9OoUmRn8J9v6GGhiQ6IopWRiPa
 U8Czlq+RCGJSK814JfZ6UUv18M2br9Tdcf76WukE5n/NkLUCWNgRXgOTRSNA16iFWuA
 ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=oGTvd0i65KMvBW35t7eaUxRrYJyXBscfdNJ7df3aFaDXlYCRXkCCS+bdJyKQXk9FE7xFExq5xrbQxj9EESoNf/QsIygDaatbUsr2uaeaAOa3RkzVMmgAvhEvtVzbyVZJwFxisuTBWTeMZ8+kChNZmR/l37HpC62CS7MMW6nE+12QhGotpeVT4huZEI5Pm7yHUGFIcpI74b5l1eE9PF45DENnROUBlnio4Dfw3s4oG3qetUgTegV8q7p7oQyaCTrNs1PdScajBH4pgILk5Ssa4CwB49FREiCbHz95MvU7EghmH5OHxu7hvxrX7kxMQ3Uxw4I+3fKvFqMKVlwcTGyWYQ==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-galgo.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jspRF-0002b6-H7; Tue, 07 Jul 2020 11:23:17 -0400
Message-ID: <5F049364.7050002@mindspring.com>
Date: Tue, 07 Jul 2020 11:23:16 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] net/tap-solaris.c: Include qemu-common.h for TFR macro
References: <20200704092317.12943-1-peter.maydell@linaro.org>
 <c247fc94-f8f7-efe1-017f-fc1c03fee811@redhat.com>
 <5F00C6D6.8010001@mindspring.com>
 <239dfc36-404f-3439-3f1e-5d8750d31f5b@vivier.eu>
In-Reply-To: <239dfc36-404f-3439-3f1e-5d8750d31f5b@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca5f98d7afda05fd72219fb38001a926c67350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.61; envelope-from=denber@mindspring.com;
 helo=elasmtp-galgo.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 11:23:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 07/06/20 13:04, Laurent Vivier wrote:
> Le 04/07/2020 à 20:13, Michele Denber a écrit :
>> On 07/04/20 13:11, Thomas Huth wrote:
>>> On 04/07/2020 11.23, Peter Maydell wrote:
>>>> In commit a8d2532645cf5ce4 we cleaned up usage of the qemu-common.h header
>>>> so that it was always included from .c files and never from other .h files.
>>>> We missed adding it to net/tap-solaris.c (which previously was pulling it
>>>> in via tap-int.h), which broke building on Solaris hosts.
>>>>
>>>> Fixes: a8d2532645cf5ce4
>>>> Reported-by: Michele Denber<denber@mindspring.com>
>>>> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
>>>> ---
>>>> Untested: Michele, could you give this a try?
>>>> ---
>>>>   net/tap-solaris.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
>>>> index 4725d2314ee..d03165c57c9 100644
>>>> --- a/net/tap-solaris.c
>>>> +++ b/net/tap-solaris.c
>>>> @@ -27,6 +27,7 @@
>>>>   #include "tap_int.h"
>>>>   #include "qemu/ctype.h"
>>>>   #include "qemu/cutils.h"
>>>> +#include "qemu-common.h"
>>>>
>>>>   #include<sys/ethernet.h>
>>>>   #include<sys/sockio.h>
>>>>
>> I can confirm that this works in Solaris 11.4:
>>
>> root@hemlock:~/qemu-5.0.0# gpatch -p1<  tap-solaris.patch.diff
>> patching file net/tap-solaris.c
>> root@hemlock:~/qemu-5.0.0#
> Do you mean building on Solaris hosts works well now?
In that message I meant that the tap-solaris patch worked.  However, 
yes, I have now successfully built all of QEMU 5.0 on Solaris 11.4 SPARC.
>
> In this case, you can add a "Tested-by:" tag.
I'd be glad to but how do I do that?

             - Michele


