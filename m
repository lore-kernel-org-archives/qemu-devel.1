Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBA6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981D620773
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDp1Z3xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981D620773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZEq-0003SN-R7
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlZE6-0002ux-Ub; Wed, 17 Jun 2020 10:39:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlZE4-0008GN-Vc; Wed, 17 Jun 2020 10:39:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id r15so2266275wmh.5;
 Wed, 17 Jun 2020 07:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=gizJgg+Z3pkzw/3zuKc6CbocxMEHgqIDqOvmu24aah4=;
 b=dDp1Z3xj0lpnTm+O4QS4Gw5Pjj3NY7fykdsffuCLntG57//QPjBFTwJOIeFhsXbC0S
 hGE/s1C9IoJIUFIgZeWpRw7aN9I2zlYkwKr1Ca5u9m9hl+24GneXxUno4EkkfxP+8325
 fkvWu37/UxV0vQTLIAGxwIA9XYsp+G4WTa9QU9H49ylTFqkLb4O3Kws9kpBF9Xnqzame
 x3HlWAKp1UXFhs+MM95Qg23JEHb+vzMEESxVML23oOk3aL7W7qhikH546PcJcTbv3YT+
 QHkS7XI1rNooOaVpmz/vrxThWnd6jXZT0s3e3LqN7RP0IU+v1I2HcTmqFkRBS9CbEWnc
 9PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gizJgg+Z3pkzw/3zuKc6CbocxMEHgqIDqOvmu24aah4=;
 b=CwxK3LAXFFecRR3feI+Rl0YuH3lsTl4X1NyAInIgH90Cp8buyBd82v7BiSs3pA/NAL
 NI9xdrwWAF4+JwqPG+EYq23XRZn03w9Tc/xwFjmFwOW1gt9ifY80dQI6AQpojz8HU3IR
 FU6oOL6n9TfRcfGbfOjOhypawv2wQm/0T66U8IMA7ll7u9jn1W16AcmLTqHSQqLqEMZz
 Pdg3jufspw5KEuCNWeP4hGw/4IQjw3JpsCYSICaXcewVMLYOwVGXGVoVxOolr1kfzQMW
 //gKHU6VibBqcV7HnMJp71G7A8KQ1NBhDvM5dXutmQZwvJqUhLWI/EUDNgloA5cIdl3I
 2DKg==
X-Gm-Message-State: AOAM533flXMHuw4SqnioPecMZTCvY178KpGaQG0Y9D5rncAMIqfJnUSO
 HZC9aPDMBVePGOB3cWC+Shw=
X-Google-Smtp-Source: ABdhPJxjDdgA+heeVlGNs7yehg10q8CQi0LJUZzipwJCpNWNTe5P1m+27tlzjkt7KqxwujsMU8cz/A==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr8734523wmt.105.1592404778915; 
 Wed, 17 Jun 2020 07:39:38 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a1sm631642wmj.29.2020.06.17.07.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 07:39:37 -0700 (PDT)
Date: Wed, 17 Jun 2020 15:39:36 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v2 1/4] Introduce yank feature
Message-ID: <20200617143936.GJ1728005@stefanha-x1.localdomain>
References: <cover.1590008051.git.lukasstraub2@web.de>
 <20005a15c708fbda983f9be602c55fc0b1979a18.1590008051.git.lukasstraub2@web.de>
 <20200521150335.GO251811@stefanha-x1.localdomain>
 <20200521174241.3b0a267f@luklap>
 <20200521154806.GI2211791@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6THr7QwYWIbrk6Kt"
