Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D012BC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 22:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AE42070B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 22:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AE42070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr8IP-0004J8-IW
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 18:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58043)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hr8IE-0003s7-Hd
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 18:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hr8Hx-0000pY-Jv
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 18:02:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hr8Hg-00006t-Kr
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 18:01:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 796AC3083362;
 Fri, 26 Jul 2019 21:16:35 +0000 (UTC)
Received: from localhost (ovpn-116-40.gru2.redhat.com [10.97.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 993F45C70A;
 Fri, 26 Jul 2019 21:16:31 +0000 (UTC)
Date: Fri, 26 Jul 2019 18:16:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190726211626.GG17432@habkost.net>
References: <3dd21116-32ae-3eb2-ffcf-2ba77391ccc3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd21116-32ae-3eb2-ffcf-2ba77391ccc3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 26 Jul 2019 21:16:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Exploring Sphinx, autodoc, apidoc,
 and coverage tools for python/qemu
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gabriel Barreto <sbarreto.gabriel@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CCing Cleber and Gabriel.  Comments at the "conclusions" section
below:

On Wed, Jul 24, 2019 at 05:06:41PM -0400, John Snow wrote:
> Has anyone on this list experimented with these tools?
> 
> I was hoping to use them to document things like the python/machine.py
> and python/qmp.py modules to help demonstrate some of our internal
> tooling API (for test writers, GSoC/Outreachy interns, folks who want to
> script QEMU at a level between writing a CLI driver and using libvirt.)
> 
> What follows below is my process trying to enable this and some of the
> problems I'm still stuck with, summarized below at the end of this more
> exploratory text.
> 
> 
> Enabling autodoc:
> 
> First, it appears as if enabling the "sphinx-autodoc" tool is not
> sufficient for actually generating anything at all when you invoke the
> sphinx-generated "make html" target. It just enables understanding
> certain directives.
> 
> So apparently you need to generate module "stubs" using sphinx-autodoc.
> Sphinx uses the sphinx-autodoc extension to understand how to consume
> the directives in these stubs.
> 
> That strikes me as odd, because these stubs might need to be changed
> frequently as code comes and goes; it seems strange that it isn't
> integrated at the top level. (Do I have the wrong idea on how these
> tools should be used?)
> 
> So you need to run:
> > sphinx-apidoc --separate --module-first -o docs/ python/qemu/
> 
> which generates stubs to docs:
> 
> Creating file docs/qemu.machine.rst.
> Creating file docs/qemu.qmp.rst.
> Creating file docs/qemu.qtest.rst.
> Creating file docs/qemu.rst.
> Creating file docs/modules.rst.
> 
> And then you can edit e.g. the top-level index.rst TOC in docs/index.rst
> to look like this:
> 
> ```
> .. toctree::
>    :maxdepth: 2
>    :caption: Contents:
> 
>    interop/index
>    devel/index
>    specs/index
>    modules
> ```
> 
> And then finally generating the build; manually removing the -W option
> from the Makefile: there are a lot of warnings in here.
> 
> > sphinx-build -n -b html -D version=4.0.92 -D release="4.0.92
> (v4.1.0-rc2-34-g160802eb07-dirty)" -d .doctrees/
> /home/bos/jhuston/src/qemu/docs/ docs/
> 
> Great! that will generate output to docs/index.html which indeed shows
> APIdoc comments generated from our Python files. Good.
> 
> However, where this gets a little strange is if you look at the
> generated stubs. For instance, qemu.machine.rst looks like this:
> 
> ```
> .. automodule:: qemu.machine
>     :members:
>     :undoc-members:
>     :show-inheritance:
> ```
> 
> :undoc-members: says that we want to "document" any members that don't
> have a matching apidoc comment by generating a stub.
> 
> Oops, but the presence of that stub will cause the sphinx coverage tool
> to happily report 100% coverage.
> 
> Further oops, pylint doesn't understand apidoc comments and can't be
> used as the linter in this case, either.
> 
> You can edit the stubs to remove these directives, but these stubs are
> generated -- and it doesn't appear like there's a command line option to
> change this behavior. ...Hmm.
> 
> And either way, the coverage tool only generates a report and not
> something with an error code that I could use to gate the build. Same
> goes for the general build: if I remove the :undoc-members: parameter,
> there's nothing in the autodoc module that appears to throw warnings
> when it encounters undocumented parameters or members.
> 
> That seems disappointing, because it's hard to keep docstrings up to
> date unless they are checked conclusively at build time.
> 
> 
> Conclusions:
> 
> - the autodoc documentation page doesn't seem to document examples of
> how you're expected to write meaningful docstrings for the tool to extract.

I had the same impression when I read sphinx/autodoc
documentation.

> 
> - autodoc fools the coverage tool into reporting 100% coverage.
> 
> - autodoc can be configured to omit non-documented members to allow the
> coverage tool to work, but the configuration is auto-generated and
> defaults to always generating documentation for these entities.
> 
> - coverage tool doesn't appear like it can be used for gating the build
> natively for missing python docs; it only generates a report.
> 
> - Even if we script to block on a non-empty report, the coverage tool
> only works at the function/class level and does not understand the
> concept of missing parameter or return value tags.
> 
> - It would seem that it would be the Autodoc module's job to be
> responsible for understanding incomplete documentation, but doesn't
> appear to. The :param name: syntax is just a ReST "field list" and isn't
> parsed semantically by autodoc, sadly.

I wonder if there are other Python documentation coverage tools
outside Sphinx.  Googling for [python docstring coverage]
resulted in a few different projects, but I don't know which ones
would understand Sphinx-compatible rST docstrings.

> 
> 
> It looks to me, at a glance, that there's nothing in Sphinx that knows
> how to look for and warn about undocumented parameters, exception types,
> return values, etc. Hopefully I've missed something and it is possible.

Personally, my first priority would be generating reasonable
documentation from docstrings, preferably integrated with the
rest of the QEMU docs.  Gating based on docstring coverage checks
would be just nice to have.

-- 
Eduardo

