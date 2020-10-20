Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2E1C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3932237B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrVA03ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3932237B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUlR2-0007QN-9L
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 02:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUlPh-00067k-FH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 02:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUlPf-0004ZD-Km
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 02:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603176386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ItSIOAeSevC9+dcqC8cuO03qo4FwB5Pr3nw54jA+Okg=;
 b=CrVA03lnKONrFABHiB8eVSZoCgetclIu9NrU8q03YP88llz55m7JSj3dl3xRNU4QIdzYeI
 6t5bUqhyG3O2A3l/xtFsYxEkuoCbCZaG2J/Rzm7fSSaeV0bqj3JzOGYREr8V9PqHmkwlL3
 gB+z4YOpxbK1hl9FFSR7HpNZevS3+wA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-2_TgUG0-M5CpStQP5luXog-1; Tue, 20 Oct 2020 02:46:25 -0400
X-MC-Unique: 2_TgUG0-M5CpStQP5luXog-1
Received: by mail-wr1-f72.google.com with SMTP id k14so397808wrd.6
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 23:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ItSIOAeSevC9+dcqC8cuO03qo4FwB5Pr3nw54jA+Okg=;
 b=D+XfOPzvAk9+csf/SN4tt3RgNxmzPIZFKaai+31AqblNhugW4oeSS7C3g9HAWFl4Nn
 r2hTix4J1I1vPj1vp3xwPsneEMUWvpSZNWl721U/odWp7QR1K2hWYz5cYVDQA6ptsbG8
 GON8WLkA7uxnblTAJkaj8Q1iVqdvExJvI9CpYO2mMPpbIryFh1Bxhl8WpzDcnQ6dQI8x
 /T8NK8Fda/3MXRjnSD0i8JDUocDEgNW00JcVMHzMT/WCdvvjtVJ1oXGK2zmQOCI4B7Ef
 ouq3Al9qg7UbwLfOoE1z+X8ZF/FEui/uk7QUChczEjnt7rb7lSqj1bJ+QhSLYHExI+7B
 13Qg==
X-Gm-Message-State: AOAM530qkg7JsJhEXtXSMbHU0em+W9bCVORlRUOdXIu7Eztco9zVQELf
 WasP1BmdYB8aVlUKkhzJwgiK0zgMEJwi2orHWcbcPBSbm5W7Et3r9wKDszEWBT4f+q119zAPYJ1
 JR7HRAjCXZr9wJrw=
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr1193072wmh.72.1603176384285; 
 Mon, 19 Oct 2020 23:46:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2SFeVNC0mQDkgaFFUaOV7h9jEiqQO7xH1uIZ7SpPz4kbxDXULNTZp9CW7qoT4FJTJVIcoJg==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr1193047wmh.72.1603176384012; 
 Mon, 19 Oct 2020 23:46:24 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id c18sm1312971wrt.10.2020.10.19.23.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 23:46:23 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] migration: Don't use '#' flag of printf format
To: Bihong Yu <yubihong@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
 <1602508140-11372-3-git-send-email-yubihong@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <55125c02-ebc5-2360-54e4-ef8035f58841@redhat.com>
Date: Tue, 20 Oct 2020 08:46:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602508140-11372-3-git-send-email-yubihong@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhengchuan@huawei.com, alex.chen@huawei.com, wanghao232@huawei.com,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 3:08 PM, Bihong Yu wrote:
> Signed-off-by: Bihong Yu <yubihong@huawei.com>
> Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>
> ---
>   migration/block.c | 2 +-
>   migration/ram.c   | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


