Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095DAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A192076E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnNVFzc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A192076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6Dv-0005JL-VQ
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo68u-00048E-Li
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo68r-0005v6-VA
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593007964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dodUbhN5/QDSqZn9CboDe3gOrUSNiRCt1w35WYoFqis=;
 b=KnNVFzc8UXm7UZRMKXwo+8Kn+Xgqs9tRkZhgCIfjGLZut3Rlxk+BS+lkwwPRW6Ajmtyz+Z
 FTlxfctRxDMuGygRgZ1aWwWSNNrmvs1XcQ0p1Nm6oFQ1U4tUJMejDcwPkARJhhIhiSGNHq
 vzyE2Zt3ddr1zngSzyMaVS0tlXf8yBo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-4qhoy6w0N8W8Gnj8EdE0FQ-1; Wed, 24 Jun 2020 10:12:42 -0400
X-MC-Unique: 4qhoy6w0N8W8Gnj8EdE0FQ-1
Received: by mail-wr1-f71.google.com with SMTP id w4so1129826wrm.5
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dodUbhN5/QDSqZn9CboDe3gOrUSNiRCt1w35WYoFqis=;
 b=BhfOXeiVbyD7XPcOAN63jpnx5m5gmfZrQBw7M+DZpb9qzBBDyBiluO0gjk7gCWdJs6
 wxb5Pc2gdm5lQCbir+mQDcx9KEJagKX702oL9cVn1FPNcpDYyheRrQGcKjVzfXRsNQ5X
 mikzzWZw0nsPyGbtAxjkeP9EVNQS/A3BEgpfPuHbZbE83/FPcF72lOaU4PVbNK8r2sAl
 LKEsAXWzr5a1Isx2h6pVWqdiPfIeuzuoip4a5Tky/meqgQWQTCHTbAQIWa/ZL9MRQQ9Z
 c+J86DYa9mic1ncvwlzW3VbB8DpfBES81I9Iud1Xy4sZGYNRI9AKO3HVNPmnZYjdNsv6
 6Hxg==
X-Gm-Message-State: AOAM530ASH3AtlSrw50g26dE0PMpgpp4dyPc4Ah4IbImSUt4t9f7xmLu
 IdZygOf5jc39RfHHB+WlLfHffAiQN5h+DBgQ2FOBNrgOpwdg8wqI/8sh6B4LVYCGJ4Wig7u9tcF
 F476PnG+z7FPoMw0=
X-Received: by 2002:a05:600c:2152:: with SMTP id
 v18mr8612117wml.5.1593007961481; 
 Wed, 24 Jun 2020 07:12:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQs7MFErLZgL8vMeAOyTMZEuC7QMxnPp4yHIqekVmaL708/G19pEwnZ36I/DCuxgi2UwOwjA==
X-Received: by 2002:a05:600c:2152:: with SMTP id
 v18mr8612108wml.5.1593007961308; 
 Wed, 24 Jun 2020 07:12:41 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.253.55])
 by smtp.gmail.com with ESMTPSA id 125sm8611682wmc.23.2020.06.24.07.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 07:12:40 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] qom: Introduce object_property_try_add_child()
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com
References: <20200624124301.7112-1-eric.auger@redhat.com>
 <20200624124301.7112-2-eric.auger@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1a144355-27bd-a26f-752e-00c2751d3a1f@redhat.com>
Date: Wed, 24 Jun 2020 16:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200624124301.7112-2-eric.auger@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/20 14:43, Eric Auger wrote:
> +    op = object_property_try_add(obj, name, type, object_get_child_property,
> +                                 NULL, object_finalize_child_property,
> +                                 child, errp);
> +    if (!op) {
> +        goto out;
> +    }
>      op->resolve = object_resolve_child_property;
> +out:
>      object_ref(child);
>      child->parent = obj;
>      return op;

I think if there's an error you need to return NULL without ref-ing
child, shouldn't you?

You can then add another test that object_property_add_child succeeds
after object_property_try_add_child fails.

Paolo


