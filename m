Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A737C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44E020787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMfCLmN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44E020787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdpbA-0007Uw-1y
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 02:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdpaB-0006zn-9q
 for qemu-devel@nongnu.org; Wed, 27 May 2020 02:30:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48985
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdpa9-0005BG-Q1
 for qemu-devel@nongnu.org; Wed, 27 May 2020 02:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590561027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e/uERUDEw/rJv174lR0x9aFTQCPxPllMUq14dHSIfOs=;
 b=fMfCLmN22IBGDaQNbCStuzU81aqDSE7W918Nn2J3F72RD+tuOZsBcpqFs55WgMdH1uu6LT
 RDxN9EQUIMZY/HXrDZ3N4EIjRzlN97Ezo1K5VZqJBvhG3oqmAmtLRbqBbl109GkRDSzYiG
 YmpgcEY231w5oP1GgujuDVQTjQOyTx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-96zJYsyENFC5L43ea8hjIg-1; Wed, 27 May 2020 02:30:23 -0400
X-MC-Unique: 96zJYsyENFC5L43ea8hjIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA5C818017EE;
 Wed, 27 May 2020 06:30:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D46D010013D7;
 Wed, 27 May 2020 06:30:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 685FD113864A; Wed, 27 May 2020 08:30:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PULL 0/8] Audio 20200526 patches
References: <20200526075639.27949-1-kraxel@redhat.com>
Date: Wed, 27 May 2020 08:30:18 +0200
In-Reply-To: <20200526075639.27949-1-kraxel@redhat.com> (Gerd Hoffmann's
 message of "Tue, 26 May 2020 09:56:31 +0200")
Message-ID: <87ftblsxdx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

> The following changes since commit fea8f3ed739536fca027cf56af7f5576f37ef9cd:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/pflash-next-20200522' into staging (2020-05-22 18:54:47 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20200526-pull-request
>
> for you to fetch changes up to b3b8a1fea6ed5004bbad2f70833caee70402bf02:
>
>   hw/mips/mips_fulong2e: Remove unused 'audio/audio.h' include (2020-05-26 08:46:14 +0200)
>
> ----------------------------------------------------------------
> audio: add JACK client audiodev.
> audio: bugfixes and cleanups.
>
> ----------------------------------------------------------------

$ qemu-system-aarch64 -S -accel qtest -display none -M akita -monitor stdio
(qemu) qemu-system-aarch64: /work/armbru/qemu/audio/paaudio.c:779: qpa_audio_init: Assertion `dev->driver == AUDIODEV_DRIVER_PA' failed.

Same for 40p, akita, borzoi, cheetah, integratorcp, milkymist, musicpal,
n800, n810, realview-eb, realview-eb-mpcore, realview-pb-a8,
realview-pbx-a9, spitz, terrier, versatileab, versatilepb, vexpress-a15,
vexpress-a9, xlnx-zcu102, z2.

git-bisect blames commit 2e44570321 "audio/jack: add JACK client
audiodev".


