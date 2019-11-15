Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88C9C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 01:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631CE2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 01:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="fGJ9oipX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631CE2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34919 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVQfl-0004LZ-Hr
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 20:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1iVQeg-0003oY-46
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 20:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1iVQed-0000Uf-4r
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 20:44:08 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1iVQec-0000Sh-K3
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 20:44:07 -0500
Received: by mail-pl1-x641.google.com with SMTP id d7so3545312pls.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 17:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Hxt7nGqHEX2BS2Or51ApcR+xonTFn8QPYN6TjcWmPZ4=;
 b=fGJ9oipXz2HkFsMHrbPmSDjcmXKKg0lOOPnPCVixPN+YoPAZny1ewje9FpLpCFMegq
 TetHw/q5e0b+VQPc9YMRb6k7zAlDH2X6KvmowdvYAXgJsrPYzxI+05DrKU/pYo6JZ6Is
 58QkN4dMajE+koh5dwelP182vO6NZWu4PLYx912x+9jMV+Mo03QeyK4wrKWlu9LVCWrI
 JCQCg3Wm9ZMKvw3JgykJ58/SDEaieCKEZxj1g0i9bYeoZw92D/sdARMHOtI0fmlEGfqQ
 cALegI+fbw9haRkmtgDIjI65f20kC48ARi0ooBMrjqCj76nqxJSiO6LtVGEx/E3VsYvW
 hxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Hxt7nGqHEX2BS2Or51ApcR+xonTFn8QPYN6TjcWmPZ4=;
 b=ohfd2lKcObTD4pV/Hdg3P4e40O0xpCpmGeaWomYUEUQ56Ipp97dB1S/YL6FJSV9l58
 0l08ETGYyqgoH4neN1kfat06H6mE3rPlneIEIQpj5238G6oixxQO9zcVsyq7+BkZ3zMj
 GMSRAcCvoidDNlyO4cMjaZUi9CoI5E4BqeJMBzzsPE0gr5WfUNw2V4lo6vSPpyTXTHcp
 PI82Jm+5TI7jteEQRY17tGgU/Q6ppxFAvKl3zFAITnYgGBVvCAj6MzUIZ3rNm/gYbtgE
 yiH5NY2t9Z84tNpwCF5r5jEgIfRyeJ1ODPeAQunbFlPjh3qCIKlVcFqLLksgpnaEhVP7
 KLSQ==
X-Gm-Message-State: APjAAAVPzLBeqy9/Gcs5Z+inAV4nvNyZdzqGbO1IFGXrgwZMqgWAHeSG
 XCCZ1o7cmfmF+GZEtwGalIUbmA==
X-Google-Smtp-Source: APXvYqwm+Zb0VPwyt3pdp9Krz/sG6FiRshk1Ker0atOk4/SkMlu550ihPy2rYmZR863qMAdPgb8pzg==
X-Received: by 2002:a17:902:6bc3:: with SMTP id
 m3mr12334182plt.329.1573782242488; 
 Thu, 14 Nov 2019 17:44:02 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id h3sm8255708pgr.81.2019.11.14.17.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 17:44:01 -0800 (PST)
