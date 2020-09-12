Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA83C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 07:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D9320796
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 07:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iwivc7nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D9320796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH0Ew-0005qp-U2
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 03:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kH0Da-0005Di-5U
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 03:45:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kH0DX-00057u-TL
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 03:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599896702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TV2SnBAjkwQL27gMLQh4okGFZdjvMKuQ8XHLf1uGsKg=;
 b=Iwivc7nw8N2TS74eezfkm5EnsjrzeZmWGoHJaebmCimu8dWBw+iAUR7OzVbVmj6PuVptwl
 FJkRkGU7HOJSERJPmiQd/9uFx6PRk0IaJb20EgJHI4J+8DKFoTEcCPDTO0YkeTupTMMdNp
 Aaj+xMuGqD6OElqI7XU44z7MvGzh6zE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-2qVzqH4VMGCG3DdqMAnXKQ-1; Sat, 12 Sep 2020 03:45:00 -0400
X-MC-Unique: 2qVzqH4VMGCG3DdqMAnXKQ-1
Received: by mail-wr1-f69.google.com with SMTP id r16so4098117wrm.18
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 00:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TV2SnBAjkwQL27gMLQh4okGFZdjvMKuQ8XHLf1uGsKg=;
 b=cfV/eHf9jeaanJufRFFqqi65dWsRKVMQhP+0IfC9xtuadKCnhq4+aWfvdXCY5/vFiB
 vqrQ4Acj/td80wLufYSngamRUPFu5X3x2jyy78rTBOr9awT877ivMAO8jLmj4AYoi6Pe
 E4yQqXyVmZ5i9TB7NSIT7CXR+DQS1oxV50qMfPXemcVVwJUc/vNpWVC1Dy6UBxPHk5y6
 SuBFTKuZSXVRgRxWhbKdERvFkm4qxa8lexUMvdqwkwv7wBbZxI1QWxD9OSB/ic0jHkta
 O+CN0mEGbJ6YFuVc1x4rvFJIcKXcOGm9wNdI24MIdTcy/IcT2+hm7gjUn6qpasbT3R6V
 jZPA==
X-Gm-Message-State: AOAM531rP5chNlkHLB9g1sAoyvIcspDoTdsaHzxvLv34Gsu0VT/HhVwE
 U6ijxq8xIaPHMWO7THOA9SA+BHq8DR1AsvOh+fS7rHvF8wrc1mIWiLCsrUc/Ol1HRoWE8RA0xGA
 +dTNBxd4nAvSPLHc=
X-Received: by 2002:adf:a3d4:: with SMTP id m20mr387183wrb.29.1599896698823;
 Sat, 12 Sep 2020 00:44:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeOIL7lAjX98JCn4uod39prNQnJ+T1kyqsjHyUo6iF5W0AceJuCxhEz63Db8Ez0toUG4WM7A==
X-Received: by 2002:adf:a3d4:: with SMTP id m20mr387167wrb.29.1599896698632;
 Sat, 12 Sep 2020 00:44:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5568:7f99:4893:a5b6?
 ([2001:b07:6468:f312:5568:7f99:4893:a5b6])
 by smtp.gmail.com with ESMTPSA id 185sm9210269wma.18.2020.09.12.00.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 00:44:58 -0700 (PDT)
Subject: Re: [PATCH 0/3] numa: cleanups for 5.2
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200911084410.788171-1-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <502e6554-5c70-48df-8827-3f52ffa04165@redhat.com>
Date: Sat, 12 Sep 2020 09:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911084410.788171-1-imammedo@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 02:25:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ehabkost@redhat.com, mst@redhat.com, libvir-list@redhat.com,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/20 10:44, Igor Mammedov wrote:
> Remove deprecated default RAM splitting beween numa
> nodes that was deprecated since 4.1, and a couple of
> minor numa clean ups.
> 
> Igor Mammedov (3):
>   numa: drop support for '-numa node' (without memory specified)
>   doc: Cleanup "'-mem-path' fallback to RAM" deprecation text
>   numa: remove fixup numa_state->num_nodes to MAX_NODES
> 
>  include/hw/boards.h        |  2 --
>  include/sysemu/numa.h      |  4 ---
>  docs/system/deprecated.rst | 44 +++++++++++++++-------------
>  hw/core/machine.c          |  1 -
>  hw/core/numa.c             | 59 --------------------------------------
>  hw/i386/pc_piix.c          |  1 -
>  hw/i386/pc_q35.c           |  1 -
>  hw/ppc/spapr.c             |  1 -
>  8 files changed, 24 insertions(+), 89 deletions(-)
> 

Queued, thanks.

Paolo


