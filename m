Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17159C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 05:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEAD217D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 05:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEAD217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVql3-0007tM-1G
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 01:04:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVqk5-0007V3-W2
	for qemu-devel@nongnu.org; Wed, 29 May 2019 01:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVqk5-0003pO-0H
	for qemu-devel@nongnu.org; Wed, 29 May 2019 01:03:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>)
	id 1hVqk4-0003oq-Qw; Wed, 29 May 2019 01:03:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB4DDC0AEE30;
	Wed, 29 May 2019 05:03:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com
	[10.36.116.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5236F1001DF9;
	Wed, 29 May 2019 05:02:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 89E1511AAB; Wed, 29 May 2019 07:02:55 +0200 (CEST)
Date: Wed, 29 May 2019 07:02:55 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190529050255.6ffo3rvig3za7uzg@sirius.home.kraxel.org>
References: <20190528164020.32250-1-philmd@redhat.com>
	<20190528164020.32250-9-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190528164020.32250-9-philmd@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 29 May 2019 05:03:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 08/10] hw/usb-storage: Use the QOM
 DEVICE() macro to access DeviceState.qdev
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
	qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Michael Walle <michael@walle.cc>,
	Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 06:40:18PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Rather than looking inside the definition of a DeviceState with
> "s->qdev", use the QOM prefered style: "DEVICE(s)".
>=20
> This patch was generated using the following Coccinelle script:
>=20
>     // Use DEVICE() macros to access DeviceState.qdev
>     @use_device_macro_to_access_qdev@
>     expression obj;
>     identifier dev;
>     @@
>     -&obj->dev.qdev
>     +DEVICE(obj)
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>


