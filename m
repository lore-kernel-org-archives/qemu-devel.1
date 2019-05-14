Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA0EC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 06:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0E2206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 06:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0E2206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40666 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQRIH-0004t2-LI
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 02:52:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQRHS-0004ZW-PO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQRHR-0006gk-Ru
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:51:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hQRHR-0006ft-MI
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:51:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6554C3695F
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 06:51:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D1E160BF7;
	Tue, 14 May 2019 06:51:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 8EF551747D; Tue, 14 May 2019 08:51:09 +0200 (CEST)
Date: Tue, 14 May 2019 08:51:09 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190514065109.eitymbi7d5gdjqpr@sirius.home.kraxel.org>
References: <20190513183325.8596-1-marcandre.lureau@redhat.com>
	<20190513183325.8596-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190513183325.8596-4-marcandre.lureau@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 14 May 2019 06:51:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/3] contrib: add vhost-user-input
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 08:33:25PM +0200, Marc-Andr=E9 Lureau wrote:
> Add a vhost-user input backend example, based on virtio-input-host
> device. It takes an evdev path as argument, and can be associated with
> a vhost-user-input device via a UNIX socket:
>=20
> $ vhost-user-input -p /dev/input/eventX -s /tmp/vui.sock
>=20
> $ qemu ... -chardev socket,id=3Dvuic,path=3D/tmp/vui.sock
>   -device vhost-user-input-pci,chardev=3Dvuic
>=20
> This example is intentionally not included in $TOOLS, and not
> installed by default.

Patch doesn't apply cleanly to git master.  Also git complains that it
can't find the sha1 and therefore can't try a 3way merge.  Does this
depend on unmerged local patches?

(same goes for the vhost-user-gpu patch in the other series btw).

cheers,
  Gerd