Subject: Re: virtio,iommu_platform=on
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <17da2769-1999-a0a3-590d-9f9bc6a9adc3@ozlabs.ru>
 <20191112014821-mutt-send-email-mst@kernel.org>
 <7ac95a46-b2ae-005b-1907-5302d5b0a39d@ozlabs.ru>
 <20191113045747-mutt-send-email-mst@kernel.org>
 <83876a34-8bc1-c69b-d846-4ac35a8c0a47@ozlabs.ru>
 <20191114034049-mutt-send-email-mst@kernel.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 mQINBE+rT0sBEADFEI2UtPRsLLvnRf+tI9nA8T91+jDK3NLkqV+2DKHkTGPP5qzDZpRSH6mD
 EePO1JqpVuIow/wGud9xaPA5uvuVgRS1q7RU8otD+7VLDFzPRiRE4Jfr2CW89Ox6BF+q5ZPV
 /pS4v4G9eOrw1v09lEKHB9WtiBVhhxKK1LnUjPEH3ifkOkgW7jFfoYgTdtB3XaXVgYnNPDFo
 PTBYsJy+wr89XfyHr2Ev7BB3Xaf7qICXdBF8MEVY8t/UFsesg4wFWOuzCfqxFmKEaPDZlTuR
 tfLAeVpslNfWCi5ybPlowLx6KJqOsI9R2a9o4qRXWGP7IwiMRAC3iiPyk9cknt8ee6EUIxI6
 t847eFaVKI/6WcxhszI0R6Cj+N4y+1rHfkGWYWupCiHwj9DjILW9iEAncVgQmkNPpUsZECLT
 WQzMuVSxjuXW4nJ6f4OFHqL2dU//qR+BM/eJ0TT3OnfLcPqfucGxubhT7n/CXUxEy+mvWwnm
 s9p4uqVpTfEuzQ0/bE6t7dZdPBua7eYox1AQnk8JQDwC3Rn9kZq2O7u5KuJP5MfludMmQevm
 pHYEMF4vZuIpWcOrrSctJfIIEyhDoDmR34bCXAZfNJ4p4H6TPqPh671uMQV82CfTxTrMhGFq
 8WYU2AH86FrVQfWoH09z1WqhlOm/KZhAV5FndwVjQJs1MRXD8QARAQABtCRBbGV4ZXkgS2Fy
 ZGFzaGV2c2tpeSA8YWlrQG96bGFicy5ydT6JAjgEEwECACIFAk+rT0sCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJEIYTPdgrwSC5fAIP/0wf/oSYaCq9PhO0UP9zLSEz66SSZUf7
 AM9O1rau1lJpT8RoNa0hXFXIVbqPPKPZgorQV8SVmYRLr0oSmPnTiZC82x2dJGOR8x4E01gK
 TanY53J/Z6+CpYykqcIpOlGsytUTBA+AFOpdaFxnJ9a8p2wA586fhCZHVpV7W6EtUPH1SFTQ
 q5xvBmr3KkWGjz1FSLH4FeB70zP6uyuf/B2KPmdlPkyuoafl2UrU8LBADi/efc53PZUAREih
 sm3ch4AxaL4QIWOmlE93S+9nHZSRo9jgGXB1LzAiMRII3/2Leg7O4hBHZ9Nki8/fbDo5///+
 kD4L7UNbSUM/ACWHhd4m1zkzTbyRzvL8NAVQ3rckLOmju7Eu9whiPueGMi5sihy9VQKHmEOx
 OMEhxLRQbzj4ypRLS9a+oxk1BMMu9cd/TccNy0uwx2UUjDQw/cXw2rRWTRCxoKmUsQ+eNWEd
 iYLW6TCfl9CfHlT6A7Zmeqx2DCeFafqEd69DqR9A8W5rx6LQcl0iOlkNqJxxbbW3ddDsLU/Y
 r4cY20++WwOhSNghhtrroP+gouTOIrNE/tvG16jHs8nrYBZuc02nfX1/gd8eguNfVX/ZTHiR
 gHBWe40xBKwBEK2UeqSpeVTohYWGBkcd64naGtK9qHdo1zY1P55lHEc5Uhlk743PgAnOi27Q
 ns5zuQINBE+rT0sBEACnV6GBSm+25ACT+XAE0t6HHAwDy+UKfPNaQBNTTt31GIk5aXb2Kl/p
 AgwZhQFEjZwDbl9D/f2GtmUHWKcCmWsYd5M/6Ljnbp0Ti5/xi6FyfqnO+G/wD2VhGcKBId1X
 Em/B5y1kZVbzcGVjgD3HiRTqE63UPld45bgK2XVbi2+x8lFvzuFq56E3ZsJZ+WrXpArQXib2
 hzNFwQleq/KLBDOqTT7H+NpjPFR09Qzfa7wIU6pMNF2uFg5ihb+KatxgRDHg70+BzQfa6PPA
 o1xioKXW1eHeRGMmULM0Eweuvpc7/STD3K7EJ5bBq8svoXKuRxoWRkAp9Ll65KTUXgfS+c0x
 gkzJAn8aTG0z/oEJCKPJ08CtYQ5j7AgWJBIqG+PpYrEkhjzSn+DZ5Yl8r+JnZ2cJlYsUHAB9
 jwBnWmLCR3gfop65q84zLXRQKWkASRhBp4JK3IS2Zz7Nd/Sqsowwh8x+3/IUxVEIMaVoUaxk
 Wt8kx40h3VrnLTFRQwQChm/TBtXqVFIuv7/Mhvvcq11xnzKjm2FCnTvCh6T2wJw3de6kYjCO
 7wsaQ2y3i1Gkad45S0hzag/AuhQJbieowKecuI7WSeV8AOFVHmgfhKti8t4Ff758Z0tw5Fpc
 BFDngh6Lty9yR/fKrbkkp6ux1gJ2QncwK1v5kFks82Cgj+DSXK6GUQARAQABiQIfBBgBAgAJ
 BQJPq09LAhsMAAoJEIYTPdgrwSC5NYEP/2DmcEa7K9A+BT2+G5GXaaiFa098DeDrnjmRvumJ
 BhA1UdZRdfqICBADmKHlJjj2xYo387sZpS6ABbhrFxM6s37g/pGPvFUFn49C47SqkoGcbeDz
 Ha7JHyYUC+Tz1dpB8EQDh5xHMXj7t59mRDgsZ2uVBKtXj2ZkbizSHlyoeCfs1gZKQgQE8Ffc
 F8eWKoqAQtn3j4nE3RXbxzTJJfExjFB53vy2wV48fUBdyoXKwE85fiPglQ8bU++0XdOr9oyy
 j1llZlB9t3tKVv401JAdX8EN0++ETiOovQdzE1m+6ioDCtKEx84ObZJM0yGSEGEanrWjiwsa
 nzeK0pJQM9EwoEYi8TBGhHC9ksaAAQipSH7F2OHSYIlYtd91QoiemgclZcSgrxKSJhyFhmLr
 QEiEILTKn/pqJfhHU/7R7UtlDAmFMUp7ByywB4JLcyD10lTmrEJ0iyRRTVfDrfVP82aMBXgF
 tKQaCxcmLCaEtrSrYGzd1sSPwJne9ssfq0SE/LM1J7VdCjm6OWV33SwKrfd6rOtvOzgadrG6
 3bgUVBw+bsXhWDd8tvuCXmdY4bnUblxF2B6GOwSY43v6suugBttIyW5Bl2tXSTwP+zQisOJo
 +dpVG2pRr39h+buHB3NY83NEPXm1kUOhduJUA17XUY6QQCAaN4sdwPqHq938S3EmtVhsuQIN
 BFq54uIBEACtPWrRdrvqfwQF+KMieDAMGdWKGSYSfoEGGJ+iNR8v255IyCMkty+yaHafvzpl
 PFtBQ/D7Fjv+PoHdFq1BnNTk8u2ngfbre9wd9MvTDsyP/TmpF0wyyTXhhtYvE267Av4X/BQT
 lT9IXKyAf1fP4BGYdTNgQZmAjrRsVUW0j6gFDrN0rq2J9emkGIPvt9rQt6xGzrd6aXonbg5V
 j6Uac1F42ESOZkIh5cN6cgnGdqAQb8CgLK92Yc8eiCVCH3cGowtzQ2m6U32qf30cBWmzfSH0
 HeYmTP9+5L8qSTA9s3z0228vlaY0cFGcXjdodBeVbhqQYseMF9FXiEyRs28uHAJEyvVZwI49
 CnAgVV/n1eZa5qOBpBL+ZSURm8Ii0vgfvGSijPGbvc32UAeAmBWISm7QOmc6sWa1tobCiVmY
 SNzj5MCNk8z4cddoKIc7Wt197+X/X5JPUF5nQRvg3SEHvfjkS4uEst9GwQBpsbQYH9MYWq2P
 PdxZ+xQE6v7cNB/pGGyXqKjYCm6v70JOzJFmheuUq0Ljnfhfs15DmZaLCGSMC0Amr+rtefpA
 y9FO5KaARgdhVjP2svc1F9KmTUGinSfuFm3quadGcQbJw+lJNYIfM7PMS9fftq6vCUBoGu3L
 j4xlgA/uQl/LPneu9mcvit8JqcWGS3fO+YeagUOon1TRqQARAQABiQRsBBgBCAAgFiEEZSrP
 ibrORRTHQ99dhhM92CvBILkFAlq54uICGwICQAkQhhM92CvBILnBdCAEGQEIAB0WIQQIhvWx
 rCU+BGX+nH3N7sq0YorTbQUCWrni4gAKCRDN7sq0YorTbVVSD/9V1xkVFyUCZfWlRuryBRZm
 S4GVaNtiV2nfUfcThQBfF0sSW/aFkLP6y+35wlOGJE65Riw1C2Ca9WQYk0xKvcZrmuYkK3DZ
 0M9/Ikkj5/2v0vxz5Z5w/9+IaCrnk7pTnHZuZqOh23NeVZGBls/IDIvvLEjpD5UYicH0wxv+
 X6cl1RoP2Kiyvenf0cS73O22qSEw0Qb9SId8wh0+ClWet2E7hkjWFkQfgJ3hujR/JtwDT/8h
 3oCZFR0KuMPHRDsCepaqb/k7VSGTLBjVDOmr6/C9FHSjq0WrVB9LGOkdnr/xcISDZcMIpbRm
 EkIQ91LkT/HYIImL33ynPB0SmA+1TyMgOMZ4bakFCEn1vxB8Ir8qx5O0lHMOiWMJAp/PAZB2
 r4XSSHNlXUaWUg1w3SG2CQKMFX7vzA31ZeEiWO8tj/c2ZjQmYjTLlfDK04WpOy1vTeP45LG2
 wwtMA1pKvQ9UdbYbovz92oyZXHq81+k5Fj/YA1y2PI4MdHO4QobzgREoPGDkn6QlbJUBf4To
 pEbIGgW5LRPLuFlOPWHmIS/sdXDrllPc29aX2P7zdD/ivHABslHmt7vN3QY+hG0xgsCO1JG5
 pLORF2N5XpM95zxkZqvYfC5tS/qhKyMcn1kC0fcRySVVeR3tUkU8/caCqxOqeMe2B6yTiU1P
 aNDq25qYFLeYxg67D/4w/P6BvNxNxk8hx6oQ10TOlnmeWp1q0cuutccblU3ryRFLDJSngTEu
 ZgnOt5dUFuOZxmMkqXGPHP1iOb+YDznHmC0FYZFG2KAc9pO0WuO7uT70lL6larTQrEneTDxQ
 CMQLP3qAJ/2aBH6SzHIQ7sfbsxy/63jAiHiT3cOaxAKsWkoV2HQpnmPOJ9u02TPjYmdpeIfa
 X2tXyeBixa3i/6dWJ4nIp3vGQicQkut1YBwR7dJq67/FCV3Mlj94jI0myHT5PIrCS2S8LtWX
 ikTJSxWUKmh7OP5mrqhwNe0ezgGiWxxvyNwThOHc5JvpzJLd32VDFilbxgu4Hhnf6LcgZJ2c
 Zd44XWqUu7FzVOYaSgIvTP0hNrBYm/E6M7yrLbs3JY74fGzPWGRbBUHTZXQEqQnZglXaVB5V
 ZhSFtHopZnBSCUSNDbB+QGy4B/E++Bb02IBTGl/JxmOwG+kZUnymsPvTtnNIeTLHxN/H/ae0
 c7E5M+/NpslPCmYnDjs5qg0/3ihh6XuOGggZQOqrYPC3PnsNs3NxirwOkVPQgO6mXxpuifvJ
 DG9EMkK8IBXnLulqVk54kf7fE0jT/d8RTtJIA92GzsgdK2rpT1MBKKVffjRFGwN7nQVOzi4T
 XrB5p+6ML7Bd84xOEGsj/vdaXmz1esuH7BOZAGEZfLRCHJ0GVCSssg==
