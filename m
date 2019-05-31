Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A36C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 21:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9DC26F43
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 21:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9DC26F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49281 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWowy-0001Hc-5E
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 17:20:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hWovi-0000Xn-8u
	for qemu-devel@nongnu.org; Fri, 31 May 2019 17:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hWoiY-0003KV-O4
	for qemu-devel@nongnu.org; Fri, 31 May 2019 17:05:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hWoiY-0003Fw-Ii
	for qemu-devel@nongnu.org; Fri, 31 May 2019 17:05:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id l3so2643912qtj.5
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 14:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=qS5KKLAuXTVNp49lNgfyAlqUee6N5DH2z0Ff1EHVEBY=;
	b=HC5VzUgJLWsAHWxBlI1JOFl5dp4DyTpWWJt8OuaRd+rvXQy8HojGsEGgt0dBX+3tdo
	SfN37W9fVgR1SJdFfcVdqaY9Qy2siBOVO212tsdghqOn7xIhGMW58rzX+vbq8q9TnnyL
	RBRQWhiA2XwehRUQMyXMQQ5xHblGgyqfEQDngYwT/y7pa10mk1TqV1KWlYtJXGFdJCeG
	x91QdmcOiHZ+KvVbfoOoJG9SpAQhlzJTGZdhuqigycyQlsOfndW/QpKOUbDEJidAIMTN
	WgXS6IwvKXYdSWfnmPJTZAEbE1TMiqiX+3LCNlAqgJ9gRwMd27w0ublmHYZ0MdgKyHMD
	kzrg==
X-Gm-Message-State: APjAAAW/W4ibpzg+n8uMC8FrlKtpYhXQh4OXc9/X+H7j7gS5f3BAHKKD
	9nLSZUE/yfGZgSWTkgXG3/IzQg==
X-Google-Smtp-Source: APXvYqydb3u++fSNSAE3fUOPfISlIgE9JmBSnIz+qjv7VbQgRv8UHEjelYZ5lDsdjSytlj2GqvHKsw==
X-Received: by 2002:a0c:9ac8:: with SMTP id k8mr10680413qvf.159.1559336730128; 
	Fri, 31 May 2019 14:05:30 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id k9sm4403987qki.20.2019.05.31.14.05.27
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 14:05:28 -0700 (PDT)
Date: Fri, 31 May 2019 17:05:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190531170437-mutt-send-email-mst@kernel.org>
References: <20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190530134631-mutt-send-email-mst@kernel.org>
	<20190530180022.GB2864@work-vm>
	<20190530140419-mutt-send-email-mst@kernel.org>
	<20190530182210.GA22103@habkost.net>
	<20190530190322-mutt-send-email-mst@kernel.org>
	<20190531170154.GB22103@habkost.net>
	<20190531135059-mutt-send-email-mst@kernel.org>
	<20190531184512.GN3169@work-vm> <20190531142933.248cbd17@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531142933.248cbd17@x1.home>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH 3/4] net/virtio: add failover support
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
Cc: pkrempa@redhat.com, berrange@redhat.com,
	Eduardo Habkost <ehabkost@redhat.com>, aadam@redhat.com,
	qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, laine@redhat.com,
	jdenemar@redhat.com, Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 31, 2019 at 02:29:33PM -0600, Alex Williamson wrote:
> I don't know what this frontend/backend rework would
> look like for vfio-pci, but it seems non-trivial for this one use case
> and I don't see that it adds any value outside of this use case,
> perhaps quite the opposite, it's an overly complicated interface for
> the majority of use cases so we either move to a more complicated
> interface or maintain both.  Poor choices either way.

Well put Alex this is what I meant when I said it's a useless
interface. I meant it only has a single use.


