Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7DAC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC44220883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC44220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41285 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhUb-0004wb-Qu
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:10:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hVhTl-0004aU-49
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hVhTg-0006fM-VD
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:09:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1hVhTg-0006eV-Ku
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:09:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76E1C81E05;
	Tue, 28 May 2019 19:09:24 +0000 (UTC)
Received: from [10.18.17.187] (dhcp-17-187.bos.redhat.com [10.18.17.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8E7821972A;
	Tue, 28 May 2019 19:09:23 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA_-DptTwe7dkbZ171HJ+DtXCAOKt08pja=4-QbQKJSEvQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
	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
Message-ID: <6382a25f-6af4-5ceb-5750-b23c5f053a48@redhat.com>
Date: Tue, 28 May 2019 15:09:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_-DptTwe7dkbZ171HJ+DtXCAOKt08pja=4-QbQKJSEvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 28 May 2019 19:09:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Sketch of a transition of QEMU docs to Sphinx
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
	"Daniel P. Berrange" <berrange@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/21/19 2:56 PM, Peter Maydell wrote:
> Currently we have a vague plan that we should migrate our
> documentation away from Texinfo to using Sphinx, plus some isolated
> bits of documentation already in .rst format. This email is an attempt
> to sketch out a transition plan for getting us from where we are today
> to where (I think) we want to be.
> 
> 
> WHERE WE ARE TODAY
> ------------------
> 
> I'm going to concentrate on the documentation that's installed by
> 'make install', because anything else is for developers only, making
> it lower priority to clean up and more amenable to messing around with
> anyway.
> 

To an extent, I'd like to emphasize that our "users" are increasingly
developers from other projects and these internal docs are primarily
useful for this crowd.

> Currently we install:
> 
> - in $DESTDIR/usr/local/share/doc/qemu:
>  qemu-doc.html
>  qemu-ga-ref.html
>  qemu-qmp-ref.html
>  qemu-doc.txt
>  qemu-ga-ref.txt
>  qemu-qmp-ref.txt
>  interop/  (the only Sphinx manual we currently ship)
> 

Oh, but this is exactly what I was referencing above, so nevermind.

> - in $DESTDIR/usr/local/share/man/:
>  man1/qemu.1
>  man1/qemu-img.1
>  man1/virtfs-proxy-helper.1
>  man1/qemu-trace-stap.1
>  man8/qemu-ga.8
>  man8/qemu-nbd.8
>  man7/qemu-block-drivers.7
>  man7/qemu-cpu-models.7
>  man7/qemu-ga-ref.7
>  man7/qemu-qmp-ref.7
> (possibly I missed one or two files, because what we install
> depends on configure options and maybe my test build-n-install
> didn't build everything we might ship.)
> 
> 
> This documentation is generated from a mix of:
> 
> - hand-written texinfo:
>  qemu-doc.texi (a top level file with both content and @include directives)
>  qemu-deprecated.texi
>  qemu-ga.texi
>  qemu-img.texi
>  qemu-nbd.texi
>  qemu-option-trace.texi
>  qemu-tech.texi
>  docs/security.texi
>  docs/qemu-cpu-models.texi
>  docs/qemu-block-drivers.texi
>  docs/interop/qemu-ga-ref.texi
>  docs/interop/qemu-qmp-ref.texi
>  fsdev/virtfs-proxy-helper.texi
>  scripts/qemu-trace-stap.texi
> - texinfo sections extracted from *.hx files by hxtool
> - texinfo autogenerated from json by qapi-gen.py
> 
> (The .html and .txt files are generated from the texinfo directly; the
> manpages via texi2pod and pod2man, which effectively create the
> manpages from marked-up subsqections of the input texi.)
> 
> WHERE WE WANT TO BE
> -------------------
> 
> (This is based on the manual split outlined at the top of
> https://wiki.qemu.org/Features/Documentation which I am assuming we
> have general consensus for. NB that IMHO everything else on that
> wiki page except the first part explaining the manual structure
> is now out of date.)
> 
> - in $DESTDIR/usr/local/share/doc/qemu:
>  interop/ sphinx manual
>  system/ sphinx manual (system emulation user's guide)
>  user/ sphinx manual (user-mode emulation user's guide)
>  specs/ sphinx manual (guest hardware etc specs)
>  plus maybe text versions of these (interop.txt, system.txt, etc)
> 
> - in $DESTDIR/usr/local/share/man/:
>  the same set of manpages we have currently
> 
> - not actually installed:
>  devel/ sphinx manual
> 
> Sphinx supports a "plain text" output format, which will create a
> one-big-text-file for each of the four installed manuals. It might
> also be possible to generate some kind of "one .txt file per input
> .rst file" format, but that would require a greater amount of messing
> about.  (The sphinx text builder doesn't do this and so you'd need to
> get make to invoke sphinx once per rst file in each manual, which will
> be awkward.) Or we could just say "it's 2019, the HTML documentation
> is the official format, that (and manpages) is what we ship". Opinions?
> 

I am not sure what the value in plaintext Sphinx docs are, since they
lose the hyperlinks ... unless you keep it in ReST or Markdown format,
and then you could just install the source documents, no?

I just seem to think that most of the text-only purists are also the
type to already have the source tree checked out somewhere.

As long as we've got HTML + manpages, I think we're doing OK.

> Sphinx supports a "manpage" builder, which I have not yet investigated
> closely but which I'm hoping will do what we need. It works by
> specifying a list of "this .rst becomes this manpage in this
> manpage-section", so we can for instance have the qemu-ga-ref and
> qemu-qmp-ref be subsections of the HTML interop/ manual but also
> pulled out into their own manpages. (It is also possible to make
> sections of a .rst file be output only for particular builders, but
> there seem to be some limitations on it -- notably it filters the
> output but it doesn't affect things like tables of contents for
> formats which have them. I am hoping we can do what we want without it.)
> 
> If there are manpages we currently ship which aren't actually very
> useful and which we could just drop that would be useful to know.
> 
> HOW TO GET THERE FROM HERE
> --------------------------
> 
> Some parts of this are easier than others (in an "everything depending
> on everything else" sense; conversion of documents and writing new
> generate-rst-file backends is obviously a fair amount of work).
> 
> (0) This is all independent of Gabriel's work on generating
> API documentation, because that will just go into the devel/
> manual, and doesn't interact at all with the user-facing manuals.
> 
> (1) qemu-ga-ref and qemu-qmp-ref will become part of the interop/
> manual. This requires:
>  * adding rst-generation support to qapi-gen.py
>  * converting the hand-written texinfo parts to rst
>  * listing those new .rst files in docs/interop/index.rst
>  * makefile runes to create manpages via the 'man' sphinx builder
>    from docs/interop/qemu-ga-ref.rst and qemu-qmp-ref.rst
>  * there is a tests/qapi-schema/doc-good.test.texi which I think
>    is acting as a test of the texi doc generation; this should
>    be converted to test the rst doc generation instead
>  * delete all the old texinfo build machinery, install runes, etc
> 

Good riddance. I assume this also means we need to rewrite the QAPI
comments to use Sphinx-ese instead of Texi-ese.

I think that'd be good, though, because it means we get proper lexing
and parsing on our examples. Especially in places where we
cross-reference; for example -- QMP has this trick where our commands
don't take any arguments themselves but rather define a data type it
expects as input.

In the output manual, this means that we don't document the arguments
near the function, which is awful.

Sphinx can help us cross-reference these things better.

> We could do this as its own patch series which would end up with a
> result that would be fine to ship, even if we don't get any of the
> other manuals converted for a particular QEMU release.  It's the
> easiest part because these docs already have an obvious home in a
> Sphinx manual we're already shipping.
> 
> (2) Any parts of the texi docs which are really "developer docs"
> should be moved into devel/
> 
> This is easy because we don't need to maintain a very coherent manual
> for devel/, we can just have it be a bucket of random documents for
> the moment. In particular:
> 
>  * the qemu-tech.texi "translator internals" section should be moved
>    (I suspect it's a bit out of date so we should add a warning note
>    at the top of the new file about that)
>  * I think we should just delete the "QEMU compared to other emulators"
>    section of qemu-tech.texi (and the accompanying bibliography of URLs)
>    since it hasn't been updated in several years and it's not really
>    documenting QEMU. This sort of general-information stuff would
>    live better on the wiki if we care about it at all.
>  * I don't think there's anything else that's really developer
>    documentation, but I haven't looked too closely
> 
> We could do this now if we wanted, independently of (1).
> 
> (3) Things which are mostly standalone manpages
> 
> Round about here things start to get trickier because we are looking
> at things which are part of the big fat qemu-doc.html.  The easiest
> next pieces to pull out are the ones which are standalone manpages
> which we're also just using @include to stuff into qemu-doc.html:
> 
>  * qemu-ga.texi
>  * qemu-nbd.texi
>  * qemu-img.texi
>  * qemu-cpu-models.texi
>  * qemu-block-drivers.texi
>  * virtfs-proxy-helper.texi
>  * scripts/qemu-trace-stap.texi
> 
> We can:
>  * convert each of these to a .rst file in the right sphinx
>    manual (probably mostly system/)
>  * generate the manpage output using sphinx as we did for qemu-ga-ref etc
>  * just drop the @include from qemu-doc.texi
> 
> qemu-img.texi here will be the tricky one as it uses hxtool to
> generate the texi for the command line option descriptions. I'm
> not sure how best to handle hxtool, because it is really just
> a mechanism for slicing the right fragments out of the input file.
> Perhaps we need to add SRST/ERST directives to match the STEXI/ETEXI
> ones we have at the moment.
> 
> This will result in a slightly "bucket of distinct docs" feel to the
> system/ manual at this point, but these files are all basically mostly
> self-contained, so it wouldn't be too terrible to ship a QEMU in this
> state.
> 
> (4) Everything else
> 
> At this point what we have left is:
>  * qemu-doc.texi itself
>  * qemu-deprecated.texi
>  * docs/security.texi
>  * qemu-option-trace.texi
>  * the leftovers from qemu-tech.texi
>  * the stuff generated via hxtool from hmp-commands-info.hx,
>    hmp-commands.hx and qemu-options.hx
> 
> and we pretty much need to:
>  * convert all that over to rst in the system/ and user/ manuals
>    (perhaps sometimes interop/)
>  * generate the qemu.1 manpage
>  * delete all the leftover machinery
> 
> We could do at least some of this in chunks, but if we had to release
> QEMU midway through this part of the transition we'd have a very weird
> setup where half the core-emulator-docs were in the old html file and
> the other half were in the new style manuals, so we should definitely
> try to avoid doing that.
> 
> PROBLEMS
> --------
> 
> I haven't yet thought through what exactly might turn out
> to be nasty problems with the conversion, and it's getting
> late in the day here, so I leave that part to you :-)
> 
> NB: Sphinx does also have a texinfo output option, but I have
> not used it in this transition, because I suspect it will want
> to output an entire texinfo document rather than a fragment that
> could be included in a larger document, which makes it a bit less
> useful to us. If we think step (4) above is too big-bang then
> we could investigate whether it would be workable to convert
> some files to .rst but then generate .texi from them to include
> in qemu-doc.texi until we're ready to flip everything over to
> directly building html.
> 
> Comments on this whole proposal (whether I've forgotten anything
> about our current setup, whether we really do want to go to the
> place I've suggested we go, etc) welcome.
> 
> thanks
> -- PMM
> 

It looks good to me overall -- any progress towards a unified manual
with automatic checking of any sort is an improvement.

I'll try to keep an eye on it over the summer and see if I can't help
nudge the block layer documents along the path to something unified.
I've written one custom extension now, so what's a few more?

I also wrote a hasty script that tried to unify the qemu-img.texi and
qemu-img help outputs and removed one more usage of the hxtool, but it's
only a stopgap and wasn't something like proper sphinx integration, but
maybe I could keep working in that area soon.

I would also like to say that it would be useful to host our HTML docs
online such that we can point to the different versions, like you can
with the official python docs. They often have a little dropdown where
you can switch between 3.5/3.6/3.7 or so on and see the difference on
that exact page. It'd just simply be nice to be able to do the same for
QMP docs.

--js

