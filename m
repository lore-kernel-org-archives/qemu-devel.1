Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2837C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 08:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7BE206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 08:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLNCENjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7BE206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixRIV-0001Hh-S6
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 03:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ixRHd-0000q3-7W
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 03:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ixRHb-0000Ua-Pg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 03:04:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57834
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ixRHb-0000R5-LR
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 03:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580457846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+dCkujbfnLlCvMGboyH/x8z20dWjPG6Q/VjzDaQKXE=;
 b=HLNCENjjaj4sA1f03gamp19jxemod5gd3a9qX9+aA5c1tmWAfgeTXNa5eF/KjbBqJOOpI+
 eh6nHf1AVfPem8AhWGhfhp6ccVKz4G+hrBRaQ3HVmtRDjMOCzRKkiGTOj1/rHHIl/aBkxu
 M0cTj0ZLx4zMSUx0Kry6zii57wdvTxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-UR1fnyqBPLGtehnAXhnZCQ-1; Fri, 31 Jan 2020 03:04:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CD2F8018AD;
 Fri, 31 Jan 2020 08:03:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-135.ams2.redhat.com
 [10.36.116.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F8401001B05;
 Fri, 31 Jan 2020 08:03:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9FB071747D; Fri, 31 Jan 2020 09:03:57 +0100 (CET)
Date: Fri, 31 Jan 2020 09:03:57 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [RFC] coreaudio: fix coreaudio_test.diff
Message-ID: <20200131080357.wyiof5grg2jtgot2@sirius.home.kraxel.org>
References: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
 <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
 <5314e860-dffe-3bc0-209f-bd2b937cd0c6@t-online.de>
 <CABLmASGcUVyASudNizcgPshEqahwYt-4m9Z1DXEhVe2vdko9cQ@mail.gmail.com>
 <54f5ddf3-5ea9-bd6d-8c71-edf4db527463@t-online.de>
 <f03b7ae9-344c-5a7f-414c-6250a9c5ec2f@t-online.de>
 <CABLmASGkSnG4+vfykBnEznX=kCAcSaiW20nf-wT9Cne4Cj9+LQ@mail.gmail.com>
 <3e4f565a-07d7-c1cc-b49c-0a8c504ae07c@t-online.de>
MIME-Version: 1.0
In-Reply-To: <3e4f565a-07d7-c1cc-b49c-0a8c504ae07c@t-online.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: UR1fnyqBPLGtehnAXhnZCQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Programmingkid <programmingkidx@gmail.com>,
 =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu Developers <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 08:37:50AM +0100, Volker R=FCmelin wrote:
> >
> > Hi all,
> >
> > Thanks to the generous help from Mark, I can now report that it is good=
 to hear coreaudio has been restored into a working state with this patch! =
I tested qemu-system-ppc running MacOS and OSX.
> >
> > Best,
> > Howard
>=20
> Thank you for testing the two patches. I will wait a few days to see if Z=
olt=E1n wants to write a cleaned up patch. Otherwise I'll try to write a pa=
tch that's acceptable for submission.

I'm busy collecting pending audio fixes for the next pull req,
planned to send out early next week.  Would be cool if I can
include a coreaudio fix ;)

The RFC patch looks sane to me but it clearly needs a better
commit message.

Current patch queue state:
  https://git.kraxel.org/cgit/qemu/log/?h=3Dqueue/audio

If I missed something please resend.

cheers,
  Gerd


