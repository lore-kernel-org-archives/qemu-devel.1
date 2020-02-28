Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEB2C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAA9246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ih4aWZmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAA9246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7czR-0007Ym-3Y
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7cyO-0006qP-WB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7cyN-00081k-KK
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:34:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7cyN-00080n-Ds
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582886059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0pg2IenwN7t5QCBH1oveC89x9IaVHX2BKicMCPpaFk=;
 b=Ih4aWZmh4As3yNNOdBSnnjCzeX4OzoaV+pmJY/r2GBB0jQeFe2KCQ5SmR6Id/OmnF82t+o
 TIgYB8JMg9HJ7WOCYtz4NwhJiy5SdF/P9Ce7P2SSZEBMKj24NherSx4AAEOMdbLn3+rZcc
 11bdxc3QOv3a+sHVgR1H1jsHdfbH52A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-Bvlwok_fMSSq0lT6DxgXdQ-1; Fri, 28 Feb 2020 05:34:17 -0500
X-MC-Unique: Bvlwok_fMSSq0lT6DxgXdQ-1
Received: by mail-wr1-f71.google.com with SMTP id o6so1149750wrp.8
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:34:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j0pg2IenwN7t5QCBH1oveC89x9IaVHX2BKicMCPpaFk=;
 b=A+Zln/A8w0Vb5tf+krg1m8VbMesCdupSn3YMM94pXKXop8JLhr6ma3EgEkZMV2IUD3
 +eTGyrEv7L/BlS9YIphBelDlmj0whpA5yRtOVquA3VLSy8ztzEd5BfecjsjkIG0WPIEj
 Wk9Ls8DzLyyNrde9FjzzQ+ITLoISTdEM4nymeUNoyiV60GqJC6Dga5+4oq6o6EoTWZNV
 5OyDT3IUEdf9LwylDwbW9+Wr0d4G03SlX3YjXy1y1GeR331imF1v0ODL8P2Ee4JH0QeR
 Egz1J11KETgjCsbfgVbAPXzMKXCf8Bp/UPJwxthuVJ+n1VU2IXpgb/Li7Lndk6w3YBeo
 VD+g==
X-Gm-Message-State: APjAAAUM7C18HnBkWEzneT4kfGAttRSTGNH1VS/Nw9pb8PchPtrzmATG
 zFOK540FBvuS9Zlt5j+7zRvxkM7S2Pj93lnZa4FvL/9spYLBUhmnl37o4nEKQE/esK8uSb9LIzX
 Ej7ivp2lzYbzma0c=
X-Received: by 2002:a05:600c:104d:: with SMTP id
 13mr4208311wmx.50.1582886056453; 
 Fri, 28 Feb 2020 02:34:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYXl4XkeRChz1DZsjaE3OCxCbAxlQznEblqKEN9ZLLQSWY5874V2XhzS2Bs1tJkJh9aCdJLw==
X-Received: by 2002:a05:600c:104d:: with SMTP id
 13mr4208290wmx.50.1582886056170; 
 Fri, 28 Feb 2020 02:34:16 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f?
 ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id v17sm11129142wrt.91.2020.02.28.02.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 02:34:15 -0800 (PST)
Subject: Re: [PATCH v1.1 4/5] KVM: Kick resamplefd for split kernel irqchip
To: Auger Eric <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20200227170048.236599-1-peterx@redhat.com>
 <5e69c385-b27c-61d4-5856-21bcf5e9c8f5@redhat.com>
 <20200227180003.GJ180973@xz-x1>
 <2852480c-89fe-4c4e-75be-7322592976b6@redhat.com>
 <20200227191900.GK180973@xz-x1>
 <8ab9ccaa-7060-9e90-d4a9-a9de32610381@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c3e3f25-b20e-08bd-fa1e-f307fe7f02a4@redhat.com>
Date: Fri, 28 Feb 2020 11:34:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8ab9ccaa-7060-9e90-d4a9-a9de32610381@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/02/20 22:14, Auger Eric wrote:
>> Yes KVM kernel side should not be involed when we're using split
>> irqchip in this case.  However it should still belongs to the work of
>> the userspace KVM module (kvm-all.c) so that it can still "mimic" the
>> resamplefd feature that KVM_IRQFD provides.
> OK. So that what my actual question. Should this be handled by kvm-all.c?

I think it should; kvm-all.c in this case is providing the API to enable
irqfds (including resamplefds).

You could have a generic file descriptor<->interrupt routing subsystem,
but for now that only exists for KVM so that's where Peter's code need
to go.

Paolo


