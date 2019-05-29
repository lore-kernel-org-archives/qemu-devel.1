Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFF5C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 19:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B051240E6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 19:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B051240E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59440 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW3yy-0006rY-SE
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 15:11:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hW3xU-0005vp-LO
	for qemu-devel@nongnu.org; Wed, 29 May 2019 15:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hW3xT-0003uM-Lr
	for qemu-devel@nongnu.org; Wed, 29 May 2019 15:09:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hW3xT-0003tv-Go
	for qemu-devel@nongnu.org; Wed, 29 May 2019 15:09:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E9DA30C3194
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 19:09:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0335F7A012;
	Wed, 29 May 2019 19:09:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id CAA591138648; Wed, 29 May 2019 21:09:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190529150853.9772-1-armbru@redhat.com>
	<20190529150853.9772-3-armbru@redhat.com>
	<84e2792c-3fd3-3236-dc45-83405abb9a12@redhat.com>
	<1ddf4672-eea7-d4de-62ae-930f98f388be@redhat.com>
Date: Wed, 29 May 2019 21:09:48 +0200
In-Reply-To: <1ddf4672-eea7-d4de-62ae-930f98f388be@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed,
	29 May 2019 17:56:03 +0200")
Message-ID: <87d0k1m60z.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 29 May 2019 19:09:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] MAINTAINERS: Improve section headlines
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/29/19 5:16 PM, Eric Blake wrote:
>> On 5/29/19 10:08 AM, Markus Armbruster wrote:
>>> When scripts/get_maintainer.pl reports something like
>>>
>>>     John Doe <jdoe@example.org> (maintainer:Overall)
>>>
>>> the user is left to wonder *which* of our three "Overall" sections
>>> applies.  We have three, one each under "Guest CPU cores (TCG)",
>>> "Guest CPU Cores (KVM)", and "Overall usermode emulation".
>>>
>>> Rename sections under
>>>
>>> * "Guest CPU cores (TCG)" from "FOO" to "FOO CPU cores (TCG)"
>>>
>>> * "Guest CPU Cores (KVM)" from "FOO" to "FOO CPU cores (KVM)"
>>>
>>> * "Guest CPU Cores (Xen)" from "FOO" to "FOO CPU cores (Xen)"
>>>
>>> * "Architecture support" from "FOO" to "FOO general architecture
>>>   support"
>>>
>>> * "Tiny Code Generator (TCG)" from "FOO target" to "FOO TCG target"
>>>
>>> While there,
>>>
>>=20
>> Unintentional truncation? Or leftover thought that should be removed
>> after you instead split things?
>
> leftover :)
>
> "While there, polish headline decorations"

You're reading my distracted mind.

