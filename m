Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D596C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1408122440
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1408122440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNeD-0005LK-AF
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iXNdG-0004lJ-GV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iXNdE-0003Ag-Ik
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:54:46 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:54243)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iXNdC-00036i-No
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:54:44 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MJm8N-1iHlU81ucz-00K97X; Wed, 20 Nov 2019 11:54:33 +0100
To: Peter Maydell <peter.maydell@linaro.org>
References: <1574190388-12605-1-git-send-email-tsimpson@quicinc.com>
 <CAFEAcA8AeTgY+3GaN9ZUi-5XtX5jxhqpdOhr3ixYwouWhQOQ5g@mail.gmail.com>
 <e4a52719-fc16-f94a-fb8d-1a4d9e683ce0@vivier.eu>
 <CAFEAcA-tVh9AMucDL4hgQ3ngFZwu4AThcGyhwjVa-LbG8o8-Lg@mail.gmail.com>
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
Subject: Re: [PATCH] Hexagon: Swap SIGRGMAX-1 and SIGRTMIN+1
Message-ID: <05b5c1b4-d1dd-7b82-cdf3-a1425edae499@vivier.eu>
Date: Wed, 20 Nov 2019 11:54:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-tVh9AMucDL4hgQ3ngFZwu4AThcGyhwjVa-LbG8o8-Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:D8XKqH8okpEqZw6BkXaxE9pKXb3osNDmgxQelXtp1KH/X1OJR/6
 TmPi0drC/4Dk/d6uSkXyfOZFAT0akeN/uh8awThnFXoWGuLBDCm1GGlanqcTbrt+PCrRm3H
 Ymx7RcHvNLroSV6ldcK3YrTbnjnAh7FaNigJZadr3gAS53r1hp1R9MmrkYAe+OtXDdOkAzR
 F5lLC6eyZRp39/pWb3eag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5y67EtJnjhE=:Bdg+4iSWzDZiUhopd3ytuS
 obhS481gA05JB0Vy/ZBh3buUpcRpFjWdJ/8tYsDrv4roBzDMvjcicaj84WbKuWcyIZNw+AGZO
 YaorqfBgxoJW9FgCXK98ZkME2Ul0uPh4p6JFWNWGeFxMtRVMOQSef5RBttUHSNucAY4UR7SZQ
 iqne8FVKBSf3k+GszyXLQEcBFYsuSwIvhP6N4rSHKCxmrH81boS22XDIUWVJ9awml6KZQPYcS
 N8WGUoQM80Zo8JlsIg4sEsMUWbtnE5s4hs7mlT8q1brca54XqcuQGZPVqP7TmepuP+o8/48ux
 tpFrYNe07w6AVul1e/5s0AOhX27nGahY297O8nb/6FT1zhEZmkdUTnO3dZAVx+SQs4Qt+wqnk
 YjyczJzXNh7N3nxHYFNbXNpUA+cXIyXbwh29WxW5L+xs1Lu4yKx7FgftzVSQ9T+nAAA35BL84
 xC6Udjz8ehDLknYIErFS63J4qQmWwvds6obCMAEfOcSKwaWKcCJXeROa2b3DE8czvTqgJV6M7
 EVLGcXVfy1+ntJQI5Gj5a9qWKVOuHlI9Vdof2/KtBE3naDWEHjiCfLt/d3dF96wfachNm89Pn
 nkR4fEowGdzh5l2V/j0xI/DaTybVUWLTR2ekiyGkjOzsbN9YSFrS1DtIiDNk6Og8RLHKhkrKz
 mm2DYThDcOeNqZBBaPR1C1ukl1mC9ueMnOyH3d5bPa0XA3jK7GJdu4WYUo5yMvPe1b6W66y4t
 tJmACfz8VqxSY13LSH9L1gLpnmwY7wqb+zmvlV5epnDSRkvE+lbG2FikxGJiD1in6x1kwebYW
 lAKjaLJg4IUa3JjWx33O2bFSWUdfUYCfWR/n7YLbtRgaoyU3IRjD4PB2KdlLXCv5Yrvv8a/iM
 BJKrbEYNeyuc+J7C1zvlhq/QvJHIZl5ZRnxfjkQsg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/11/2019 à 11:45, Peter Maydell a écrit :
> On Wed, 20 Nov 2019 at 08:10, Laurent Vivier <laurent@vivier.eu> wrote:
>> For the moment we don't have a better solution, Josh Kunz tried to
>> rework [1] patches from Miloš Stojanović [2] but it doesn't seem to be
>> an easy task.
>>
>> So I agree we need a generic solution to fix this problem, but in the
>> meantime I told to Taylor if he doesn't care about Go on hexagon he can
>> do this change specifically to his target (perhaps we can have cleaner
>> approach by containing this change into linux-user/hexagon). And what I
>> understand is hexagon libc (musl) doesn't work without this.
> 
> I really don't like target-specific ifdeffery that changes behaviour
> that shouldn't be target specific. They reduce the chances we ever
> try to go back and actually fix the underlying problem correctly,
> and they can be awkward to undo without breaking things.
> As far as I can tell there is nothing special about Hexagon here.

I understand your point, and I agree, but not allowing this will block
the merge of the hexagon target, and I don't see any fix for the
underlying problem coming soon.

Other targets work without this change, and adding this change breaks
some user space applications (like go), whereas adding this change for
hexagon target only will improve the situation for it (with no
regression, as it doesn't work at all for the moment)

But, yes, we must fix the underlying problem...

Thanks,
Laurent

