Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C57EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAFC20704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5sLLsxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAFC20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTiw5-0002dX-Rz
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 05:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiuY-0001w7-Rv; Sat, 17 Oct 2020 05:54:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiuX-0001Es-5W; Sat, 17 Oct 2020 05:54:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so6149099wrv.7;
 Sat, 17 Oct 2020 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=q49UfyD14QXRlfnbUMiA5vIoF4Xb1w8fN0itedSb+2M=;
 b=f5sLLsxblQrfSujPopRSZJu+ffXtEZdorPpo9KhpjmeXeaqTIEAaQyLwJ0p1EHZVfD
 MiXrLykGkCkUZvxeD1EHFbypsrmGV/zDF0BdgESlgzidr2sLrLqiS1uq2t2lgTp3jq5j
 qAb9xSDA+OcZqUK9FeVKlKfDFL8PZV+G+CMpC6hGq40kGVjpNmhxUxQMymtF5G5YUw1G
 xm8QVpO/yVp4NULjbS2Acny4gCpUoxrsRJp+WaW67opBT4Maw35eMlBcCLze/NYbl1Yd
 eXFuNSa82bNSypBhOreRnpL1L7n3xPFZ52FgDqEcDGjjBNtGIWp5nSSMblVOOitSE5Sl
 NZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q49UfyD14QXRlfnbUMiA5vIoF4Xb1w8fN0itedSb+2M=;
 b=p7eE3IWeAThl10Us6CzQEBtezfH0y1HtaSYqMqVR/jHiHssJGCDVReW3GhgA0mJ79T
 1kjs369bBFmiddBqLlv9c8spD0M4OSane4yVPacr6O68uT24sKfvp0ECSm7pCiVFpqsB
 Vse4icacDkbq4V1PqjFzGkiEA69ygFKKSgcGKYHV9bD77TA1IO23RopH+SvdmOzZB9Ko
 oRbfIRKFmUtfRGhl3xuqNE0UBHz6uF5/3Lt4StM/2d0x3kMOU+s1coAH0zbCKXgnM+HQ
 uwTslXa1ryF9T+le2C8y9wf0LnrMAiJivdv4rLakSYZGEdzBHyYIoZl3PXwnxSAJH33/
 LtvQ==
X-Gm-Message-State: AOAM532eRVrupMC6gQ+Ockswr/ia0b3X1ACcWEhS+LCj6kIOzxfgvMGB
 UOZ0q7STc31qfurC2R7FI14=
X-Google-Smtp-Source: ABdhPJzAhSzbhJyrmRYg+EN/1RzYaqKROMIjk0y3saZJ4DAONmPExQTKDvmuRu1mD5fCo6vlH9lYdQ==
X-Received: by 2002:a5d:504a:: with SMTP id h10mr8902218wrt.85.1602928438803; 
 Sat, 17 Oct 2020 02:53:58 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id q7sm3182764wrr.39.2020.10.17.02.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 02:53:57 -0700 (PDT)
Subject: Re: [PATCH 5/5] m48t59: remove legacy m48t59_init() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, hpoussin@reactos.org, qemu-ppc@nongnu.org,
 atar4qemu@gmail.com, david@gibson.dropbear.id.au
References: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
 <20201016182739.22875-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ad533302-e715-cc8a-12ec-d7e4ad75c120@amsat.org>
Date: Sat, 17 Oct 2020 11:53:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016182739.22875-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 8:27 PM, Mark Cave-Ayland wrote:
> Now that all of the callers of this function have been switched to use qdev
> properties, this legacy init function can now be removed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/rtc/m48t59.c         | 35 -----------------------------------
>   include/hw/rtc/m48t59.h |  4 ----
>   2 files changed, 39 deletions(-)

In the PoC I started after your suggestion, I see:

#define TYPE_M48T02_SRAM "sysbus-m48t02"
#define TYPE_M48T08_SRAM "sysbus-m48t08"
#define TYPE_M48T59_SRAM "sysbus-m48t59"

static void m48t02_class_init(ObjectClass *oc, void *data)
{
     M48txxSysBusDeviceClass *amc = M48TXX_SYS_BUS_CLASS(oc);

     amc->model = 2;
     amc->size = 2 * KiB;
};

static void m48t08_class_init(ObjectClass *oc, void *data)
{
     M48txxSysBusDeviceClass *amc = M48TXX_SYS_BUS_CLASS(oc);

     amc->model = 8;
     amc->size = 8 * KiB;
};

static void m48t59_class_init(ObjectClass *oc, void *data)
{
     M48txxSysBusDeviceClass *amc = M48TXX_SYS_BUS_CLASS(oc);

     amc->model = 59;
     amc->size = 8 * KiB;
};

static const TypeInfo m48t59_register_types[] = {
     {
         .name           = TYPE_M48T02_SRAM,
         .parent         = TYPE_M48TXX_SYSBUS,
         .class_init     = m48t02_class_init,
     }, {
         .name           = TYPE_M48T08_SRAM,
         .parent         = TYPE_M48TXX_SYSBUS,
         .class_init     = m48t08_class_init,
     }, {
         .name           = TYPE_M48T59_SRAM,
         .parent         = TYPE_M48TXX_SYSBUS,
         .class_init     = m48t59_class_init,
     }, {
         .name           = TYPE_M48TXX_SYSBUS,
         .parent         = TYPE_SYS_BUS_DEVICE,
         .instance_size  = sizeof(M48txxSysBusState),
         .instance_init = m48t59_init1,
         .class_size     = sizeof(M48txxSysBusDeviceClass),
         .class_init     = m48txx_sysbus_class_init,
         .abstract       = true,
         .interfaces = (InterfaceInfo[]) {
             { TYPE_NVRAM },
             { }
         }
     }
};

and:

#define TYPE_M48T59_SRAM "isa-m48t59"

static void m48t59_class_init(ObjectClass *oc, void *data)
{
     M48txxISADeviceClass *midc = M48TXX_ISA_CLASS(oc);

     midc->model = 59;
     midc->size = 8 * KiB;
};

static const TypeInfo m48t59_isa_register_types[] = {
     {
         .name           = TYPE_M48T59_SRAM,
         .parent         = TYPE_M48TXX_ISA,
         .class_init     = m48t59_class_init,
     }, {
         .name           = TYPE_M48TXX_ISA,
         .parent         = TYPE_ISA_DEVICE,
         .instance_size  = sizeof(M48txxISAState),
         .class_size     = sizeof(M48txxISADeviceClass),
         .class_init     = m48txx_isa_class_init,
         .abstract       = true,
         .interfaces = (InterfaceInfo[]) {
             { TYPE_NVRAM },
             { }
         }
     }
};

I guess I didn't pursue because I wondered what was the
best way to have the same model usable by sysbus/isa.

IIRC I wanted to proceed as having TYPE_M48T59_SRAM being
an abstract qdev parent, and then TYPE_M48TXX_SYSBUS /
TYPE_M48TXX_ISA implementing the SYSBUS/ISA interfaces.

As it need some thinking I postponed that for after 5.2.

Anyhow back to this patch:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

