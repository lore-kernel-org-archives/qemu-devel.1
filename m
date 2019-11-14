Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37059C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CD7206EF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaJJJShi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CD7206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCmK-0000RK-5d
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iVCle-0008Kx-UG
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:54:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iVCld-0003lk-9n
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:54:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47986
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iVCld-0003l6-2x
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573728864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAWcFBj50Enc2VC3bUrFoF95FC5XConkQl/HifRxdxQ=;
 b=JaJJJShi94/8v4qR4VmS5onxJWWayAwhrLbzPTuj/qvYp7yBqa+9vrn00pmW21+E1uQdT3
 yC6GvqoSAjz4dIQK/0hoI3gqyPbcRoZxGAFRFbTHdZzp22nmJi++jWiNMsIKX5ZedW1k4A
 jihTvs4PcMmCaTii7KEPJDyJF84D3wA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-iJ_DPPqtN9-_UpPe67szYg-1; Thu, 14 Nov 2019 05:54:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 024A7800052;
 Thu, 14 Nov 2019 10:54:22 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26A55F6E0;
 Thu, 14 Nov 2019 10:54:16 +0000 (UTC)
Message-ID: <eec4be0933c4f3e3831f2c574bc237ae77a1fb85.camel@redhat.com>
Subject: Re: API definition for LUKS key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Kevin
 Wolf <kwolf@redhat.com>
Date: Thu, 14 Nov 2019 12:54:16 +0200
In-Reply-To: <20191112110227.GN2366658@redhat.com>
References: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
 <20191111183424.GR814211@redhat.com>
 <20191112091245.GB5364@linux.fritz.box>
 <20191112110227.GN2366658@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: iJ_DPPqtN9-_UpPe67szYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 John Ferlan <jferlan@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-11-12 at 11:02 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Nov 12, 2019 at 10:12:45AM +0100, Kevin Wolf wrote:
> > Am 11.11.2019 um 19:34 hat Daniel P. Berrang=C3=A9 geschrieben:
> > > On Mon, Nov 11, 2019 at 05:58:20PM +0200, Maxim Levitsky wrote:
> > > > One of the concerns that was raised during the review was that amen=
d interface for luks that I propose is
> > > > different from the amend inteface used currently for qcow2.
> > > >=20
> > > > qcow2 amend interface specifies all the format options, thus overwr=
ites the existing options.
> > > > Thus it seems natural to make the luks amend interface work the sam=
e way, that it receive an array
> > > > of 8 slots, and for each slot specify if it is active, and if true =
what password to put in it.
> > > > This does allow to add and erase the keyslots, but it doesn't allow=
:
> > > >=20
> > > >    * add a password without knowing all other passwords that exist =
in existing keyslots
> > > >      this can be mitigated by specifying which keyslots to modify f=
or example by omitting the
> > > >      keyslots that shouldn't be touched from the array (passing nul=
l placeholder instead)
> > > >      but then it already doesn't follow the 'specify all the option=
s each time' principle.
> > >=20
> > > I think this is highly undesirable, as we must not assume that the
> > > mgmt app has access to all the passwords currently set.
> >=20
> > And I think this shows the problem that we realy have with the crypto
> > driver and amend: For every other driver, if you must, you can query th=
e
> > current settings and just write them back.
> >=20
> > The difference here is that crypto doesn't allow to directly query or
> > specify the content of some options (the keyslots), but provides only a
> > way to derives that content from a secret, and obviously there is no wa=
y
> > back from the stored data to the secret (that's what it's for).
> >=20
> > I think we have two options here:
> >=20
> > 1. Add a special "don't touch this" value for keyslots. Normally, just
> >    leaving out the value would be suitable syntax for this. Here,
> >    however, we have a list of keyslots, so we can't leave anything out.
> >=20
> >    We could use something like an alternate between str (new secret ID)=
,
> >    null (erase keyslot) and empty dict (leave it alone) - the latter
> >    feels a bit hackish, but maybe it's not too bad. If the list is
> >    shorter than 8 entries, the rest is assumed to mean "leave it alone"=
,
> >    too.
>=20
> I'd be very wary of having a "null" vs "empty dict" distinction to
> mean "erase" vs "don't touch".
>=20
> It feels like that is designed to maximise the chances of someone
> shooting themselves in the foot by accidentally using "null" instead
> of an "empty dict".
>=20
> The reason for the use of "active=3Dyes" / "active=3Dno" is because that
> was reasonable explicit about wanting to erase a keyslot, and it does
> does actually map to the key slot on disk which has an "active" field
> taking two magic values.
>=20
> > 2. Allow to query and set the raw key, which doesn't require a password
>=20
> I don't think I understand what you mean here. If you don't have a
> password the only change you can make is to erase key slots.
Well in the theory the keyslot has the hash of the password, the salt, the =
hash function
iteration count and the active field.=20

In theory you can let the user read these values directly and write them ba=
ck=20
as is without knowing the password.
This is very ugly IMHO but will fit the classical amend definition.


>=20
> > > >    * erase all keyslots matching a password - this is really hard t=
o do using this approach,
> > > >      unless we give user some kind of api to try each keyslot with =
given password,
> > > >      which is kind of ugly and might be racy as well.
> > > > So what do you think?
> > >=20
> > > The point of using "amend" is that we already have some of the boiler=
plate
> > > supporting framework around that, so it saves effort for both QEMU an=
d
> > > our users. If the semantics of "amend" don't fit nicely though, then =
the
> > > benefit of re-using "amend" is cancelled out and we should go back to
> > > considering a separate "key-manage" command.
> >=20
> > This wouldn't solve the fundamental problem that the crypto block
> > driver, as it currently is, isn't able to provide a blockdev-amend
> > callback. It's worse for qcow2 because qcow2 already implements amend.
> >=20
> > I think we need to find a solution for the amend API.
I also think so. Amend interface can be *ahem* amended to be more generic :=
-)
Currently it is designed for just one use case.

>=20
>=20
> BTW, looking forward to the future, if we ever implement LUKS version 2
> support there are a bunch more things can be tweaked at runtime. Most
> notable is that it is possible to change the master key, and change the
> encryption algorithm choices. Both of these then need to trigger a bulk
> re-encrypt of the entire disk contents, which takes a long time.
This is good to know, and would mean that I was right to make blockdev-amen=
d
a block job.

This also means that when user wants to tweak some setting, he might not
want to pass all the keyslots again.

BTW, I guess that to change the master key, user ought to know all password=
s,
since each keyslot is basically an encrypted master key. I didn't read the =
LUKS v2
spec though.


>=20
> I doubt we'll do this in the near term, but we should consider how this
> might fit into whatever scheme we pick for updates.
We might have to since LUKS v2 becomes default in more and more distros,
so users will eventually expect it be used by us as well.


Best regards,
=09Maxim Levitsky


