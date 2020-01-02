Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D8C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5623720866
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMKnj7U5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5623720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in1Nm-0004Zh-Ez
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 09:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1in1Mw-00040u-0g
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1in1Mt-0007Nd-Jn
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:22:33 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1in1Mt-0007NI-C0
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:22:31 -0500
Received: by mail-wr1-x42b.google.com with SMTP id q6so39304995wro.9
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 06:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QF9EMq/wguFCyMI34mxVwGA1QAPzHTqo/16I8ZA9roo=;
 b=FMKnj7U5+f5+YKEZ5e2WgQBlzsyNEZkU9wqJc+LQ5oMNFMcSLFiuiLX2E6W7kIPtfZ
 36vZAnrF68Q9NNNeo9t9H5pgLLPUsF6fHiUsn01o5tljhLHnVYoxzlPLJKu3p7hkkkqp
 MvwarQ0TDQSvI+qOo8zB0OQUIEZf8HXty4OA0bOel/LrFgwhjN8wjWwPUHDkSCf5hoy+
 KrL5/mRv2CbQJROMWqoFmq+H+Bhr7vfNWLl30EK3u2CFhNf/F580iVyP+QeLM76d3mLT
 4+uyqBBh8gE3kLNOPNi1VKG90HaNXAZWWfYA3yGr2T4XJAyt5vAcaAn8jK9HCG+xAwjI
 jwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QF9EMq/wguFCyMI34mxVwGA1QAPzHTqo/16I8ZA9roo=;
 b=MihWTc7KHua07CXFSsocFVQc8hKIkl0u31uAWTIV3Yw0GtWnefcMZXEzH72gDK7lz1
 rR+BZQio73acsOdvEpvsusDWmgAvrezbeyq0n1X03GAKv7Uvw2UErUbDTM6oQq5JqoS/
 nbdGVER6tycdWLO/Nt0ObXv+RsumtQhLRGNJORp+emSr1+/hihr+NylcCauYeSViqYT3
 vrn1w4ilXxR/72evxsYT7sPg9+EcNoMOZhrKpw0HcXGBOH+46V1qvtdSMbTZU3LK0WOE
 Mi9vKaun/V8Wk5xzVM5NsYJbDFKPEAgaDe/NsBRVrEbvpOuCVOYIMlal3Vs69Li6alkp
 ESXg==
X-Gm-Message-State: APjAAAVme8/E+03YHqQ3fTRRRNxBQDxpI7a4sPLGTEgAJnX43oFKePuW
 e5x1x0Wo4kmTqTr6VKLZ40o=
X-Google-Smtp-Source: APXvYqxeLXkIBFo3pAJlwNr4gKZ1cwApu8n5DYBxu+QM81QrnOj3d73z4vwroE4iuWhnuBsR7a5+Vg==
X-Received: by 2002:adf:e74f:: with SMTP id c15mr86339653wrn.274.1577974949573; 
 Thu, 02 Jan 2020 06:22:29 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p17sm57025891wrx.20.2020.01.02.06.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 06:22:28 -0800 (PST)
Date: Thu, 2 Jan 2020 14:22:27 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200102142227.GK121208@stefanha-x1.localdomain>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <20191224130035.GC2710539@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RVlUGXxwBj5SDcM9"
Content-Disposition: inline
In-Reply-To: <20191224130035.GC2710539@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RVlUGXxwBj5SDcM9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2019 at 01:00:35PM +0000, Daniel P. Berrang=E9 wrote:
> On Fri, Dec 20, 2019 at 04:13:59PM +0000, Stefan Hajnoczi wrote:
> > Hi,
> > QEMU presents a command-line interface and QMP monitor for
> > applications to interact with.  Applications actually need API
> > bindings in their programming language.  Bindings avoid reimplementing
> > code to spawn a QEMU process and interact with QMP.  QEMU is kind of
> > lazy and de facto relies on libvirt for API bindings.
> >=20
> > Is it time for better QEMU APIs?
> >=20
> > 1. We have qapi-schema.json.  Let's render to HTML and publish
> > versioned documentation online.
>=20
> You have patches to publish this to the website already which is
> good for git master. We still need to get this published for
> stable releases, ideally we would have up to publish it for our
> pre-existing stable releases back a year or two too.
>=20
> At the same time though this is insufficient. It is *really* hard
> to understand how QAPI schema maps to either JSON or CLI args for
> either QMP or the CLI. Most docs examples just talk in terms of
> -drive. I think the qapi schema docs could benefit from more
> work to provide real world example usage inline.
>=20
>=20
> > 2. scripts/qmp/ contains command-line tools for QMP communication.
> > They could use some polish and then be shipped.
>=20
> The qmp-shell in particular is interesting. Libvirt has a similar
> need for a simpler way to deal with QMP and "virsh qemu-monitor-command"
> has notable overlap with functionality of qmp-shell.
>=20
> I wonder if there's a way to spin this off so that we have have a
> standard QMP client shell that can either talk direct to a UNIX
> socket, or indirect via libvirt's QMP command passthrough APIs.

