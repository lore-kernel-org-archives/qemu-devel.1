Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4C6C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5586720740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0KKRfGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5586720740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFT4-00052f-Dh
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZFSJ-0004Sy-GU
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZFSH-0003ow-8b
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:35:11 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:40618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZFSH-0003oO-1y
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:35:09 -0500
Received: by mail-oi1-x22c.google.com with SMTP id d22so13260042oic.7
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 06:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=iB1DfQYWFBnempY55EkgOPE/R3j1LMrSd1Lruc2hEqI=;
 b=t0KKRfGih9X4d5Mw0UQUvv0q820rIyVJbE/yAVDD9vQhF9DYqAP8Bs2nPus4DFIWcB
 J0qgw6kLboy3uMLkk30V6vpMve+5yaNnuKS6MntvNhSuN07Mmr1nc7aHs/KGmsdpRMSO
 sqxHbU7sn+CzhGpCO3dDyF+5JnYCgUzFN/GcXDNukv6YXyFRs0eL5TIKeBNxxK0crRBS
 XJBA313yNEOI7q8RekkclLhu3nJpIOXOezEzwPSQK27FwgknsymgEq3t1WjnLV1/rOaG
 O2X/A9CRYKegVhLzJd4IL2K1hGJb5c/vmbOsjgN4KoKDZnqjMyG1KyyWIIG5IFwgBSFM
 lTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=iB1DfQYWFBnempY55EkgOPE/R3j1LMrSd1Lruc2hEqI=;
 b=bKvkSzIyLQyKDPLcTMU7LVh/WsTz9Ym+2gudMvG2VeVQOIMaRPsq+APrJ1lqUm7x+U
 USuUKLNkqjjFdGDQCS97puFGW4owX7SB3AwISO0mfyEs6ELiTH8PIVRIuF18WS+ixJ55
 FsfvxORxaITjLtOPxLnNM/M+r7Vm73xaSR0HUVZp3j/UaW/kCPue6NrSnHEPUFG6rA9T
 x+gCCr3FUtk/vaQcxKkIPGt90ZyaqY47ExaldCzdJkA6rrAsSWR3jAdOBb/DlwHyp4Iu
 qW06QaKCZngJy+MCWxTOpV2gqeOv7dEurhJeowxwmh0wXkQqxh8wqw5uu+8AXdJQqtRM
 ++8A==
X-Gm-Message-State: APjAAAXTQxVPm5JcCoHZXH13dSOCjLeqtfoTBWq6kw4WlNMPKZx22w9i
 wFaYlG/ht9Yq690VZ2KwhBsZoJ/TjEjiFPttHiO4LMLJDIk=
X-Google-Smtp-Source: APXvYqyEa8t22fzO2pStWkyssiPcbxT8EETx7MXj97MMUCmbikZNAAdzH5yMztM2YxAncy6rdZe/ZTPp2aGEVEZ8xKA=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr23227773oij.163.1574692507180; 
 Mon, 25 Nov 2019 06:35:07 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2019 14:34:56 +0000
Message-ID: <CAFEAcA9+qAonjUEtFBG0GRkTcHQ-Anggdvi0YTf1u4eGTQvYug@mail.gmail.com>
Subject: QEMU Summit Minutes
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As usual, we held a QEMU Summit meeting at KVM Forum.
This is an invite-only meeting for the most active maintainers
and submaintainers in the project, and we discuss various
project-wide issues, usually process stuff. We then post
the minutes of the meeting to the list as a jumping off point
for wider discussion and for those who weren't able to attend.

Attendees:
Peter Maydell
Kevin Wolf
Richard Henderson
Markus Armbruster
Gerd Hoffmann
Eduardo Habkost
Laurent Vivier
Mike Roth
Alex Benn=C3=A9e
David Gibson
Stefan Hajnoczi
Thomas Huth
Cornelia Huck
Paolo Bonzini
Daniel Berrang=C3=A9
Aleksandar Markovic
Paul Durrant
Juan Quintela

1. QEMU Leadership Committee

