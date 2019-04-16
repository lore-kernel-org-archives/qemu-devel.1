Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F6BC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEABD206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEABD206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41721 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGTnh-0003Dt-Io
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 15:31:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGTcW-00020Y-UI
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGTcV-00041u-SU
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:19:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGTcV-00041X-Ls
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:19:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4587C04959F;
	Tue, 16 Apr 2019 19:19:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 58BD2608E1;
	Tue, 16 Apr 2019 19:19:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id BBA6E1138648; Tue, 16 Apr 2019 21:19:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190415141547.15444-1-berrange@redhat.com>
	<87a7gq75l6.fsf@dusky.pond.sub.org>
	<20190416090358.GF31311@redhat.com>
	<87zhoq3pn9.fsf@dusky.pond.sub.org>
	<20190416160927.GT31311@redhat.com>
Date: Tue, 16 Apr 2019 21:19:42 +0200
In-Reply-To: <20190416160927.GT31311@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Tue, 16 Apr 2019 17:09:27 +0100")
Message-ID: <87sguh3ghd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 16 Apr 2019 19:19:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] vl: set LC_CTYPE early in main() for
 all code
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416191942.5LkGKeWbRhLcs88kz2T2n5yxwnMyDfWka9Kqk2oMCTQ@z>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

[...]
> I think that's fundamentally the wrong way around. Most stuff *should*
> be locale dependant, otherwise any interaction with the host OS is
> likely to use incorrect localization. It isn't practical to put a
> uselocale() call around every place that opens a filename. There are
> a few places where QEMU should be locale indepandant such as the QMP
> and guest OS ABI sensitive things, which should take account of it.

All right, you convinced me.  The problem is even bigger than I thought.
That means the return on investment in this area is even poorer than I
thought.

I don't think we should try to support anything but ASCII and UTF-8.

