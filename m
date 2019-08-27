Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DA4C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F38920656
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F38920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kent.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ZB0-0000OD-LJ
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 06:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1i2ZA5-0008NU-2T
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1i2ZA2-00074C-E6
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:57:15 -0400
Received: from mx0.kent.ac.uk ([129.12.21.32]:57880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <S.E.Harris@kent.ac.uk>)
 id 1i2ZA1-00073V-Rx
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:57:14 -0400
Received: from edue0f8.kent.ac.uk ([129.12.224.248] helo=cadance)
 by mx0.kent.ac.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.92) (envelope-from <S.E.Harris@kent.ac.uk>)
 id 1i2Z9y-000M9k-Ns; Tue, 27 Aug 2019 11:57:10 +0100
Date: Tue, 27 Aug 2019 11:59:54 +0100
From: Sarah Harris <S.E.Harris@kent.ac.uk>
To: Thomas Huth <thuth@redhat.com>
Message-Id: <20190827115954.d2f925de4c0f7c063a7e7131@kent.ac.uk>
In-Reply-To: <54f5b717-4864-9e42-155e-a2ab2e041f02@redhat.com>
References: <20190824184635.34192-1-mrolnik@gmail.com>
 <20190824184635.34192-2-mrolnik@gmail.com>
 <55f37e1b-8ed3-b295-0298-4299279e4043@redhat.com>
 <CAK4993iY908S85hvHT64+Zo=AG8ihoTnTsFEJQSNBew7TBWWTg@mail.gmail.com>
 <54f5b717-4864-9e42-155e-a2ab2e041f02@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 129.12.21.32
Subject: Re: [Qemu-devel] [PATCH v29 1/8] target/avr: Add outward facing
 interfaces and core CPU logic
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I don't mind if you want to drop my signed-off-by for commits that were bas=
ed on Michael's work.
You probably want to keep my sign-off for the USART/timer commit though as =
that was new code.

Regards,
Sarah Harris

On Mon, 26 Aug 2019 10:00:51 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 26/08/2019 09.53, Michael Rolnik wrote:
> > the commit was originally mine. Then Sarah rearranged it, signed and
> > submitted. She no longer maintains it. So' I believe I can remove her s=
ob.
> > what do=A0you think?.
>=20
> Fine for me, but maybe you should mention her in the patch description
> if she made significant changes?
>=20
> Sarah, what do you think?
>=20
> Anyway, if the patch is originally from you, you should also remove the
> "From: Sarah ..." line from the patch. For this, you likely have to
> change the author of the patch in your git tree with "git commit --amend
> --reset-author".
>=20
>  Thomas