The Leadership Committee represents QEMU in the Software Freedom
Conservancy (the legal home for our project). Generally it doesn't
have much to do as we luckily don't have active legal problems :-)
One of the rules for the committee is that it mustn't have more
than two members employed by the same company at once; since IBM
acquired Red Hat that put them over the two-person limit and we
needed to adjust the membership. Mike Roth has now stepped down,
and Alex Benn=C3=A9e has agreed to take up the now-vacant seat.
I'd like to thank Mike for his past work and Alex for agreeing
to take on the role.
(The full list of members is at https://wiki.qemu.org/Conservancy)

2. Sharing qemu.git/master maintainership duties

Something I've talked about on the list before is that I'd like to
move away from doing all the work on merging pull requests and
wrangling releases, but we hadn't made much forward progress on this.
The concrete next thing we need to do is move the testing of merges
away from my ad-hoc setup onto a proper CI system.

Markus Armbruster told us that Red Hat is willing to help set up the
generic parts of the CI plus builders for the host architectures
they care about. Host architecture/OS maintainers will need to keep
other builders running and triage failures.  Red Hat is interested in
x86, ppc, s390, and aarch64.

There was a discussion of various possible approaches, mostly
centring on patchew vs gitlab, with the consensus being that
we should prefer gitlab unless the issues with running on non-x86
hosts turn out to be unsolvable.

Mike Roth noted that CI/release handling for stable releases is separate
from the testing done for mainline, and the stable release process is
separate from the regular release process. Once we have working
CI on mainline we should look at using the same mechanisms for stable.

I've written up a draft requirements wiki page for the CI work:
 https://wiki.qemu.org/Requirements/GatingCI

3. QEMU Security

We had a general discussion about our current security process,
and various people raised pain points/issues. Most of them were
familiar from the discussion of the previous year...

Daniel Berrang=C3=A9 noted that CVEs are hard to spot upstream.  Some
commits may not contain CVE numbers because the CVEs were filed after
the commit - this makes it hard to be sure your QEMU build is
secure. We could do a better job of documenting project security
issues, as libvirt does.

I (re)raised my view from last year, which is that upstream QEMU
doesn't provide timely stable releases when security issues are
fixed. The practical effect of this is that users are forced to use
distro releases of QEMU, unless they want to take on the large burden
of tracking CVEs and the commits that fix them and rolling their own
versions of QEMU. I think that it would be better as a project for our
users if we provided releases with security fixes (it's what most
projects do), but in practice we don't seem to have anybody who cares
enough to put in the work that would require.

The suggestion was made that we should document on the website what
the purpose/scope of our stable releases is.

4. GPL circumvention via plugins and out-of-process devices

Markus Armbruster noted that we now have several "plugin" like
interfaces, and these raise a risk of a situation where the GPL is
circumvented via proprietary features.  How to resist circumvention?
(Plugin-like interfaces include the "modules" system we have already,
the new "TCG plugins", vhost-user, and usb-redir.)

There was a wide-ranging discussion, and overall we seemed to be mostly
in consensus that the philosophy the project takes is broadly:
 * it's obviously not possible to technically prevent license
   circumvention if somebody really wants to do it
 * we aim to make it require an obvious "this is not something
   we intended you to do" step across a red line
 * we don't want to have the project end up stuck with the pain
   of maintaining a stable ABI while out-of-tree plugin/device/etc
   implementations get all the benefits
 * we'd like to catch end-user accidental attempts to load
   a module/TCG plugin/etc from a mismatched version in a friendlier
   way than just crashing
 * depending on the exact situation, there might be different
   approaches to providing the 'red line', e.g.
    - specifying a clearly limited-purpose API with version-checking
    - including checks that a module/plugin was built against the
      same git hash as the QEMU binary it's used with

Since we now have an increasing number of these 'external interfaces',
Daniel Berrang=C3=A9 agreed to write up some guidelines explaining the
general philosophy.

5. git pull request workflow when there are multi-level sub-maintainers

This one we probably want to discuss on the mailing list, because
it was submitted by Cornelia Huck, but she had to leave the meeting
before we got to this agenda item.

Some starter points from the meeting discussion:

 * most people present seemed to be using the "we don't have
   multilevel submaintainers, usually rebase before sending pull" flow

 * as the person doing merges of pullreqs, I don't much care
   what the submaintainer's workflow is, as long as it doesn't
   produce a deeply weird git commit graph when merged, and is
   capable of handling "this fails tests, please fix" bounces
   (which in the common workflow are dealt with via 'squash
   in fix and rebase'), preferably without breaking bisection

 * Kevin Wolf notes that although they never made an explicit decision,
   in practice the block layer team has stopped doing multilevel
   submaintainers and instead just has several people sending separate
   pullrequests directly. In the common case, single level is just much
   easier because it requires less coordination (especially when a v2
   pull request is needed).

 * Alex Benn=C3=A9e noted that the Linux kernel development process tends
   to avoid rebasing, on the theory that testing is wasted when trees
   are rebased. However he thought that the distributed testing model
   of Linux gives more weight to the status of a "tested tree branch",
   wherease for QEMU how applicable this is depends on how much
   testing is done at different levels on the PR tree. For us
   if the maintainer re-runs the tests on re-base it is less
   of an issue, as it's unlikely many other people will have done
   much testing on that tree anyway.

 * Various people noted that the 'rebase invalidates testing' idea
   has holes in it of various kinds anyway.

6. Mentorship

Aleksandar Markovic wanted to raise the topic of mentorship as
a skill for QEMU maintainers. There was a general discussion of
things we're doing already (eg the GSOC and Outreachy internships,
the 'bitesized tasks' wiki page) and things we could do.

Aleksandar said he'd write up and share mentoring advice with the
community.
Stefan said he had a link to QEMU internship talk video.

7. Documentation pipeline discussion

Alex Benn=C3=A9e said it would be nice to get our docs (user and
development) being regularly re-generated and nicely hosted on our
infrastructure.  There was general agreement; the blocker has always
been that this requires somebody with interest in the documentation,
time to work on it and also access to the VM which runs out website.

Stefan agreed to create a docs container image to give us a
starting point which we can iterate on. (He's now posted some
patches to the list which do this; thanks!)

We intend to move to rST and Sphinx.  Perhaps the biggest obstacle is
converting qemu-doc.texi and its prerequisites, such as the Texinfo
embedded into the *.hx, and the Texinfo generated from QAPI schema doc
comments.

Markus said he would be okay with making the QAPI doc generator
generate rST instead of Texinfo, but lacked the bandwidth to do it
himself.

Paolo said he'd investigated a document flow where we (temporarily)
had a tool (Pandoc) which converted rST to Texinfo so we could
gradually convert parts of qemu-doc.texi to rST while still building
that document with Texinfo.

I said that I would prefer it if we could avoid the sort of
long-drawn-out changeover that that approach implies, and that
although there is a fair amount of text to convert in qemu-doc,
it would be better to try to just make it a release goal to
do the conversion. If we start with a skeleton of the new
documentation, we can then convert portions of the documentation.
During the transition we'll effectively have two 'manuals'
on the same topic with some info in one and some in the other.

thanks
-- PMM

