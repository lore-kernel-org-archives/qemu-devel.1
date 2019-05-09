Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2447BC04AB3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE372173C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE372173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56773 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlGA-00085d-7Q
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:47:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOlDg-0006ac-GW
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOlDf-0005SN-HK
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:44:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOlDf-0005Pf-7i
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:44:27 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MxmBi-1gVIDG0Pd8-00zHDM; Thu, 09 May 2019 17:44:24 +0200
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190118213122.22865-1-richard.henderson@linaro.org>
	<20190118213122.22865-48-richard.henderson@linaro.org>
	<86bae9b3-75c8-64df-92d1-b4efc35b646c@vivier.eu>
	<c1dc5dbc-cbc7-16a3-9d14-c93b52c362fd@vivier.eu>
	<2004b6c4-0aea-f535-d2bc-80d5c14537be@linaro.org>
	<d0735945-f5de-5ddc-327a-53eaec40d0d1@linaro.org>
	<48937430-bbb1-6c26-3fae-6cc841580555@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8e4caba8-4e69-8af3-5c78-afafd9f8182c@vivier.eu>
Date: Thu, 9 May 2019 17:44:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <48937430-bbb1-6c26-3fae-6cc841580555@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uUYZm1BjLmRdaR8YuIv36/ro2p1UYGfnt+6nGmTzbJQyxnMaiqT
	Wu+ymcveXmLNaiyyt73nl+WtBasQ+bTRXfddwiRTtrnOCW31DlViBwy5g+Fuavlcq9TtBGG
	VbiFILRCibkV0VNwaJqzK1OVWWihM4/ZQOdAJuOAUPHTU3Nppy1QtVvyKIaaP9m3EvVQ5if
	SYM8puH2yIfGc1DRINSjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aphW2srHRY0=:PoGnRE/4w10GJFldfZG8kZ
	EO39PzVvqfcullLxgY2W05g0/dZq4BNYNwnfQsbpZ/Ni7tCY1ZcZDj4sKQg3COxxgEmgBBJaT
	h3vTrW8ew3L7Wjx6S3AatsXyczHSAvofHcCYSYBx7+CAOBmWaMISiSrHdAkTbW4O6mG7NplpO
	EmGmjSkR22F3hOUzR4HZ7aA7e3W27QlFGFWesR3Al0ogs3mQ0AtgJ+gSP95vExwYbjQFLk4Yg
	6K9O02xrq0DpE/dCRdDLrEOz6viJFWefo1jtO0dYrifsHjRPZF8itGBHUTxpwV2qbXtLgMhsG
	5e8L2/M7eGMtdBCF8KrPk524VRMbk0BS+F9/LCjMYyg23FR4Na9HvpvYyXLxJL5z1ENpqsSWt
	cjAxK6iK9EkRJw5AG56EU27gI9QpciWPWrZN9tXKWWP3+1MbDjCWVo6wOZzQk/pitoAYBDDMW
	Jd3AspWIW2K9j/BzQr53aMiwWSpJ2zspzUz3D36h6eLUQacdjxrWn2l4pk1RGIHdUEjBlqUmz
	7nsih017/+8Tc0R6CP2NZXrUBJP87LWwZvzSRs8nJcUm1ZxZQSeQGdACGSZJGoLVDHjkB3XgK
	u6CDTs2tkeP1UwF7kS0VudW+JrlqQyuoacu9cUqoieaqPwUado3PrLwiB3+SX1qrtopXqgRL9
	M3iqFqMXtcrxOoLMur6uQiKpuSYB0/5OMZis/XWAO6/MUX2uqBFgwy5rnipNnAuVj7topdKCv
	W8OVgwsi53KCJE7Dhc3X4RGeZyENBTT9iKS/vKKTSVy1qxSO/E5VyIMDHXk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: Re: [Qemu-devel] [PATCH v6 48/49] linux-user: Split out ioctl
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/04/2019 03:55, Richard Henderson wrote:
> On 4/9/19 1:30 PM, Richard Henderson wrote:
>> On 4/9/19 1:15 PM, Richard Henderson wrote:
>>> On 2/13/19 3:46 AM, Laurent Vivier wrote:
>>>> In fact it happens with sid, with ppc64 too, but not with m68k and sh4.
>>>>
>>>> And only with "unshare --pid --fork".
>>>>
>>>> Without "unshare", the result is:
>>>>
>>>>    Unsupported ioctl: cmd=0x80047476
>>>>    bash: cannot set terminal process group (11507): Function not implemented
>>>>    bash: no job control in this shell
>>>>    Unsupported ioctl: cmd=0x80087467
>>>>    Unsupported ioctl: cmd=0x80087467
>>>>    Unsupported ioctl: cmd=0x802c7415
>>>
>>> I'm just now getting back to this, and cannot replicate the issue
>>
>> ... Oh nevermind.  I should be expecting no "unsupported" at all, since that's
>> what we get with master.
> 
> The cause is that "cmd" accidentally changed from "int" in the do_ioctl
> parameter list to "abi_ulong" as a local variable in impl_ioctl.  This caused a
> table lookup failure on any ioctl with bit 31 set, for 64-bit guests.

Do you plan to send a new version of this series?

Thanks,
Laurent

