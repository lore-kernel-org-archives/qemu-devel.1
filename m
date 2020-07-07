Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13283C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE484206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq2dHy1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE484206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsd8j-0000cz-Ui
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 22:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsd89-0000B3-Ap
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 22:14:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsd87-0006cw-QR
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 22:14:45 -0400
Received: by mail-wr1-x441.google.com with SMTP id f2so15482852wrp.7
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 19:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xbFcqWkLtEt6afgn/H3Y3kAqS72kSqaaoAl2cDG9jZc=;
 b=Mq2dHy1pT1YQ3AR81djVXEcNjAkXbp9//57PtkB87Zv+dhXgVs6xVu0QaksgGngfH8
 QJruXDNuapW+IUm3N3pxeUan5tQt9kJRxQf80PtKpihI5/OD6v6gtX2KZMCdokAFhDf0
 mxUM3c4GLp3K2gcI6gcFT5fSg/SmzeJPG5Iuprhf8qUreWZxh8iYfAtdVDeg54lD7QSx
 6wgf+7/UY8aZa4GzHOqDodsvNn/zPkL4ZJDHW080yek6aS78ihpcAbv2Ne2rX+Q/KhDc
 4eriFOTlDHjaX7N1aOwj4MdB/0TjteCdD2FhMh9Vr+ldcTOy0Ex3luZcS6Ku9HvMRvyO
 DI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xbFcqWkLtEt6afgn/H3Y3kAqS72kSqaaoAl2cDG9jZc=;
 b=NnOp0jjLfeK0ocoMGSBpcaar0BQTpv/Vkbj4UT97JVeprbWQIvu+qPcYbq6HGu9gCu
 +LM4kTemsUUpAn2ndEpe43scbUoVn6azrWSETmxPh8AbafICqoJgr9rsyQXTSi8hGWC+
 E94pjyGFTZS5rvpm5ssobBevQxe60/+4Tql3Zdde0brSDpIdG0+S7TGD6/VC26m7IBMd
 jXg4+y2v38x10tSGGQc5DAQRYIMtEbXoqukTrKgWibZL/uYHHNJ3LuVjEtZrIPISevHw
 O6JjXVKlS9e39ou1Z6a/z0RIDK1odHH/l3lwIviTrZ3UXHVS3NXos55cmmwmilZHQkF5
 h2ng==
X-Gm-Message-State: AOAM532eNr84E2OmW47s5WQdr5Xh20Cj2xyonh6GKuqEv6b+4ZABW5H0
 kbZTtN+7668tG5XZHLsgaTA=
X-Google-Smtp-Source: ABdhPJyJGZOXgSckFXdAeSlwfH+Dhs20wyT+qK6ji2O2VcrcHK7F3D+40vuw1B0bjmjlwq0vfebM6w==
X-Received: by 2002:a5d:4e48:: with SMTP id r8mr50495981wrt.309.1594088082261; 
 Mon, 06 Jul 2020 19:14:42 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id o205sm1473578wme.24.2020.07.06.19.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 19:14:41 -0700 (PDT)
Subject: Re: [PATCH v2] util/qemu-option: Document the get_opt_value() function
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200629070858.19850-1-philmd@redhat.com>
 <1dec6cd5-42f8-8e9f-cc87-108e46a926cc@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <82bd90f7-9e08-8ada-2a87-b031ea1d116f@amsat.org>
Date: Tue, 7 Jul 2020 04:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1dec6cd5-42f8-8e9f-cc87-108e46a926cc@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 3:14 AM, Richard Henderson wrote:
> On 6/29/20 12:08 AM, Philippe Mathieu-Daudé wrote:
>> Coverity noticed commit 950c4e6c94 introduced a dereference before
>> null check in get_opt_value (CID1391003):
>>
>>   In get_opt_value: All paths that lead to this null pointer
>>   comparison already dereference the pointer earlier (CWE-476)
>>
>> We fixed this in commit 6e3ad3f0e31, but relaxed the check in commit
>> 0c2f6e7ee99 because "No callers of get_opt_value() pass in a NULL
>> for the 'value' parameter".
>>
>> Since this function is publicly exposed, it risks new users to do
>> the same error again. Avoid that documenting the 'value' argument
>> must not be NULL.
> 
> I think we should also add some use of __attribute__((nonnull(...))) to enforce
> this within the compiler.
> 
> I recently did this without a qemu/compiler.h QEMU_FOO wrapper within
> target/arm.  But the nonnull option has optional arguments, so it might be
> difficult to wrap in macros.

I have this patch after your suggestion from last year:

+#if __has_attribute(nonnull)
+# define QEMU_NONNULL(LIST) __attribute__((nonnull((LIST))))
+#else
+# define QEMU_NONNULL(LIST)
+#endif

Examples:

 SpaprDrc *spapr_dr_connector_new(Object *owner, const char *type,
-                                         uint32_t id);
+                                 uint32_t id) QEMU_NONNULL(1);
 SpaprDrc *spapr_drc_by_index(uint32_t index);
 SpaprDrc *spapr_drc_by_id(const char *type, uint32_t id);
-int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t
drc_type_mask);
+int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t
drc_type_mask)
+                 QEMU_NONNULL(3);

...


 /**
  * memory_region_init_iommu: Initialize a memory region of a custom type
@@ -1066,7 +1073,8 @@ void memory_region_init_iommu(void *_iommu_mr,
                               const char *mrtypename,
                               Object *owner,
                               const char *name,
-                              uint64_t size);
+                              uint64_t size)
+                              QEMU_NONNULL(4);

 /**
  * memory_region_init_ram - Initialize RAM memory region.  Accesses
into the
@@ -1154,7 +1162,8 @@ void memory_region_init_rom_device(MemoryRegion *mr,
                                    void *opaque,
                                    const char *name,
                                    uint64_t size,
-                                   Error **errp);
+                                   Error **errp)
+                                   QEMU_NONNULL(2);

I can send as RFC is that looks OK to you.

Regards,

Phil.

