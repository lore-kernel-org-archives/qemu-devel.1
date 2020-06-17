Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C74C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE68214DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1IzeFr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE68214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlefk-0000jH-Dx
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 16:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jleez-0000D0-KZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:27:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jleew-0002NL-Gr
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592425665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E7Iw0to8hZhWCYuPy8jifwnSWnI0oXdmmz12eq/HxMk=;
 b=L1IzeFr6MC3GcUofkZZb95ombO6Wr8BBoUzkF1UJRN973MKhRe5EwRqXd+dnMGJUtacLc6
 hDDv0hd4I0ZeX0sFejF9ma16ZTXMhUw5vvR1MCYS7S7BNuN7LYuMsaB+9+7IB09gpAi65B
 +wkKVGtAxNyE/pQDhm8pYqfIbWeMULo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-5_XnfT0WP7CIEqvviyf88w-1; Wed, 17 Jun 2020 16:27:41 -0400
X-MC-Unique: 5_XnfT0WP7CIEqvviyf88w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8615964AD0;
 Wed, 17 Jun 2020 20:27:40 +0000 (UTC)
Received: from [10.10.117.188] (ovpn-117-188.rdu2.redhat.com [10.10.117.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E52B5C1D4;
 Wed, 17 Jun 2020 20:27:36 +0000 (UTC)
Subject: Re: [PATCH 0/7] python: create installable package
To: Cleber Rosa <crosa@redhat.com>
References: <20200603001523.18085-1-jsnow@redhat.com>
 <20200617195241.GA434320@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <32791435-4aa4-7eaa-e2c6-b53165f2e28d@redhat.com>
Date: Wed, 17 Jun 2020 16:27:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200617195241.GA434320@localhost.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/17/20 3:52 PM, Cleber Rosa wrote:
> On Tue, Jun 02, 2020 at 08:15:16PM -0400, John Snow wrote:
>> Based-on: 20200602214528.12107-1-jsnow@redhat.com
>>
>> This series factors the python/qemu directory as an installable
>> module. As a developer, you can install this to your virtual environment
>> and then always have access to the classes contained within without
>> needing to wrangle python import path problems.
>>
> 
> First of all, major kudos for picking up this task.  It's so high in
> importance to so many users (myself included) that I feel like I owe
> you many truck loads of beers now. :)
> 

Mostly I just wanted to formalize mypy, pylint, flake8 et al across the
most important python bits in our tree so that when making changes for
testing it's easier to verify that I didn't break something else.

Easiest way to get the right structure that these tools expect is to
make a real package ...

So here we are. And also Philippe asked nicely.

>> When developing, you could go to qemu/python/ and invoke `pipenv shell`
>> to activate a virtual environment within which you could type `pip
>> install -e .` to install a special development version of this package
>> to your virtual environment. This package will always reflect the most
>> recent version of the source files in the tree.
>>
>> When not developing, you could install a version of this package to your
>> environment outright to gain access to the QMP and QEMUMachine classes
>> for lightweight scripting and testing.
>>
>> This package is formatted in such a way that it COULD be uploaded to
>> https://pypi.org/project/qemu and installed independently of qemu.git
>> with `pip install qemu`, but of course that button remains unpushed.
>>
>> There are a few major questions to answer first:
>>
>> - What versioning scheme should we use? See patch 2.
>>
>> - Should we use a namespace package or not?
>>   - Namespaced: 'qemu.machine', 'qemu.monitor' etc may be separately
>>     versioned, packaged and distributed packages. Third party authors
>>     may register 'qemu.xxx' to create plugins within the namespace as
>>     they see fit.
>>
>>   - Non-namespaced: 'qemu' is one giant glob package, packaged and
>>     versioned in unison. We control this package exclusively.
>>
> 
> For simplicity sake, I'd suggest starting with non-namespaced
> approach.  It should be easier to move to a namespaced package if the
> need arises.  Also, there are many ways to extend Python code without
> necessarily requiring third party authors to register their packages
> according to a namespace.
> 
> In the Avocado project, we have been using setuptools entrypoints with
> a reasonable level of success.  Anyone can have code under any
> namespace whatsoever extending Avocado, as long as it register their
> entrypoints.
> 

It's not (from my POV) very complex to do a namespace. I have some plans
to move e.g. qapi into qemu.qapi, and some of our other tools into
qemu.tools.

Some of these packages can be published externally, some can remain in
the tree.

but -- maybe namespaces ARE complicating matters in ways I don't
understand yet. I'll be open about it. The thought was mostly about
keeping flexibility with just installing the bits and pieces that you
want/need.

>> - How do we eliminate sys.path hacks from the rest of the QEMU tree?
>>   (Background: sys.path hacks generally impede the function of static
>>   code quality analysis tools like mypy and pylint.)
>>
>>   - Simplest: parent scripts (or developer) needs to set PYTHONPATH.
>>
>>   - Harder: Python scripts should all be written to assume package form,
>>     all tests and CI that use Python should execute within a VENV.
>>
> 
> Having a venv is desirable, but it's not really necessary.  As long as
> "python setup.py develop --user" is called, that user can access this
> code without sys.path hacks.  And if the user chooses to use a venv,
> it's just an extra step.
> 

whether a venv or a user installation, it's the same thing, really: the
user needs to set up and be in that environment to use the python tools
in the tree.

Once we're there, we may as well formalize the VENV to make it easier to
set up and use.

> In the Avocado project, we have a `make develop` rule that does that
> for the main setup.py file, and for all plugins we carry on the same
> tree, which is similar in some regards to the "not at the project root
> directory" situation here with "qemu/python/setup.py".
> 

Ah, yeah. If we're going this far, I'd prefer using a VENV over
modifying the user's environment. That way you can blast it all away
with a `make distclean`.

Maybe the "make develop" target could even use the presence of a .venv
directory to know when it needs to make the environment or not ...

>>   In either case, we lose the ability (for many scripts) to "just run" a
>>   script out of the source tree if it depends on other QEMU Python
>>   files. This is annoying, but as the complexity of the Python lib
>>   grows, it is unavoidable.
>>
> 
> Like I said before, we may introduce a "make develop"-like
> requirement, but after that, I don't think we'll loose anything.
> Also, I think this is just a sign of maturity.  We should be using
> Python as it's inteded to be used, and sys.path hacks is not among
> those.
> 

Joking nitpick: There is no intended way to use Python! :)