A standard (and easier-to-use and powerful) QMP shell would be nice.

> > 3. python/qemu/ contains Python modules for managing a QEMU process
> > and QMP communication.  This should be packaged in distros and
> > available on PyPI.
> >
> > 4. Go and Rust bindings would also be useful.  There is
> > https://github.com/intel/govmm but I think it makes sense to keep it
> > in qemu.git and provide an interface similar to our Python modules.
>=20
> Presumably you mean bindings for the QMP commands ?  This will
> quickly expand to mean bindings for every aspect of QEMU configuration
> that's currently QAPI-ified. It will quickly become a very big job
> to design, develop & maintain, especially if you want to support
> multiple languages in a natural way.

No, I mean just launching QEMU and communicating over QMP.

I think creating bindings for QMP commands is too much effort.  It would
duplicate the QAPI schema documentation because we'd need native API
documentation too.

I think clients should work at the QMP JSON level.

> > 5. A jailer is needed to isolate the QEMU process and vhost-user
> > device backends using seccomp, Linux namespaces, and maybe
> > SELinux/AppArmor.  We used to be able to rely on libvirt for QEMU
> > security, but it's becoming a common task for any device backend and
> > IMO should be its own launcher tool.
>=20
> Based on experiance in libvirt, this is an even larger job than (4),
> as the feature set here is huge.  Much of it directly ties into the
> config problem, as to deal with SELinux / namespace setup the code
> needs to understand what resources to provide access to. This
> requires a way to express 100% coverage of all QEMU configuration
> in use & analyse it to determine what resources it implies. So this
> ties strongly into QAPI-ification completion.

I don't have a clear design in mind yet but I've learnt a little from
writing the virtiofsd namespace isolation and seccomp code.  The task is
really hard for a general-purpose QEMU binary that supports all
features, because configuring the sandbox with the minimal attack
surface requires knowledge of the feature set being used in this QEMU
invocation :(.

> On the libvirt side, we've a strong long term desire to move our
> codebase from C to either Go or Rust. In doing this refactoring
> and rewriting, we would quite likely end up with self-contained
> packages / modules / APIs that can be used independantly of the
> main libvirt API. Thus there's probably scope here to collaborate
> between libvirt & QEMU communities to develop new APIs.
>=20
> Some of this code could be directly QEMU related, but other parts
> of the code are likely to be generic & not tied to QEMU at all.
> For example libvirt's SELinux, namespace, cgroup setup code is used
> by LXC too. Thus from the libvirt POV, some libraries might be
> deliverable by QEMU project, but others might be deliverable by
> libvirt project. Or might be scope for a indepent new project to
> deliver pieces.

I think duplication is in the nature of these isolation mechanisms.
systemd also supports most of the features necessary for isolation but
neither QEMU nor libvirt take advantage of systemd and it's not easy to
do so either.  I think it will be necessary to be pragmatic and look at
it on a case-by-case basis.  There will be some duplication.

> Essentially we can consider a stack
>=20
>      +--------------+
>      |  Libvirt API |
>      +--------------+
>            |
> 	   V
>      +--------------+
>      | Helper APIs  |
>      +--------------+
>            |
> 	   V
>      +--------------+
>      |  QEMU        |
>      +--------------+
>=20
> Right now, everything in "Helper APIs" is hidden inside libvirt.
> Some of that conceptually ought to be deliverable by QEMU. Some
> of that ought to be spun out as separate deliverables by libvirt
> or another independant project.

I would like QEMU to directly expose APIs without the need for another
level of APIs, where this makes sense.  It's inefficient and slow to
develop stable APIs in QEMU and then repeat that work again in higher
layers of the stack.  To some extent this is unavoidable but I think
QEMU is close to providing usable APIs and tools itself in the areas
I've outlined in this email thread.

By doing this we'll create a better experience for Kata Containers and
other programs that directly use QEMU.

> > 6. A configuration file format is sorely needed so that guest
> > configuration can be persisted and easily launched.  Today you have to
> > create a shell script that executes a QEMU command-line, but this is
> > suboptimal because sharing executable scripts is dangerous from a
> > security perspective and is hard to parse or modify programmatically.
>=20
> A configuration file is just one aspect of our broader configuration
> problem.
>=20
> Our CLI in particular suffers from trying to be "all things to all people"
> and IMHO is a direct cause of the perception of QEMU as being overly
> complex, hard to understand & burdened by legacy support. Of course we
> didn't set out intentionally on this path, things just grew organically
> we were not succesfully enough at tackling technical debt over time.
>=20
> To pick on blockdev, as it has had the most growth, IIUC we have
>=20
>   $QEMU FILENAME
>   $QEMU -hda FILENAME
>   $QEMU -drive if=3Dide,file=3DFILENAME
>   $QEMU -drive if=3Dnone,file=3DFILENAME,id=3Ddisk0 -device virtio-blk,dr=
ive=3Ddisk0
>   $QEMU -blockdev driver=3Draw,file.filename=3DFILENAME,id=3Ddisk0 -devic=
e virtio-blk,drive=3Ddisk0
>=20
> IIUC, in (all/most) cases "FILENAME" can be either a plain filename,
> or a "json:{....}" string, so that's giving us possibly as many as
> 10 ways to configure disks, with increasing generality.
>=20
> If you were designing QEMU from a clean slate it is unlikely we'd
> plan to have 10 syntaxes. A clean slate would probably provide
> 2 different syntaxes at most - one simple but convenient, and one
> complex but fully expressive.
>=20
> For every one there's going to be some set of users who think
> their chosen syntax is ideal, and will thus be unhappy if we
> cull one choice.  For the health of QEMU long term though, I
> think we're going to have to accept the need to make some people
> temporarily unhappy in order to become sustaininable over the
> long term.

Agreed :).

