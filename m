Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4DAC31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3677205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3677205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyBne-0001dO-Oz
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 05:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hyBmX-00010l-Hd
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hyBmW-0006Cb-E4
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:10:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hyBmT-0006AU-Km; Thu, 15 Aug 2019 05:10:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D1D1AC057F2E;
 Thu, 15 Aug 2019 09:10:47 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-12.ams2.redhat.com [10.36.117.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55DA67D3FC;
 Thu, 15 Aug 2019 09:10:41 +0000 (UTC)
Date: Thu, 15 Aug 2019 11:10:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190815091039.GA7415@linux.fritz.box>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <d0635a23-7f99-9cf7-500c-af668e8ca370@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <d0635a23-7f99-9cf7-500c-af668e8ca370@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 15 Aug 2019 09:10:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/13] RFC: luks/encrypted qcow2 key
 management
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 14.08.2019 um 23:08 hat Eric Blake geschrieben:
> On 8/14/19 3:22 PM, Maxim Levitsky wrote:
>=20
> > This is an issue that was raised today on IRC with Kevin Wolf. Really t=
hanks
> > for the idea!
> >=20
> > We agreed that this new qmp interface should take the same options as
> > blockdev-create does, however since we want to be able to edit the encr=
yption
> > slots separately, this implies that we sort of need to allow this on cr=
eation
> > time as well.
> >=20
> > Also the BlockdevCreateOptions is a union, which is specialized by the =
driver name
> > which is great for creation, but for update, the driver name is already=
 known,
> > and thus the user should not be forced to pass it again.
> > However qmp doesn't seem to support union type guessing based on actual=
 fields
> > given (this might not be desired either), which complicates this somewh=
at.
>=20
> Does the idea of a union type with a default value for the discriminator
> help?  Maybe we have a discriminator which defaults to 'auto', and add a
> union branch 'auto':'any'.  During creation, if the "driver":"auto"
> branch is selected (usually implicitly by omitting "driver", but also
> possible explicitly), the creation attempt is rejected as invalid
> regardless of the contents of the remaining 'any'.  But during amend
> usage, if the 'auto' branch is selected, we then add in the proper
> "driver":"xyz" and reparse the QAPI object to determine if the remaining
> fields in 'any' still meet the specification for the required driver bran=
ch.
>=20
> This idea may still require some tweaks to the QAPI generator, but it's
> the best I can come up with for a way to parse an arbitrary JSON object
> with unknown validation, then reparse it again after adding more
> information that would constrain the parse differently.

Feels like this would be a lot of code just to allow the client to omit
passing a value that it knows anyway. If this were a human interface, I
could understand the desire to make commands less verbose, but for QMP I
honestly don't see the point when it's not trivial.

Kevin

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdVSGPAAoJEH8JsnLIjy/WtpgP/2H2n9oGcS6sTiQsAp4tKO3/
EoOm45ZXH44f6ysYOe9LBf0EPJjZ1A0JpjM9mD/UqjNHFyKTFe+qnobujKcip1kU
I5rBG3CvT17tDtI6RzriJ6WGY4Dzzf4ULAgBxpHeb1NjI//MAy2H4Enu+uLoiZ0U
aXibOEqmc5iVdlI4S3uCRdkKaLdie5zJHRxKV9oZL4zo9vOkOQ06TCRWEsr1knYn
Y57KE/WU/y5xaPyGrgITBxjstp42IA8vOTOQWSt7xpdmUPS2BjqzxlCSUSTBGenJ
oSmywYJMR9MHjS8fOTGkhp8SzjOqiHRziXt1dF991IZH37GXRLud8HsA4Lq3JlKX
ysfNwABac8BL9sKG8ZPhgm9fqAOm8jKXJENqUcLtWkKv6db/f48c+A9KbGCOyEFl
AIKEmc1w58CHXYK2MMU9bvj1GAnrQhQWcHDlZuuhchs0NZfqy0b9k+B/ufjvuVZG
f5//JGhI+6ScaIDSULQo1qUHomkbNZx+AdHDkrPOSmp8cxKxyR3lh2SE6vUQHnpG
pIY7YN+41Ko4mcK5FIXCIntv56AtI5Mms4FlkChZSmSWt1vCEKNh0XKeSnd7YukC
6YOI58Slzpu0GOQcQKJwo7GEs97+OCEgjBrzhcgMvup7k/x7D1GzvFtZKKOPQCzi
n34Aifl3q804JmlJJAoA
=ZuvE
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

