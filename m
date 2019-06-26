Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E98C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B7F20644
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B7F20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgAw4-0001Bc-PG
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 12:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57488)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgAn3-0002L5-VW
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgAn3-0005hh-0Y
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:28:57 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57007)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hgAn0-0005eb-IP; Wed, 26 Jun 2019 12:28:54 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MxUfh-1iUOr71fLd-00xtrV; Wed, 26 Jun 2019 18:28:36 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190605131221.29432-1-marcandre.lureau@redhat.com>
 <b66f43e4-e176-67d7-388b-23e04cff0884@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <8212139b-80a7-3af8-6af1-0c004ec2fe82@vivier.eu>
Date: Wed, 26 Jun 2019 18:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b66f43e4-e176-67d7-388b-23e04cff0884@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bj854EWvvWZ+CYMLSosg+n9yAbPLn+YCYEEpM6ZTH9uolkWAmjH
 25GkDZbwCF2aNl2KHARxl4IUzfVgBgYv9TiXwSabK1Afr4FNawn/CRTQZulT2exPkO7+8kG
 4yvqAd0uiLs5j5tCwD9LH23HB1iN3Jrg0frnJ6TA1sRLz1YuNUin/88TGy5ScWD6bERgLNO
 M2ObohyR0OG+xjGsEo9kQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h7QtK/8Ylpg=:+CBVo2X9UakLs43IxwqGWQ
 351EE+yjv75QjZnUZvoEKRjbqZj9oPjEm2OI2PdO1w0OxJyg8R6MV0zNGmhpZ6KH8rlKnTLpW
 x17UZoPtS3V839c9y0UKQcR33h4uFuNHHHM0c5kbbqqH4P+qR6W/pIOG9jZBC1YENxi1tvE1w
 QOFxgXI44v86S8CmYmK57tsovh9EY5x5s2QW2jDhy5RUXZRnLisYm64Lv0RbPijzUY+eF9COC
 vVZT0c3LNsttgWtif+RV3U7g/cgZDx5snamEqO2BVMTN+kmhmDcC5PLTl8D/KRt1KQpdAMXgF
 Ty7gDLvoXKasdJ00es6MtAtpof50QVe5akTADNZGJdpLgIxiakLT9mI9SVzQAJOGEx8b5IbVM
 YVHeCOLsc2QHhKUtT0/vHUOAkG33GXzt478gfD7Gd8qopmborKsEO4HXo+CgGMgivgpaoaRcz
 cUox14gVicz+Wvb2GJ2NV09huZP9E7c0o8RsXkiq/Yvo7cGfdVpwQg3UerNbGtzjhg42hrm4f
 HL72fIbG4Qf+Ty6S8WeHQFq1qInYMIHN64Z6jdQw8/C2aBahQL3Yt6GPMMopLdqfADWOvGKKE
 a9NPI8GNT+VP1lwg7vt8LQ00J4o5Fackqn2XEK+iyW4Ya7UOyWybgvv3X8DODt+hiCBWMLQOf
 uMlu0nK9LKs13y9Yttyc6zgPiiZsh5KfiGSL8WfnFoFSIjWkBKoX2MEjT09DAdUN7yUafCh8G
 tVZRArQnu6CNBsO6Nnhwe59g+mCcg0Ck5OYaSYk4cIxPa8FmaZWuuF+sf3U=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] docs/vhost-user.json: some
 firmware.json copy leftovers
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
Cc: qemu-trivial@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/06/2019 à 18:24, Laurent Vivier a écrit :
> Le 05/06/2019 à 15:12, Marc-André Lureau a écrit :
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>  docs/interop/vhost-user.json | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
>> index ae88c03117..da6aaf51c8 100644
>> --- a/docs/interop/vhost-user.json
>> +++ b/docs/interop/vhost-user.json
>> @@ -178,11 +178,11 @@
>>  #
>>  #   - /usr/share/qemu/vhost-user/50-crosvm-gpu.json
>>  #
>> -# then the sysadmin can prevent the default QEMU being used at all with
>> +# then the sysadmin can prevent the default QEMU GPU being used at all with
>>  #
>>  #   $ touch /etc/qemu/vhost-user/50-qemu-gpu.json
>>  #
>> -# The sysadmin can replace/alter the distro default OVMF with
>> +# The sysadmin can replace/alter the distro default QEMU GPU with
>>  #
>>  #   $ vim /etc/qemu/vhost-user/50-qemu-gpu.json
>>  #
>> @@ -190,7 +190,7 @@
>>  #
>>  #   $ vim /etc/qemu/vhost-user/10-qemu-gpu.json
>>  #
>> -# or they can provide a parallel OVMF with lower priority
>> +# or they can provide a parallel QEMU GPU with lower priority
>>  #
>>  #   $ vim /etc/qemu/vhost-user/99-qemu-gpu.json
>>  #
>>
> 
> Applied to my trivial-patches branch.

In fact, no, it has already been merged.

Thanks,
Laurent


