Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECF6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479A12067D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wx70QRnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479A12067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jadS9-0008Ot-C2
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1jadRP-0007et-1i
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:56:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1jadRN-0001Es-1u
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589799371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A6VDRfiNywvuu+tLfq0csnz5KQjYHd5jFx7T0uhddto=;
 b=Wx70QRnHxhoHJaTI46yW8iDlNrc34rFYHu7p97Rgxv9NSaPDdspwAJWecF31fdGRIAXe3+
 jTF7oyves6p/kWMHJN32zDy7k6mwF0kB1wAjDb3Rg64o1fXDp3r5msyv4MC1XnwnAmYvPM
 umwSpecsA35cd7HRrW4zAi7/s8AX2iY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-Wl2m8rULPAmkeUDpfP1Hnw-1; Mon, 18 May 2020 06:56:09 -0400
X-MC-Unique: Wl2m8rULPAmkeUDpfP1Hnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A8EE1005512
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 10:56:08 +0000 (UTC)
Received: from lpt (unknown [10.40.208.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 556CE1A922;
 Mon, 18 May 2020 10:56:01 +0000 (UTC)
Date: Mon, 18 May 2020 12:55:58 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 11/13] audio: deprecate -soundhw pcspk
Message-ID: <20200518105558.GD773906@lpt>
References: <20200515143528.13591-1-kraxel@redhat.com>
 <20200515143528.13591-12-kraxel@redhat.com>
 <20200515150823.GA738369@lpt>
 <20200518101628.3j4d6hwq6pitjfo3@sirius.home.kraxel.org>
 <20200518102650.GG1430944@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200518102650.GG1430944@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Monday in 2020, Daniel P. Berrang=E9 wrote:
>On Mon, May 18, 2020 at 12:16:28PM +0200, Gerd Hoffmann wrote:
>> On Fri, May 15, 2020 at 05:08:23PM +0200, J=E1n Tomko wrote:
>> > On a Friday in 2020, Gerd Hoffmann wrote:
>> > > Add deprecation message to the audio init function.
>> > >
>> > > Factor out audio initialization and call that from
>> > > both audio init and realize, so setting audiodev via
>> > > -global is enough to properly initialize pcspk.
>> > >
>> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> > > ---
>> > > hw/audio/pcspk.c | 24 +++++++++++++++++++++---
>> > > 1 file changed, 21 insertions(+), 3 deletions(-)
>> > >
>> > > @@ -236,9 +245,18 @@ static const TypeInfo pcspk_info =3D {
>> > >     .class_init     =3D pcspk_class_initfn,
>> > > };
>> > >
>> > > +static int pcspk_audio_init_soundhw(ISABus *bus)
>> > > +{
>> > > +    PCSpkState *s =3D pcspk_state;
>> > > +
>> > > +    warn_report("'-soundhw pcspk' is deprecated, "
>> > > +                "please set a backend using '-global isa-pcspk.audi=
odev=3D<name>' instead");
>> > > +    return pcspk_audio_init(s);
>> >
>> > -soundhw pcspk is the only soundhw device present in libvirt git.
>> >
>> > Is there a way to probe for this change via QMP?
>>
>> Oops.  I'm surprised libvirt actually supports pcspk.
>>
>> There is no way to see that in qmp, and I can't think of an easy way
>> to add that.  Does libvirt check for command line switches still?
>> So it could see -soundhw going away if that happens?
>
>IIUC, instead of probing for whether -soundhw is deprecated, it should
>be suffiicent for us to probe if "isa-pcspk.audiodev" exists. Assuming
>we always use isa-pcspk.audiodev if it exists, then we'll trivially
>avoid using the -soundhw arg.
>

Yes, we can probe for that, but the phrasing in the commit message makes
it look like setting the property via -global will only be effective
after this commit.

Jano

>Regards,
>Daniel
>--=20
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrang=
e :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.co=
m :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrang=
e :|
>

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl7CabsACgkQ+YPwO/Ma
t51mCwgAnLXLRWlfGT8XR5lsRHxHVnf6/RnXT2aVCN0UWq8bAXdlQu4FvnXKSlSF
ec9hcDVlqSowqJx2oPCxMjfBfGq2XzkWSkG63g6XzRU9ClnTMqQhq14nxdvFUD5h
GkZ0Fka3sAILpIpstbPAqVSwHr5dDUVRPcoG62kloJwB40mGC0ibQWfVvfgyfs5R
8A8g+KW1iDEsM/OcMmHBkDYizpgLGB1Tvy0nBSGN8dpNgCGwpi1BrgO0GfncZN0l
inS2JFmFQ45K3VnJ38qVcicMb38xja370Haj1EsMVqvGfcks1uUR2U+Yv2qj0FOS
vFqVlwuXlxBdBZ1c8MKA7GsJhAnUDQ==
=IMfu
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--


