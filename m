Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D740C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3942077B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZkFJJc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3942077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifiA3-0005KL-2C
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ifi9K-0004tJ-Jm
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ifi9H-0005Ec-E9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:26:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46881
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ifi9H-0005Cj-6O
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576232773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnJCNSJw5J80zzXVAGL0dQdOZQSY17icR9/w37Fvn10=;
 b=YZkFJJc61Bri6MnLqo4eaJ3zT+VKiSwK2TteT/ibbiBeNmbSK6C7AxC2Gl5dRap49ssQxS
 Xz86bi3iYoXzpBJLeJhR6esMXtEuyMbZjICZaKPCiGZdpBx/1lFJ4ZxL+RoKpm8tPf9zXV
 iYaLnCll18NjlLPnZYA/MhX0Dzp30ps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-s5wZZyXpOLicTWrivhvepg-1; Fri, 13 Dec 2019 05:26:12 -0500
X-MC-Unique: s5wZZyXpOLicTWrivhvepg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BC85801E74;
 Fri, 13 Dec 2019 10:26:11 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4162619C4F;
 Fri, 13 Dec 2019 10:26:07 +0000 (UTC)
References: <20191213095410.1516119-1-jean-philippe@linaro.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH] virtio-mmio: Clear v2 transport state on soft reset
In-reply-to: <20191213095410.1516119-1-jean-philippe@linaro.org>
Date: Fri, 13 Dec 2019 11:26:04 +0100
Message-ID: <87d0csttc3.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Jean-Philippe Brucker <jean-philippe@linaro.org> writes:

> At the moment when the guest writes a status of 0, we only reset the
> virtio core state but not the virtio-mmio state. The virtio-mmio
> specification says (v1.1 cs01, 4.2.2.1 Device Requirements:
> MMIO Device Register Layout):
>
>     Upon reset, the device MUST clear all bits in InterruptStatus and
>     ready bits in the QueueReady register for all queues in the device.
>
> The core already takes care of InterruptStatus by clearing isr, but we
> still need to clear QueueReady.
>
> It would be tempting to clean all registers, but since the specification
> doesn't say anything more, guests could rely on the registers keeping
> their state across reset. Linux for example, relies on this for
> GuestPageSize in the legacy MMIO tranport.
>
> Fixes: 44e687a4d9ab ("virtio-mmio: implement modern (v2) personality (virtio-1)")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> This fixes kexec of a Linux guest that uses the modern virtio-mmio
> transport.
> ---
>  hw/virtio/virtio-mmio.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

LGTM, thanks!

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl3zZzwACgkQ9GknjS8M
AjVBPQ/8DMBcpQYpjFHpYVQBmd9sCvkWZmTLeC9V5AT+C2rHmVjTV0PZn+56aqCE
E2M2Lg/RVaIncA2OYGpyR3frSQ+9pdYR72irm7xwkKH3w79q2/riIXxD7mvMDCo9
p9KjSiezAarvrPeLKv2jE5wwhDtZ7pJjQ6AMO0rZ+pfvkFNYmnizEvOiW1ZrIPwj
dOb10VPEfPaXdszPWmIXXei3aLZw2tcOB2++HHLAUEX7C/RlK8SQL6irXdRSkaU5
d+fSxcS0ubBLFkjpeOppNatg+yDZfwGBBMzsHNcDeT7QDfzc0h0bg5JXbXwgLDS+
yJXZBfEyDrPAYi7rM6+y+MOKBdUgYue8xV9RzcVFdefMqufDrDI9WiMztn3zUfap
Onwl0O8eKpOHo22WJovBVsrF/zbUCFCOwjNFL5AHs0jS4Bjqsg5yuSvSRh22bpeq
SaTv3VuzFGNa8RG82FwgEa8oY3CFUlCkWv52RTQLwWIieXh3YeJMXGeXanTxqS9p
VWgyAaGjuIwxFqLd8+Wj5yn2jKHXj7+uLKhu+1bY2e3QCQkr3Djyt6WdT44rWWJd
jqZ3FTHdfw1AYkOschM72hTAmFQSND1T9E3lowTjuHOXY7fGlL0fjdnkGYSsEMv3
m11bk6CCiTAq7mI2da12/l64BS3eOnGhMuHC3SvwHZL2Xc26y1U=
=kxdD
-----END PGP SIGNATURE-----
--=-=-=--


