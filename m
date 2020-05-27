Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D607C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29499207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc7QfmnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29499207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdu3K-0004KH-CG
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 07:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdu2f-0003p4-3v
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:16:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdu2e-0002iE-AX
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:16:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id x13so8943749wrv.4
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=R3cM8aKxHLy75Pz1U+Vsw+e80lnIJU8Go4GIMUYt1ng=;
 b=mc7QfmnGb1HsBouMrk3C9398vDwimKJeNUBsbh4jTMBiYVVyIlVrXjQT0jaw0Lu514
 Z0FX5BniJA+/8EY8fVtUkRHZM3IVukfAz9H8oh/AIO8w+Bu7od+b4JsbibWcEdTSpowA
 KTDy3fjiV407DS15o10DrdYs8nIhSLQIWVeiqKjtfNprh0M3jZwg0nfrATXvCkNz2Bq0
 J7CoUFBl8wRM+2B2mi3lw2b6goZrSbm6YoYlPHipkU1r8mQoaEMPfKnknfJceqd8ejAs
 uBQlAA3apCpxANToJGE6GDLT+a9nAgT5G5DZ25pnV2r8T0mmt40fxXlSsjZipna7hxvW
 Nsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R3cM8aKxHLy75Pz1U+Vsw+e80lnIJU8Go4GIMUYt1ng=;
 b=o5Il1EZ5TBYie4iaa8scA4BdGsRCACgElXQN7YX0GKFn5tBmvyWkMDzjnI2q3CFmSs
 GapLnOWYKBndEBN8s58nCV7UX7CtdIGnwJuenofOmWQgxD8XIyG/RlkJ9DUxQ/R3Uyaj
 kLBgFC2SMrDJT4sY5EpfM+m5nxa8UUPbfQ91goCNWZ/mVEV/1weKPpGPB41Elx0PCjMV
 zE0myfping99l4WgZbHJUceog3MFrXOrNRhnVwgYi43hmA6trM95QS8FcVpuTAmeLdkP
 HFGBL/YQfR6ZkDidaZVniMu3J8AlnSOtn8KIqqAq2UspJouFwPh/TVh3rXvBdOsPPOnG
 QURA==
X-Gm-Message-State: AOAM5328YdZuPpO9z40eXAoK9eDk2HO4SNRf5ujXrafZhulk052nGv1z
 fjFnhbQzz05H8mnTp5TOvY8h2JMFoRg=
X-Google-Smtp-Source: ABdhPJxgRPHmHY/vlMT6H1M6Owvs04TCMVQqD7/895QVBeEKlqkieccrMB6mW59qJh5mOKQoO3WvKg==
X-Received: by 2002:adf:dccc:: with SMTP id x12mr15007609wrm.72.1590578170875; 
 Wed, 27 May 2020 04:16:10 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id r2sm2833653wrg.68.2020.05.27.04.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 04:16:10 -0700 (PDT)
Date: Wed, 27 May 2020 12:16:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] virtiofsd: Use clone() and not unshare(), support non-root
Message-ID: <20200527111608.GE29137@stefanha-x1.localdomain>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
 <20200506191614.GR2743@work-vm>
 <20200507092832.GA1104082@redhat.com>
 <20200521101923.GF251811@stefanha-x1.localdomain>
 <20200521104344.GD2211791@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LSp5EJdfMPwZcMS1"
Content-Disposition: inline
In-Reply-To: <20200521104344.GD2211791@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Colin Walters <walters@verbum.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 11:43:44AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, May 21, 2020 at 11:19:23AM +0100, Stefan Hajnoczi wrote:
> > On Thu, May 07, 2020 at 10:28:32AM +0100, Daniel P. Berrang=E9 wrote:
> > > If the person in the host launching virtiofsd is non-root, then
> > > user namespaces mean they can offer the guest the full range of
> > > POSIX APIs wrt access control & file ownership, since they're
> > > no longer restricted to their single host UID when inside the
> > > container.
> >=20
> > What installs the uid_map/gid_map for virtiofsd?
> >=20
> > My machine has /etc/subuid and /etc/subgid, but how would this come into
> > play with these patches applied?
>=20
> AFAICT, nothing is setting up the mapping, hence my question in the first
> review of this patch, that this patch seems incomplete.
>=20
> The subuid/subgid files are essentially just reserving a range of IDs
> for each user. Something then needs to read & honour those IDs.
>=20
> The rules on setting up a mapping are complex though, to avoid a user
> from creating a new user namespace, and defining a mapping that lets
> them elevate privileges to read files in the host they wouldn't otherwise
> be permitted to access.
>=20
> IIUC, applying the range of IDs from subuid/subgid will require the
> process defining the mapping to have CAP_SETUID *outside* the container.
> As an unprivileged host user, you won't have that, so I think the only
> thing you can do is setup a mapping for your own UID/GID, which would
> allow the container to read/write files owned by the host user that
> started it. That should be ok for virtiofsd's needs at least for simple
> file sharing. If virtiofsd needs to expose its full range of features
> though, something privileged in the host needs to setup a full mapping
> based on subuid/subgid
>=20
> BTW, "man user_namespaces" gives many more details on UID mapping
> rules.
>=20
> > What happens when an unprivileged user who is not listed in /etc/subuid
> > runs virtiofsd?
>=20
> The UID map inside the container will be empty, which should result in
> all files being remapped to (uid_t)-1 or whatever is shown in the
> /proc/sys/kernel/overflow{u,g}id files.
>=20
> So virtiofsd would not have any write access, and only have read access
> to files which have world-read bit set. =20

Okay. Enabling user namespaces for virtiofsd is valuable. I think the
behavior should be documented though so users know what needs to be
configured. That is missing from this patch series.

Stefan

--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OS/gACgkQnKSrs4Gr
c8hSCgf/c/hBUXfeINuXnzL1o6gEq6vGrlwe/+ctA8v6/zcM6SDwyqXfhjUBB7T9
IGfyjjuafnuOkcD4KaWI2Ufaiv5U5Q5WptrjazKMTRk+MkHvPKSF5KSUUpWlfhH9
LqX7SmPWXFafLXOvHpgyPWeaSCnTwnmhTE842Y/O71SrJFb0Y1k6mEDwNM0Za0oo
5fQ4dygUoDAwjohJmYJSilNPEfwrxES55wlrmdL4Q9ULVA6vWDwsLZFPfgtDUIyC
QiIlFBbYd65kDyxzG97Ebwgffxj3p5TRonclbscMEm0f8hFrDzX8O43bBWrD1oQz
0JpZ5qQcxQp/0QRftaZ65SikG2yX8A==
=d5zl
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--

