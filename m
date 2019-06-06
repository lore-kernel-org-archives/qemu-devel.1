Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE302C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 04:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C673D207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 04:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C673D207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYkJe-0004x9-1G
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 00:47:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYkI1-00045Z-2v
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 00:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYkHy-00074s-8i
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 00:46:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hYkHv-0006yR-W5
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 00:46:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96689C18B2CC;
	Thu,  6 Jun 2019 04:45:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 50FAA2E02B;
	Thu,  6 Jun 2019 04:45:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D73D811386A0; Thu,  6 Jun 2019 06:45:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
References: <20190529143106.11789-1-lvivier@redhat.com>
	<87a7ewp4h4.fsf@dusky.pond.sub.org>
	<4601cfa8-732a-3063-7106-da8d3b990410@redhat.com>
	<87v9xjlxuu.fsf@dusky.pond.sub.org>
	<adf9f2b2-931d-01ac-ed44-99aac169b89e@redhat.com>
Date: Thu, 06 Jun 2019 06:45:46 +0200
In-Reply-To: <adf9f2b2-931d-01ac-ed44-99aac169b89e@redhat.com> (Laurent
	Vivier's message of "Wed, 5 Jun 2019 20:36:46 +0200")
Message-ID: <87zhmvjp8l.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 06 Jun 2019 04:45:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 0/4] rng-builtin: add an RNG backend
 that uses qemu_guest_getrandom()
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
Cc: =?utf-8?Q?Daniel_P=2EBerrang?= =?utf-8?Q?=C3=A9?= <berrange@redhat.com>,
	Amit Shah <amit@kernel.org>, Kashyap Chamarthy <kchamart@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	"Richard W . M .
	Jones" <rjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> writes:

> On 05/06/2019 19:56, Markus Armbruster wrote:
>> Laurent Vivier <lvivier@redhat.com> writes:
>> 
>>> On 05/06/2019 15:05, Markus Armbruster wrote:
>>>> Laurent Vivier <lvivier@redhat.com> writes:
>>>>
>>>>> Add a new RNG backend using QEMU builtin getrandom function.
>>>>>
>>>>> v7: rebase on master
>>>>>     Make rng-builtin asynchronous with QEMUBH (removed existing R-b)
>>>>
>>>> Pardon the ignorant question: why is that necessary?
>>>>
>>>
>>> Because request_entropy() function is called while the request is not in
>>> the requests queue, so the loop on !QSIMPLEQ_EMPTY(&s->parent.requests)
>>> doens't process it. The request is added just after the call.
>> 
>> In rng_backend_request_entropy().  I see.  Any particular reason for
>> this order?  "I don't know" is an acceptable answer :)
>> 
>
> Yes...
>
> and there is a reason:
>
> in rng_random_request_entropy(), QSIMPLEQ_EMPTY() is used to know if we
> have to register an fd handler with qemu_set_fd_handler().
>
> For me, it seemed easier to use QEMUBH rather than to change the
> existing algorithm, as the backend has been thought to be asynchronous.

In your shoes, I'd be tempted to explore whether changing the order
simplifies things overall.  I'm not asking you to do that; your patch is
okay as is.

Thanks!

