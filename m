Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD191C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 03:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91ED722CED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 03:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91ED722CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3B7g-0005vJ-M5
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 23:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i3B6J-0004zo-Hz
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 23:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i3B6F-0002Ta-Jq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 23:27:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i3B6F-0002T6-C4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 23:27:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A1B25AFD9;
 Thu, 29 Aug 2019 03:27:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-242.rdu2.redhat.com
 [10.10.123.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5351F600C1;
 Thu, 29 Aug 2019 03:27:48 +0000 (UTC)
Date: Wed, 28 Aug 2019 23:27:46 -0400
From: Cleber Rosa <crosa@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190829032746.GA488@localhost.localdomain>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190829015117.GH16342@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829015117.GH16342@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 29 Aug 2019 03:27:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
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
Cc: ldoktor@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 29, 2019 at 11:51:17AM +1000, David Gibson wrote:
> On Thu, Aug 29, 2019 at 11:31:25AM +1000, David Gibson wrote:
> > If I attempt to run "make check-acceptance" on my POWER9, RHEL8.1
> > machine when the openssl-devel package isn't installed, I get the
> > following very cryptic error:
> > 
> >   VENV    /home/dwg/qemu/build/rhel8/tests/venv
> >   PIP     /home/dwg/qemu/tests/requirements.txt
> > Command "/home/dwg/qemu/build/rhel8/tests/venv/bin/python -u -c "import setuptools, tokenize;__file__='/tmp/pip-build-la4el5r5/cryptography/setup.py';f=getattr(tokenize, 'open', open)(__file__);code=f.read().replace('\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install --record /tmp/pip-1efs22iz-record/install-record.txt --single-version-externally-managed --compile --install-headers /home/dwg/qemu/build/rhel8/tests/venv/include/site/python3.6/cryptography" failed with error code 1 in /tmp/pip-build-la4el5r5/cryptography/
> > 
> > Using V=1 doesn't give any more useful information, and it's not
> > (easily) possible to manually re-run the given command since it relies
> > on things in /tmp that are removed once the attempt finishes.
> > 
> > I only figured out it was openssl-devel being missing that was the
> > problem by (mostly) guesswork.  It would be really great if we could
> > generate a more helpful error here.
> > 
> > In addition, if I rerun "make check-acceptance" it no longer even
> > attempts the PIP install, since tests/venv already exists in my build
> > environment.  It then sort of works, but I think it might be hitting
> > other errors because of the missing python packages.  Sorry that's a
> > bit vague - I also seem to be getting unrelated errors that I'm still
> > trying to figure out.
> 
> Fwiw, I also get an equally cryptic error that I haven't figured out
> the cause for on my 32-bit Fedora container environment:
> 
>   VENV    /home/dwg/src/qemu/build/i386/tests/venv
>   PIP     /home/dwg/src/qemu/tests/requirements.txt
>   Failed building wheel for bcrypt
> Could not build wheels for bcrypt which use PEP 517 and cannot be installed directly
> You are using pip version 19.0.3, however version 19.2.3 is available.
> You should consider upgrading via the 'pip install --upgrade pip' command.
>

This is certainly caused by pip not being able to install paramiko on
those systems.  I have dealt with paramiko (and its many dependencies)
before on the avocado remote runner plugin (which is not being used
here) and it was not fun.

My personal goal was to rely on the ssh binary as an ssh client, which
should be more ubiquitous, and with that I added a simple wrapper to
Avocado:

  https://avocado-framework.readthedocs.io/en/71.0/api/utils/avocado.utils.html#module-avocado.utils.ssh

I guess we should consider changing the (few) tests that require
paramiko to use that module instead.

> In this case the check definitely doesn't work - it doesn't appear to
> have installed avocado in the venv.
> 
>   AVOCADO tests/acceptance
> /home/dwg/src/qemu/build/i386/tests/venv/bin/python: No module named avocado
>

My hope is that with pure Python modules in requirements.txt, failures
will be much harder to come by.  Either way, it'd be nice to improve
the venv creation, at the very least add a cleanup if it fails to
complete successfully.

As a workaround I'd suggest two things:

 1) remove paramiko from requirements.txt
 2) set the env var CONTINUOUS_INTEGRATION=1 before running `make
    check-acceptace` (the tests in linux_ssh_mips_malta.py check for
    that and don't run if it's set).

But, we'll need to address those failures definitely ASAP.  Anyway,
thanks for reporting it.

- Cleber.

> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



