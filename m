Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26BEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC0921852
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kRQwhAxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC0921852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJu1-00008w-MF
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmJqa-00078C-6y; Fri, 19 Jun 2020 12:26:33 -0400
Received: from mout.web.de ([217.72.192.78]:38959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmJqW-0005HX-IP; Fri, 19 Jun 2020 12:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592583982;
 bh=2AlghV7pYz2VSAK2z8KBY6+0xV5NG5CUdIJUc/S/XTw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=kRQwhAxs7L0T0Dwg2yEdhi3/KgfBkL8lLKHTSMxzqaS2zBoVPLPJNBgb07pfSAgZX
 Ysp58wm21qlbz6vpJz7mCmbWUkvn1maA67f/ARntsh7FWVtQPVqiQPCBmjm9QGtfMZ
 Rv87lKy9/3ohWnyl89pa23vtNbJ3UawGbs5imHlI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.165]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL4Y-1jgnWr3fVc-00ET80; Fri, 19
 Jun 2020 18:26:21 +0200
Date: Fri, 19 Jun 2020 18:26:20 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 1/4] Introduce yank feature
Message-ID: <20200619182620.4e8736ed@luklap>
In-Reply-To: <20200617143936.GJ1728005@stefanha-x1.localdomain>
References: <cover.1590008051.git.lukasstraub2@web.de>
 <20005a15c708fbda983f9be602c55fc0b1979a18.1590008051.git.lukasstraub2@web.de>
 <20200521150335.GO251811@stefanha-x1.localdomain>
 <20200521174241.3b0a267f@luklap>
 <20200521154806.GI2211791@redhat.com>
 <20200617143936.GJ1728005@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FJ6wu_jdqi1r1DYwfci_=hH";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:I3Z7pB4zGEEemRAsYaYIuNebXrMg7OpsM6YCBWnEVb4ZEyH6/Na
 Iikx7UKq67HIqbvM6sspe1c7xxWfcox5VYhlSL0+dk43Y5YcQ6F5KdZzt0Ns/j73RgBjdlI
 MYM4xO7VWuJgtGpWSPJtJgOzqiLCs5CqZsjPJe5xMFgDRTMb7Ad+Q7zFEgrZ+2T9YCY4ZJ3
 2SjdqY2Vht111TnQALWcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hchmx3NDY38=:emiVpNA3guOcBsU5TmcYbQ
 IZq1T4oZVF6LxHc9Pq2Tv2TnN9xDh1bGKOE0fCw4BmKEGbaRWBwpWuRr6/qK8Ghk++QKpt4E0
 gca9UgeLzlvh5H4eMtKUkphkQ0SiUNq0WTQnWFWQA2tczhnAN9RxpbKpd1kCcYxgixufA6VGc
 Tw5JLUJlnc/QTGhJTHOu8CjpyKCMzn8TjfUDRx6dX195FTIzBrHv8A+j0RRTJqT3czzFlhzyL
 SbmpBnDaG/O5kWxO4oT1Hz4wlSjVK+kz2W0/v/lORlLbBeR3Ez/1qdLmcV0Ds2v0cxPeGAV0w
 EIw06EHTHvvOuv50XS+S75I7OLWoQ9RNbWHdUKxYYrFrBdPe3F8WvQCR6Oky71d7yhcNyZbc5
 0+eKu/XTsGDPGeYNS6Iuc2XLUQzFxrAxYz02Ip2BTOqbCflSK3RAWeNKqxZpuGTtz63jQd2Q0
 Hkk6KGsevIRO4Sp4ppWLDiQ3IsRq7rm2nKsYPA3vbNbLs9j8plsEp2mdKBpMYLNJkeiit25kl
 roVbOI3u3tZn1l/kLL5YSnQpww8Qj6aQJujGcOxoOjY6yR24AIhzSJgjLIQKaf7hEWF+p1o+G
 Hnyk1IEONQ5tz/KMRPzonMYi57Rn7SOXTsFdi+oidzQnqZo//8OqnZdbSrkml8NcTdk14Yj2N
 K1Q6a+mZk3b6YK0SwVEIVG5is6+GUQVTDHQaNQkN5rHHwQ3eBuHCGvCNJA6EbCzs3LGTSW95l
 b5YspkV3WwYHBvqd088pQzsXe+2ZSKkK/35VyJ2hgrhB2BaNCoh6MisuyDl2vvgX+/6TSQPqk
 8oDB4UcVedFdX9wLiMsZx8L0tzir29/jF36pfENuOjBbUwnNgybl7rLscflr2r6pJC0V2y5Hh
 XCOTC/UBaXnJJkcibhpTY0dafu1de4H+obf5XTbP6oUdRJhKFWEMXJttAJSTKd/qaTSlQ925M
 dZd8HlQs2B3oAaVxd7f/1ZpnxSdlyNnbKOKCvFVy8B7w2n0Osfqy2hiC1nvml3ymnJ7CQ43Q0
 BahaCSvJyZVmlArk2rFC0+GCG4cEzk7Bc0yQxQsCNcnHs6CJ1Yw6AtHnJmWRGgn/kyn8bgiv3
 B1C6x9qGizGQ/9ZOR4ieBGDkjWtP800e4l9K4LyEUwPQD4mXLRNKM0vP3UOprdqWuwFw4ediY
 uZ7pvvH9qy4h6Cs/7ah2H8k3Q5i7NzWzmrv8NeZ4TChgoMweTmjbtr6CEXOTSSsDrIRNE5OZU
 Cbb02KZy/MA+rWFIP
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 12:26:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/FJ6wu_jdqi1r1DYwfci_=hH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jun 2020 15:39:36 +0100
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Thu, May 21, 2020 at 04:48:06PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, May 21, 2020 at 05:42:41PM +0200, Lukas Straub wrote: =20
> > > On Thu, 21 May 2020 16:03:35 +0100
> > > Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > >  =20
> > > > On Wed, May 20, 2020 at 11:05:39PM +0200, Lukas Straub wrote: =20
> > > > > +void yank_generic_iochannel(void *opaque)
> > > > > +{
> > > > > +    QIOChannel *ioc =3D QIO_CHANNEL(opaque);
> > > > > +
> > > > > +    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> > > > > +}
> > > > > +
> > > > > +void qmp_yank(strList *instances, Error **errp)
> > > > > +{
> > > > > +    strList *tmp;
> > > > > +    struct YankInstance *instance;
> > > > > +    struct YankFuncAndParam *entry;
> > > > > +
> > > > > +    qemu_mutex_lock(&lock);
> > > > > +    tmp =3D instances;
> > > > > +    for (; tmp; tmp =3D tmp->next) {
> > > > > +        instance =3D yank_find_instance(tmp->value);
> > > > > +        if (!instance) {
> > > > > +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> > > > > +                      "Instance '%s' not found", tmp->value);
> > > > > +            qemu_mutex_unlock(&lock);
> > > > > +            return;
> > > > > +        }
> > > > > +    }
> > > > > +    tmp =3D instances;
> > > > > +    for (; tmp; tmp =3D tmp->next) {
> > > > > +        instance =3D yank_find_instance(tmp->value);
> > > > > +        assert(instance);
> > > > > +        QLIST_FOREACH(entry, &instance->yankfns, next) {
> > > > > +            entry->func(entry->opaque);
> > > > > +        }
> > > > > +    }
> > > > > +    qemu_mutex_unlock(&lock);
> > > > > +}   =20
> > > >=20
> > > > From docs/devel/qapi-code-gen.txt:
> > > >=20
> > > >   An OOB-capable command handler must satisfy the following conditi=
ons:
> > > >=20
> > > >   - It terminates quickly. =20
> > > Check.
> > >  =20
> > > >   - It does not invoke system calls that may block. =20
> > > brk/sbrk (malloc and friends):
> > > The manpage doesn't say anything about blocking, but malloc is alread=
y used while handling the qmp command.
> > >=20
> > > shutdown():
> > > The manpage doesn't say anything about blocking, but this is already =
used in migration oob qmp commands. =20
> >=20
> > It just marks the socket state in local kernel side. It doesn't involve
> > any blocking roundtrips over the wire, so this is fine.
> >  =20
> > >=20
> > > There are no other syscalls involved to my knowledge.
> > >  =20
> > > >   - It does not access guest RAM that may block when userfaultfd is
> > > >     enabled for postcopy live migration. =20
> > > Check.
> > >  =20
> > > >   - It takes only "fast" locks, i.e. all critical sections protecte=
d by
> > > >     any lock it takes also satisfy the conditions for OOB command
> > > >     handler code. =20
> > >=20
> > > The lock in yank.c satisfies this requirement.
> > >=20
> > > qio_channel_shutdown doesn't take any locks. =20
> >=20
> > Agreed, I think the yank code is compliant with all the points
> > listed above. =20
>=20
> The code does not document this in any way. In fact, it's an interface
> for registering arbitrary callback functions which execute in this
> special environment.
>=20
> If you don't document this explicitly it will break when someone changes
> the code, even if it works right now.
>=20
> Please document this in the yank APIs and also in the implementation.

