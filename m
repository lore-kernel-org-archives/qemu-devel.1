Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5782C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B351620B80
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcJbJkFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B351620B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBc5J-0007c4-Tv
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBc4d-00074p-Q3
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:57:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24613
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBc4b-0007XC-7p
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598612251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGFkJMsMkXgG1rFHqJifH5Lw5fq7ifY1o1i4v9gpWJA=;
 b=PcJbJkFEjFEykLyrvhrWkoXzgB/zjRHuxHQbLN43Bu8zn6gEf92mEYdGpygHg8ibDevHTz
 iIntrG7suqM0UBS7LperQj21G5Ma1BJrkZ61Sxlkd35Hm5nJr74aa+WsBZM3XeFH/XDYk/
 cRepMpvH3lvxvVQTZMUgGwV3bv3zKKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-mIehgT4ZNfO_889Y984V9w-1; Fri, 28 Aug 2020 06:57:27 -0400
X-MC-Unique: mIehgT4ZNfO_889Y984V9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B3CE189E617;
 Fri, 28 Aug 2020 10:57:26 +0000 (UTC)
Received: from localhost (ovpn-113-65.rdu2.redhat.com [10.10.113.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60D5519C59;
 Fri, 28 Aug 2020 10:57:20 +0000 (UTC)
Date: Fri, 28 Aug 2020 12:57:19 +0200
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 03/20] seabios: add bios-microvm.bin binary
Message-ID: <20200828105719.tax5x5youqm3laki@mhamilton>
References: <20200826105254.28496-1-kraxel@redhat.com>
 <20200826105254.28496-4-kraxel@redhat.com>
 <20200827144854.vz7yhakvks5xoh63@mhamilton>
 <20200828050232.jykyjztkwaplkhsu@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200828050232.jykyjztkwaplkhsu@sirius.home.kraxel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=slp@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hy4kckpuz6zyuzbt"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 01:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--hy4kckpuz6zyuzbt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2020 at 07:02:32AM +0200, Gerd Hoffmann wrote:
> On Thu, Aug 27, 2020 at 04:48:54PM +0200, Sergio Lopez wrote:
> > On Wed, Aug 26, 2020 at 12:52:37PM +0200, Gerd Hoffmann wrote:
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >  pc-bios/bios-microvm.bin | Bin 0 -> 131072 bytes
> > >  1 file changed, 0 insertions(+), 0 deletions(-)
> > >  create mode 100644 pc-bios/bios-microvm.bin
> >=20
> > Without reproducible builds (which we should probably consider having
> > for everything inside "pc-bios", but that's outside the scope of this
> > series), this one is hard to debug.
>=20
> We have roms/Makefile for firmware builds.  "make -C roms bios" will
> build seabios binaries (you need the seabios submodule initialized for
> this).
>=20
> And, yes, seabios builds are reproducible.  If you build with the same
> compiler (rhel-7 gcc 4.8.5) you should end up with the same binary.

Which version exactly? I'm still getting a different binary with this
one:

gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Thanks,
Sergio.

> take care,
>   Gerd
>=20

--hy4kckpuz6zyuzbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl9I4wwACgkQ9GknjS8M
AjX+GA/9FbR5yv9bgiHVjZqxpx00M/rdK2JzzT3wCYh4VYaZRk+j2PnFtVFfXIMA
IRp0Pg6iyqD1JnDzEeEuPEbAxpG+UG0OYCiGgRWfTKA4Jjgea51wV0MCvE/piWwC
kzgZcDtj8mjmCLapOMWUL1A6UuCfZCWyK6kP7L8+7dZxvqjDEPpFMrFJb0idQkW6
TDqKqCigb2PaAhzKpZgxv3MT3KG2JYBpeKj0VUcXviwRrObjJlGevI+7V4vyCFUT
naS3rdQY2y0YBHS5FudaVd0ZVTOzeET0wNDvHS/4zBpjU0UvTMLD/rR3zlbu+3/O
dDKWgNDZVoOPls0S2+utRPbSUndktJk6FGeODwbA32V4XIvZ/XcMjJ0j7OJacqny
wBN5wetJxq8szHoMo+5XVENrQ/hpTHGoZMgTOpclwibOQSKL/eFh4dIOHNMrnVoA
Dm+OgYUXfySeRQ9mAQ+APM4B6FgWGI/7Sfz04XTbFEwP4RUMBUmoME3jaOTp8tRV
nCfZD0x4AoeGYoIF1kFcgE+KHpEeg6p3QjfVNzmIiRzwmY6L/1CB6hbRoW3lCw6a
PnEtNDivgeiYIV2M9Vbrdos6DLsjPT95VR6pKS0+PuV9ffrwQ0zKV0o44eVpqIx5
Bf5bHCitprhI/yOkewcTvpLgBCHnuKWMTFLs5kirDPqMlUBcG9A=
=7fZP
-----END PGP SIGNATURE-----

--hy4kckpuz6zyuzbt--


