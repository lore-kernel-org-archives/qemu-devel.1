Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686A6C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 05:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91CD2171F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 05:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91CD2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFAqY-0004sk-Sz
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 01:04:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hFApa-0004YI-CX
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hFApZ-0006KW-40
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:03:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hFApW-0006Hh-Oi; Sat, 13 Apr 2019 01:03:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2DB93084242;
	Sat, 13 Apr 2019 05:03:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BE2E05D9CD;
	Sat, 13 Apr 2019 05:03:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 449CB1138648; Sat, 13 Apr 2019 07:03:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
References: <20190412152619.23542-1-thuth@redhat.com>
	<CAFEAcA9kXdUH3vkGLfEe+CFuD=S9XFEaWGNETre7gYOx5epFpQ@mail.gmail.com>
	<7d2fc749-e6ac-7646-8e37-3399d42b6822@redhat.com>
Date: Sat, 13 Apr 2019 07:03:52 +0200
In-Reply-To: <7d2fc749-e6ac-7646-8e37-3399d42b6822@redhat.com> (Thomas Huth's
	message of "Fri, 12 Apr 2019 20:59:12 +0200")
Message-ID: <87sgumh4xz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Sat, 13 Apr 2019 05:03:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/nseries: Deprecate the n800
 and n810 machines
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413050352.sckZUhC-CHu4cDvFKoE-pdbmsSzaEcrv2OLVhI-sEZw@z>

Thomas Huth <thuth@redhat.com> writes:

> On 12/04/2019 18.02, Peter Maydell wrote:
>> On Fri, 12 Apr 2019 at 16:26, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> These machines depend on the deprecated bluetooth subsystem. In case we
>>> finally decide to remove the bluetooth subsystem, we likely need to
>>> remove the n800 and n810 machines, too, so mark them now as deprecated.
>> 
>> ...we could just remove the bluetooth devices from the boards?
>
> Maybe we could. But do we really want to spent time to work on boards
> that likely nobody uses anymore? Or do you know anybody using it?
> (at least Guenter does not seem to use it, according to his list, see
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06125.html )

I think we're far too willing to drag along code of dubious utility.

Deprecation is not a death sentence.  It's a formal notice to users "we
intend to drop this, and now is the time to argue for keeping it".

