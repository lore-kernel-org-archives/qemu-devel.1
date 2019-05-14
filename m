Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D463CC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9ECF208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9ECF208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47374 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWPZ-0001oy-Vh
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:20:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQWOJ-00019B-AU
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQWOI-0000WC-7w
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:18:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQWOI-0000Uc-0D
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:18:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EC5A3091765;
	Tue, 14 May 2019 12:18:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 900EE5D6A6;
	Tue, 14 May 2019 12:18:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 0E8C511385E4; Tue, 14 May 2019 14:18:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
	<CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
Date: Tue, 14 May 2019 14:18:33 +0200
In-Reply-To: <CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
	(Peter Maydell's message of "Mon, 13 May 2019 14:58:00 +0100")
Message-ID: <877eat6xgm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 14 May 2019 12:18:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 13 May 2019 at 14:21, Markus Armbruster <armbru@redhat.com> wrote:
>> Perhaps I should do it just for this file while I touch it anyway.  The
>> question to ask: should parse_acl_file() obey the locale for whitespace
>> recognition?
>
> I vote for "no".
>
> Q: do we document the format of the ACL file anywhere ?

Support for it was added in commit bdef79a2994, v1.1.  Just code, no
documentation.

Grepping for qemu-bridge-helper finds just qemu-options.hx.  Contains
-help output and some .texi that goes into qemu-doc and the manual page.
None of it mentions how qemu-bridge-helper is run, or the ACL file
feature, let alone what its format might be.

I'm afraid all we have is the commit message.  Which doesn't really
define the file format, it merely gives a bunch of examples.

As far as I can tell, qemu-bridge-helper is for use with -netdev tap and
-netdev bridge.

Both variations of -netdev call net_bridge_run_helper() to run the
helper.  First argument is -netdev parameter "helper", default usually
"$prefix/libexec/qemu-bridge-helper".  Second argument is parameter
"br", default "br0".

If @helper contains space or tab, net_bridge_run_helper() guesses its a
full command, else it guesses its the name of the executable.  Bad
magic.

If it guesses name of executable, it execv()s this executable with
arguments "--use-vnet", "--fd=FD", "--br=@bridge".

If it guesses full command, it appends "--use-vnet --fd=FD", where FD is
the helper's half of the socketpair used to connect QEMU and the helper.
It further appends "--br=@bridge", unless @helper contains "--br=".
More bad magic.

It executes the resulting string with sh -c.  Magic cherry on top.

When the helper fails, netdev creation fails.

The helper we ship with QEMU unconditionally tries to read
"$prefix/etc/bridge.conf".  Fatal error if this file doesn't exist.
Errors in this file are fatal.  Errors in files it includes are not
fatal; instead, the remainder of the erroneous file is ignored.
*Boggle*

As far as I can tell, libvirt runs qemu-bridge-helper itself (Paolo's
commit 2d80fbb14df).  Makes sense, because running QEMU with the
necessary privileges would be unwise, and so would be letting it execute
setuid helpers.  Also bypasses the bad magic in QEMU's
net_bridge_run_helper().

qemu-bridge-helper should have a manual page, and its handling of errors
in ACL include files needs work.  There's probably more; I just glanced
at it.  I'm not volunteering, though.  It lacks a maintainer.  Should we
add it to Jason's "Network device backends"?

-netdev's helper parameter is seriously underdocumented.  Document or
deprecate?

