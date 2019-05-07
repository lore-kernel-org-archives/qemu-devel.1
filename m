Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C74C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C73420578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C73420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43725 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNwzq-0007Uk-5u
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 06:06:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNwyD-00060n-8a
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNwyC-0006TN-2Y
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hNwyB-0006Sx-Sf
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:05:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93138308A9BE;
	Tue,  7 May 2019 10:05:06 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-152.rdu2.redhat.com
	[10.10.120.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A7F5F377F;
	Tue,  7 May 2019 10:04:54 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Michael Walle <michael@walle.cc>,
	Jordan Justen <jordan.l.justen@intel.com>, 
	Peter Maydell <peter.maydell@linaro.org>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Paul Burton <paul.burton@imgtec.com>, Roy Franz <roy.franz@linaro.org>, 
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org,
	David Engraf <david.engraf@sysgo.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnoij@jcrosoft.com>,
	Stefan Weil <sw@weilnetz.de>
References: <20190505224737.1028-1-philmd@redhat.com>
	<20190505224737.1028-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a3bde8dd-dc86-32c1-2b03-8d5418c75659@redhat.com>
Date: Tue, 7 May 2019 12:04:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190505224737.1028-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 07 May 2019 10:05:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/1] MAINTAINERS: Add an entry for the
 Parallel NOR Flash devices
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/06/19 00:47, Philippe Mathieu-Daud=C3=A9 wrote:
> Step in to maintain it, since I have some familiarity with
> the technology.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66ddbda9c95..633f6315536 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1391,6 +1391,13 @@ F: include/hw/net/
>  F: tests/virtio-net-test.c
>  T: git https://github.com/jasowang/qemu.git net
> =20
> +Parallel NOR Flash devices
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> +T: git https://gitlab.com/philmd/qemu.git pflash-next
> +S: Maintained
> +F: hw/block/pflash_cfi*.c
> +F: include/hw/block/flash.h
> +
>  SCSI
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  R: Fam Zheng <fam@euphon.net>
>=20

Acked-by: Laszlo Ersek <lersek@redhat.com>