Message-ID: <f0413acd-9b2d-48ce-142d-0f37b7cfad08@ozlabs.ru>
Date: Fri, 15 Nov 2019 12:43:57 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191114034049-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 14/11/2019 19:42, Michael S. Tsirkin wrote:
> On Thu, Nov 14, 2019 at 09:58:47AM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 13/11/2019 21:00, Michael S. Tsirkin wrote:
>>> On Wed, Nov 13, 2019 at 03:44:28PM +1100, Alexey Kardashevskiy wrote:
>>>>
>>>>
>>>> On 12/11/2019 18:08, Michael S. Tsirkin wrote:
>>>>> On Tue, Nov 12, 2019 at 02:53:49PM +1100, Alexey Kardashevskiy wrote:
>>>>>> Hi!
>>>>>>
>>>>>> I am enabling IOMMU for virtio in the pseries firmware (SLOF) and seeing
>>>>>> problems, one of them is SLOF does SCSI bus scan, then it stops the
>>>>>> virtio-scsi by clearing MMIO|IO|BUSMASTER from PCI_COMMAND (as SLOF
>>>>>> stopped using the devices) and when this happens, I see unassigned
>>>>>> memory access (see below) which happens because disabling busmaster
>>>>>> disables IOMMU and QEMU cannot access the rings to do some shutdown. And
>>>>>> when this happens, the device does not come back even if SLOF re-enables it.
>>>>>
>>>>> In fact clearing bus master should disable ring access even
>>>>> without the IOMMU.
>>>>> Once you do this you should not wait for rings to be processed,
>>>>> it is safe to assume they won't be touched again and just
>>>>> free up any buffers that have not been used.
>>>>>
>>>>> Why don't you see this without IOMMU?
>>>>
>>>> Because without IOMMU, virtio can always access rings, it does not need
>>>> bus master address space for that.
>>>
>>> Right and that's a bug in virtio scsi. E.g. virtio net checks
>>> bus mastering before each access.
>>
>> You have to be specific - virtio scsi in the guest or in QEMU?
> 
> If a device accesses memory with bus master on, it's buggy.
> 
>>
>>> Which is all well and good, but we can't just break the world
>>> so I guess we first need to fix SLOF, and then add
>>> a compat property. And maybe keep it broken for
>>> legacy ...
>>>
>>>>
>>>>> It's a bug I think, probably there to work around buggy guests.
>>>>>
>>>>> So pls fix this in SLOF and then hopefully we can drop the
>>>>> work arounds and have clearing bus master actually block DMA.
>>>>
>>>>
>>>> Laszlo suggested writing 0 to the status but this does not seem helping,
>>>> with both ioeventfd=true/false. It looks like setting/clearing busmaster
>>>> bit confused memory region caches in QEMU's virtio. I am confused which
>>>> direction to keep digging to, any suggestions? Thanks,
>>>>
>>>
>>> to clarify you reset after setting bus master? right?
>>
>>
>> I was talking about clearing the bus master, and where I call that
>> virtio reset does not matter. Thanks,
>>
>>
> 
> so
> 
> bus master =0
> reset
> bus master =1
> 
> device does not recover?


