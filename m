Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9501AC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6143B215F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjsZEiRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6143B215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iact5-0001jB-Ho
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iacdA-0007mF-Nv
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iaccx-0008K1-95
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:31:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46584
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iaccw-00084s-4N
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575019901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDFO3Tr884+CXFho/NF2ORgr9UhXxuyz6Bfi0NpiBz0=;
 b=PjsZEiRnE/ITiyXb3H3G9IWNr3j00Gk15lZK3pU8mrZWgFL/j1QkYdfZOpRexVxqKL8I2o
 R02x0oyHqUVNMg5RE6PQ7ImRd/dM4qM0/ZSgaQrmR+6Bv1gvDQV1wyZJ5WV/J+tnsVAcIr
 J5WkBxXU7Ss94jx98EC9M4z5XvXy6nQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-J8zP5kxmPMGgEPEoa0Zp7Q-1; Fri, 29 Nov 2019 04:31:39 -0500
Received: by mail-wm1-f72.google.com with SMTP id y14so4124265wmj.9
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 01:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wSBoanCvEavmJVqM3Nj1qCBmDZmbemLflV/jI36ZfcM=;
 b=qUYjovU8WP/qebMwTI/TFgZAyYJB1PZQntt0WseDdppZXcytHjUDR09YZvZ97dgw7s
 HlLdt0DS95Mo5bF+cLSXEA0uuzGnRSnQ6ZwRAqU7GLkc5aAwfvXHih17HFjzgHRswMfX
 7iCJDs1bRR/oTv083ykZ9lpUlrYFfec1WBNi0qWqt/1aM7IXr/8w/EAQ7L+/OWXJS13W
 HtSPvEwfM5638GG6ecttu0a2NrppdGD1zev9xaUjxKQP59s5CbqzwrYat1xFSTeMiwHk
 YfuXuP/sUULWZPQl7qNmB2mJhTsslQBA/Tvrg1urUJOmP72xjz87LC5J0i5LfRGqG8YO
 NaBQ==
X-Gm-Message-State: APjAAAWZ39TDzUl0W3CqfKR8zWEadBnIL/kD6cdxb8SLA/Pnfb6HSU51
 cTXR2cjuur4ggaVQE/IoI2ZxAtQ0ps6OULpE8p64naJRjDF1qZKFeuQU4Dv2Go31FSAa0ljQepC
 zZqfLoBmLCu5Fzgs=
X-Received: by 2002:a05:6000:1612:: with SMTP id
 u18mr28666682wrb.306.1575019898051; 
 Fri, 29 Nov 2019 01:31:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMKRUYiA2R/Vg1mjWuum9W1dXilTfdA1J7Hs7sNsbV5gS+4hXuPy9rlanfIJtKXvG7fuSftQ==
X-Received: by 2002:a05:6000:1612:: with SMTP id
 u18mr28666657wrb.306.1575019897738; 
 Fri, 29 Nov 2019 01:31:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:459f:99a9:39f1:65ba?
 ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
 by smtp.gmail.com with ESMTPSA id b186sm12607036wmb.21.2019.11.29.01.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2019 01:31:37 -0800 (PST)
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128161021.GA14595@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb122bbe-3fc4-e3cd-899a-c3538237203a@redhat.com>
Date: Fri, 29 Nov 2019 10:31:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191128161021.GA14595@habkost.net>
Content-Language: en-US
X-MC-Unique: J8zP5kxmPMGgEPEoa0Zp7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: stefanha@redhat.com, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/11/19 17:10, Eduardo Habkost wrote:
> On Thu, Nov 28, 2019 at 06:15:16PM +0400, Marc-Andr=C3=A9 Lureau wrote:
>> Hi,
>>
>> Setting up shared memory for vhost-user is a bit complicated from
>> command line, as it requires NUMA setup such as: m 4G -object
>> memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don -n=
uma
>> node,memdev=3Dmem.
>>
>> Instead, I suggest to add a -mem-shared option for non-numa setups,
>> that will make the -mem-path or anonymouse memory shareable.
>=20
> Can we make this be a "-m" option?
>=20
> Or, even better: can we make "-m" options be automatically
> translated to memory-backend-* options somehow?
>=20

The original idea was to always support one NUMA node, so that you could
do "-numa node,memdev=3D..." to specify a memory backend with -object.
However, this is not possible anymore since

    if (!mc->cpu_index_to_instance_props ||
        !mc->get_default_cpu_node_id) {
        error_setg(errp, "NUMA is not supported by this machine-type");
        return;
    }

has been added to hw/core/numa.c.

Therefore, I think instead of -mem-shared we should add a "-m
memdev=3D..." option.  This option:

* would be mutually exclusive with both -mem-path

* would be handled from allocate_system_memory_nonnuma.

* could be mutually exclusive "-numa node", or could just be mutually
exclusive with "-numa node,memdev=3D..." (the logical conclusion of that
however would be an undeprecation of "-numa node,mem=3D...", so that has
to be taken into account as well).

Paolo


