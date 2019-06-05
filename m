Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E1EC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB2B2083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB2B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYaAS-0004HF-HO
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 13:57:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYa9e-0003yB-10
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYa9b-0005Z6-TQ
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:56:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hYa9b-0005Uy-Kg
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:56:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BC6BC05B00E;
	Wed,  5 Jun 2019 17:56:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 793F56199A;
	Wed,  5 Jun 2019 17:56:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 46E9911386A0; Wed,  5 Jun 2019 19:56:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
References: <20190529143106.11789-1-lvivier@redhat.com>
	<87a7ewp4h4.fsf@dusky.pond.sub.org>
	<4601cfa8-732a-3063-7106-da8d3b990410@redhat.com>
Date: Wed, 05 Jun 2019 19:56:41 +0200
In-Reply-To: <4601cfa8-732a-3063-7106-da8d3b990410@redhat.com> (Laurent
	Vivier's message of "Wed, 5 Jun 2019 15:58:29 +0200")
Message-ID: <87v9xjlxuu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 05 Jun 2019 17:56:45 +0000 (UTC)
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
Cc: =?utf-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> writes:

> On 05/06/2019 15:05, Markus Armbruster wrote:
>> Laurent Vivier <lvivier@redhat.com> writes:
>> 
>>> Add a new RNG backend using QEMU builtin getrandom function.
>>>
>>> v7: rebase on master
>>>     Make rng-builtin asynchronous with QEMUBH (removed existing R-b)
>> 
>> Pardon the ignorant question: why is that necessary?
>> 
>
> Because request_entropy() function is called while the request is not in
> the requests queue, so the loop on !QSIMPLEQ_EMPTY(&s->parent.requests)
> doens't process it. The request is added just after the call.

In rng_backend_request_entropy().  I see.  Any particular reason for
this order?  "I don't know" is an acceptable answer :)

