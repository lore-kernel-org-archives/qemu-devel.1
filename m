Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBC6C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6942088E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVnOuPlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6942088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsog-0007F7-Qn
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdso6-00063U-QE
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:57:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdso5-00080z-E5
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590573423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWLXBOmzZ6owup2km2Ahu/zi/2POMIq5HSyPPYIBS5s=;
 b=DVnOuPlXYE6DMVDbRQ7S72/gQ4nvxydfTvQ32A23HqZfhB30I7Lelv3ywmif73hkzhSrWs
 c5EmFFHJkWcpEWqeHAo9PAtixD/JKHxK7HsR1FBA4DkuDdDUyRnecVxLe6veYE7bbQoMUT
 vKO6eKI0llraibr1+J61h/n3dNqjHiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-Uhu0fW1dMiCgQcuh8WcQwg-1; Wed, 27 May 2020 05:57:02 -0400
X-MC-Unique: Uhu0fW1dMiCgQcuh8WcQwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 079C51902EA2;
 Wed, 27 May 2020 09:57:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02C4460C05;
 Wed, 27 May 2020 09:56:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B5EA016E16; Wed, 27 May 2020 11:56:57 +0200 (CEST)
Date: Wed, 27 May 2020 11:56:57 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 0/8] Audio 20200526 patches
Message-ID: <20200527095657.c4m7itjvbgqq3jmz@sirius.home.kraxel.org>
References: <20200526075639.27949-1-kraxel@redhat.com>
 <87ftblsxdx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87ftblsxdx.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 08:30:18AM +0200, Markus Armbruster wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
> > The following changes since commit fea8f3ed739536fca027cf56af7f5576f37ef9cd:
> >
> >   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/pflash-next-20200522' into staging (2020-05-22 18:54:47 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kraxel.org/qemu tags/audio-20200526-pull-request
> >
> > for you to fetch changes up to b3b8a1fea6ed5004bbad2f70833caee70402bf02:
> >
> >   hw/mips/mips_fulong2e: Remove unused 'audio/audio.h' include (2020-05-26 08:46:14 +0200)
> >
> > ----------------------------------------------------------------
> > audio: add JACK client audiodev.
> > audio: bugfixes and cleanups.
> >
> > ----------------------------------------------------------------
> 
> $ qemu-system-aarch64 -S -accel qtest -display none -M akita -monitor stdio
> (qemu) qemu-system-aarch64: /work/armbru/qemu/audio/paaudio.c:779: qpa_audio_init: Assertion `dev->driver == AUDIODEV_DRIVER_PA' failed.

Hmm, seems to be a dependency issue in our build system.
rm -rf $builddir, rebuild, try again, assert gone.

take care,
  Gerd


