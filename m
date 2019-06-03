Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9985DC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735E1250BB
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735E1250BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34449 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXm48-0004XU-GH
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:27:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hXm3F-0004BT-7R
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hXm3E-0007lS-7Y
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:26:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hXm3E-0007kX-2P
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:26:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CDB9356FE;
	Mon,  3 Jun 2019 12:26:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-223.ams2.redhat.com
	[10.36.117.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 908FF61994;
	Mon,  3 Jun 2019 12:26:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 22F2D11386A0; Mon,  3 Jun 2019 14:26:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190531192429.GH22103@habkost.net>
	<93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com>
Date: Mon, 03 Jun 2019 14:26:49 +0200
In-Reply-To: <93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com> (John Snow's
	message of "Fri, 31 May 2019 18:06:37 -0400")
Message-ID: <871s0asvli.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 03 Jun 2019 12:26:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Deprecation policy and build dependencies
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-?= =?utf-8?Q?Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 5/31/19 3:24 PM, Eduardo Habkost wrote:
>> Long story short: I would really like to drop support for Python
>> 2 in QEMU 4.1.

The sooner, the better, as far as I'm concerned.

>> What exactly prevents us from doing this?  Does our deprecation
>> policy really apply to build dependencies?
>> 
>
> Normally I'd say it's only nice to also follow the depreciation policy
> for tooling as well to give people a chance to switch away, but with
> regards to Python2, I feel like we're in the clear to drop it for the
> first release that will happen after the Python2 doomsday clock.
>
> (So, probably 4.2.)

In addition to our feature deprecation policity, we have a "Supported
build platforms" policy (commit 45b47130f4b).  The most common holdback
is this one:

    For distributions with long-lifetime releases, the project will aim
    to support the most recent major version at all times. Support for
    the previous major version will be dropped 2 years after the new
    major version is released. For the purposes of identifying supported
    software versions, the project will look at RHEL, Debian, Ubuntu
    LTS, and SLES distros. Other long-lifetime distros will be assumed
    to ship similar software versions.

RHEL-7 has Python 3 only in EPEL.  RHEL-8 came out last month.  Unless
we interpret our policy to include EPEL, this means supporting Python 2
for some 16 months after upstream Python retires it.  My personal
opinion: nuts.

I didn't bother checking Debian, Ubuntu LTS and SLES.

For hosts other than Linux, we're less ambitious.

