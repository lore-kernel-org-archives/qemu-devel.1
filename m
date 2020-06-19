Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51784C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 00:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3582073E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 00:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gBoJ83zG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3582073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm53E-0001OS-Bh
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 20:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm51v-0008Ha-7j; Thu, 18 Jun 2020 20:37:15 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm51r-0003R5-06; Thu, 18 Jun 2020 20:37:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49p0Hj59Dxz9sR4; Fri, 19 Jun 2020 10:37:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592527025;
 bh=PF+udPKLwp8IjjM1vHc5w+SSoUbVPLZJaePRrw7TYBM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gBoJ83zGqIWaW2P3aELHmYKkDjfudHdWFf9tHBuJ/WwWNOBMsCF/CeU/cpKZpHy9s
 mkZ/szfEdZMFJDpTMqbGa40QDN/CWlWkXwG/TRun3qPwyQKX7r04+azxMP4m0xc84g
 6Fyc+qWs9q1j0GSRNCYcyfU/sIu7mEaEQ6ritcAw=
Date: Fri, 19 Jun 2020 10:33:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200619003316.GE17085@umbus.fritz.box>
References: <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
 <20200609114130.0ca9190b.pasic@linux.ibm.com>
 <20200609174747.4e300818@ibm-vm>
 <20200609182839.7ac80938.pasic@linux.ibm.com>
 <20200609124155-mutt-send-email-mst@kernel.org>
 <20200610043118.GF494336@umbus.fritz.box>
 <4e5d62d8-9bfb-67d5-7398-2079729fd85e@redhat.com>
 <20200610100756.GO494336@umbus.fritz.box>
 <858e9554-a4c7-6487-121b-ac3eaa209cb7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline
In-Reply-To: <858e9554-a4c7-6487-121b-ac3eaa209cb7@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Viktor Mihajlovski <mihajlov@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2020 at 12:24:14PM +0200, David Hildenbrand wrote:
> On 10.06.20 12:07, David Gibson wrote:
> > On Wed, Jun 10, 2020 at 09:22:45AM +0200, David Hildenbrand wrote:
> >> On 10.06.20 06:31, David Gibson wrote:
> >>> On Tue, Jun 09, 2020 at 12:44:39PM -0400, Michael S. Tsirkin wrote:
> >>>> On Tue, Jun 09, 2020 at 06:28:39PM +0200, Halil Pasic wrote:
> >>>>> On Tue, 9 Jun 2020 17:47:47 +0200
> >>>>> Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
> >>>>>
> >>>>>> On Tue, 9 Jun 2020 11:41:30 +0200
> >>>>>> Halil Pasic <pasic@linux.ibm.com> wrote:
> >>>>>>
> >>>>>> [...]
> >>>>>>
> >>>>>>> I don't know. Janosch could answer that, but he is on vacation. A=
dding
> >>>>>>> Claudio maybe he can answer. My understanding is, that while it m=
ight
> >>>>>>> be possible, it is ugly at best. The ability to do a transition is
> >>>>>>> indicated by a CPU model feature. Indicating the feature to the g=
uest
> >>>>>>> and then failing the transition sounds wrong to me.
> >>>>>>
> >>>>>> I agree. If the feature is advertised, then it has to work. I don't
> >>>>>> think we even have an architected way to fail the transition for t=
hat
> >>>>>> reason.
> >>>>>>
> >>>>>> What __could__ be done is to prevent qemu from even starting if an
> >>>>>> incompatible device is specified together with PV.
> >>>>>
> >>>>> AFAIU, the "specified together with PV" is the problem here. Curren=
tly
> >>>>> we don't "specify PV" but PV is just a capability that is managed b=
y the
> >>>>> CPU model (like so many other).
> >>>>
> >>>> So if we want to keep it user friendly, there could be
> >>>> protection property with values on/off/auto, and auto
> >>>> would poke at host capability to figure out whether
> >>>> it's supported.
> >>>>
> >>>> Both virtio and CPU would inherit from that.
> >>>
> >>> Right, that's what I have in mind for my 'host-trust-limitation'
> >>> property (a generalized version of the existing 'memory-encryption'
> >>> machine option).  My draft patches already set virtio properties
> >>> accordingly, it should be possible to set (default) cpu properties as
> >>> well.
> >>
> >> No crazy CPU model hacks please (at least speaking for the s390x).
> >=20
> > Uh... I'm not really sure what you have in mind here.
> >=20
>=20
> Reading along I got the impression that we want to glue the availability
> of CPU features to other QEMU cmdline parameters (besides the
> accelerator). ("to set (default) cpu properties as well"). If we are
> talking about other CPU properties not expressed as CPU features (e.g.,
> -cpu X,Y=3Don ...), then there is no issue.

Well, depends what you mean by "glue".  What I have in mind is that
setting the host-trust-limitation machine property will change the
defaults for cpu features in include the necessary feature for s390,
just as the draft code already changes the defaults for the relevant
virtio properties.  My intention is that if you explicitly put feature
properties on the cpu, that will override those defaults.

Is that acceptable?  I'm aware that this property affecting things in
distant devices is kinda weird and ugly, but I don't see how else we
can make configuring this not horribly complicated and differently so
for each platform.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7sB8wACgkQbDjKyiDZ
s5I4bA//dFok/0wt6bCLwE8ddC4IdcRY6xwmNB0B/r9vy6ksLy9jVBiWbygQkpLh
pcKaS9DbapEgqPKGOqYk1azyffTVvf+X+GKlMTEVrfP9+hJDw7/U5e2K4PE2e4bL
gxI0/UUr3YtHtCh10k96I3ZP/jaZ7QjdqC64A5VWx+sgacNWS6XSQKaGhADI8+oZ
aHGY6TPxp3CQt22EA3oZGaiPpeYYv89tmdcdRIuBEy6H5B333Pe53BYk7wYs+zy+
/nYXT08nS4Y8O0L/4+MvqPoDsX0n69rbWgi/LcDJQboocrFxbtIJzDlA08jOdrmr
WZ867Ug1z7DZuM0gyGCIXf2bmEjBICBc0HQAxnP5T6aa6eCY9cbc6xTPeh3t1ZXR
mtb8N+Kwc2RQzR2MMOP/U/WM5Zyha9KtEicIK3RLTd7cPfKRVIFLpYyXYjSkIN/6
sPaKEuccLfM9OHNsy3oUc/sSEbJm1NZnzkVOE0VcbtuOWZw3HAYVJ3KH6opj3DR2
H79SCrD6kl1VUF/zef6pUm37a8flqN/s9s/ldcIk/YHmrrZ0R25AYfKqwL3PMLCG
vluruuyp3NM77MXi5eyY8sQnP86aC0ALnRqWJoVbigoZRuwafIMOe42nmIAWGJvN
+Q62OTHaV3G9XD4jRgcLKQ85laUkjjIcOtG17g40AqXPmK2O2YA=
=0Zgx
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--

