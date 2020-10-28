Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26050C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8E6246B1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9WiKa4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8E6246B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXjLa-0008L6-L5
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 07:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kXjKi-0007tp-AO
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kXjKf-0004wb-H8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603883369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fV/D+/CQrSZU+NReL0OUdqqDe3XrWsxVGCUB2h8aqXw=;
 b=Q9WiKa4OBFQQTs/fZo8ILca3qzo+1VLDq0/b2EL73zPI49a5z1fSpPli5CQXgjY/VslT3n
 8yqs1C8pR7PJAQPB5wlZTXWfrwqEsGb5m+SQbj+lO6GPnx/KsBKn6Cvb0Uw7R2bDs6irpB
 CbN0Utf5s9r7yeUrhkXNWhQ9qypkbO4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-8ZYkg884P2CthnLeoSvfKA-1; Wed, 28 Oct 2020 07:09:27 -0400
X-MC-Unique: 8ZYkg884P2CthnLeoSvfKA-1
Received: by mail-wr1-f70.google.com with SMTP id n14so1987352wrp.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 04:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fV/D+/CQrSZU+NReL0OUdqqDe3XrWsxVGCUB2h8aqXw=;
 b=K1UYFLxbzSAuD1yFjr0sZUF9OfGUXs7qpG4BPfCg244epm/l+HgrQN+2O7O4PgIAes
 0JZi+yAcOko+H6eq6vUKj0o6tsNDQqy/FZQMOwccmTzVPWVw6Fe5y1/4/Jvp65b6iG/r
 BabOZWFcsnJqht3q+8kY/R6ctqVtWm8RUl91sEZU0KMf8vvIi6eK9K6Dz7aTIB84zfTh
 K3SHnECr3/ezdDV8FCwttW20GWIviuGG3t16ZrvwqjQsz5WGgVMZjQdFpcLN9hrItFSo
 NvBZ+9XOMd+DH/90365q2j18s63Xbhl7hXb5NuK4SHvfHbJ+yWG3aefVZvORv8jbTRQG
 vKEA==
X-Gm-Message-State: AOAM533JgyxEcP76JK0ju3kX6SnXeLcCVSF51X3+79zxIdz5kCV2u4OI
 Ysx898im+s795RqFHn3fSYNVkrvWHrHn8q+o4hN1Qupn8QBxCTfkIMmQ6aEwk5I1OpalXYDSOp1
 IBM9AyKaEwS8CW88=
X-Received: by 2002:a7b:ce8f:: with SMTP id q15mr7667825wmj.88.1603883366092; 
 Wed, 28 Oct 2020 04:09:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFcpvrFzTDNc4/BirFvtTP0XPHCxDgmqoetYIP9xqsrBst7f3r1fBHcxGIldFvmRbiiR32TQ==
X-Received: by 2002:a7b:ce8f:: with SMTP id q15mr7667798wmj.88.1603883365847; 
 Wed, 28 Oct 2020 04:09:25 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id f5sm5677078wmh.16.2020.10.28.04.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 04:09:24 -0700 (PDT)
Date: Wed, 28 Oct 2020 07:09:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
Message-ID: <20201028070758-mutt-send-email-mst@kernel.org>
References: <20201027151400.GA138065@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201027151400.GA138065@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.g.johnson@oracle.com,
 jag.raman@oracle.com, slp@redhat.com, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 kraxel@redhat.com, Felipe Franciosi <felipe@nutanix.com>,
 thanos.makatos@nutanix.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 03:14:00PM +0000, Stefan Hajnoczi wrote:
> There will be a birds-of-a-feather session at KVM Forum, a chance for
> us to get together and discuss Out-of-Process Device Emulation.
> 
> Please send suggestions for the agenda!
> 
> These sessions are a good opportunity to reach agreement on topics that
> are hard to discuss via mailing lists.
> 
> Ideas:
>  * How will we decide that the protocol is stable? Can third-party
>    applications like DPDK/SPDK use the protocol in the meantime?

and if not how do we prevent that?

>  * QEMU build system requirements: how to configure and build device
>    emulator binaries?
>  * Common sandboxing solution shared between C and Rust-based binaries?
>    minijail (https://github.com/google/minijail)? bubblewrap
>    (https://github.com/containers/bubblewrap)? systemd-run?

disconnect
migration

> Stefan



