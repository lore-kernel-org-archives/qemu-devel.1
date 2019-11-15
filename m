Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FE3C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 23:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD87206D6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 23:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crpcmUyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD87206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVlLc-0005EP-8i
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 18:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iVlKl-0004iI-OY
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iVlKk-0008PC-GX
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:48:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36806
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iVlKk-0008Os-D7
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573861737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=udWjb6mMN8XZS4uyfvjevyltlX1Y/p2sQo/otc11qQw=;
 b=crpcmUyWZ2l+P6pe0xInrE5rrqf7IaqcVri2CxSuCcpoULx/DCLZt+A3SZRi4ZDXR1Cy0R
 +Y0vnzSUIrPyP+NFChUlk47Wr/lTsbWLVMdJxz2aHYYmHr4KslFA2ZL2yxbAVkPd48Kbli
 HPRXvTT26Jw9UGJ4d3VCtEVeiE09dho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-aBje4K6aM4KxAtWaEO4_Zg-1; Fri, 15 Nov 2019 18:48:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1A1B1005500;
 Fri, 15 Nov 2019 23:48:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-0.rdu2.redhat.com [10.10.125.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 097E41036C80;
 Fri, 15 Nov 2019 23:48:48 +0000 (UTC)
Date: Fri, 15 Nov 2019 18:48:46 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v7 8/8] Acceptance test: add "boot_linux" tests
Message-ID: <20191115234846.GL19559@localhost.localdomain>
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-9-crosa@redhat.com>
 <1a4e69bb-2713-3aa8-a58d-7fbb6c6886ed@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1a4e69bb-2713-3aa8-a58d-7fbb6c6886ed@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: aBje4K6aM4KxAtWaEO4_Zg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 12, 2019 at 07:20:38PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 11/4/19 4:13 PM, Cleber Rosa wrote:
> > This acceptance test, validates that a full blown Linux guest can
> > successfully boot in QEMU.  In this specific case, the guest chosen is
> > Fedora version 31.
> >=20
> >   * x86_64, pc and q35 machine types, with and without kvm as an
> >     accellerator
>=20
> typo "accelerator"
>

Fixed, thanks!

> >=20
> >   * aarch64 and virt machine type, with and without kvm as an
> >     accellerator
>=20
> Ditto.
>

Also fixed, thanks again!

- Cleber.


