Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B9C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 05:49:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD18820828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 05:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD18820828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ULw-0001Ha-0g
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 01:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i2ULK-0000sT-Eg
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 01:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i2ULJ-0004T0-Fw
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 01:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i2ULJ-0004Sl-AU
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 01:48:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 52300307D962;
 Tue, 27 Aug 2019 05:48:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com
 [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8BDF600D1;
 Tue, 27 Aug 2019 05:48:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 38B9117536; Tue, 27 Aug 2019 07:48:31 +0200 (CEST)
Date: Tue, 27 Aug 2019 07:48:31 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Message-ID: <20190827054831.n54sjsh3p5q6rwkx@sirius.home.kraxel.org>
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
 <13e6e43861c2868b65ba580e8104e6ad7ed7e7ad.1566755452.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13e6e43861c2868b65ba580e8104e6ad7ed7e7ad.1566755452.git.DirtY.iCE.hu@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 27 Aug 2019 05:48:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 13/25] audio: remove hw->samples,
 buffer_size_in/out pcm_ops
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 25, 2019 at 08:46:15PM +0200, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1=
n wrote:
> This patch removes the samples member from HWVoiceIn and HWVoiceOut.
> Backends can specify buffer size via the newly added buffer_size_in and
> buffer_size_out functions in audio_pcm_ops.  They are optional, if not
> defined qemu will fall back to some built-in constant.
>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>=20
> Notes:
>     Not sure if this is necessary.  At first it seemed like a good idea=
 to
>     have a function so that backends can compute the size on demand whe=
n
>     needed and things like that, but currently it's just a burden.

If none of the backends actually uses this, then drop it.

cheers,
  Gerd


