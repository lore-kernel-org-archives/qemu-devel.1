Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5095C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73BF20879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73BF20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44388 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQUAE-0002QL-Tm
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 05:56:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hQU86-0000qT-4w
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hQU2X-0003nW-D7
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:48:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1hQU2X-0003iT-4t
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:48:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AD913082B40
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:48:03 +0000 (UTC)
Received: from andariel.pipo.sk (unknown [10.40.205.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE25919C69;
	Tue, 14 May 2019 09:47:59 +0000 (UTC)
Date: Tue, 14 May 2019 11:47:57 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190514094757.GC2240@andariel.pipo.sk>
References: <87sgtqejn9.fsf@dusky.pond.sub.org>
	<20190507093954.GG27205@redhat.com>
	<875zql3ylk.fsf@dusky.pond.sub.org>
	<20190513120856.GH15029@redhat.com>
	<87ef525uls.fsf@dusky.pond.sub.org>
	<a3378e24-f13f-b51f-7180-8e0bf4661e10@redhat.com>
	<87tvdx8tfa.fsf@dusky.pond.sub.org>
	<20190514092638.GE25916@redhat.com> <20190514093754.GC2753@work-vm>
	<20190514094331.GF25916@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20190514094331.GF25916@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 14 May 2019 09:48:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt]    QMP; unsigned 64-bit ints;
 JSON standards compliance
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
Cc: libvir-list@redhat.com, =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 10:43:31 +0100, Daniel Berrange wrote:
> On Tue, May 14, 2019 at 10:37:55AM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > On Tue, May 14, 2019 at 08:02:49AM +0200, Markus Armbruster wrote:
> > > > Eric Blake <eblake@redhat.com> writes:

[...]

> > > Unless I'm missing something, this should ensure we don't loose preci=
sion,
> > > can always parse large numbers, and can internally change QEMU precis=
ion
> > > from int8/16/32 upto full int64 without breaking clients.
> >=20
> > But we could be stricter and simpler in string mode:
> >=20
> >   - QEMU & clients MUST format integer fields as strings, always
> >   - QEMU & clients MUST parse only strings for integer fields.
> >=20
> > That's (3) above, but also meets your requirements.
>=20
> Yep, given that we don't actually expose the int8/int16/int32/int64
> distinction via the QMP introspection data, that would be fine too.
>=20
> Its basically saying we'll never use JSON's number format.

I think this would make the most sense. If you are going to switch to
the "string" mode, why bother doing any compat?

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlzajsoACgkQHGwCByjY
1GqmBhAAk0z54ivDqokx1WzZib1Wc++E9RilLWgt2Ee2kW5QtJxkDQrk9JLPQQ1s
ttoh1yy8mmakf0xr7S7BAIYaatgQNVJIZGsy5W3M+48WJQ1ZjwRnhmyjSWHsBsZO
xWYPTGd35uPUUgr9yybgQvPlthvOIGU+nfzX2CxWcDiPOqXVQxHtmAOo4Ul2/28Y
4yyFEK3iCZnXiZrWCQpmZCSc1ikxWjjOKeqs/9p0zyr1ngsp/TiMTRxKqJrzAOdk
0A7L1NpLgjglVLnP/93vUfBs9Rt+ubHnpEUMwoZZnj7+40niZEwsqoOQ5d1XEpTn
h4LahYKjq4zmQkqR6ascQASQEe4XxgoDdgi1U+oWYDvmb1oykSSwgW0GXU8b+Y7Q
T90ZTFpkYhpGsxUKShqnLUWkqfEJyM471EM0bjz8kxTG64g34242deyiyZfYLlUT
hMdQAKLhg5FnAgWGKU2NwfK2oZj21e6tNrZjZLO28HP+U0Rcr/oerdLU0M3Ndzj0
uJLu0OFvH5TpuTH4e8oGxA54pNNPdWzkAo7PWRV1F0QQajXrBOCz4mQTL+/TyBVs
SWm209IhRjdQ22eY9C6i+4Bm2NjunoigBQOlktOXLwi/hmVjl+ZS3ouY5WoeKfDq
EZJioH6NppuGzlP07m+y2pyAbJfpJz2FrYDo4oOdzd1TUNHMhAE=
=QuLy
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--

