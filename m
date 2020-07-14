Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91CAC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD064206F0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD064206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvFNb-0000Sk-0Q
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 03:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFMw-0008Sx-7K
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:28:50 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFMu-0001L5-72
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:28:49 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M2OAi-1jsTwh0Sly-003rDo; Tue, 14 Jul 2020 09:28:37 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: Josh Kunz <jkz@google.com>, qemu-devel@nongnu.org
References: <20200710195328.587462-1-jkz@google.com>
 <c5af9eb0-c01a-b624-e753-f7533e4e2772@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: Add several IFTUN ioctls
Message-ID: <34c4dbf2-b7b5-dad9-962a-f15c8e3b2f64@vivier.eu>
Date: Tue, 14 Jul 2020 09:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c5af9eb0-c01a-b624-e753-f7533e4e2772@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ySB60QB14wL4ZNUbq8Qpvn9vD2mF/NxEfRUmYvlcY3/ohVtm35w
 YXBSSyX/gs9SwmXcHYD4rHpZEaF5UIZsX5FRuydwImJhghCrn4HCxiUkgYcfMJWjT8prd6H
 2glFihpnvKsYph7+8XbAPSO1TOMOLw0273gY/agqCaTotn4KddJk4KCuOQUjiqBYUEkp+/0
 KyZ02ctRQfIqSjQHKwMIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ePcYCCUM6Tk=:0u1OkouPjpYQjYJPaVdfuC
 fyjXN0b5hOi21yKnPhtumYZecIFcMqKTNL0YhHfSN5BN6G5SeaRZQ2nOCNLTAue0yCwziC8JB
 K5kXsutLYvCsxukhsLQ21v3AnwqcIUHEhF52M626DxsuQaBvF5bCH12v9J6L9PkpyiXnn3pfv
 FQuF8wUzhuXmpFmXnvAS8cIos1/dwQRMK/UbOm9cBhxBQL8JOOY8YySEFn8nzD2qM/ponplCq
 VZ+MESNQ7+xsHhE5vvgJfcH6mmftHUhZFlqczEmNSML70z78n2WjJ9t00KyAW2RBLPzJQvUwt
 mT3JaZW7ASxbuKUfwsLkG6hp3G6pcLm8EKMVSIRxz41J1iFsJhFuXvi0Xk+TU6NXPNFUJIkcb
 k45sCkh++wKv59EFHRtuh/h2cwmGDHquBQ82ohv+LLGDTuJVNG7CMm8f4h3im5ATik1GOBaHn
 Z8W0vqJzbEJowO5uOwKtEjd8Sx0CI/b6nbZd6SSIsEIz6SeIEP/vnzCTsMkigdVOVVzM3zFmz
 HbckGJNMmpAh2deSefBgsUW5uLUk8499RPVQHEy37K3bBwE3iMdFbRx9x1eSaibm3qcrgLpND
 R4Oav4+N0yli+TemgJFuL6V9t5fEk0WM72SvRqKZbLBRARELXgULHmPYJcDhBjGMmVEe7frax
 MZu07WTcEwsqB6I8TCwZ6g6VrbFptonAI248H73qYz2BuqFJ55rkHxbOWUeyZQGUdrOflsFZW
 GLNv68RKBrYlW8oV4a3uFNJNiLPb/U0H7u83h/kPaGr3RqeEXTK5V6HaAziQEdnlrK7hV2vP3
 nmLJinsVj9v9gG37OUoYkDIp8tmw4RmS9cTLNDBS+qQ7mvN532AFjsuejxJT3lXNhIwVE0T
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:28:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/07/2020 à 21:28, Laurent Vivier a écrit :
> Le 10/07/2020 à 21:53, Josh Kunz a écrit :
>> This change includes most widely-available if_tun ioctls that are
>> integer typed.
>>
>> Tested by compiling all linux-user emulators. This patch has also been
>> used successfully to run several binaries that utilize these ioctls for
>> several months.
>>
>> Linux Header:
>> https://github.com/torvalds/linux/blob/dcde237b9b0eb1d19306e6f48c0a4e058907619f/include/uapi/linux/if_tun.h#L31
>>
>> Signed-off-by: Josh Kunz <jkz@google.com>
>> ---
>>  linux-user/ioctls.h       | 20 ++++++++++++++++++++
>>  linux-user/syscall.c      |  1 +
>>  linux-user/syscall_defs.h | 21 +++++++++++++++++++++
>>  3 files changed, 42 insertions(+)
>>
>> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
>> index 0713ae1311..9b4a67fe84 100644
>> --- a/linux-user/ioctls.h
>> +++ b/linux-user/ioctls.h
>> @@ -593,3 +593,23 @@
>>    IOCTL(KCOV_DISABLE, 0, TYPE_NULL)
>>    IOCTL(KCOV_INIT_TRACE, IOC_R, TYPE_ULONG)
>>  #endif
>> +
>> +  IOCTL(TUNGETFEATURES  , IOC_R , TYPE_INT)
>> +  IOCTL(TUNGETIFF       , IOC_R , TYPE_INT)
>> +  IOCTL(TUNGETSNDBUF    , IOC_R , TYPE_INT)
>> +  IOCTL(TUNGETVNETHDRSZ , IOC_R , TYPE_INT)
>> +  IOCTL(TUNGETVNETLE    , IOC_R , TYPE_INT)
>> +  IOCTL(TUNSETDEBUG     , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETGROUP     , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETIFF       , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETIFINDEX   , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETLINK      , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETNOCSUM    , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETOFFLOAD   , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETOWNER     , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETPERSIST   , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETQUEUE     , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETSNDBUF    , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETTXFILTER  , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETVNETHDRSZ , IOC_W , TYPE_INT)
>> +  IOCTL(TUNSETVNETLE    , IOC_W , TYPE_INT)
...
>>
> 
> Applied to my linux-user-for-5.1 branch.

This patch fails ioctls03 LTP tests on some archs (s390x for instance),
TUNGETFEATURES returns unknown features.

Your patch is not correct, definitions should use MK_PTR(...) rather
than TYPE_INT (and some of them are not based on int but on more complex
structures). Your patch only works with guest with same endianness and
word size.

I remove it from the queue.

Thanks,
Laurent

