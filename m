Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE22FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B878B206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDmkyKKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B878B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2VvT-0005ZH-Mt
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 04:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k2Vuf-0004jd-CS
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 04:33:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k2Vuc-00063D-Dw
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 04:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596443617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eiODh9iEk5Y1dLmycFGRV8bBkh4XdJ9QBJIGydOQe60=;
 b=WDmkyKKVCkn76W7Gh2tCgdgkh5yfSYht4tIrOKcLVJ5rkDOgb0/8PtDgK7NHHC1SYhiTla
 ecL8ba8jyGfVxfNBM87SNpHtM2XNIrC5pWcFWzWkEZp10DtN7FAXiDHE96sthA6Jw8eGla
 +wtllubMKSuT3Gutbe3Muz1TFGeOlXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-y6embGqIMTyNY_T3JCLjeA-1; Mon, 03 Aug 2020 04:33:35 -0400
X-MC-Unique: y6embGqIMTyNY_T3JCLjeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF23180183C;
 Mon,  3 Aug 2020 08:33:32 +0000 (UTC)
Received: from gondolin (ovpn-112-197.ams2.redhat.com [10.36.112.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5AC787E35;
 Mon,  3 Aug 2020 08:33:18 +0000 (UTC)
Date: Mon, 3 Aug 2020 10:33:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [for-5.2 v4 10/10] s390: Recognize host-trust-limitation option
Message-ID: <20200803103307.3b213a1c.cohuck@redhat.com>
In-Reply-To: <20200803081457.GE7553@yekko.fritz.box>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
 <20200724025744.69644-11-david@gibson.dropbear.id.au>
 <8be75973-65bc-6d15-99b0-fbea9fe61c80@linux.ibm.com>
 <20200803075459.GC7553@yekko.fritz.box>
 <d8168c58-7935-99e7-dfe5-d97f22766bf7@linux.ibm.com>
 <20200803081457.GE7553@yekko.fritz.box>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/JpL+alQ2rrMB=FqQpkLBumG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com,
 Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/JpL+alQ2rrMB=FqQpkLBumG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Aug 2020 18:14:57 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Aug 03, 2020 at 10:07:42AM +0200, Janosch Frank wrote:
> > On 8/3/20 9:54 AM, David Gibson wrote: =20
> > > On Mon, Aug 03, 2020 at 09:49:42AM +0200, Janosch Frank wrote: =20
> > >> On 7/24/20 4:57 AM, David Gibson wrote: =20
> > >>> At least some s390 cpu models support "Protected Virtualization" (P=
V),
> > >>> a mechanism to protect guests from eavesdropping by a compromised
> > >>> hypervisor.
> > >>>
> > >>> This is similar in function to other mechanisms like AMD's SEV and
> > >>> POWER's PEF, which are controlled bythe "host-trust-limitation"
> > >>> machine option.  s390 is a slightly special case, because we alread=
y
> > >>> supported PV, simply by using a CPU model with the required feature
> > >>> (S390_FEAT_UNPACK).
> > >>>
> > >>> To integrate this with the option used by other platforms, we
> > >>> implement the following compromise:
> > >>>
> > >>>  - When the host-trust-limitation option is set, s390 will recogniz=
e
> > >>>    it, verify that the CPU can support PV (failing if not) and set
> > >>>    virtio default options necessary for encrypted or protected gues=
ts,
> > >>>    as on other platforms.  i.e. if host-trust-limitation is set, we
> > >>>    will either create a guest capable of entering PV mode, or fail
> > >>>    outright
> > >>>
> > >>>  - If host-trust-limitation is not set, guest's might still be able=
 to
> > >>>    enter PV mode, if the CPU has the right model.  This may be a
> > >>>    little surprising, but shouldn't actually be harmful. =20
> > >>
> > >> As I already explained, they have to continue to work without any ch=
ange
> > >> to the VM's configuration. =20
> > >=20
> > > Yes.. that's what I'm saying will happen.
> > >  =20
> > >> Our users already expect PV to work without HTL. This feature is alr=
eady
> > >> being used and the documentation has been online for a few months. I=
've
> > >> already heard enough complains because users found small errors in o=
ur
> > >> documentation. I'm not looking forward to complains because suddenly=
 we
> > >> need to specify new command line arguments depending on the QEMU ver=
sion.
> > >>
> > >> @Cornelia: QEMU is not my expertise, am I missing something here? =
=20
> > >=20
> > > What I'm saying here is that you don't need a new option.  I'm only
> > > suggesting we make the new option the preferred way for future
> > > upstream releases.  (the new option has the advantage that you *just*
> > > need to specify it, and any necessary virtio or other options to be
> > > compatible should be handled for you).
> > >=20
> > > But existing configurations should work as is (I'm not sure they do
> > > with the current patch, because I'm not familiar with the s390 code
> > > and have no means to test PV, but that can be sorted out before
> > > merge).
> > >  =20
> > OK, should and might are two different things so I was a bit concerned.
> > That's fine then, thanks for the answer. =20
>=20
> Well, the "should" and "might" are covering different things.
> Existing working command lines should continue to work.  But those
> command lines must already have the necessary tweaks to make virtio
> work properly.  If you try to make a new command line for a PV guest
> with a virtio device - or anything else that introduces extra PV
> complications - then just chosing a CPU model with UNPACK might not be
> enough.  By contrast, if you set host-trust-limitation, then it should
> work and be PV capable with an arbitrary set of devices, or else fail
> immediately with a meaningful error.

Yes, that was also my understanding.

Getting the interaction with the cpu model right seems to be the tricky
part, though. The UNPACK feature would only be set automatically
_after_ the htl device has already checked for it...

--Sig_/JpL+alQ2rrMB=FqQpkLBumG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl8ny8MACgkQ3s9rk8bw
L68bYhAAgJSdtqjUzbxvCFFHLhDpjwAQY/kiMyI+yqVHl6hMxa/57Xiz76RXAiVL
nM3Uptu8TPHJa9nh1XYN6Zt8kCU/KIg2wZCKqap60EbmfIBFH8f0dfeouPGDmxDu
o6OY5wwnJNnD4iJgUxHv9PYWj8DKGXDc10xP4H4lO1jtIBXGfdcP0Y1JKrmY+ztj
zfZF6XFCgLuFpS3MMzk1eIryiDnxGn3PS4nZEq3fdi8GgRinbWgdiI5Yez4e4B5D
NMnFcv1+vbh8HVSUUFAkw9/heZOPpqZzknF5aEP3b2q6v7lDPChv/v+ttnsLeipY
Ln8L9w56lRKZNRCf5YrA/wsIygjwdSRqjHx0JrzOZJtTXcVPWrqYIj6ZdMucKhO8
v+gzUB2hnOvag9hR507LKmgQXb4fwdng4dhZPUxvBR1EwUZG8It4yj1fxvms5t9k
8TKSG/8i5HTEeUHPJZXZBfriYu2suiqwS2WWTR3ClPMSVA657t6YWPI4VtfX1uVB
dN0seJXgl0MjfjOoPAu4eoITVbx/NzHHqdMlVRTedewVUVeQIbuEdu8qR/q2xknH
4RKvdBy1uzz7Aqu/1VpughHs2E8r8wuPghN4k+MSKkFMrd1rsuWNIC6pANJCkgtX
qraO5PLlimfLqOkO21/C69YVtuetALZ9z9uE9hPjaa/a98+grzo=
=p0E1
-----END PGP SIGNATURE-----

--Sig_/JpL+alQ2rrMB=FqQpkLBumG--


