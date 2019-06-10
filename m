Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22979C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 12:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62362085A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 12:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uD8mOrgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62362085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haJIv-0001P6-4u
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 08:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57824)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1haJH9-0000Cd-65
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1haJH8-0006eu-1t
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:19:47 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:35572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1haJH7-0006da-Qs
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:19:46 -0400
Received: by mail-wr1-x434.google.com with SMTP id m3so8978802wrv.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JYGZkYAD5n3RO12D0esSv14MauJq3BjWwsP8BdIX/Z4=;
 b=uD8mOrgo2XyXG3U7b2cCUIaz+vfdMITxUmHsIJcq8v8R+XlsA7H1rs3xGTO2bFtCbB
 B1bHC9k3+n9yfCmfhrSQvkLYod5CCPkH9U0Y6XFUNynPHKdz6otydp97fkkDfsyrh7/x
 4ekSjetOcsTNdtvohKI7k2t6NV7ech28ytkkNxoQSwilJ0xL1ObXJFHP+JiYF6nH7b8o
 Tye571me1awLkM/2BUIBf3JcSYMTz5Wc7DPXAFIijGgr/rfbcesWx/O9LS7s/s/jquQl
 88Tz8THc96tjON28T92tC4IRCcZ0XdXT6zDgSLEbydwPYna0TzN+KjNWtlpl/yL+aVvS
 XIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JYGZkYAD5n3RO12D0esSv14MauJq3BjWwsP8BdIX/Z4=;
 b=eH9UhXthjOdCOOZpIDGg9Wq8KuJglLtqE8Ev0RBMouA7F8hsCygx+bcc4RxpCZSdrD
 wZXk/iN56IX3U58oXBwndPvutA2ajIXfYzrWbloBhcHI4f0GryJGGHgoP9hTa9eyzTMU
 12ctntAQDdf6WgkvTSGPMEp4vL6TqcqnbNn7BO0rTA5bpyDlgl3msMIyMW2QaxmUIAto
 PyKd2osZn/QV7yCKwn0nJWbggVc69tU9emIoIkTMpKhFbLd7p/EXLZ3GYuIb7vHacr4i
 7kAtdchmTDFjxeXGWhgCYW/++vd+TeClBZRyt/kY0muKcKBnEHcEcU+BI5FUZzjQAY+0
 ZdlQ==
X-Gm-Message-State: APjAAAXcK07vPdGaUML2Tm6dZzA75bQKjIS3OH90+RvrXWun5hgKqRe9
 Rk9l4lES6Hg5tTjQKF8eXYU=
X-Google-Smtp-Source: APXvYqxs50R6D1XDTR8BN2WQC49+42ud9XgEr3bP4A7iMC6z/GjWOTI3JN2Qn7j+CVAAGJAKssbsjw==
X-Received: by 2002:a5d:51cb:: with SMTP id n11mr5406170wrv.143.1560169183597; 
 Mon, 10 Jun 2019 05:19:43 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u5sm13445392wmc.32.2019.06.10.05.19.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 10 Jun 2019 05:19:42 -0700 (PDT)
Date: Mon, 10 Jun 2019 13:19:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Gary Dale <gary@extremeground.com>
Message-ID: <20190610121941.GI14257@stefanha-x1.localdomain>
References: <abb7990e-0331-67a4-af92-05276366478c@extremeground.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8/UBlNHSEJa6utmr"
Content-Disposition: inline
In-Reply-To: <abb7990e-0331-67a4-af92-05276366478c@extremeground.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: Re: [Qemu-devel] kvm / virsh snapshot management
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8/UBlNHSEJa6utmr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 01, 2019 at 08:12:01PM -0400, Gary Dale wrote:
> A while back I converted a raw disk image to qcow2 to be able to use
> snapshots. However I realize that I may not really understand exactly how
> snapshots work. In this particular case, I'm only talking about internal
> snapshots currently as there seems to be some differences of opinion as to
> whether internal or external are safer/more reliable. I'm also only talki=
ng
> about shutdown state snapshots, so it should just be the disk that is
> snapshotted.
>=20
> As I understand it, the first snapshot freezes the base image and subsequ=
ent
> changes in the virtual machine's disk are stored elsewhere in the qcow2 f=
ile
> (remember, only internal snapshots). If I take a second snapshot, that
> freezes the first one, and subsequent changes are now in third location.
> Each new snapshot is incremental to the one that preceded it rather than
> differential to the base image. Each new snapshot is a child of the previ=
ous
> one.

