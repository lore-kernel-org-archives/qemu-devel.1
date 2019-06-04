Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8546C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FC5248CB
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FC5248CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46063 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY289-0005Kc-PM
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 01:37:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hY22s-0001wH-GZ
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hY22r-0001sG-CF
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:31:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hY22r-0001qw-78
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C4CD308795D;
	Tue,  4 Jun 2019 05:31:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 651A35D9CC;
	Tue,  4 Jun 2019 05:31:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E996A11386A0; Tue,  4 Jun 2019 07:31:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190531192429.GH22103@habkost.net>
	<93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com>
	<871s0asvli.fsf@dusky.pond.sub.org>
	<236db86d-52df-5537-4f33-f3c09bbb6289@redhat.com>
	<CAFEAcA_bSzWYu5Oa_knq2SAK9Z3RN3LZjxeirVncgRQ9FsDZXA@mail.gmail.com>
	<b4de3161-7b9c-debc-a652-21832612ebf4@redhat.com>
	<CAFEAcA-+2Csn4wW8xLaogJrQiqc2xHrGKFc_zdaOMKNn-yas9g@mail.gmail.com>
Date: Tue, 04 Jun 2019 07:31:29 +0200
In-Reply-To: <CAFEAcA-+2Csn4wW8xLaogJrQiqc2xHrGKFc_zdaOMKNn-yas9g@mail.gmail.com>
	(Peter Maydell's message of "Mon, 3 Jun 2019 19:27:00 +0100")
Message-ID: <87lfyhq5la.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 04 Jun 2019 05:31:36 +0000 (UTC)
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 3 Jun 2019 at 19:21, John Snow <jsnow@redhat.com> wrote:
>> I get it, we don't want to require Python 3.8 because some dev wanted
>> assignment conditionals -- but we're talking about Python 2 here, which
>> suffers its EOL by the end of this calendar year.

"Not because some dev wanted assignment conditionals" is the non-reason.
Let me spell out the reason: supporting Python 2 is expensive for us.
As the amount of Python code grows, it gets more and more expensive.

Is this really time and effort well spent?

>> So do we think it's reasonable to drop support for Python2 for the
>> release that comes out after Python2's EOL, or do we insist on 2x3
>> simultaneous support for years more?
>
> I don't have a strong opinion on Python in particular, but
> I think it would be nicer to avoid the "python is a special
> snowflake" effect.

Lots of things are nice.  Limited resources dictate we can only get some
of them.

>                    Would it really be so bad for it to just
> be "drop it when it falls off the last LTS distro" like the
> rest of our dependencies ?

In my experience maintaining and evolving the QAPI generators,
supporting both Python 2 and 3 is a constant distraction that adds up
over time.  It's all manual; we decided against adopting one of tool
chains made for dealing with this mess.  I'd rather think about how to
solve real user problems like deprecation information or command line
introspection than deal with Python 2 vs. 3 arcana.

Just the other day, I flagged an innocent-looking simplification of some
non-QAPI Python code that changed semantics subtly on Python 2, impact
unknown.  The developer did not know.  The fact that I waste precious
brain capacity on knowing this shit (pardon my French) is a bloody
shame.  Well, some of this shit, because I've screwed it up myself, too.

The sooner we stop the bleeding, the better.

