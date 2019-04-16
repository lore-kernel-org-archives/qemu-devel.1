Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FF9C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 16:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91820206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 16:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91820206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39216 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGQgO-0008PZ-Sn
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 12:11:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hGQfA-0007fN-5D
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hGQf9-0006iu-4K
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:10:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hGQf8-0006iG-SB
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:10:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32B86C004BEF;
	Tue, 16 Apr 2019 16:10:21 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com
	[10.18.17.132])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ACF49608A4;
	Tue, 16 Apr 2019 16:10:17 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
	<jpgk1fvp5wm.fsf@linux.bootlegged.copy>
	<20190415165426.GT5718@redhat.com> <20190416084059.GD31311@redhat.com>
Date: Tue, 16 Apr 2019 12:10:16 -0400
In-Reply-To: <20190416084059.GD31311@redhat.com> ("Daniel P.
	\=\?utf-8\?Q\?Ber\?\= \=\?utf-8\?Q\?rang\=C3\=A9\=22's\?\=
	message of "Tue, 16 Apr 2019 09:40:59 +0100")
Message-ID: <jpglg0a3p93.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 16 Apr 2019 16:10:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
	Thomas Huth <thuth@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416161016.rnHjY6Lkxqo4EkyWUlTOejpSMHijZF-nt8mKX8muXp4@z>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
...
>> > The store is read only by default. Are you trying something like:
>> >  -device usb-mtp,rootdir=3D/code/mtpshare,readonly=3Dfalse ?
>>=20
>> Ah ha, I didn't realize I had to enable write support explicitly. Will
>> retry with that.
>
> Even after setting  readonly=3Dfalse, I still can't get "mtp-sendfile"
> to succeed in a guest.
>
I posted a patch for a bug introduced by a recent commit that made smaller
file sizes return back with a incomplete file transfer.

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02552.html

> Regards,
> Daniel

