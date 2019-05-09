Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE426C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926592053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926592053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55039 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOjey-0006BP-BF
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:04:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOje0-0005VU-AQ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOjdy-0003a6-B0
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:03:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hOjdy-0003YU-5B
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:03:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id b203so3423576wmb.4
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 07:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Yrhkeo/D1SWdn9V2cEE0ViA0DwIW0vyIKZvpuO7PeWY=;
	b=jhrT/3PsgxIxBxUhVLSLXc3Kx5xrgJM961n7y4bwSLWuqCerf6iWWaBOq0Bz/rPJpX
	Z0njN92691ObmDjQX/WFxONSdK1lpk3zVLkxJSm9dEy4Dxz6xizRKzIVi2mV/qnXEKyG
	RzYn1TSR9HF/TLbdYLUj2A4DZ8QNZN8HBmIgfOfEIT3HafcCDoJxHlMJV9g9iVL4W7oo
	MorVzHIZ15X447T1F+Ha/eSDb50lBD30ELLYN3ZtvsVWgrkCV82R4koFODGvbsvGyfak
	xH3bzMRUxzTzUW1oMLbYJh6IaS77XmhXkYevwKI3MlCd94fCfyYCgmezxBHaIYz6W4Mn
	ZfHw==
X-Gm-Message-State: APjAAAVmFtBpMMtlqoCYTaEpvsOi9bx0zL1nsLOJT3XNKkzxK76gcpos
	DXH20npq9gazZP7ybEI+o+Elbw==
X-Google-Smtp-Source: APXvYqwDk+n3XwhZCsKh1ANuo9jWXryjM+Vxg935rpH+KLGIRVRIODVkxo97wjcLdmILS3CDRDY5kg==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr3271666wmh.32.1557410608505; 
	Thu, 09 May 2019 07:03:28 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151])
	by smtp.gmail.com with ESMTPSA id m6sm3121799wmc.32.2019.05.09.07.03.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 07:03:27 -0700 (PDT)
Date: Thu, 9 May 2019 16:03:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190509140325.dbdhybz67u7smhrq@steredhat>
References: <20190508075527.32164-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508075527.32164-1-thuth@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2] tests/Makefile: Remove unused
 test-obj-y variable
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 08, 2019 at 09:55:27AM +0200, Thomas Huth wrote:
> I recently noticed that test-obj-y contains a file called
> tests/check-block-qtest.o which simply does not belong to any .c
> file and thus wondered why this is not causing any trouble. It is
> only used to add -Itests to the command line (which refers to the
> build directory). However, it is not needed because "-iquote $(@D)"
> already sets this up in rules.mak. Thus we can simply remove this
> variable.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Fixed patch description with the information that Paolo provided.
> 
>  tests/Makefile.include | 19 -------------------
>  1 file changed, 19 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

