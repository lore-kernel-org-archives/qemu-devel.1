Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D475C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0ABF21537
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0ABF21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQXuU-0005Jw-93
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 09:56:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQXtA-0004SY-IV
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQXt9-0003kf-PA
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:54:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hQXt9-0003ir-K3
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:54:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1DE9300183E;
	Tue, 14 May 2019 13:54:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 23FDD600CD;
	Tue, 14 May 2019 13:54:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 060ABA1E1; Tue, 14 May 2019 15:54:35 +0200 (CEST)
Date: Tue, 14 May 2019 15:54:35 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190514135435.auxlb4pbkmj63p7u@sirius.home.kraxel.org>
References: <20190513184433.21038-1-marcandre.lureau@redhat.com>
	<20190513184433.21038-2-marcandre.lureau@redhat.com>
	<20190514053747.os6lwvzwhe2ojsuu@sirius.home.kraxel.org>
	<CAJ+F1CLO2Wn1kJYrR5DYcyOXnM1e0JToZ7CJruhWbYEbWbeRHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLO2Wn1kJYrR5DYcyOXnM1e0JToZ7CJruhWbYEbWbeRHg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 14 May 2019 13:54:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 1/8] vhost-user: add
 vhost_user_gpu_set_socket()
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > > +  typedef struct VhostUserGpuMsg {
> > > +      uint32_t request; /* VhostUserGpuRequest */
> > > +      uint32_t flags;
> > > +      uint32_t size; /* the following payload size */
> >
> > uint32_t padding;
> >
> > > +      union {
> > > +          VhostUserGpuCursorPos cursor_pos;
> > > +          VhostUserGpuCursorUpdate cursor_update;
> > > +          VhostUserGpuScanout scanout;
> > > +          VhostUserGpuUpdate update;
> > > +          VhostUserGpuDMABUFScanout dmabuf_scanout;
> > > +          struct virtio_gpu_resp_display_info display_info;
> > > +          uint64_t u64;
> >
> > ... so this 64bit value will be aligned.
> 
> vhost-user didn't bother. Should we?

I think it is nicer, but given that the struct is declared as "packed"
it'll work either way.

Matter of taste.  Consider it a suggestion.

cheers,
  Gerd


