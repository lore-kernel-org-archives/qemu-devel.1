Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9918DC282E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C5720856
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C5720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55780 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUBT8-0008SK-Om
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:46:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1hUBRR-0007Pt-9E
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1hUBRQ-00064t-EK
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:45:05 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1hUBRQ-000642-9U
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:45:04 -0400
Received: by mail-it1-f193.google.com with SMTP id t184so16155789itf.2
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 07:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=QjAUOWJNDyVWG0osAZK7BPW17jsPC8d3cYMXCiQcZXo=;
	b=MJ6ywWe9T3AF14FynS+4DQdRYz8zfGC529sxq5phjepbMcK4Oa6m3ZeDR2bRCuc1eS
	BL+IgghIA/cnUL8X8qokyHBLtWBJlF51CUmss7yJChq29JJQlpcKQY6cjfsIMM0l6x0N
	AWfKz+lNg8Y0BaVrWzKS/Ajj8V+hXDxhq/gE7i1nYmWtJH7bqvK3+emvYmjzPP2FrvK3
	mOAwfUUQ9ee7m9LwsCKz8OAE0WJb1dkWk6qQPjEMUikVOzsrCVO0ztaM6wqGIOGnKWbA
	6pJ3buzAJOX9g3OfKpiyI/MEUptGpW9rN3MF19rhqE/fgMddRrnC+ESv571eebkV+w69
	ystA==
X-Gm-Message-State: APjAAAVQg4c4nzG5U0qJTMy/rOln75FjE2uDaaSZGqPDJNBzE4VtYUbQ
	Nz1hts+03PHVN6wBz4a5PnzebsJOG8BbZkxSIHc=
X-Google-Smtp-Source: APXvYqw+XT3vIJi6USZjkEH8n4Um3qiw+i0PheqEBhIRiZ5tcj67Ixmr9zmyer1vSWXSKkqHFYc8NiObrwn4JsiUTsQ=
X-Received: by 2002:a02:ce53:: with SMTP id y19mr11452538jar.129.1558709103382;
	Fri, 24 May 2019 07:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190520124716.30472-1-kraxel@redhat.com>
	<20190520124716.30472-6-kraxel@redhat.com>
In-Reply-To: <20190520124716.30472-6-kraxel@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Fri, 24 May 2019 04:15:50 -0400
Message-ID: <CAPyFy2B07uoAyH86mhxC+6dNj41hkprDdZd6ukrTRKW78urGhA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.166.193
Subject: Re: [Qemu-devel] [PATCH v3 05/14] tests/vm: run test builds on
 snapshot
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
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 at 08:47, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The build script doesn't shutdown the guest VMs properly,
> which results in filesystem corruption and guest boot
> failures sooner or later.
>
> Use the --snapshot to run builds on a snapshot,
> That way killing the VM doesn't corrupt the base image.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

Acked-by: Ed Maste <emaste@freebsd.org>

