Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3ECC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9EB206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6oeX0pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9EB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdln-0008E3-Lb
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqdZV-0006YU-Cp
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:18:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43315
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqdZT-0000wk-Lm
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593613122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqMz89H4c14TmMKc3yqFpUusmscUOLX+JHF4/nTCE4s=;
 b=K6oeX0pYSFPku333fXvG55kFDhLnQv9i6hX4Ek02qIEdE4GGw6/xp2QA/xDSHwVc6qu4Ik
 fDwLlu97LMazupDl3+7W3u33mgEQy2udgHlUhUx7w/A/QHzFebkIQKxArk+4NORhQgTJSg
 mvxrJ8Emap8cU0aKV/tsV/1Nbk6T1YI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-aZxv6-JrMgimKWsAY4dfqQ-1; Wed, 01 Jul 2020 10:18:40 -0400
X-MC-Unique: aZxv6-JrMgimKWsAY4dfqQ-1
Received: by mail-wm1-f70.google.com with SMTP id g124so23630712wmg.6
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sqMz89H4c14TmMKc3yqFpUusmscUOLX+JHF4/nTCE4s=;
 b=XcimqT8Nl5DobK9mZwggPYeJZYXCwFmYZ8wAqXXzuc7zmIuTwbRDtC3hNKT/cQ/s7S
 oT4oNl6Vsj7xxgd4NMiPRZH7s9bBstQ8y4r78wMMBWGm8xJjkhXfBBueXZgAq6rAbC5p
 scFI//VjJQMCGoTnbM58+0x4TYacJa56ixWntdxC1J93F0IOj7+ew+T1lwRprGiJta+4
 laYVbW6KZ+gCdz0fx7BfINYtAozYriLAbW2PYXGWU00Xy4tnJGXnT/KrENvOTx9CgpUM
 Vqx65S+3H03Orpb9/GDV7WAF64MZQ4hA+KscIfjYmwZDMZszrd5Xb5RnQr261eK5IxCt
 kdVQ==
X-Gm-Message-State: AOAM533GqgtgWvdHB0oUCYq/tuBkNp6K6vISUMRhaOe1udJ3pitesa+t
 JtwxXWgfFc1dTv5A/xqQjY7Mf06LZdvvitfKy9G1TM9DasYpXbKWk8mFN5Ec3Q1zYjUUJh629iI
 i5O3owHx1+Rt6CRA=
X-Received: by 2002:a05:6000:1107:: with SMTP id
 z7mr26502153wrw.355.1593613119626; 
 Wed, 01 Jul 2020 07:18:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc0Y14fY6lhSx4ENHriBx4HpDdP2PigV45lAOFKyHpJdb8wtvUnKo47p8UF2iJrvC1+GXGCw==
X-Received: by 2002:a05:6000:1107:: with SMTP id
 z7mr26502141wrw.355.1593613119425; 
 Wed, 01 Jul 2020 07:18:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1142:70d6:6b9b:3cd1?
 ([2001:b07:6468:f312:1142:70d6:6b9b:3cd1])
 by smtp.gmail.com with ESMTPSA id x1sm7410182wrp.10.2020.07.01.07.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 07:18:38 -0700 (PDT)
Subject: Re: [PATCH] pc: fix leak in pc_system_flash_cleanup_unused
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200701015859.29820-1-alxndr@bu.edu>
 <edb74f76-57a0-ef4b-17fa-f9f4b5dae8bc@redhat.com>
 <20200701130620.cldkfygyhz6oscev@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d3de8d7e-3a11-106d-c0c8-33015813ef6c@redhat.com>
Date: Wed, 1 Jul 2020 16:18:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200701130620.cldkfygyhz6oscev@mozz.bu.edu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 15:06, Alexander Bulekov wrote:
>> Yes; you can also add it in pc_pflash_create, because
>>
>>     /*
>>      * Since object_property_add_child added a reference to the child object,
>>      * we can drop the reference added by object_initialize(), so the child
>>      * property will own the only reference to the object.
>>      */
>>
>> (from object_initialize_childv).
> Isn't that reference used at pc_sysfw.c:104 ?
> pcms->flash[0] = pc_pflash_create(pcms, "system.flash0", "pflash0");
> 
> In this case, shouldn't we unref when
> pc_sysfw.c:126  pcms->flash[0] = NULL
> ?

object_unparent already drops a reference.  Therefore, it's okay to drop
the reference immediately after object_property_add_child (which adds a
reference) and match pc_pflash_create with just object_unparent.

Paolo


