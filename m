Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0D8CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 22:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296D120717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 22:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSY1hWXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296D120717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPDAL-0001rR-9i
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 18:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPD99-0000ca-LM
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 18:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPD97-0001Mf-Cx
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 18:05:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52910
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPD97-0001MJ-8p
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 18:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572300352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+R1QbG3et7I1l9CPG6LLjgTqBqwZYgk5KsbYNWG9LHo=;
 b=TSY1hWXmruj+2JihDFpiAPYIkz0QscjpfsBzq9IYDWW05msInvuHz3YJZwWQxTwu3DMPPn
 /lfCMPxfX+Sn+MGwTi2YFhtZjZCGXFSsvFVlDm4qYjWtSQv4P1qUvJoIVK1W695PkkbQ4M
 kZY1Noh+954SjmQdDQVIb6FcpSoSaUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-iJ6SjBnaMdurt7INVr-Ccg-1; Mon, 28 Oct 2019 18:05:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E96B1005509;
 Mon, 28 Oct 2019 22:05:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61C695D6AE;
 Mon, 28 Oct 2019 22:05:39 +0000 (UTC)
Date: Mon, 28 Oct 2019 18:05:37 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH 26/26] tests/boot_linux_console: Run BusyBox on 5KEc
 64-bit cpu
Message-ID: <20191028220537.GH18794@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-27-philmd@redhat.com>
 <CAL1e-=gBPSYmuoU4eH75mdUu_sUMDQNoXMHXU1ThNZFhJUHTwA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gBPSYmuoU4eH75mdUu_sUMDQNoXMHXU1ThNZFhJUHTwA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: iJ6SjBnaMdurt7INVr-Ccg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Kamil Rytarowski <kamil@netbsd.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 09:17:24AM +0100, Aleksandar Markovic wrote:
> On Monday, October 28, 2019, Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> wrote:
>=20
> > From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >
> > This tests boots a Linux kernel on a Malta machine up to a
> > busybox shell on the serial console. Few commands are executed
> > before halting the machine (via reboot).
> >
> >
>=20
> A very nice test.
>=20
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>

Thanks for the review Aleksandar.

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

Queuing on my python-next branch (and sending shortly in a PR).

Thanks,
- Cleber.


