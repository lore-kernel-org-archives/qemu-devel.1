Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E033C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 18:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE9B21019
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 18:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmwJw6RA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE9B21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT9xe-00032G-G0
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 14:58:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT9w8-0001wT-G4
	for qemu-devel@nongnu.org; Tue, 21 May 2019 14:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT9w6-0001sb-KQ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 14:56:32 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:45010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT9w6-0001rm-Ca
	for qemu-devel@nongnu.org; Tue, 21 May 2019 14:56:30 -0400
Received: by mail-oi1-x229.google.com with SMTP id z65so13605944oia.11
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=4h3SAUA+Fm6Y0OLcNBQS7K5ksf9eUQfpq7crGuHz7Iw=;
	b=UmwJw6RABwqj5/kjdhB09GVtW+Jt9EH32A5xlMYpuyf63qTV1zQjsY9NmbHtwGfh9G
	GHkCEW0GmWU6mZZWl9a8zNRRghnJ5WkWih+KEKWwaQe5/aqdIBkJoI0mrh/kLUX02feY
	BKkhARCkdfFH6QO1uqdQX5JsCCNzXiNq/cWjcB/RBabbo62pjQDADQA3fxIUhW4uNmmL
	Elrgq2Md1NDJyeNzGYfggFi0S4bpF/r/k4d11nSNkBufCB9LGsvqeBE79m7X9UogjBV7
	/uEauZHIBiW4DOFWCKATgV0gKeI4V9mfP2+z1rK0FRK6dNt3J2iN0pbdcudQ+A/XK8Cr
	vHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=4h3SAUA+Fm6Y0OLcNBQS7K5ksf9eUQfpq7crGuHz7Iw=;
	b=FREXFf/reGYniID3Yuc61ElQV0ZCkcX8HJFSlgDrvGFdUQ8JFdd5xHXKjICWyDkq0D
	l0T4VijAA60AowBs/4U3rwykKGu6yWM2XjXqrEDP0SlRsNB0oJtsMowwLuvyk4aFfefH
	OmjtZ+jmrmzio8/WVnpt5O4SS2MVzIzZQ2hEtx1r+wIC4Nn+rcA+dCHfIm6arGIVTiLt
	7PAuJJ8NgIpGrECOqyGoZePNc2Iax0l1ZSPALpi58mS7JWEepF+ugh0uCxvdtg+5jpeA
	5LNGdg3yfWSJZ19GrG351gp2YQwIPXHNMT+h33EFIDRjYQMzDiJx25CoJ4uVr6eODFBX
	MOOw==
X-Gm-Message-State: APjAAAXkS+RSwUR9dbKcEwnVLWuHsUtUWXHmDFLRLkHBXPECDheavTn/
	mLJoqnP+dNID9DKULYI/PyIUcQhcEQXIWDo3Aep0Kwc3fVg=
X-Google-Smtp-Source: APXvYqyvJjRqRZ0T2D9mM6XEcfVlWOyMGVTVLBjPtEjVdiIYpkt3JshjfQgxSLiJinnn7/yVgEUe6/E8PkcbejclNts=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr4601710oib.170.1558464988817; 
	Tue, 21 May 2019 11:56:28 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 19:56:18 +0100
Message-ID: <CAFEAcA_-DptTwe7dkbZ171HJ+DtXCAOKt08pja=4-QbQKJSEvQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: [Qemu-devel] Sketch of a transition of QEMU docs to Sphinx
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently we have a vague plan that we should migrate our
documentation away from Texinfo to using Sphinx, plus some isolated
bits of documentation already in .rst format. This email is an attempt
to sketch out a transition plan for getting us from where we are today
to where (I think) we want to be.


WHERE WE ARE TODAY
------------------

I'm going to concentrate on the documentation that's installed by
'make install', because anything else is for developers only, making
it lower priority to clean up and more amenable to messing around with
anyway.

Currently we install:

- in $DESTDIR/usr/local/share/doc/qemu:
 qemu-doc.html
 qemu-ga-ref.html
 qemu-qmp-ref.html
 qemu-doc.txt
 qemu-ga-ref.txt
 qemu-qmp-ref.txt
 interop/  (the only Sphinx manual we currently ship)