Hi,
It is documented in yank.h:

/**
 * yank_register_function: Register a yank function
 *
 * This registers a yank function. All limitations of qmp oob commands apply
 * to the yank function as well.
 *
 * This function is thread-safe.
 *
 * @instance_name: The name of the instance
 * @func: The yank function
 * @opaque: Will be passed to the yank function
 */

Thanks,
Lukas Straub

> For example, QemuMutex yank has the priority inversion problem: no other
> function may violate the oob rules while holding the mutex, otherwise
> the oob function will hang while waiting for the lock when the other
> function is blocked.
>=20
> Stefan


--Sig_/FJ6wu_jdqi1r1DYwfci_=hH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7s5ywACgkQNasLKJxd
slh5iw//QAy4r1/OvHElfBVbFCFj3lnxW8SrS9sLKjVYW8tYqU9UPiaEVukexHVC
V+LlKO6dGpfVU+YFb79fHX4PXbF7fgI5Xpnwlj1HzsFgIZznrMv0+dtneQkHobdp
XE+u22NzCD/tpeWUCeOCcKoyN/vpCsueVE2I2P+k2xYYroQeha+yIzCJdYb0YN5H
oLFDTL8J+9K/jC1/PYMJlNVAzettm5s9ew5LtlAu4af/LcYw7pLBJlIdSIZ10nlH
1eMA9Uyq0Q/7lFvHjGo0mqY/yIxiFP5uhY5JYzZt1gthJjzvoL8tXV8I7wUAfLc6
sCx/MjdDeIiaZM4h3R2/YfC5VI9srvbAX3CyayltGLr0VvvenKMQDUZRFWiS2/r5
0Il9tkeIyqSYWz+AN5EnEzBwtymxzj7AnJrP93B3OyDmkI6pm5yfZrG6fkWx60LB
/iBe+8vtk/2iqGRutCNEIDP1/vjsmT+IZw5N372/wOM0GKdUecUFxKx3/rNUzuC5
Jc/qsVnumX5b7Md7NwB4lQcubRJ1DOPR0XyOr5GMokgU8SMednjhDvle2M/y2wFV
TGJr9vX3IHY6GvphOPNWQxvV/naL0zWHXKaSsz4sPOuz+O2mk2+4qJ6sgujyp4Tk
onpRGiLHtuCxILMCjU9dHtvIco/WOzhbkm1uDutndO0eVVtiUk0=
=hkuE
-----END PGP SIGNATURE-----

--Sig_/FJ6wu_jdqi1r1DYwfci_=hH--

