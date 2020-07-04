Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4756C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE5B2145D
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="lEirzSmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE5B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmgC-0006H7-Qd
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrmfd-0005nP-Dc; Sat, 04 Jul 2020 14:13:49 -0400
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:50706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrmfb-0007Bb-ET; Sat, 04 Jul 2020 14:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593886427; bh=YGMKMa+vTB4LsPWqzqVkOcc2TiujminyZma1
 ZHPHpGw=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:
 X-Originating-IP; b=lEirzSmOrM+h4w4uVYO6dqWytEAcQg+Nn5vSx+ceFeqNyH
 es8dlBNemj5q878ngPhXeh5nHgPsdOW+o/4EEAJDoh8jBrThRUmtSKFnJKlVh3Up5LG
 TNYoOhWWSOrbubox1Kxkwo7VcSWjvFKwJqJkxPdP41r168SzEQtBoLcot2I1GuFNPd7
 sGe0pSnfJTPSa3FA5Hl2yEt4oWDhH9X/rmnSatbqSQG73O2HUuKbRhBxmu6gIGG+83c
 VJkAKLQm0IZYB/VoAX8qHyI4Of0lJs+FkJPo8ONNLn3P6xCH7Le5Xd9Yw30HKQ+jx6p
 SAF7Mo1onq6DcFDTuFD4YkqnFyaA==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=bCx5X2QuJU3ex2VJL8TOfgbThc5EQvaBJVCug+LfS4qwiwV1SfAoF3eLbpQc3nGpjrdQ9pbARN1Z7IUJfGejouoy+cSRH0Zkv0luq/a4UsMcdhrckzNO1vDhErGJ5mYX7JJix5hzIrrs1fdasie8H8f+RyeA5TxAPB2nWqjcuYVYfIEoMqD0BjsIyE91uXiJcFuWKGur2JvUt/TqOBhzS93WML2U9Kqkeo4c6+xXb5DEyGitAbhPiXBdOqxmd4afVG2MKKbw0sjVTUyknElMgl4F5LsWM57ZAUdYUFI6NDHkdec+w6GUF9ZWGiiCHxxq8jOeUTmeBgzBuPlkI4kTqg==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-dupuy.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jrmfX-000BZw-Jb; Sat, 04 Jul 2020 14:13:43 -0400
Message-ID: <5F00C6D6.8010001@mindspring.com>
Date: Sat, 04 Jul 2020 14:13:42 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] net/tap-solaris.c: Include qemu-common.h for TFR macro
References: <20200704092317.12943-1-peter.maydell@linaro.org>
 <c247fc94-f8f7-efe1-017f-fc1c03fee811@redhat.com>
In-Reply-To: <c247fc94-f8f7-efe1-017f-fc1c03fee811@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------030702040502050707010206"
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca53bfc07c2c7148f61e09c666de9206b95350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.62; envelope-from=denber@mindspring.com;
 helo=elasmtp-dupuy.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 14:13:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------030702040502050707010206
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/04/20 13:11, Thomas Huth wrote:
> On 04/07/2020 11.23, Peter Maydell wrote:
>> In commit a8d2532645cf5ce4 we cleaned up usage of the qemu-common.h header
>> so that it was always included from .c files and never from other .h files.
>> We missed adding it to net/tap-solaris.c (which previously was pulling it
>> in via tap-int.h), which broke building on Solaris hosts.
>>
>> Fixes: a8d2532645cf5ce4
>> Reported-by: Michele Denber<denber@mindspring.com>
>> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
>> ---
>> Untested: Michele, could you give this a try?
>> ---
>>   net/tap-solaris.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
>> index 4725d2314ee..d03165c57c9 100644
>> --- a/net/tap-solaris.c
>> +++ b/net/tap-solaris.c
>> @@ -27,6 +27,7 @@
>>   #include "tap_int.h"
>>   #include "qemu/ctype.h"
>>   #include "qemu/cutils.h"
>> +#include "qemu-common.h"
>>
>>   #include<sys/ethernet.h>
>>   #include<sys/sockio.h>
>>
I can confirm that this works in Solaris 11.4:

root@hemlock:~/qemu-5.0.0# gpatch -p1 < tap-solaris.patch.diff
patching file net/tap-solaris.c
root@hemlock:~/qemu-5.0.0#


             - Michele


--------------030702040502050707010206
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 07/04/20 13:11, Thomas Huth wrote:
    <blockquote
      cite="mid:c247fc94-f8f7-efe1-017f-fc1c03fee811@redhat.com"
      type="cite">
      <pre wrap="">On 04/07/2020 11.23, Peter Maydell wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">In commit a8d2532645cf5ce4 we cleaned up usage of the qemu-common.h header
so that it was always included from .c files and never from other .h files.
We missed adding it to net/tap-solaris.c (which previously was pulling it
in via tap-int.h), which broke building on Solaris hosts.

Fixes: a8d2532645cf5ce4
Reported-by: Michele Denber <a class="moz-txt-link-rfc2396E" href="mailto:denber@mindspring.com">&lt;denber@mindspring.com&gt;</a>
Signed-off-by: Peter Maydell <a class="moz-txt-link-rfc2396E" href="mailto:peter.maydell@linaro.org">&lt;peter.maydell@linaro.org&gt;</a>
---
Untested: Michele, could you give this a try?
---
 net/tap-solaris.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 4725d2314ee..d03165c57c9 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -27,6 +27,7 @@
 #include "tap_int.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu-common.h"
 
 #include &lt;sys/ethernet.h&gt;
 #include &lt;sys/sockio.h&gt;

</pre>
      </blockquote>
    </blockquote>
    I can confirm that this works in Solaris 11.4:<br>
    <br>
    <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a>
        gpatch -p1 &lt; tap-solaris.patch.diff<br>
        patching file net/tap-solaris.c<br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> </font></small><br>
    <br>
    <br>
                - Michele<br>
    <br>
  </body>
</html>

--------------030702040502050707010206--

