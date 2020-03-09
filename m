Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDB1C10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEF120637
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEF120637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBE5z-0003h8-7o
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBE59-0003Hl-Mj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBE58-0007UU-6D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:48:15 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBE57-0007Ta-Tv; Mon, 09 Mar 2020 04:48:14 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MxmJs-1jY0Yz1oL8-00zH2V; Mon, 09 Mar 2020 09:48:07 +0100
Subject: Re: [PATCH] dp8393x: Mask EOL bit from descriptor addresses, take 2
To: Jason Wang <jasowang@redhat.com>
References: <alpine.LNX.2.22.394.2003041421280.12@nippy.intranet>
 <2116e607-52c8-7e7d-8ac1-c80d4628b2de@vivier.eu>
 <d2e80d5b-3c7a-92ad-7371-1cd0800195ca@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
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
Message-ID: <23179263-a8fb-57cc-e98a-bfe9a2ee9037@vivier.eu>
Date: Mon, 9 Mar 2020 09:48:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d2e80d5b-3c7a-92ad-7371-1cd0800195ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nW5+porYYJUczELFs0G+M24y9dQ7Sw8MfpqGS4LjlN1vtGXxboE
 QGgEuVM22bcDOkhI+pI4+8X1TN4aSz9r5FgI9wiytV+9q6TtORZ1TKula/IT4etkpoKlRHL
 g/yMLcOewZnvbTref+ABj2vVb74HyuX++Cvu77WENqflxOXZj1R8Qrpeca+RvK4KhcgG4lF
 qqTU9mjjpr6B5DVp5r/LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:juIUUIMqmv4=:dI/auL1JLYxesFklA6hCiI
 L5Wy9crXLPEMkTCpjMGRtzBTOrazxs+ex/ETWxqZK7SVzJRpiPLA2YmGqoF6GSMwt21idYhHq
 ILgHbNehwIWuMHH6Xdr3AczMZYNf56rSyZseSYO6COi3LC73MzhYdOMnHyOzz9u0CurK4Byag
 H/XRJo04vyPXAfh5u+4xc8ZjqBUKhyIr/uUNKTZgEa9og7z46V0IfDrRTez3bfaBoNSXXRfOw
 HSlDcllP59upK17ZSJH7XUf4lDhwZwQvHuJ+1vWBPEjTVwI/bYV7beK3oeXhmvQGeAddqAUOz
 ZP/bhxBBMH0/cpGGaXkb0mgcnZzWPCYzOH8/ozpJEIbBEq/4GpaQJM32do8bBOw7Qy5/NHIdr
 zSuetgp+YadIG7dQBBBGdWduqa9/Rsmu/ijDF88mDxTbOQOYcp6Oq7zf4zW3dai2AZISbsn+4
 /4crSMDFW11wa582SZRNarkIZb1Wf25Gh1b5LduCZZOxTLTDCYoWO1xiUAhGVhrmGpsjuAuy7
 82+7Fd2ngYpSe385QSkK67DsAIuZLBjLMk3H/fAsPN2i/5b5tbuV55p56LasYKr4RGCTljESI
 Myb7bpKZicb26NKZVEP5VvpsK8u56bNmOnGFan/MbX7XtGmP41nC8rjuO14/p4EGeS411xZyI
 QPkZ7zEjjXxP8NrJrhQh0Ijhxw5zvrGp3IGbIV1wATUliSdvYnyoWYcwBi2nJ1vLREtCoi0Kp
 Q2IsEQkA8AeWEOvMe2l3jInWvQ6pdg6uXlPHc8V5XpJtpVB5gC04lrf3Nvexd/9DLRjbKcus1
 EN+fL3wL16SgMHBmWEEncwVlevOsLj9tDT1dH8pHsdqtbce4Etqsa2wgOaPDO1FXl5B75i5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/03/2020 à 03:51, Jason Wang a écrit :
> 
> On 2020/3/8 下午5:52, Laurent Vivier wrote:
>> Le 04/03/2020 à 04:23, Finn Thain a écrit :
>>> A portion of a recent patch got lost due to a merge snafu. That patch is
>>> now commit 88f632fbb1 ("dp8393x: Mask EOL bit from descriptor
>>> addresses").
>>> This patch restores the portion that got lost.
>>>
>>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>>> ---
>>>   hw/net/dp8393x.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
>>> index 8a3504d962..81fc13ee9f 100644
>>> --- a/hw/net/dp8393x.c
>>> +++ b/hw/net/dp8393x.c
>>> @@ -525,8 +525,8 @@ static void
>>> dp8393x_do_transmit_packets(dp8393xState *s)
>>>                                    * (4 + 3 * s->regs[SONIC_TFC]),
>>>                                  MEMTXATTRS_UNSPECIFIED, s->data,
>>>                                  size);
>>> -            s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
>>> -            if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
>>> +            s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0);
>>> +            if (s->regs[SONIC_CTDA] & SONIC_DESC_EOL) {
>>>                   /* EOL detected */
>>>                   break;
>>>               }
>>>
>> Jason,
>>
>> as it's a trivial bug fixes (only a diff between the commit and the
>> patch), will you merge it via the network queue or do you want I take it
>> via trivial queue?
> 
> 
> Hi Laurent:
> 
> Please merge it.

Applied to my trivial-patch branch.

Thanks,
Laurent

