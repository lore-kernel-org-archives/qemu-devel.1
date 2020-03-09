Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3A9C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131F420675
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131F420675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHy2-0001FS-7w
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBHxH-0000V4-7B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBHxD-0000qo-Ra
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:56:22 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42173)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBHxD-0000kv-Ih; Mon, 09 Mar 2020 08:56:19 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N4Q8u-1jIbgc2uP8-011VBi; Mon, 09 Mar 2020 13:56:00 +0100
Subject: Re: [PATCH v3 11/12] usb/hcd-ehci: Remove redundant statements
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
 <20200302130715.29440-13-kuhn.chenqun@huawei.com>
 <e786f342-7ba6-1c25-dea7-a34372a4ff81@vivier.eu>
 <7412CDE03601674DA8197E2EBD8937E83B67D5D6@dggemm511-mbx.china.huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <85ae07ca-3751-305e-618d-1ab741e9cdbc@vivier.eu>
Date: Mon, 9 Mar 2020 13:55:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B67D5D6@dggemm511-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wbR5t0XVnl5VVGV4MSgxCKgg9PT2a08/+I+Y6lVxE+l98ffFBGZ
 fKYZIGIX/e89XtQUse2339npPWi3UGrG2dvEOByGGHfALfgIeOmLC1dDpSDkPSrm3EnRwRT
 3GjVWIgfd+3oPSB80pz4GL9C39OHLWd8KtUBRnUEyhwK/4lWrbuY8v+Xnu6wbe7vce8vo2g
 91s/bQ7YQ8IL3Ahc2tBXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ceOf0KLACEo=:ESRNaeotz4H9DuaaCOQd1a
 Nbgg+LXpl7JA9usnzHylckWn5mAXS/xPOCwQkFVLMZDnfiC2mXGs49trr8belxtpotQSVKHhm
 t++z57A3fwTpVirdudmIIY2qCMmL4gPD5Qt0QxbFRFQV3kaDaPaIK8FP0hjdEqE5fJxQpMWAn
 3JmK6q6YML/MvaYJ0UKhbAAPPCiA9SlcuxsO+Tw16EwrUAi8hia8pHdric+o9kvaJIriEiy3S
 lTyQgg02MKiOBC4tOKTe4g/lcd13cDAukAmiAu8QUPXVAwpAH7xHmdKs1KtVl88vyhaK53VYc
 eg/ORQ4UWUoAi1Xa/02fk1V29zt/kMOUaDIkpMHzgvzL873xwQKe/GUgDZ/ImTzX0tMb8kW8C
 HIToxqo75hj6YLwexmT5dlYxbbDZC+ZETvrRleHnXrZXIwk+ekADVKQmh0xsuOLMVIGCqE++u
 nd9izw0DwX51RX7V/EIVM/HsLvXa68XJc4tExGwRhTpIIdp/CSKJwZ4rapitLmOJYZCjQRj1N
 J/AlAcZSeFGNsUG9truUpdmUss9dNgVmH8l5ux++fl1BjY16F7b/iwNxckSsC2R3vSXE38KPO
 R84JpCz84QTdlXdaQzG9CyMcx5HFmrKWwZIEb2ZCBQD6TimS8j7l2uIHTjbdcNksDR1W91/jH
 rlDOzfLEdfw04pjcpyNv+rKCELX872UuSpIDH+75IwEqgjbZQhayxsSlfeQvwV7F3e6sadxoZ
 4rA6oKMweY/wbKt3lLlr75jUJzFTUD69lq9lErGF2I1rtNd/ZylIY3QBa0qk1oPJQIz1KJJaQ
 6B1bJvd+6LcG+O5MsKnilbjQpurmwZWru1r11an0gg8lFonIi/QIiGrs6+mFNAu+Hfc7yqx
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/03/2020 à 13:52, Chenqun (kuhn) a écrit :
> 
>> -----Original Message-----
>> From: Laurent Vivier [mailto:laurent@vivier.eu]
>> Sent: Monday, March 9, 2020 8:43 PM
>> To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>; qemu-
>> devel@nongnu.org; qemu-trivial@nongnu.org
>> Cc: peter.maydell@linaro.org; Zhanghailiang
>> <zhang.zhanghailiang@huawei.com>; Gerd Hoffmann <kraxel@redhat.com>;
>> Euler Robot <euler.robot@huawei.com>; Philippe Mathieu-Daudé
>> <philmd@redhat.com>
>> Subject: Re: [PATCH v3 11/12] usb/hcd-ehci: Remove redundant statements
>>
>> Le 02/03/2020 à 14:07, Chen Qun a écrit :
>>> The "again" assignment is meaningless before g_assert_not_reached.
>>> In addition, the break statements no longer needs to be after
>>> g_assert_not_reached.
>>>
>>> Clang static code analyzer show warning:
>>> hw/usb/hcd-ehci.c:2108:13: warning: Value stored to 'again' is never read
>>>             again = -1;
>>>             ^       ~~
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  hw/usb/hcd-ehci.c | 3 ---
>>>  1 file changed, 3 deletions(-)
>>>
>>> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c index
>>> 56ab2f457f..29d49c2d7e 100644
>>> --- a/hw/usb/hcd-ehci.c
>>> +++ b/hw/usb/hcd-ehci.c
>>> @@ -1301,7 +1301,6 @@ static void ehci_execute_complete(EHCIQueue *q)
>>>          /* should not be triggerable */
>>>          fprintf(stderr, "USB invalid response %d\n", p->packet.status);
>>>          g_assert_not_reached();
>>> -        break;
>>>      }
>>>
>>>      /* TODO check 4.12 for splits */
>>> @@ -2105,9 +2104,7 @@ static void ehci_advance_state(EHCIState *ehci,
>>> int async)
>>>
>>>          default:
>>>              fprintf(stderr, "Bad state!\n");
>>> -            again = -1;
>>>              g_assert_not_reached();
>>> -            break;
>>>          }
>>>
>>>          if (again < 0 || itd_count > 16) {
>>>
>>
>> Applied to my trivial-patches branch.
>>
> Hi, Laurent
> 
> Gerd has added a patch to the USB queue today.
> 
> https://patchwork.kernel.org/patch/11405615/
>

Ok, removing it from mine.

Thanks,
Laurent


