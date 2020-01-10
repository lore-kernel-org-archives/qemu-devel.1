Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F883C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE2E2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+ArHyns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE2E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipw3z-0007QM-65
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1ipvzb-00025D-2D
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mszeredi@redhat.com>) id 1ipvzZ-0002g2-0E
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:14:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33606
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mszeredi@redhat.com>) id 1ipvzY-0002ci-Qg
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578669268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JtPiOgRKCd1DVDF6rMovizquEnEA+3526ZmAhvq4I4g=;
 b=E+ArHynstaLJXJj9h8MlRVekX+sO+PMPJ6K46g3dYSKQ8yRuBJq+LLQtCx4enmSBPNwB6B
 FG/RTei5Sv6txHDty7/H2xYGhGg4kTQyjX6oj759z3uzCBlrxWAOe7eueXkbu990f1CUC3
 75tf1R6pzxjEbh7xypizgcJKqggEKeI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-xfoZGW-yOnyxRU2T4pQZyw-1; Fri, 10 Jan 2020 10:13:20 -0500
Received: by mail-io1-f72.google.com with SMTP id c23so1701449ioi.12
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 07:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JtPiOgRKCd1DVDF6rMovizquEnEA+3526ZmAhvq4I4g=;
 b=UvBSJp/Kpf8xK/+HXVwSIaVAguYnNe6G6FhThaS7h+aviLivaQGiYnKSvGXBY4Jjvy
 t2UpIQ3shO3GmLDwwZ3izOEHtytIQVySapjBN/L4i+U+xE3JDTXrg8SlAHvt4tDxlwca
 dZPA0XIiOKrrkalJGgB4jSuSe6YEoJrZXXdmi0LYxtqM5LnNc8uESAT+PtoBcy58Bg9I
 XUfU9b009gwgWm2rss37mGTM8dqRHCGxjDhyTVakU3WnpLu9pM4xsbBVXykl5C9rXJln
 tXHoU7/KUg0gpY6pUcs5blh9qxEgX9s3N4TrDLvYHjURgketLwxFnwHFMrJQ2+1IXna8
 F0rQ==
X-Gm-Message-State: APjAAAWrJLkMH91bKncvMrsxZxSl5XHPnYQBRMVx5P3t4abqTkuo3FON
 fVcEnXbqKdhHiQX6TrTmLsLXvaJq1Ai0JB9lH/wM+CRZ3Bs0mz7MABMbWhoq+2invIGSTgTM+fW
 X/MsE7dLr5w3dfT1vOckaWtfCUdjSyf8=
X-Received: by 2002:a05:6602:24c6:: with SMTP id
 h6mr2894556ioe.273.1578669200157; 
 Fri, 10 Jan 2020 07:13:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzXwE1B5T4Hrw3Xvb8tst9a6CtwiW/BIwACUVb/NtO/ub9XHZnZIRPaGMz5SCQqXC0DHe3UojrLu8FYQTAgyk=
X-Received: by 2002:a05:6602:24c6:: with SMTP id
 h6mr2894533ioe.273.1578669199894; 
 Fri, 10 Jan 2020 07:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-69-dgilbert@redhat.com>
 <20200107112316.GL3368802@redhat.com> <20200110150447.GH3901@work-vm>
In-Reply-To: <20200110150447.GH3901@work-vm>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Fri, 10 Jan 2020 16:13:08 +0100
Message-ID: <CAOssrKdRn9NGV9TuvCkRRXEwZep6B-R2598iYLY4-9d6zkPUXg@mail.gmail.com>
Subject: Re: [PATCH 068/104] virtiofsd: passthrough_ll: control readdirplus
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-MC-Unique: xfoZGW-yOnyxRU2T4pQZyw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 4:04 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > On Thu, Dec 12, 2019 at 04:38:28PM +0000, Dr. David Alan Gilbert (git) =
wrote:
> > > From: Miklos Szeredi <mszeredi@redhat.com>
> > >
> >
> > What is readdirplus and what do we need a command line option to
> > control it ? What's the user benefit of changing the setting ?
>
> cc'ing Miklos who understands this better than me.
>
> My understanding is that readdirplus is a heuristic inherited from NFS
> where when you iterate over the directory you also pick up stat() data
> for each entry in the directory.  You then cache that stat data
> somewhere.
> The Plus-ness is that a lot of directory operations involve you stating
> each entry (e.g. to figure out if you can access it etc) so rolling it
> into one op avoids the separate stat.  The unplus-ness is that it's an
> overhead and I think changes some of the caching behaviour.

Yeah, so either may give better performance and it's hard to pick a
clear winner.  NFS also has an option to control this.

Thanks,
Miklos