- in $DESTDIR/usr/local/share/man/:
 man1/qemu.1
 man1/qemu-img.1
 man1/virtfs-proxy-helper.1
 man1/qemu-trace-stap.1
 man8/qemu-ga.8
 man8/qemu-nbd.8
 man7/qemu-block-drivers.7
 man7/qemu-cpu-models.7
 man7/qemu-ga-ref.7
 man7/qemu-qmp-ref.7
(possibly I missed one or two files, because what we install
depends on configure options and maybe my test build-n-install
didn't build everything we might ship.)


This documentation is generated from a mix of:

- hand-written texinfo:
 qemu-doc.texi (a top level file with both content and @include directives)
 qemu-deprecated.texi
 qemu-ga.texi
 qemu-img.texi
 qemu-nbd.texi
 qemu-option-trace.texi
 qemu-tech.texi
 docs/security.texi
 docs/qemu-cpu-models.texi
 docs/qemu-block-drivers.texi
 docs/interop/qemu-ga-ref.texi
 docs/interop/qemu-qmp-ref.texi
 fsdev/virtfs-proxy-helper.texi
 scripts/qemu-trace-stap.texi
- texinfo sections extracted from *.hx files by hxtool
- texinfo autogenerated from json by qapi-gen.py

(The .html and .txt files are generated from the texinfo directly; the
manpages via texi2pod and pod2man, which effectively create the
manpages from marked-up subsqections of the input texi.)

WHERE WE WANT TO BE
-------------------

(This is based on the manual split outlined at the top of
https://wiki.qemu.org/Features/Documentation which I am assuming we
have general consensus for. NB that IMHO everything else on that
wiki page except the first part explaining the manual structure
is now out of date.)

- in $DESTDIR/usr/local/share/doc/qemu:
 interop/ sphinx manual
 system/ sphinx manual (system emulation user's guide)
 user/ sphinx manual (user-mode emulation user's guide)
 specs/ sphinx manual (guest hardware etc specs)
 plus maybe text versions of these (interop.txt, system.txt, etc)

- in $DESTDIR/usr/local/share/man/:
 the same set of manpages we have currently

- not actually installed:
 devel/ sphinx manual

Sphinx supports a "plain text" output format, which will create a
one-big-text-file for each of the four installed manuals. It might
also be possible to generate some kind of "one .txt file per input
.rst file" format, but that would require a greater amount of messing
about.  (The sphinx text builder doesn't do this and so you'd need to
get make to invoke sphinx once per rst file in each manual, which will
be awkward.) Or we could just say "it's 2019, the HTML documentation
is the official format, that (and manpages) is what we ship". Opinions?

Sphinx supports a "manpage" builder, which I have not yet investigated
closely but which I'm hoping will do what we need. It works by
specifying a list of "this .rst becomes this manpage in this
manpage-section", so we can for instance have the qemu-ga-ref and
qemu-qmp-ref be subsections of the HTML interop/ manual but also
pulled out into their own manpages. (It is also possible to make
sections of a .rst file be output only for particular builders, but
there seem to be some limitations on it -- notably it filters the
output but it doesn't affect things like tables of contents for
formats which have them. I am hoping we can do what we want without it.)

If there are manpages we currently ship which aren't actually very
useful and which we could just drop that would be useful to know.

HOW TO GET THERE FROM HERE
--------------------------

Some parts of this are easier than others (in an "everything depending
on everything else" sense; conversion of documents and writing new
generate-rst-file backends is obviously a fair amount of work).

(0) This is all independent of Gabriel's work on generating
API documentation, because that will just go into the devel/
manual, and doesn't interact at all with the user-facing manuals.

(1) qemu-ga-ref and qemu-qmp-ref will become part of the interop/
manual. This requires:
 * adding rst-generation support to qapi-gen.py
 * converting the hand-written texinfo parts to rst
 * listing those new .rst files in docs/interop/index.rst
 * makefile runes to create manpages via the 'man' sphinx builder
   from docs/interop/qemu-ga-ref.rst and qemu-qmp-ref.rst
 * there is a tests/qapi-schema/doc-good.test.texi which I think
   is acting as a test of the texi doc generation; this should
   be converted to test the rst doc generation instead
 * delete all the old texinfo build machinery, install runes, etc

We could do this as its own patch series which would end up with a
result that would be fine to ship, even if we don't get any of the
other manuals converted for a particular QEMU release.  It's the
easiest part because these docs already have an obvious home in a
Sphinx manual we're already shipping.

(2) Any parts of the texi docs which are really "developer docs"
should be moved into devel/

This is easy because we don't need to maintain a very coherent manual
for devel/, we can just have it be a bucket of random documents for
the moment. In particular:

 * the qemu-tech.texi "translator internals" section should be moved
   (I suspect it's a bit out of date so we should add a warning note
   at the top of the new file about that)
 * I think we should just delete the "QEMU compared to other emulators"
   section of qemu-tech.texi (and the accompanying bibliography of URLs)
   since it hasn't been updated in several years and it's not really
   documenting QEMU. This sort of general-information stuff would
   live better on the wiki if we care about it at all.
 * I don't think there's anything else that's really developer
   documentation, but I haven't looked too closely

We could do this now if we wanted, independently of (1).

(3) Things which are mostly standalone manpages

Round about here things start to get trickier because we are looking
at things which are part of the big fat qemu-doc.html.  The easiest
next pieces to pull out are the ones which are standalone manpages
which we're also just using @include to stuff into qemu-doc.html:

 * qemu-ga.texi
 * qemu-nbd.texi
 * qemu-img.texi
 * qemu-cpu-models.texi
 * qemu-block-drivers.texi
 * virtfs-proxy-helper.texi
 * scripts/qemu-trace-stap.texi

We can:
 * convert each of these to a .rst file in the right sphinx
   manual (probably mostly system/)
 * generate the manpage output using sphinx as we did for qemu-ga-ref etc
 * just drop the @include from qemu-doc.texi

qemu-img.texi here will be the tricky one as it uses hxtool to
generate the texi for the command line option descriptions. I'm
not sure how best to handle hxtool, because it is really just
a mechanism for slicing the right fragments out of the input file.
Perhaps we need to add SRST/ERST directives to match the STEXI/ETEXI
ones we have at the moment.

This will result in a slightly "bucket of distinct docs" feel to the
system/ manual at this point, but these files are all basically mostly
self-contained, so it wouldn't be too terrible to ship a QEMU in this
state.

(4) Everything else

At this point what we have left is:
 * qemu-doc.texi itself
 * qemu-deprecated.texi
 * docs/security.texi
 * qemu-option-trace.texi
 * the leftovers from qemu-tech.texi
 * the stuff generated via hxtool from hmp-commands-info.hx,
   hmp-commands.hx and qemu-options.hx

and we pretty much need to:
 * convert all that over to rst in the system/ and user/ manuals
   (perhaps sometimes interop/)
 * generate the qemu.1 manpage
 * delete all the leftover machinery

We could do at least some of this in chunks, but if we had to release
QEMU midway through this part of the transition we'd have a very weird
setup where half the core-emulator-docs were in the old html file and
the other half were in the new style manuals, so we should definitely
try to avoid doing that.

PROBLEMS
--------

I haven't yet thought through what exactly might turn out
to be nasty problems with the conversion, and it's getting
late in the day here, so I leave that part to you :-)

NB: Sphinx does also have a texinfo output option, but I have
not used it in this transition, because I suspect it will want
to output an entire texinfo document rather than a fragment that
could be included in a larger document, which makes it a bit less
useful to us. If we think step (4) above is too big-bang then
we could investigate whether it would be workable to convert
some files to .rst but then generate .texi from them to include
in qemu-doc.texi until we're ready to flip everything over to
directly building html.

Comments on this whole proposal (whether I've forgotten anything
about our current setup, whether we really do want to go to the
place I've suggested we go, etc) welcome.

thanks
-- PMM