No, it does not. With my recent changes, it seems that only virtio-block
cannot recover; virtio-net and virtio-scsi are fine. Thanks,


> 
> 
>>>
>>>
>>>>
>>>>>
>>>>>> Hacking SLOF to not clear BUSMASTER makes virtio-scsi work but it is
>>>>>> hardly a right fix.
>>>>>>
>>>>>> Is this something expected? Thanks,
>>>>>>
>>>>>>
>>>>>> Here is the exact command line:
>>>>>>
>>>>>> /home/aik/pbuild/qemu-garrison2-ppc64/ppc64-softmmu/qemu-system-ppc64 \
>>>>>>
>>>>>> -nodefaults \
>>>>>>
>>>>>> -chardev stdio,id=STDIO0,signal=off,mux=on \
>>>>>>
>>>>>> -device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
>>>>>>
>>>>>> -mon id=MON0,chardev=STDIO0,mode=readline \
>>>>>>
>>>>>> -nographic \
>>>>>>
>>>>>> -vga none \
>>>>>>
>>>>>> -enable-kvm \
>>>>>> -m 2G \
>>>>>>
>>>>>> -device
>>>>>> virtio-scsi-pci,id=vscsi0,iommu_platform=on,disable-modern=off,disable-legacy=on
>>>>>> \
>>>>>> -drive id=DRIVE0,if=none,file=img/u1804-64le.qcow2,format=qcow2 \
>>>>>>
>>>>>> -device scsi-disk,id=scsi-disk0,drive=DRIVE0 \
>>>>>>
>>>>>> -snapshot \
>>>>>>
>>>>>> -smp 1 \
>>>>>>
>>>>>> -machine pseries \
>>>>>>
>>>>>> -L /home/aik/t/qemu-ppc64-bios/ \
>>>>>>
>>>>>> -trace events=qemu_trace_events \
>>>>>>
>>>>>> -d guest_errors \
>>>>>>
>>>>>> -chardev socket,id=SOCKET0,server,nowait,path=qemu.mon.ssh59518 \
>>>>>>
>>>>>> -mon chardev=SOCKET0,mode=control
>>>>>>
>>>>>>
>>>>>>
>>>>>> Here is the backtrace:
>>>>>>
>>>>>> Thread 5 "qemu-system-ppc" hit Breakpoint 8, unassigned_mem_accepts
>>>>>> (opaque=0x0, addr=0x5802, size=0x2, is_write=0x0, attrs=...) at /home/
>>>>>> aik/p/qemu/memory.c:1275
>>>>>> 1275        return false;
>>>>>> #0  unassigned_mem_accepts (opaque=0x0, addr=0x5802, size=0x2,
>>>>>> is_write=0x0, attrs=...) at /home/aik/p/qemu/memory.c:1275
>>>>>> #1  0x00000000100a8ac8 in memory_region_access_valid (mr=0x1105c230
>>>>>> <io_mem_unassigned>, addr=0x5802, size=0x2, is_write=0x0, attrs=...) at
>>>>>> /home/aik/p/qemu/memory.c:1377
>>>>>> #2  0x00000000100a8c88 in memory_region_dispatch_read (mr=0x1105c230
>>>>>> <io_mem_unassigned>, addr=0x5802, pval=0x7ffff550d410, op=MO_16,
>>>>>> attrs=...) at /home/aik/p/qemu/memory.c:1418
>>>>>> #3  0x000000001001cad4 in address_space_lduw_internal_cached_slow
>>>>>> (cache=0x7fff68036fa0, addr=0x2, attrs=..., result=0x0,
>>>>>> endian=DEVICE_LITTLE_ENDIAN) at /home/aik/p/qemu/memory_ldst.inc.c:211
>>>>>> #4  0x000000001001cc84 in address_space_lduw_le_cached_slow
>>>>>> (cache=0x7fff68036fa0, addr=0x2, attrs=..., result=0x0) at
>>>>>> /home/aik/p/qemu/memory_ldst.inc.c:249
>>>>>> #5  0x000000001019bd80 in address_space_lduw_le_cached
>>>>>> (cache=0x7fff68036fa0, addr=0x2, attrs=..., result=0x0) at
>>>>>> /home/aik/p/qemu/include/exec/memory_ldst_cached.inc.h:56
>>>>>> #6  0x000000001019c10c in lduw_le_phys_cached (cache=0x7fff68036fa0,
>>>>>> addr=0x2) at /home/aik/p/qemu/include/exec/memory_ldst_phys.inc.h:91
>>>>>> #7  0x000000001019d86c in virtio_lduw_phys_cached (vdev=0x118b9110,
>>>>>> cache=0x7fff68036fa0, pa=0x2) at
>>>>>> /home/aik/p/qemu/include/hw/virtio/virtio-access.h:166
>>>>>> #8  0x000000001019e648 in vring_avail_idx (vq=0x118c2720) at
>>>>>> /home/aik/p/qemu/hw/virtio/virtio.c:302
>>>>>> #9  0x000000001019f5bc in virtio_queue_split_empty (vq=0x118c2720) at
>>>>>> /home/aik/p/qemu/hw/virtio/virtio.c:581
>>>>>> #10 0x000000001019f838 in virtio_queue_empty (vq=0x118c2720) at
>>>>>> /home/aik/p/qemu/hw/virtio/virtio.c:612
>>>>>> #11 0x00000000101a8fa8 in virtio_queue_host_notifier_aio_poll
>>>>>> (opaque=0x118c2798) at /home/aik/p/qemu/hw/virtio/virtio.c:3389
>>>>>> #12 0x000000001092679c in run_poll_handlers_once (ctx=0x11212e40,
>>>>>> timeout=0x7ffff550d7d8) at /home/aik/p/qemu/util/aio-posix.c:520
>>>>>> #13 0x0000000010926aec in try_poll_mode (ctx=0x11212e40,
>>>>>> timeout=0x7ffff550d7d8) at /home/aik/p/qemu/util/aio-posix.c:607
>>>>>> #14 0x0000000010926c2c in aio_poll (ctx=0x11212e40, blocking=0x1) at
>>>>>> /home/aik/p/qemu/util/aio-posix.c:639
>>>>>> #15 0x000000001091fe0c in aio_wait_bh_oneshot (ctx=0x11212e40,
>>>>>> cb=0x1016f35c <virtio_scsi_dataplane_stop_bh>, opaque=0x118b9110) at
>>>>>> /home/aik/p/qemu/util/aio-wait.c:71
>>>>>> #16 0x000000001016fa60 in virtio_scsi_dataplane_stop (vdev=0x118b9110)
>>>>>> at /home/aik/p/qemu/hw/scsi/virtio-scsi-dataplane.c:211
>>>>>> #17 0x0000000010684740 in virtio_bus_stop_ioeventfd (bus=0x118b9098) at
>>>>>> /home/aik/p/qemu/hw/virtio/virtio-bus.c:245
>>>>>> #18 0x0000000010688290 in virtio_pci_stop_ioeventfd (proxy=0x118b0fa0)
>>>>>> at /home/aik/p/qemu/hw/virtio/virtio-pci.c:292
>>>>>> #19 0x00000000106891e8 in virtio_write_config (pci_dev=0x118b0fa0,
>>>>>> address=0x4, val=0x100100, len=0x4) at
>>>>>> /home/aik/p/qemu/hw/virtio/virtio-pci.c:613
>>>>>> #20 0x00000000105b7228 in pci_host_config_write_common
>>>>>> (pci_dev=0x118b0fa0, addr=0x4, limit=0x100, val=0x100100, len=0x4) at
>>>>>> /home/aik/p/qemu/hw/pci/pci_host.c:81
>>>>>> #21 0x00000000101f7bdc in finish_write_pci_config (spapr=0x11217200,
>>>>>> buid=0x800000020000000, addr=0x4, size=0x4, val=0x100100,
>>>>>> rets=0x7e7533e0) at /home/aik/p/qemu/hw/ppc/spapr_pci.c:192
>>>>>> #22 0x00000000101f7cec in rtas_ibm_write_pci_config (cpu=0x11540df0,
>>>>>> spapr=0x11217200, token=0x2017, nargs=0x5, args=0x7e7533cc, nret=0x1,
>>>>>> rets=0x7e7533e0) at /home/aik/p/qemu/hw/ppc/spapr_pci.c:216
>>>>>> #23 0x00000000101f5860 in spapr_rtas_call (cpu=0x11540df0,
>>>>>> spapr=0x11217200, token=0x2017, nargs=0x5, args=0x7e7533cc, nret=0x1,
>>>>>> rets=0x7e7533e0) at /home/aik/p/qemu/hw/ppc/spapr_rtas.c:416
>>>>>> #24 0x00000000101ee214 in h_rtas (cpu=0x11540df0, spapr=0x11217200,
>>>>>> opcode=0xf000, args=0x7ffff4cf0030) at
>>>>>> /home/aik/p/qemu/hw/ppc/spapr_hcall.c:1214
>>>>>> #25 0x00000000101f0524 in spapr_hypercall (cpu=0x11540df0,
>>>>>> opcode=0xf000, args=0x7ffff4cf0030) at
>>>>>> /home/aik/p/qemu/hw/ppc/spapr_hcall.c:2014
>>>>>> #26 0x000000001033bff0 in kvm_arch_handle_exit (cs=0x11540df0,
>>>>>> run=0x7ffff4cf0000) at /home/aik/p/qemu/target/ppc/kvm.c:1684
>>>>>> #27 0x00000000100cc7c8 in kvm_cpu_exec (cpu=0x11540df0) at
>>>>>> /home/aik/p/qemu/accel/kvm/kvm-all.c:2391
>>>>>> #28 0x000000001008edf8 in qemu_kvm_cpu_thread_fn (arg=0x11540df0) at
>>>>>> /home/aik/p/qemu/cpus.c:1318
>>>>>> #29 0x000000001092c704 in qemu_thread_start (args=0x11588d90) at
>>>>>> /home/aik/p/qemu/util/qemu-thread-posix.c:519
>>>>>> #30 0x00007ffff7b58070 in start_thread (arg=0x7ffff550ebf0) at
>>>>>> pthread_create.c:335
>>>>>> #31 0x00007ffff7aa3a70 in clone () at
>>>>>> ../sysdeps/unix/sysv/linux/powerpc/powerpc64/clone.S:96
>>>>>> (gdb)
>>>>>>
>>>>>> -- 
>>>>>> Alexey
>>>>>
>>>>
>>>> -- 
>>>> Alexey
>>>
>>
>> -- 
>> Alexey
> 

-- 
Alexey

