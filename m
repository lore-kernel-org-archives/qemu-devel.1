Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CA2C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFDD206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFDD206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFdrR-0006W7-TA
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 08:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iFdpS-0004u1-Du
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iFdpR-0005Hk-3X
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:34:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:45939)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iFdpQ-0005Fu-Qj; Wed, 02 Oct 2019 08:34:01 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MQuwR-1iScf83gBT-00NvUn; Wed, 02 Oct 2019 14:33:30 +0200
Subject: Re: [PATCH v13 1/9] esp: add pseudo-DMA as used by Macintosh
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190927090453.24712-1-laurent@vivier.eu>
 <20190927090453.24712-2-laurent@vivier.eu>
 <84f1108e-cc69-558d-4d67-ebb0b7b5f42a@redhat.com>
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
Message-ID: <e62b699d-6e05-1914-65b6-683e81b7640d@vivier.eu>
Date: Wed, 2 Oct 2019 14:33:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <84f1108e-cc69-558d-4d67-ebb0b7b5f42a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T8yEcKUu6pstUCHs+mriWOYJ1XAcHbIko5RQMrGDJRjTcMpT0Xj
 Ad+bDM3GzwC8XLsJhlD2lPOeeWh1RplFCK21YsnZY8nxWqpEn0+lnOdX5ADmlPeeUvL5vPk
 94QHE5mgvcp5gHPji1XFTe9IZf+l9dY8OrJrpr2BCokiT4enjFUTi9TrKFzBKOrqQtfyuBg
 JWtZqvSmdhvUTcyNP+0Hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZwnLcpat27g=:gq7nvkC07rgwXQJ56c3gMg
 7XvKt3jgZxPeuO8mMZlxO8v4ktWGlN1wBemlimfIxIcq/gazZ/y6aXOCq3a9JARNYfoHD9Jso
 zCjUS1K7LMVHB15V97v5BFaSjmNOY6qhk86J0qnvCX8WNoNNa4NdUN4Q949AQlDX98OyRA7Ku
 cpcXkt4W3o1qj/g67lmgcbjoTy+eN9M2rituiw0jwaDY35bmfzw8houGwgIqKaGV/ifocD7px
 fPdaachGxaOhdfzOYAWaGhON8HOct7o6JSFk1FprkQWvMc6a6elDbwGTaT4lU1n/wFMI6DkfH
 0vLSFUKEFcoMGosb7vKZOK8WPUM+1V8q60vJgm/fbxOQu8Jpor8adXv+nlrB2sdtEESNXR+kV
 jwao5rxmBX1cSYwpABZjL078GHcsIFjnJ7Nr87S+tc6ltAV5ZwffhALcHAqCR508lhAX120Zk
 ZkuF8XqWVRWuCmXJwoIgk7N7E3Fvl9sh677i1dIpWy84sl8NCMHM36dIlRLQhZUpojGXNS+bi
 /L7q5RYEw10iBasMeAjhtMbAE642nyRZwCarFyWcVp0jZ9qSmrWr5oZwAFsJyFjm2IeNOouF7
 GCV3fWGVyLDWhzcNeY2xcIH6LnDB8AUbTlm11enCGQdcfm5xKYq+OndFqFk3LR7mL1+Yd99G8
 IkVvV9w2wIY7TifU4QvGMF1N6MU3gDeq/HDjOyUwKBP3enzOjQI0Sd2+GRujE113S/O5T62fz
 vZGS+uTfPWZh6rxGOfH/O1LHD1IRxhd79XG0lGt02kK36fwocaRlX4bebetl9YvRAiEFL84s5
 OqSasMudTStqBQJY5E/uHMeE9tD6w4HFX5uPLOukeD4exDInzH+XsV8iU1PsFXxD5UGvJ+hNj
 FxfatfIZnSqRWlr1C8j8cBIHBymj7xYZEmC/PYQ3M=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/10/2019 à 13:10, Philippe Mathieu-Daudé a écrit :
> On 9/27/19 11:04 AM, Laurent Vivier wrote:
>> There is no DMA in Quadra 800, so the CPU reads/writes the data from the
>> PDMA register (offset 0x100, ESP_PDMA in hw/m68k/q800.c) and copies them
>> to/from the memory.
>>
>> There is a nice assembly loop in the kernel to do that, see
>> linux/drivers/scsi/mac_esp.c:MAC_ESP_PDMA_LOOP().
>>
>> The start of the transfer is triggered by the DREQ interrupt (see linux
>> mac_esp_send_pdma_cmd()), the CPU polls on the IRQ flag to start the
>> transfer after a SCSI command has been sent (in Quadra 800 it goes
>> through the VIA2, the via2-irq line and the vIFR register)
>>
>> The Macintosh hardware includes hardware handshaking to prevent the CPU
>> from reading invalid data or writing data faster than the peripheral
>> device can accept it.
>>
>> This is the "blind mode", and from the doc:
>> "Approximate maximum SCSI transfer rates within a blocks are 1.4 MB per
>> second for blind transfers in the Macintosh II"
>>
>> Some references can be found in:
>>    Apple Macintosh Family Hardware Reference, ISBN 0-201-19255-1
>>    Guide to the Macintosh Family Hardware, ISBN-0-201-52405-8
>>
>> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   hw/scsi/esp.c         | 338 ++++++++++++++++++++++++++++++++++++++----
>>   include/hw/scsi/esp.h |  15 ++
> 
> I recommend you to install the scripts/git.orderfile file.

done

> 
>>   2 files changed, 324 insertions(+), 29 deletions(-)
>>
...
>> --- a/include/hw/scsi/esp.h
>> +++ b/include/hw/scsi/esp.h
>> @@ -14,10 +14,18 @@ typedef void (*ESPDMAMemoryReadWriteFunc)(void
>> *opaque, uint8_t *buf, int len);
>>     typedef struct ESPState ESPState;
>>   +enum pdma_origin_id {
>> +    PDMA,
>> +    TI,
>> +    CMD,
>> +    ASYNC,
>> +};
>> +
>>   struct ESPState {
>>       uint8_t rregs[ESP_REGS];
>>       uint8_t wregs[ESP_REGS];
>>       qemu_irq irq;
>> +    qemu_irq irq_data;
>>       uint8_t chip_id;
>>       bool tchi_written;
>>       int32_t ti_size;
>> @@ -48,6 +56,12 @@ struct ESPState {
>>       ESPDMAMemoryReadWriteFunc dma_memory_write;
>>       void *dma_opaque;
>>       void (*dma_cb)(ESPState *s);
>> +    uint8_t pdma_buf[32];
>> +    int pdma_origin;
> 
> 'int' -> 'enum pdma_origin_id'
> 
> You can also declare the enum in place:
> 
>        enum pdma_origin_id {
>            PDMA,
>            TI,
>            CMD,
>            ASYNC,
>        } pdma_origin;

If I remember correctly I put an "int" here because I didn't find the
VMSTATE_XXX() to use and VMSTATE_INT32() doesn't like the enum type
(which should be treated as an int).

Thanks,
Laurent


