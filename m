Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60773CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387A520659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387A520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhMs-0000rT-BS
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNgpb-0007q5-Ay
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNgpZ-0004ot-V8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:23:27 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:54601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNgpZ-0004oT-KX; Thu, 24 Oct 2019 13:23:25 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MHGPA-1iAVYm3rIO-00DISK; Thu, 24 Oct 2019 19:23:21 +0200
Subject: Re: [PATCH] qemu-options.hx: Update for reboot-timeout parameter
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Han Han <hhan@redhat.com>
References: <20191015151451.727323-1-hhan@redhat.com>
 <87d0epqp5r.fsf@dusky.pond.sub.org>
 <1a07f8dd-88e8-c8f0-f76e-2fe62259cac3@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f149a9d6-83eb-c9f7-ab27-94bae0c10a23@vivier.eu>
Date: Thu, 24 Oct 2019 19:23:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1a07f8dd-88e8-c8f0-f76e-2fe62259cac3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LtcqubGEJHfgHFpiyEnz4efuOVv14JWefdoXMF/DqPja7YU7ozf
 zWneC3YnCZYLti+EBoHJg6yxb3dzHs8WSHok/7UyAAz847jruq5htAEeUW/O4sNdMnnjPhC
 oDQMBpmW5Oo6mwuCK+Qul4px1KIVuOGI+a+/3eOeecT3GW8tZ95leQOK1bH4HXzzfAZIiOz
 CSp0gqVjLC7HdIOD07ChQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I3c8X5G0/RE=:ahwWKOrklsGTLdT4aPpl3Z
 9k/CdStpbmZvBpOVG0t+33XYAkwMUI7Uw8gklOGEjYYpol4XxtSQkUulBDtRT/zjiS+6kg/F5
 JZ1tFBw1JkIx3SWj9K+aI8RwMHaTW3uZDHCOzmA4doRFBmfoXXRJpxv27ncBfYZ9yYG/ohq9h
 acugOQSO/ocSEIRIguZ3axnXr4uX2iYJnGiEUfFc412bkRouSC4El47pwhnBwQOTeGGKQZTfs
 7+qcjxGznzk3DNE4UnTKjrqTjfmBlj0zCW556MMaLkIMEvBm0vg8FNrETpq6nEb1HMz1g3daP
 bULGk79H9Mar2Zh8FjVF9QzkOSxnFcoQRJUSF4ViGvFRB6tHz9D9WBFAyzoWBI4fLJ5VRHkUB
 jcoFyGAkvNSFaYDOM/LZZdYGXtfNTzE2BTH3n1aVypcONxtMKIMzuu9DpTV4gxRMW1UulUE2s
 NujQLOebaWyztoi2WAm8+zg+5Vf75TBT+H4Zxc4rext7S0KAW+m1aGB6frSCL3mWl/oDv40JV
 9U8ycmm3Eam4vkw1hOQ2nUJMQum/zZ/+2P+9TcCjVjZZ6xUkTd2fazkqzCgOVcjeeHPgPygC2
 4QFBBJiep5IuD7hxsJiS4GAiAkYdVyXFm+BeSVuM+A0AsYtxbYe3dntfHX+yY2O32bCO8A+2q
 jW26cTrFZFbOnBvreeeGiShB/rvmm4AvvbkfRUKJkWv+6WW2Z52zSeuAOpt7+N0Rtj/+q1Sl4
 adYhtdhYP87hqfq+VVxOAHEQYtg7PIjprXro0qTxC4pdSU15yp6WYetietGCoEP/uXusRMhSm
 uHptjubdhWektk00H9xOJ7vMxKjeybSQkmrsUFpMFaA0ThYwEWbnTHRRQU4CRM50qgYXhGoqC
 u/6vAwtxFiQyD2VNzgwOKFxqx8kiSBS6Bmul07vuc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 22/10/2019 à 14:52, Philippe Mathieu-Daudé a écrit :
> On 10/22/19 8:18 AM, Markus Armbruster wrote:
>> Han Han <hhan@redhat.com> writes:
>>
>>> Since ee5d0f89d, -1 is not valid for the value of reboot-timeout. Update
>>> that in qemu-options doc.
>>>
>>> Signed-off-by: Han Han <hhan@redhat.com>
>>> ---
>>>   qemu-options.hx | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index 793d70ff..6b92a916 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -327,8 +327,8 @@ format(true color). The resolution should be
>>> supported by the SVGA mode, so
>>     A splash picture could be passed to bios, enabling user to show it
>> as logo,
>>     when option splash=@var{sp_name} is given and menu=on, If
>> firmware/BIOS
>>     supports them. Currently Seabios for X86 system support it.
>>     limitation: The splash file could be a jpeg file or a BMP file in
>> 24 BPP
>>     format(true color). The resolution should be supported by the SVGA
>> mode, so
>>>   the recommended is 320x240, 640x480, 800x640.
>>>     A timeout could be passed to bios, guest will pause for
>>> @var{rb_timeout} ms
>>> -when boot failed, then reboot. If @var{rb_timeout} is '-1', guest
>>> will not
>>> -reboot, qemu passes '-1' to bios by default. Currently Seabios for X86
>>> +when boot failed, then reboot. If @option{reboot-timeout} is not set,
>>> +guest will not reboot by default. Currently Seabios for X86
>>>   system support it.
>>>     Do strict boot via @option{strict=on} as far as firmware/BIOS
>>
>> Preexisting: "could be passed" sounds awkward.  Same in the previous
>> paragraph.  Not this patch's problem, so:
>>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> I assume this patch will go via qemu-trivial.
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

