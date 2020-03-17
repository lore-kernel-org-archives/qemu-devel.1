Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E9CC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CADC20724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJZtx4jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CADC20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEKBq-000381-Px
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jEKBF-0002c7-VR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jEKBF-00024y-0q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:55:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31747)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jEKBE-0001zb-Sc
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584482120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eyj/8B2DWUEHFdYMNuNgRuoyeBbhgMMooaRhZGs3Lxs=;
 b=MJZtx4jr0z/LBN/dt4GdkiZKvOWCcZsOvMEVYwVw7Qo98+nH92wdlHRJlb/rioU3v8IreH
 lUgEdPW5JcGiEA5c7DnPiFcADKGAhAPaqka+PAd4kuGtJrKIEEYlvJ0oH5+3c+CVJi0h6b
 B5UlDInWTmAeULsrWVjbkc58aW/1GSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-FFC-I9F4PWC51Q0QOCaI5g-1; Tue, 17 Mar 2020 17:55:18 -0400
X-MC-Unique: FFC-I9F4PWC51Q0QOCaI5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A428DB60
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 21:55:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-2.rdu2.redhat.com [10.10.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4E1D9080B;
 Tue, 17 Mar 2020 21:55:13 +0000 (UTC)
Date: Tue, 17 Mar 2020 17:55:11 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Oksana Vohchana <ovoshcha@redhat.com>
Subject: Re: [PATCH v4] python/qemu/qmp.py: QMP debug with VM label
Message-ID: <20200317215511.GA104204@localhost.localdomain>
References: <20200316103203.10046-1-ovoshcha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200316103203.10046-1-ovoshcha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-devel@nongnu.org, wainersm@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 12:32:03PM +0200, Oksana Vohchana wrote:
> QEMUMachine writes some messages to the default logger.
> But it sometimes hard to read the output if we have requests to
> more than one VM.
> This patch adds a label to the logger in the debug mode.
>=20
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

Queueing it on my python-next branch.

Thanks!

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5xRzwACgkQZX6NM6Xy
CfPrUxAAien1HHxqzfqiC9U/hfFET04cudQf1pavjwWSiMB2f7V1bR5Qrrn5MP0n
rOTEc8VzHV6yczNJovXQbWRHGu1FwgeeXhiNnnS8NCTzYDqaQJazNNXbwd0p+3IL
r2nQCWEnuNX42lTyo9eMyo0dSibWdrvv/U/9Y/MVF7pzOYQg7hFofV4/RqYTuYxl
urHL+3WKKI0hAP1giVWcqnH3Dxw1lsG9e5Aa7wUeoVNBmoWWEdMRFNpbdjpQ5vN2
h2CubpdbIs1XmxMWi4kOrxOnTe7vH6FWfAntiV7lc9iTI7B8WsUh4Q5kFzp8J493
IMPT/NFa5M9ZZ52euD7/w+LCgT/c73eOVrZ/0XJjUPx+qi7c52FyUTIr18wXkaCQ
dBSv0xf7zIh3lVrNjOMR2RQqF3R5SWMx1wcDnAnskfQepGs5QqWRdRGcS/9/3CPH
tXZejBpYMbIEHmpq/b9y70LuunaXgHY8NA+3s8EGJi7BoOhLSPmNOHZwYCqVxjiR
Ec3JW3iYuvbyBLWgJ+0HPiT9TqakeRM7x50k5JfTuHvtgwxXRKKqP1cdM3YeneKh
XoZvSomR2J+XBA4CAe1oLnHsb4Snos+r8DWez91a/Xy7ANWD+AoXC3ryCox4ffh1
em13npoByzGAw8qlmnNPesZQcYMsxR5tEQgS5uyRSDAtpMkcIh8=
=4zYp
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--