Internal snapshots are not incremental or differential at the qcow2
level, they are simply a separate L1/L2 table pointing to data clusters.
In other words, they are an independent set of metadata showing the full
state of the image at the point of the snapshot.  qcow2 does not track
relationships between snapshots and parents/children.

>=20
> One explanation I've seen of the process is if I delete a snapshot, the
> changes it contains are merged with its immediate child.

Nope.  Deleting a snapshot decrements the reference count on all its
data clusters.  If a data cluster's reference count reaches zero it will
be freed.  That's all, there is no additional data movement or
reorganization aside from this.

> So if I deleted the
> first snapshot, the base image stays the same but any data that has chang=
ed
> since the base image is now in the second snapshot's location. The merge
> with children explanation also implies that the base image is never touch=
ed
> even if the first snapshot is deleted.
>=20
> But if I delete a snapshot that has no children, is that essentially the
> same as reverting to the point that snapshot was created and all subseque=
nt
> disk changes are lost? Or does it merge down to the parent snapshot? If I
> delete all snapshots, would that revert to the base image?

No.  qcow2 has the concept of the current disk state of the running VM -
what you get when you boot the guest - and the snapshots - they are
read-only.

When you delete snapshots the current disk state (running VM) is
unaffected.

When you apply a snapshot this throws away the current disk state and
uses the snapshot as the new current disk state.  The read-only snapshot
itself is not modified in any way and you can apply the same snapshot
again as many times as you wish later.

>=20
> I've seen it explained that a snapshot is very much like a timestamp so
> deleting a timestamp removes the dividing line between writes that occurr=
ed
> before and after that time, so that data is really only removed if I reve=
rt
> to some time stamp - all writes after that point are discarded. In this
> explanation, deleting the oldest timestamp is essentially updating the ba=
se
> image. Deleting all snapshots would leave me with the base image fully
> updated.
>=20
> Frankly, the second explanation sounds more reasonable to me, without hav=
ing
> to figure out how copy-on-write works,=A0 But I'm dealing with important =
data
> here and I don't want to mess it up by mishandling the snapshots.
>=20
> Can some provide a little clarity on this? Thanks!

If you want an analogy then git(1) is a pretty good one.  qcow2 internal
snapshots are like git tags.  Unlike branches, tags are immutable.  In
qcow2 you only have a master branch (the current disk state) from which
you can create a new tag or you can use git-checkout(1) to apply a
snapshot (discarding whatever your current disk state is).

Stefan

--8/UBlNHSEJa6utmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz+St0ACgkQnKSrs4Gr
c8jLBwf9EADjPYBGSLRi0QAOiT6zoiTfGJS1yHW0HIphH6L3Fcy9DVm3Qrv3yhG6
r/w4g8HAigy9m1GIwVSy5sLADysfNSK4kxtZ8Hna8a0rjv1fq7ZSdOBSFc0wwK7Y
s047y4UIlH+wdmQktAtV2F3KFjE6zmS0MWZbHK+rFfg11AjFDGvHiiOYl8wGY10V
vz+OyIJILYjtsUn4RYYAJUB/3XlJZ6CScqoRPBBa9bkfkzUMG3SUPjOyWWPFsRgm
TS7kjiNP3AEvFDNVtuhfLFvAbWnjinW1Wg9NP9zFuzg8tihLK3az7Rer4IpL1Goe
glLXb1p7ROzTvcW/k6JZ02CrZHbGzQ==
=X0dh
-----END PGP SIGNATURE-----

--8/UBlNHSEJa6utmr--