Content-Disposition: inline
In-Reply-To: <20200521154806.GI2211791@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6THr7QwYWIbrk6Kt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 04:48:06PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, May 21, 2020 at 05:42:41PM +0200, Lukas Straub wrote:
> > On Thu, 21 May 2020 16:03:35 +0100
> > Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >=20
> > > On Wed, May 20, 2020 at 11:05:39PM +0200, Lukas Straub wrote:
> > > > +void yank_generic_iochannel(void *opaque)
> > > > +{
> > > > +    QIOChannel *ioc =3D QIO_CHANNEL(opaque);
> > > > +
> > > > +    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> > > > +}
> > > > +
> > > > +void qmp_yank(strList *instances, Error **errp)
> > > > +{
> > > > +    strList *tmp;
> > > > +    struct YankInstance *instance;
> > > > +    struct YankFuncAndParam *entry;
> > > > +
> > > > +    qemu_mutex_lock(&lock);
> > > > +    tmp =3D instances;
> > > > +    for (; tmp; tmp =3D tmp->next) {
> > > > +        instance =3D yank_find_instance(tmp->value);
> > > > +        if (!instance) {
> > > > +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> > > > +                      "Instance '%s' not found", tmp->value);
> > > > +            qemu_mutex_unlock(&lock);
> > > > +            return;
> > > > +        }
> > > > +    }
> > > > +    tmp =3D instances;
> > > > +    for (; tmp; tmp =3D tmp->next) {
> > > > +        instance =3D yank_find_instance(tmp->value);
> > > > +        assert(instance);
> > > > +        QLIST_FOREACH(entry, &instance->yankfns, next) {
> > > > +            entry->func(entry->opaque);
> > > > +        }
> > > > +    }
> > > > +    qemu_mutex_unlock(&lock);
> > > > +} =20
> > >=20
> > > From docs/devel/qapi-code-gen.txt:
> > >=20
> > >   An OOB-capable command handler must satisfy the following condition=
s:
> > >=20
> > >   - It terminates quickly.
> > Check.
> >=20
> > >   - It does not invoke system calls that may block.
> > brk/sbrk (malloc and friends):
> > The manpage doesn't say anything about blocking, but malloc is already =
used while handling the qmp command.
> >=20
> > shutdown():
> > The manpage doesn't say anything about blocking, but this is already us=
ed in migration oob qmp commands.
>=20
> It just marks the socket state in local kernel side. It doesn't involve
> any blocking roundtrips over the wire, so this is fine.
>=20
> >=20
> > There are no other syscalls involved to my knowledge.
> >=20
> > >   - It does not access guest RAM that may block when userfaultfd is
> > >     enabled for postcopy live migration.
> > Check.
> >=20
> > >   - It takes only "fast" locks, i.e. all critical sections protected =
by
> > >     any lock it takes also satisfy the conditions for OOB command
> > >     handler code.
> >=20
> > The lock in yank.c satisfies this requirement.
> >=20
> > qio_channel_shutdown doesn't take any locks.
>=20
> Agreed, I think the yank code is compliant with all the points
> listed above.

The code does not document this in any way. In fact, it's an interface
for registering arbitrary callback functions which execute in this
special environment.

If you don't document this explicitly it will break when someone changes
the code, even if it works right now.

Please document this in the yank APIs and also in the implementation.

For example, QemuMutex yank has the priority inversion problem: no other
function may violate the oob rules while holding the mutex, otherwise
the oob function will hang while waiting for the lock when the other
function is blocked.

Stefan

--6THr7QwYWIbrk6Kt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qKygACgkQnKSrs4Gr
c8g2LAf7BxJ1dORohdY3Bgnrq4Hvo0E0zCx5J8LVNftDLVsNXn6Mmcb+ukcHLFCP
5SsCundfAx1BqIJajVtZtWAOjgq6e58YWba4cZA5kWTeXKJbQlrz/h5rkHyg9D7k
YHzy6T1vl+zcVq3dsz0nlDjevYs7ZQW8MKfLVuE+iYM8GT/szaQt+zlQ2TlZA4lX
axbxdATUoTMPZ/tQYMJ+yQJ2DC6XpArw8IiqC003a0vKKy+8TbFgbI72zHujgGX+
kz/hSemtg7+HyvERmut3YrNiMb7guGwb5cOe+2+bx9/pUOBEuSBBuyJpBpqMCE7d
SFaZ9GekoWzpZDA+y015SM1mx7F34A==
=VjRb
-----END PGP SIGNATURE-----

--6THr7QwYWIbrk6Kt--

