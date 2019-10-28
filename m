Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382BECA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 20:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35CF20830
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 20:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="df3Jsff6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35CF20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPBtz-0001zp-4t
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 16:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPBZA-0007Z3-DL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPBZ7-0005EH-Lk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:24:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35449
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPBZ7-0005Da-CD
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572294276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=duBC+SJe29dnpBnosA1wQmFiVDFzvoo21SnaKFHVTnI=;
 b=df3Jsff62oeGviVP9icUCDS/zBWunz3zpHMQaXX5J4j5m0EUroKjL3bpbfjelhnVdG3rCf
 LgCntrEkpJku7AuovSdXZXb6lOdnh9IWZ/O87xlbPMmNMu+rX9CpG3wWqrwxlonNAdBuVA
 lvxYXuzhuDtFCKas+ur3h+nbo72R2f4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-F26kaY1NPlScNB2o7fPmDg-1; Mon, 28 Oct 2019 16:24:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31BE5801E64;
 Mon, 28 Oct 2019 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DEBD5C1D8;
 Mon, 28 Oct 2019 20:24:19 +0000 (UTC)
Date: Mon, 28 Oct 2019 16:24:17 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 20/26] tests/boot_linux_console: Add a test for the
 Raspberry Pi 2
Message-ID: <20191028202417.GA18794@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-21-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191028073441.6448-21-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: F26kaY1NPlScNB2o7fPmDg-1
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 08:34:35AM +0100, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Similar to the x86_64/pc test, it boots a Linux kernel on a raspi2
> board and verify the serial is working.
>=20
> The kernel image and DeviceTree blob are built by the Raspbian
> project (based on Debian):
> https://www.raspbian.org/RaspbianImages
> as recommended by the Raspberry Pi project:
> https://www.raspberrypi.org/downloads/raspbian/
>=20
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>=20
> Alternatively, this test can be run using:
>=20
>     $ avocado run -t arch:arm tests/acceptance
>     $ avocado run -t machine:raspi2 tests/acceptance
>=20
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Queuing on my python-next branch (and sending shortly in a PR).

Thanks,
- Cleber.