> This ultimately all stems from the fact that the CLI design has
> aimed to provide 100% coverage of all QEMU features for mgmt apps,
> while at the same time as providing convenient syntax for humans.
> Except it has actually failed in the former, because there's some
> stuff you can only configured after launching QEMU via QMP commands.
>=20
> We can reduce some of the maint burden by mapping "convenient syntax"
> onto the more expressive (usually QAPI modelled) syntax internally,
> but I think that alone is insufficient.
>=20
> We should step back & consider the bigger question of what we want
> QEMU's approach to configuration to be.
>=20
> With my libvirt hat on, we have to support JSON for a large portion
> of config because we need to use QMP hotplug. Thus if we could eliminate
> the need to use the CLI syntax entirely, it would remove / simplify
> libvirt's code base to work exclusively in terms of JSON.
>=20
> With this in mind, I think we could reasonably declare a high level
> goal that
>=20
>  - CLI arg syntax is *exclusively* for human targetted convenient syntax
>  - CLI arg syntax will *not* aim for 100% feature coverage
>  - CLI arg syntax will not guarantee strict back compat but will not
>    gratituitously break human usage
>  - JSON syntax will provide 100% feature coverage for mmgmt apps and huma=
ns
>  - JSON syntax will not be exposed via ARGV
>  - JSON syntax will be usable via a config file
>  - JSON syntax will be usable via QMP
>  - JSON syntax will provide strict back compat, but with deprecations
>    policy followed
>=20
> This is more or less what our long term goal with QAPI has always
> been. The sticking point has always been the tension with CLI arg
> syntax back-compat. We need to decide how to cut the knot so that
> we can complete the QAPI-ification in a forseeable amount of time.

Sounds good.

> > In many of these areas we already have a partial solution.  It just
> > needs more work.  I think it would be worth the effort and the mental
> > shift to really providing APIs that are easy to use by applications.
> >=20
> > What do you think?
>=20
> Personally I think QEMU configuration is the single biggest pain point
> for dealing with QEMU that we're not investing enough resources in.
>=20
> > Have I missed things that are needed?
> >=20
> > Have I included things that are unnecessary?
>=20
> Many of the things you list above are conceptually nice, but imply a
> lot of extra work for maintainers, as they are expanding the scope of
> the QEMU project. There's a risk this could divert resources away from
> tackling technical debt in things we're already maintaining. The flip
> side of course is that some of the things might attract new contributors
> to the project, because new concepts are inevitably more interesting to
> some people than tackling technical debt. IOW both are important and
> we need to find a balance between them.
>=20
> One of the serious long term issues we've had in QEMU is our inability
> to finish jobs that we start. The configuration problem is the biggest
> example or something we started JSON-ifying 10 years ago, but are still
> an unknowable amount of time away from finishing.

I think now is the right time to do it because there is awareness and
willingness to find solutions both in libvirt and QEMU.  I'm optimistic
that progress can be made here.

The next step is a more detailed plan so that multiple people can work
on these tasks.

Stefan

--RVlUGXxwBj5SDcM9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4N/KMACgkQnKSrs4Gr
c8jZAAgAjeDIA/VlLoqohHLgdkQtA4TUtZyZznZBVZ4weycdhgUTf1ttQk3rfUH7
ugaV6IDuEwbLCuFeQ1N9PCeVkU/ka6saemA0bIWi5gu65axFXXSNcqotpXUVmMyQ
ntE39iOgrGSNiMEpVB+3l7zJbAUsmqTlsFt4emjmQrPwSmPXcL+Ck8ucZWa1176l
oFosaYTkSZlw458kZ7DKqntRFqpY8Q0NULhXVGs1BK0fRaqZuoa8ArgOpFrzvGd9
X51t+E1SaNaMDDP0l7YIo5toI+o0lnMXsLfHSuCvRvKvTND53RVqdfc/em1wRc3R
VZmgvbVPfvL6N+A1T7A84092qA1dOQ==
=ls06
-----END PGP SIGNATURE-----

--RVlUGXxwBj5SDcM9--

