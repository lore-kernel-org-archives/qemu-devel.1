Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E717DC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88C920777
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0iwp+c5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88C920777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH9Ri-00055h-Ro
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jH9Qo-0004Bu-7o
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jH9Qm-000620-Qx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:03:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48337)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jH9Qm-00061g-Iw
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585155783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kiHmGKF0kvAkNrfI0xhN7LIgyJG0vefdgpUYFKoz6SM=;
 b=Y0iwp+c5xQR4JktAL1mpBB9ZiySTDAsD8AiD3ReGTW+vliYxXkawDf2HEtFgBSR8YXefts
 jZRywxgk1hy41N+C93jJIAlCqlIDVwRmzxPegHpf3SFgt+SxGorz+nf3AkOPkBvhQEixzG
 UsIaigPUK7gno9qaOiKKOwjjuDXp6zw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-irJV9QUIOsy9k6LHcSXT1Q-1; Wed, 25 Mar 2020 13:03:01 -0400
X-MC-Unique: irJV9QUIOsy9k6LHcSXT1Q-1
Received: by mail-wr1-f72.google.com with SMTP id y1so321515wrp.5
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 10:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=j8l8OJCJqcgtQ0rfT4C7wvtihZsb2kNdO3jh6r/nrbw=;
 b=gUpB5a80xAA073QwUzLaURP0Cp0XxR6Gh5HXQnMIMLDoZKTLPFxlqqF1pfUw36JU88
 Lwt1/Xz8qkAXFDb3kjyBBZWi23B0YoXwXnUPRWkM1TWjE+Eu3n5nSd3r8xZQTXad7bCy
 /Lgp9p8vnFcHqQaS0uixdPWLtZeMlMKtINHeQaHuqoTkdkvSrIDB8yyS+kKu0bNcm7UO
 dKvbygIMJ8j3UIVVm06EixM9J4Xb6hNMjOQ/MbYCts6/oTcpx7Dxg9xN0vpBTpnplpxc
 A+6zqmsi0caGURx+NYLqgMG/Zz7XoPhjTSjAf+XYgRc8l/EkJ4az/E6mZsla+qBjBQQX
 8Y+g==
X-Gm-Message-State: ANhLgQ12U4PbLLMiB+EOBrZNfoDjECLyY27hX1S48i3wYk/GWnp+LY8X
 LhFXNFOsEhSoExGu5PHG7+4LfYMXKTpcOHTNnyQR0wNwpNyHlHdyKxPvDfpzcFNhXQbwmryc5lw
 /YDjoa+5OZHcaosg=
X-Received: by 2002:adf:aa92:: with SMTP id h18mr4533671wrc.139.1585155780139; 
 Wed, 25 Mar 2020 10:03:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvGpkqY69t+Qzw8lOoTfgaK2lGtvUGrPBI6FmdUcwmG4HNgK6aD8yiGb54b8nEkhCcNS+i+Jg==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr4533655wrc.139.1585155779899; 
 Wed, 25 Mar 2020 10:02:59 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id y187sm10282980wmd.0.2020.03.25.10.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 10:02:58 -0700 (PDT)
Date: Wed, 25 Mar 2020 13:02:56 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 3/9] memory: Introduce log_sync_global() to memory
 listener
Message-ID: <20200325170256.GG354390@xz-x1>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-4-peterx@redhat.com>
 <20200325165252.GB2635@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200325165252.GB2635@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 04:52:52PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Some of the memory listener may want to do log synchronization without
> > being able to specify a range of memory to sync but always globally.
> > Such a memory listener should provide this new method instead of the
> > log_sync() method.
> >=20
> > Obviously we can also achieve similar thing when we put the global
> > sync logic into a log_sync() handler. However that's not efficient
> > enough because otherwise memory_global_dirty_log_sync() may do the
> > global sync N times, where N is the number of flat views.
> >=20
> > Make this new method be exclusive to log_sync().
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
> OK, so I guess the idea here is that when you have a ring with dirty
> pages on it, you just need to clear all outstanding things on the ring
> whereever they came from.

Yeah, or say it's about granularity of log_sync(), and the ring layout
will only be able to sync in a global manner rather than per-memslot.
It's actually not good when we only want to sync some specific small
memory region (e.g., the VGA code wants to only sync the VGA ram), but
we don't have much choice...

>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

--=20
Peter Xu


