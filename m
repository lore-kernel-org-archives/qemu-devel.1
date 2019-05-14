Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392ECC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 06:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD94208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 06:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD94208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQQpx-00011X-7d
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 02:22:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQQo1-0008Ei-0K
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQQo0-0005Iv-6F
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:20:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hQQnz-0005Gd-Ui
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:20:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3738356FF;
	Tue, 14 May 2019 06:20:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 99FC510021B4;
	Tue, 14 May 2019 06:20:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id EAEF61747D; Tue, 14 May 2019 08:20:45 +0200 (CEST)
Date: Tue, 14 May 2019 08:20:45 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <20190514062045.i3xagseraliqbu72@sirius.home.kraxel.org>
References: <20190507080501.26712-1-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507080501.26712-1-marcel.apfelbaum@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 14 May 2019 06:20:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] ui/console: Precautionary glBindTexture
 and surface->texture validation in surface_gl_update_texture
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 11:05:01AM +0300, Marcel Apfelbaum wrote:
> From: HOU Qiming <hqm03ster@gmail.com>
> 
> In a GVT-g setup with dmabuf and GTK GUI, the current 2D texture at
> surface_gl_update_texture is not necessarily
> surface->texture. Adding a glBindTexture fixes related crashes and
> artifacts, and is generally more secure.

Added to UI patch queue.

thanks,
  Gerd


