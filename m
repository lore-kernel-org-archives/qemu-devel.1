Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9923BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FDF20715
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qvhrbtvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FDF20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTz5-0003Js-BJ
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iXTxf-0001ni-6G
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:40:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iXTxc-0005nk-DZ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:40:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58779
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iXTxc-0005mw-9l
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574271610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=j8oqeMNjyhCupX7B59eBB2lP0dJuuyqnNjWazIOvRj4=;
 b=QvhrbtvybDTTZdBvFwJMg3Uv1YeCPezr4Y/Na4jMQnCgdRX5GMfL+SUShAGEBTvUSWPFNT
 eC6qY/52UGev9ir7KkQi7fFgMKe/IFL2/VLgqgIapdqyiQufpXJTGC1CZChY58HDtsNWld
 bME5h5E0Qn2tfgafPK7P2xpipum63fQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-tWlVGYvsMm27uXgk3O8G2g-1; Wed, 20 Nov 2019 12:40:09 -0500
Received: by mail-wm1-f72.google.com with SMTP id y14so10326wmj.9
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 09:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HYdI+sd0b+BcPAEUIND3FA13bW9JY7nPQ0Az0CncgtQ=;
 b=jKfnbNNmSq5A2cfToo0uG2lxYb3LiK5Jh1RI9e6QEZbr30k6ZEGN0M3beCMa6lpKWB
 lCrnKn08y8fcGoB6/3JPJO4rntfEojk+0N+5Dyw4AQK4bNrjlNMP0nZPGteCCk6fGO0e
 af7jdiWTSdQq64zGkXgLr4hJXM4rMQGHBZxCwHC7ruwrgacdK+0BAt3cwcLy8sgze/0T
 /QNZsQOEoqfXc74fF0G/dNwKCB5jLg1eirGwckTuykq/1awLF16Gg4+BMOfa3Ao5sZyb
 0jQOLFuMMTb0yyGW+NXMSjlozaPVWwlZv8ZGxwU2S10G3ywQB+TLOZJce7JSFiX2+9C+
 rUYg==
X-Gm-Message-State: APjAAAVuhz7i4DU1yRxJwWEq9Bfl3f6MjDPx6MwTN3qcHYr05PgJ/pjN
 +ptaADg21p99X6Y+p/sZSE5Se42lhoS69BNI3Xq1Vx/19A/tX79Yz48Hezkv1VeBGomoQwDOR54
 VHEyWGpMjpClK5Nc=
X-Received: by 2002:a1c:dc09:: with SMTP id t9mr4616176wmg.65.1574271608172;
 Wed, 20 Nov 2019 09:40:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvTgXGus9TCV669z1+Qj45gZ7GbypisJHOpSwUzgtXG/YDt1a/GVhQyftkaeRk360S6h7YiA==
X-Received: by 2002:a1c:dc09:: with SMTP id t9mr4616144wmg.65.1574271607871;
 Wed, 20 Nov 2019 09:40:07 -0800 (PST)
Received: from [192.168.178.40] ([151.48.115.61])
 by smtp.gmail.com with ESMTPSA id k14sm33149468wrw.46.2019.11.20.09.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 09:40:07 -0800 (PST)
Subject: Re: [PATCH for-4.2 1/2] i386: Add new versions of
 Skylake/Cascadelake/Icelake without TSX
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20191120164912.32384-1-ehabkost@redhat.com>
 <20191120164912.32384-2-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b1d8c3ef-646a-85c7-176b-c4429f36d384@redhat.com>
Date: Wed, 20 Nov 2019 18:40:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191120164912.32384-2-ehabkost@redhat.com>
Content-Language: en-US
X-MC-Unique: tWlVGYvsMm27uXgk3O8G2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Jiri Denemark <jdenemar@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/19 17:49, Eduardo Habkost wrote:
> One of the mitigation methods for TAA[1] is to disable TSX
> support on the host system.  Linux added a mechanism to disable
> TSX globally through the kernel command line, and many Linux
> distributions now default to tsx=3Doff.  This makes existing CPU
> models that have HLE and RTM enabled not usable anymore.
>=20
> Add new versions of all CPU models that have the HLE and RTM
> features enabled, that can be used when TSX is disabled in the
> host system.

What is the effect of this when using "-cpu CascadeLake-Server" and
upgrading QEMU?  Would it automatically switch to the new version?  If
so, would it be better to include a duplicate of the models (and if so,
that would conflict with my VMX features patch, which is also for 4.2).

Paolo


