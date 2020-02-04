Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC54C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7373C2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7373C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0Y1-0007BL-KL
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@pond.sub.org>) id 1iz0XQ-0006hB-C3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@pond.sub.org>) id 1iz0XO-0003dp-OU
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:54:56 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3]:39262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@pond.sub.org>) id 1iz0XO-0003PU-Em
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:54:54 -0500
Received: from blackfin.pond.sub.org (p4FD0571C.dip0.t-ipconnect.de
 [79.208.87.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 50156715C3;
 Tue,  4 Feb 2020 16:54:51 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BDA4A11386A7; Tue,  4 Feb 2020 16:54:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Summary of Re: Making QEMU easier for management tools and
 applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
Date: Tue, 04 Feb 2020 16:54:48 +0100
Message-ID: <875zgm2vqv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:13b:3ad0:1::3
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This thread has accumulated more than a hundred messages over seven
weeks.  We need a summary.

The conversation has gone in several directions.  In this message, I'll
cover just the one I consider most important: machine-friendly initial
configuration.  I'll do the rest later, if I have stamina left.

= QMP is fine for machines, CLI is not =

We have two major external host interfaces: the CLI and QMP.  Compare:

QMP
* Purpose: control at run-time
* Commands with argument and return value
* Events with argument value
* Simple type system
* Based on QAPI
* Regular, well-defined syntax: QAPI schema on top of JSON
* Documentation is required; actual documentation is of mixed quality
* Introspectable, except for a few mostly QOM-related holes where we
  bypass QAPI
* Machine-friendly, complemented by human-only HMP

CLI
* Purpose: initial configuration
* Options with argument
* Based on a crazy zoo of QemuOpts (with and without dotted keys), QAPI
  (only a few recent options), ad hoc parsers
* Option argument syntax is mostly (variations of) key=value,...
* QemuOpts' "type system" is "list of key-value pairs, where value can
  be string, bool, (unsigned) integer, or size", optionally restricted
  to known keys with known value types.
* QAPI type system is the same as in QMP
* Introspection is completely inadequate: misses options, incorrect
  option names, misses option arguments partly or completely
* Configuration files with INI-like syntax, completely inadequate: can't
  do most options
* Not machine-friendly
* Maintaining it is a pain, evolving it is worse

The inadequacy of the CLI has become a serious issue.

= Ways to provide machine-friendly initial configuration =

Two ways to provide machine-friendly initial configuration on par with
QMP have been proposed:

1. Extend QMP

   Machines use the CLI only to configure a QMP socket.  The remainder
   of the CLI becomes human-only, with much relaxed compatibility rules.

2. QAPIfy the CLI

   Provide a machine-friendly CLI based on QAPI and JSON.  The current
   CLI becomes human-only, with much relaxed compatibility rules.

   Aside: I looked into cleaning up the human-only CLI at the same time,
   but the need to maintain compatibility until the transition to the
   machine-friendly CLI is complete makes this hard.  It needs to be
   cleaned up, though.  More on that below.

To extend QMP, we wrap QMP commands around the internal initial
configuration interfaces.  These QMP commands take arguments, but don't
return anything.  Many of them will only make sense during initial
configuration.  We'll want to express that in the schema, and enforce it
in the QMP core.  Others will behave differently, e.g. cold plug during
initial configuration, hot plug once the guest runs.

Configuration files are just QMP commands from the initial configuration
subset read from a file instead of a chardev.  JSON is a poor choice for
configuration files, and QMP's verbosity makes it poorer.  We'll want
more suitable concrete syntax for configuration files.

To improve the CLI, we wrap QAPI-based CLI options around the internal
initial configuration interfaces.  We'll want some infrastructure to
generate CLI option boilerplate, just like we generate QMP command
boilerplate.

Configuration files are just CLI options read from a file instead of
argv[].  Again, we'll want a more suitable concrete syntax there.

With an improved CLI, I'd expect machines to use configuration files so
they don't have to mess with shell quoting.  With extended QMP, they'd
perhaps rather reuse their existing QMP code to send the configuration
down a socket.  Less efficient, but I doubt it'll matter.

In both cases, the internal configuration interfaces need to be
converted from QemuOpts to QAPI types.

The one clear advantage of extending QMP is the ability to mix query
commands with initial configuration.

This is also a clear disadvantage: we need to make it work.  Existing
QMP commands may rely on initial configuration to be complete.  We may
have to allow only QMP commands we carefully checked.

How important is the advantage?

= Cleaning up the human-only CLI =

In both cases, the existing CLI remains in a human-only role.  That's a
truckload of messy code to maintain.  Not good.  Can we replace it by
thin wrappers around the machine-friendly alternative, ideally
incrementally?  Can we generate a useful part of these wrappers?

If we QAPIfy the CLI, the QAPI generator already knows the CLI, and only
has to be taught the general human-friendly key=value,... syntax, plus a
way to specify exceptions.

If we extend QMP, we'll additionally need some of the CLI QAPIfication
infrastructure for this.  Hmm.