Still, the sys.path hacks -- worse than being "unpythonic", actively
seem to get in the way of pylint, flake8, mypy et al which do provide us
with legitimate and serious value.

So, sad to say, but we might lose the ability to run these python
scripts ad-hoc out of the tree (with no setup) in order to gain a more
robust python CI regime.

I think it's a fair trade-off, but we'll see if that's born out in review.

>>   In the VENV case, we at least establish a simple paradigm: the scripts
>>   should work in their "installed" forms; and the rest of the build and
>>   test infrastructure should use this VENV to automatically handle
>>   dependencies and path requirements. This should allow us to move many
>>   of our existing python scripts with "hidden" dependencies into a
>>   proper python module hierarchy and test for regressions with mypy,
>>   flake8, pylint, etc.
>>
>>   (We could even establish e.g. Sphinx versions as a dependency for our
>>   build kit here and make sure it's installed to the VENV.)
>>
>>   Pros: Almost all scripts can be moved under python/qemu/* and checked
>>   with CQA tools. imports are written the same no matter where you are
>>   (Use the fully qualified names, e.g. qemu.core.qmp.QMPMessage).
>>   Regressions in scripts are caught *much* faster.
>>
>>   Downsides: Kind of annoying; most scripts now require you to install a
>>   devkit forwarder (pip3 install --user .) or be inside of an activated
>>   venv. Not too bad if you know python at all, but it's certainly less
>>   plug-n-play.
>>
>> - What's our backwards compatibility policy if we start shipping this?
>>
>>   Proposed: Attempt to maintain API compatibility (after stabilizing the
>>   library). Incompatible changes should probably cause a semver bump.
>>
>>   Each published release makes no attempt to support any version of QEMU
>>   other than the one it was released against. We publish this on the tin
>>   in big red letters.
> 
> It may be too early to tell, but it's not clear to me how we'll keep
> both the QEMU version supported by a given release, and its API
> "level".
> 
> Are you proposing that we have, say, "python-qemu" version 10, being
> the 10th API version, without any regard to the QEMU version
> supported?  Or version 10.5.3 would mean 10th API version, intended
> to support QEMU 5.3?
> 

I am proposing only that we use semver to track the API version of the
SDK itself.

So that could be:

A) 1.x, 2.x, 3.x (etc) with absolutely no connection to the intended
QEMU support version. It either works or it doesn't. It might not work
very spectacularly. Major semver bumps indicate a breaking change to the
library API.

B) 1.5.0.0, 1.5.1.0, 1.5.2.0 (etc) where the major version still
describes the API, but the remainder of the version describes the
intended target QEMU.

Or, we could do:

C) 5.0.0, 5.1.0, 5.2.0, etc. where it tracks the QEMU version verbatim,
end of story.


I don't like (C) very much, because it violates some prevailing idioms
about python package versioning. A or B seem better, but do run us into
potential trouble with people having mismatched versions.

I'd take A or B. (B) is a little chatty but gives some good information
and allows you to pin versions effectively, so I think I'm leaning
towards that one right now.

Well, whatever we do right now, I think I do really want to make sure we
are publishing under 0.x to really give the illustration that we are NOT
promising even the illusion of stability right now.

>>
>> TESTING THIS PACKAGE OUT:
>>
>> 1. You can install to your local user's environment normally by
>> navigating to qemu/python/ and typing "pip3 install --user ."
>>
> 
> s/install/develop/ should be a better option here.  I mean, I'm
> not aware of any reason to user install while developing.
> 

I tried to make note to the develop case in several places; for the
purposes of this email I wanted to demonstrate what installing and using
it as a user would look like.

For those unaware of the distinction:

- install does a real bona-fide installation.
- develop installs a forwarder package that references the living
development files, so the package contents (but NOT its metadata!) are
always up to date with your development files.

For QEMU developers, installing with develop is going to be the smart
way to go. When your git tree is updated, your package will be updated
along with it. You can do it once and then probably forget about it.

> - Cleber.
> 



