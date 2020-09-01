Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1C7C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB082098B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB082098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCzwm-0000xZ-5R
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kCzw1-0008MF-Kk; Tue, 01 Sep 2020 02:38:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kCzvz-0002sl-F1; Tue, 01 Sep 2020 02:38:25 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MG9wg-1kMrpl0Q7Y-00Gc9a; Tue, 01 Sep 2020 08:38:09 +0200
Subject: Re: [PATCH 09/12] hw: Remove superfluous breaks
To: Thomas Huth <thuth@redhat.com>, Yi Wang <wang.yi59@zte.com.cn>,
 qemu-devel@nongnu.org
References: <1594631126-36631-1-git-send-email-wang.yi59@zte.com.cn>
 <728da22b-18db-cec9-1cb8-b17202a62846@redhat.com>
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
Message-ID: <da57820c-f059-16fb-d4de-dbf18c494ef3@vivier.eu>
Date: Tue, 1 Sep 2020 08:38:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <728da22b-18db-cec9-1cb8-b17202a62846@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3LuAQFXj/bK6tmmIFEk75EUNdjoB1eeyJmSSWjMHtjUSOwecdw9
 ZXAQ0e4ofq1/eRHxteGYJl3H1MALRMig8MCTjkWibjbHhw8F7rTznIgptl27xDK4vietBvw
 /kHhZ372QqHEZo9zXM7OVWA3gk97dePQpLmUaBPugf1LYUjbRB6AgKJ+mnQ9fUlBZViPfgx
 ASNETZNyC8voX6GRd32Yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l3Ken/RFWoE=:1mPX2LPjf7GQM0f2ZEuvPc
 ULqlWB2EfWDQXcZWUba2WF3qjZs18s8YJsOXntRjxVc05h+smBcmJbkdrD12DIUbv2dTUeTwj
 KwX0wg9y/7Wg/sWCuUkp+vtgaw/CpO1aYwt17rIao2Zc4T3s1CbUHulWUUbtWb1YxFR99GRhi
 Rog/6PV1l9mav5+IoG/uccBTCiHga/6eVA4jkTVbsMxwc9sWg564tP960hEHUGCHDjVI+Y/Gj
 zGUUOW1C1lufWaNYF6Jyn/pWv7wQr0zKYJU7oDOBfU8NV8l5kmRKFC8icGgl1gfFMk2OKfjea
 2jD3vNCCy7PX7UcX6/8iQnEC7wnykX+3AnpP8qXMKHoBb0T736GD+ug77lclu71W+EXK6VHQo
 5CQ30g74kakx7b2jwt1TryV49xB2BFMkiiPSDUhr+XCxdSN+o02Wk77AQYPTyJwPv8eW7uafZ
 9phuQi6Mc9esUi5N7nYkaE4Wk/RDOxB/hCqaVR88xGDlN2BE6GOq3VQ01AT/h4qBKkaI+yXOg
 SdIxBczlpB+cFA/jfJtV1uB0M4tve5ne2DJ3OW4ilfaSqjxJtAzeSyt853+Si+3GgjtC0nlyi
 7vlq3EcPW6CvGXb5cV1YPPjs4J74Z63gLsqHH/QDRQhA33hqJSy0Z2uXDn3wr3hpRmZjv8vqr
 fBgh88YF6UxyN4LxsI2dOc69M4MH6EklDSL+xt7JtPZnBoz9i7WKPlEjzbPgjMtKpWz6zoOHG
 lP7iNWDlvqeHEVmcQtZrsdIbe5FNSXF3TBfJDKfK1piotYekNzUfOjMaAqd3wt9uprQ3uyHjM
 YhydqATgKKpB4vfjQ9mnIZfuNSA5ABSr3WM2Xmr7/eOdkzasEyFnK33TPjiyb7za6vaCjun
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:34:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Liao Pingfang <liao.pingfang@zte.com.cn>, wang.liang82@zte.com.cn,
 xue.zhihong@zte.com.cn
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/07/2020 à 11:37, Thomas Huth a écrit :
> On 13/07/2020 11.05, Yi Wang wrote:
>> From: Liao Pingfang <liao.pingfang@zte.com.cn>
>>
>> Remove superfluous breaks, as there is a "return" before them.
>>
>> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
>> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/block/pflash_cfi01.c     |  1 -
>>  hw/display/cirrus_vga.c     |  1 -
>>  hw/display/qxl-logger.c     |  2 --
>>  hw/gpio/max7310.c           |  3 ---
>>  hw/i386/intel_iommu.c       |  1 -
>>  hw/input/pxa2xx_keypad.c    | 10 ----------
>>  hw/intc/armv7m_nvic.c       |  1 -
>>  hw/net/lan9118.c            |  2 --
>>  hw/usb/ccid-card-emulated.c |  1 -
>>  9 files changed, 22 deletions(-)
>>
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 8ab1d66..f0fcd63 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -213,7 +213,6 @@ static uint32_t pflash_devid_query(PFlashCFI01 *pfl, hwaddr offset)
>>      default:
>>          trace_pflash_device_info(offset);
>>          return 0;
>> -        break;
>>      }
>>      /* Replicate responses for each device in bank. */
>>      if (pfl->device_width < pfl->bank_width) {
>> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
>> index 212d6f5..02d9ed0 100644
>> --- a/hw/display/cirrus_vga.c
>> +++ b/hw/display/cirrus_vga.c
>> @@ -1637,7 +1637,6 @@ static int cirrus_vga_read_cr(CirrusVGAState * s, unsigned reg_index)
>>  	return s->vga.cr[s->vga.cr_index];
>>      case 0x26:			// Attribute Controller Index Readback (R)
>>  	return s->vga.ar_index & 0x3f;
>> -	break;
>>      default:
>>          qemu_log_mask(LOG_GUEST_ERROR,
>>                        "cirrus: inport cr_index 0x%02x\n", reg_index);
>> diff --git a/hw/display/qxl-logger.c b/hw/display/qxl-logger.c
>> index 2ec6d8f..c15175b 100644
>> --- a/hw/display/qxl-logger.c
>> +++ b/hw/display/qxl-logger.c
>> @@ -161,7 +161,6 @@ static int qxl_log_cmd_draw(PCIQXLDevice *qxl, QXLDrawable *draw, int group_id)
>>      switch (draw->type) {
>>      case QXL_DRAW_COPY:
>>          return qxl_log_cmd_draw_copy(qxl, &draw->u.copy, group_id);
>> -        break;
>>      }
>>      return 0;
>>  }
>> @@ -180,7 +179,6 @@ static int qxl_log_cmd_draw_compat(PCIQXLDevice *qxl, QXLCompatDrawable *draw,
>>      switch (draw->type) {
>>      case QXL_DRAW_COPY:
>>          return qxl_log_cmd_draw_copy(qxl, &draw->u.copy, group_id);
>> -        break;
>>      }
>>      return 0;
>>  }
>> diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
>> index bebb403..4f78774 100644
>> --- a/hw/gpio/max7310.c
>> +++ b/hw/gpio/max7310.c
>> @@ -51,11 +51,9 @@ static uint8_t max7310_rx(I2CSlave *i2c)
>>      switch (s->command) {
>>      case 0x00:	/* Input port */
>>          return s->level ^ s->polarity;
>> -        break;
>>  
>>      case 0x01:	/* Output port */
>>          return s->level & ~s->direction;
>> -        break;
>>  
>>      case 0x02:	/* Polarity inversion */
>>          return s->polarity;
>> @@ -65,7 +63,6 @@ static uint8_t max7310_rx(I2CSlave *i2c)
>>  
>>      case 0x04:	/* Timeout */
>>          return s->status;
>> -        break;
>>  
>>      case 0xff:	/* Reserved */
>>          return 0xff;
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index c56398e..7b390ca 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -3163,7 +3163,6 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
>>                                index, entry->irte.sid_vtype);
>>              /* Take this as verification failure. */
>>              return -VTD_FR_IR_SID_ERR;
>> -            break;
>>          }
>>      }
>>  
>> diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
>> index 62aa6f6..7f2f739 100644
>> --- a/hw/input/pxa2xx_keypad.c
>> +++ b/hw/input/pxa2xx_keypad.c
>> @@ -192,10 +192,8 @@ static uint64_t pxa2xx_keypad_read(void *opaque, hwaddr offset,
>>              s->kpc &= ~(KPC_DI);
>>          qemu_irq_lower(s->irq);
>>          return tmp;
>> -        break;
>>      case KPDK:
>>          return s->kpdk;
>> -        break;
>>      case KPREC:
>>          tmp = s->kprec;
>>          if(tmp & KPREC_OF1)
>> @@ -207,31 +205,23 @@ static uint64_t pxa2xx_keypad_read(void *opaque, hwaddr offset,
>>          if(tmp & KPREC_UF0)
>>              s->kprec &= ~(KPREC_UF0);
>>          return tmp;
>> -        break;
>>      case KPMK:
>>          tmp = s->kpmk;
>>          if(tmp & KPMK_MKP)
>>              s->kpmk &= ~(KPMK_MKP);
>>          return tmp;
>> -        break;
>>      case KPAS:
>>          return s->kpas;
>> -        break;
>>      case KPASMKP0:
>>          return s->kpasmkp[0];
>> -        break;
>>      case KPASMKP1:
>>          return s->kpasmkp[1];
>> -        break;
>>      case KPASMKP2:
>>          return s->kpasmkp[2];
>> -        break;
>>      case KPASMKP3:
>>          return s->kpasmkp[3];
>> -        break;
>>      case KPKDI:
>>          return s->kpkdi;
>> -        break;
>>      default:
>>          qemu_log_mask(LOG_GUEST_ERROR,
>>                        "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
>> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
>> index 3c4b6e6..720ac97 100644
>> --- a/hw/intc/armv7m_nvic.c
>> +++ b/hw/intc/armv7m_nvic.c
>> @@ -1275,7 +1275,6 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>>      case 0xd90: /* MPU_TYPE */
>>          /* Unified MPU; if the MPU is not present this value is zero */
>>          return cpu->pmsav7_dregion << 8;
>> -        break;
>>      case 0xd94: /* MPU_CTRL */
>>          return cpu->env.v7m.mpu_ctrl[attrs.secure];
>>      case 0xd98: /* MPU_RNR */
>> diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
>> index 8e2a432..e35f00f 100644
>> --- a/hw/net/lan9118.c
>> +++ b/hw/net/lan9118.c
>> @@ -931,10 +931,8 @@ static uint32_t do_mac_read(lan9118_state *s, int reg)
>>                 | (s->conf.macaddr.a[2] << 16) | (s->conf.macaddr.a[3] << 24);
>>      case MAC_HASHH:
>>          return s->mac_hashh;
>> -        break;
>>      case MAC_HASHL:
>>          return s->mac_hashl;
>> -        break;
>>      case MAC_MII_ACC:
>>          return s->mac_mii_acc;
>>      case MAC_MII_DATA:
>> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
>> index 7d6105e..0f1afd6 100644
>> --- a/hw/usb/ccid-card-emulated.c
>> +++ b/hw/usb/ccid-card-emulated.c
>> @@ -350,7 +350,6 @@ static void *event_thread(void *arg)
>>          case VEVENT_LAST: /* quit */
>>              vevent_delete(event);
>>              return NULL;
>> -            break;
>>          default:
>>              break;
>>          }
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


