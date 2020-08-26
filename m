Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F52C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEEB92071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEB92071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsXK-0000hU-4G
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kAsWQ-0007Lz-NT; Wed, 26 Aug 2020 06:19:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:32877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kAsWO-0005M1-C9; Wed, 26 Aug 2020 06:19:14 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mg6Na-1kp9HR3UgI-00hhXy; Wed, 26 Aug 2020 12:19:08 +0200
Subject: Re: [PATCH v3 49/74] swim: Rename struct SWIM to Swim
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-50-ehabkost@redhat.com>
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
Message-ID: <cf381ba6-96b6-1782-acdb-d6771bcf29cd@vivier.eu>
Date: Wed, 26 Aug 2020 12:19:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825192110.3528606-50-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AWlmIXZvUQel1AwEMTttrOQtWkMeLxjcjUeQBkuTP8+F3O+SpOQ
 pm4XYcjY6BgbDXRZpPDUEBGtRVc9mkhA1Vu0vOg0QyZKYoPsmM3mzVT6VozFwmTDST0Sq5m
 UcTTLkLmgo1rYYCUSB7FTcneNoIQsbkvNfW9FaRRuawa7e9iqXg1QH6rvBGXAk/ezOq8h6Z
 LptETr19fDY/9MiagZD7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RAFyOA8Iv94=:dewkJwPoAe0XflC31SxHOG
 oKBtyo8zx55IJWnvJt1IqzLyNLerlbGYQhlTPXzrnlxdmf8uuVzGOXU67LQESanP5iHSZVM+d
 rzwCTlYRxgrDNMqsW2rrEfn1OJeR9s7uTgODYuw/plq82XKQ5GlE1Z1dTdeKFI0UxNw6SqWo/
 YhWhEuP/mg8J7ySaGHgxXTYk5FzKBLHcy9zUs61o0oJAFfWQ7hei5Kp6oqPvWpSu96NHVoa78
 ty+yrMc/FMumvSjkc+pMvUS00N0wGesnOorKLr1jfeNJVzO0wZnwbkxRRBGri1nBDs/5r1p3h
 paHoixKFC/PHRqoO5NYUVFo9qsybLt00oabVaC9HZywePngwBOHZZ1FoQs7a5gODDf2Q/xI97
 g7CsewUOKQE7M6rKg0X5asgyRoOGKuYlhfW71qh8yM/czn852BQBwJXcxuq7G1WlUXXEE1MpQ
 iYOCWVyG1OycaPMOyAwz6GLJIVi2pdLezK8nf/HrDqNkgSkC0erRRXUiCmHttqCyBaziTXZCD
 Us+dh6SHLcWEPX5Ru791NLus68X834SVJpcYstgfBA3xg6/lIbBNiZME/EjgBiXMoUrf4D5hK
 Nrt9aCamgQAPBhk84GgzLMNJ2CCDo1CXbMVIfkDicZpnWLCB/b8POuX7UFx00xLPaKUcC3P5G
 kmI4lUth+OTUCQa2fvLHx2NPUmvvF9MGRXxm/6DoDWvxkYSgQP4EH90Go/hOq075o3ogONM/h
 JoqL8+1Fy4GkMbeFbqKATWCtrJS83/rEBuumb1O+TXK1N0VZIVYHkBEfSWmfpn8b2t3v64ZJ6
 XXQXSkkwqkzSrwTVAjj2BOABvp2wy1VLM9UMcWdEbUogBM9MhQ4tpeebVt4DIZH5Grm4Bdh
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 04:51:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.602,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/08/2020 à 21:20, Eduardo Habkost a écrit :
> Currently we have a SWIM typedef and a SWIM type checking macro,
> but OBJECT_DECLARE* would transform the SWIM macro into a
> function, and the function name would conflict with the SWIM
> typedef name.
> 
> Rename the struct and typedef to "Swim". This will make future
> conversion to OBJECT_DECLARE* easier.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes series v2 -> v3: new patch added to series v3
> 
> ---
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Cc: qemu-devel@nongnu.org
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/hw/block/swim.h |  6 +++---
>  hw/block/swim.c         | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
> index 6add3499d0..9d8b65c561 100644
> --- a/include/hw/block/swim.h
> +++ b/include/hw/block/swim.h
> @@ -67,10 +67,10 @@ struct SWIMCtrl {
>  };
>  
>  #define TYPE_SWIM "swim"
> -#define SWIM(obj) OBJECT_CHECK(SWIM, (obj), TYPE_SWIM)
> +#define SWIM(obj) OBJECT_CHECK(Swim, (obj), TYPE_SWIM)
>  
> -typedef struct SWIM {
> +typedef struct Swim {
>      SysBusDevice parent_obj;
>      SWIMCtrl     ctrl;
> -} SWIM;
> +} Swim;
>  #endif
> diff --git a/hw/block/swim.c b/hw/block/swim.c
> index 74f56e8f46..20133a814c 100644
> --- a/hw/block/swim.c
> +++ b/hw/block/swim.c
> @@ -387,7 +387,7 @@ static const MemoryRegionOps swimctrl_mem_ops = {
>  
>  static void sysbus_swim_reset(DeviceState *d)
>  {
> -    SWIM *sys = SWIM(d);
> +    Swim *sys = SWIM(d);
>      SWIMCtrl *ctrl = &sys->ctrl;
>      int i;
>  
> @@ -408,7 +408,7 @@ static void sysbus_swim_reset(DeviceState *d)
>  static void sysbus_swim_init(Object *obj)
>  {
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> -    SWIM *sbs = SWIM(obj);
> +    Swim *sbs = SWIM(obj);
>      SWIMCtrl *swimctrl = &sbs->ctrl;
>  
>      memory_region_init_io(&swimctrl->iomem, obj, &swimctrl_mem_ops, swimctrl,
> @@ -418,7 +418,7 @@ static void sysbus_swim_init(Object *obj)
>  
>  static void sysbus_swim_realize(DeviceState *dev, Error **errp)
>  {
> -    SWIM *sys = SWIM(dev);
> +    Swim *sys = SWIM(dev);
>      SWIMCtrl *swimctrl = &sys->ctrl;
>  
>      qbus_create_inplace(&swimctrl->bus, sizeof(SWIMBus), TYPE_SWIM_BUS, dev,
> @@ -460,7 +460,7 @@ static const VMStateDescription vmstate_sysbus_swim = {
>      .name = "SWIM",
>      .version_id = 1,
>      .fields = (VMStateField[]) {
> -        VMSTATE_STRUCT(ctrl, SWIM, 0, vmstate_swim, SWIMCtrl),
> +        VMSTATE_STRUCT(ctrl, Swim, 0, vmstate_swim, SWIMCtrl),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -477,7 +477,7 @@ static void sysbus_swim_class_init(ObjectClass *oc, void *data)
>  static const TypeInfo sysbus_swim_info = {
>      .name          = TYPE_SWIM,
>      .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(SWIM),
> +    .instance_size = sizeof(Swim),
>      .instance_init = sysbus_swim_init,
>      .class_init    = sysbus_swim_class_init,
>  };
> 

Acked-by: Laurent Vivier <laurent@vivier.eu>

