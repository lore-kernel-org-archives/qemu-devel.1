Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA6ACA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 19:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31B320873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 19:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esDHZswW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31B320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPAtU-0006gO-AN
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 15:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPA14-0005Kw-Sw
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPA13-0000se-Kf
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:45:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33688
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPA13-0000s1-Gr
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572288320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rmd3V9XFtzYl/iGr0izTo3UMW6rq39dft6svXCis2Qo=;
 b=esDHZswWsu8zKhjJKchwVHGEu0YmXI5QVbWCrD2555AICcyHVaLuZC7LDWZ8dJ14ScKbLt
 OPr7+bqooc/EfmY2/xdPkkCmq0Zl2gPngtVBZg2q+YNCyQGRZC8lkdXymwmuo8vtgv+9/e
 HQXbZbZWEqv5qOyxAit8NYi2snsUwCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-DNoKY-ynOHK8SzrA8caP9A-1; Mon, 28 Oct 2019 14:45:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 617F2801E5C;
 Mon, 28 Oct 2019 18:45:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4A76600C9;
 Mon, 28 Oct 2019 18:45:04 +0000 (UTC)
Date: Mon, 28 Oct 2019 14:45:03 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 14/26] tests/acceptance: Test Open Firmware on the PReP/40p
Message-ID: <20191028184503.GA7292@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-15-philmd@redhat.com>
 <20191028174743.GI3978@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191028174743.GI3978@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: DNoKY-ynOHK8SzrA8caP9A-1
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 01:48:01PM -0400, Cleber Rosa wrote:
> On Mon, Oct 28, 2019 at 08:34:29AM +0100, Philippe Mathieu-Daud=E9 wrote:
> > From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >=20
> > User case from:
> > https://tyom.blogspot.com/2019/04/aixprep-under-qemu-how-to.html
> >=20
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
> > Tested-by: Cleber Rosa <crosa@redhat.com>
> > Reviewed-by: Cleber Rosa <crosa@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > ---
> > v3: use avocado_qemu.wait_for_console_pattern (Cleber)
> > ---
> >  tests/acceptance/ppc_prep_40p.py | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >=20
>=20
> Queuing on my python-next branch (and sending shortly in a PR).
>=20
> Thanks,
> - Cleber.

Actually, this test is (now?) failing once every 3 times on my system.
I'm pulling this one for now.

Sorry about the noise.
- Cleber.


