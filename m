Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912E7C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E8D21473
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E8D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQXpE-0002g7-HM
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 09:50:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQXoP-0002KF-Ib
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQXoO-0004Gg-L7
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:49:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQXoO-0004Dd-FS
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:49:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BAB53079B92;
	Tue, 14 May 2019 13:49:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B4F441001943;
	Tue, 14 May 2019 13:49:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 31CC411385E4; Tue, 14 May 2019 15:49:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
References: <20190514075602.7674-1-lvivier@redhat.com>
	<20190514075602.7674-2-lvivier@redhat.com>
	<20190514080854.GD17214@paraplu>
	<2c68e2a2-384b-e107-03ff-42d09df558a7@redhat.com>
Date: Tue, 14 May 2019 15:49:27 +0200
In-Reply-To: <2c68e2a2-384b-e107-03ff-42d09df558a7@redhat.com> (Laurent
	Vivier's message of "Tue, 14 May 2019 10:15:31 +0200")
Message-ID: <87woitf8ns.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 14 May 2019 13:49:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/3] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
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
Cc: =?utf-8?Q?Daniel_P=2E_Berran?= =?utf-8?Q?g=C3=A9?= <berrange@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> writes:

> On 14/05/2019 10:08, Kashyap Chamarthy wrote:
>> On Tue, May 14, 2019 at 09:56:00AM +0200, Laurent Vivier wrote:
>>> From: Kashyap Chamarthy <kchamart@redhat.com>
>>>
>>> When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
>>> source of entropy, and that source needs to be "non-blocking", like
>>> `/dev/urandom`.  However, currently QEMU defaults to the problematic
>>> `/dev/random`, which on linux is "blocking" (as in, it waits until
>>
>> OCD nit: s/linux/Linux/
>>
>> Maybe Michael can do the touch up when applying.
>
> A little reminder: this patch can be applied alone, but the followings
> need the series from Richard to be applied first.

I guess you mean
    [PATCH v6 00/25] Add qemu_getrandom and ARMv8.5-RNG etc
    Message-Id: <20190510173049.28171-1-richard.henderson@linaro.org>

You can make the dependency machine-readable by declaring

    Based-on: <20190510173049.28171-1-richard.henderson@linaro.org>

in your cover letter.  Patchew will then test your series on top of
Richard's.

