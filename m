Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AA7C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 18:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33DB8206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 18:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DB8206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48259 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYao1-0003TB-7p
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 14:38:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hYamV-0002dr-2K
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hYamT-0008Qr-CF
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:37:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hYamT-0008Pd-6D
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:37:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84C923092669;
	Wed,  5 Jun 2019 18:36:59 +0000 (UTC)
Received: from [10.40.204.44] (ovpn-204-44.brq.redhat.com [10.40.204.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19EFB1001DD1;
	Wed,  5 Jun 2019 18:36:52 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
References: <20190529143106.11789-1-lvivier@redhat.com>
	<87a7ewp4h4.fsf@dusky.pond.sub.org>
	<4601cfa8-732a-3063-7106-da8d3b990410@redhat.com>
	<87v9xjlxuu.fsf@dusky.pond.sub.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <adf9f2b2-931d-01ac-ed44-99aac169b89e@redhat.com>
Date: Wed, 5 Jun 2019 20:36:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87v9xjlxuu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 05 Jun 2019 18:36:59 +0000 (UTC)
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
Cc: "=?UTF-8?Q?Daniel_P.Berrang=c3=a9?=" <berrange@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/06/2019 19:56, Markus Armbruster wrote:
> Laurent Vivier <lvivier@redhat.com> writes:
> 
>> On 05/06/2019 15:05, Markus Armbruster wrote:
>>> Laurent Vivier <lvivier@redhat.com> writes:
>>>
>>>> Add a new RNG backend using QEMU builtin getrandom function.
>>>>
>>>> v7: rebase on master
>>>>     Make rng-builtin asynchronous with QEMUBH (removed existing R-b)
>>>
>>> Pardon the ignorant question: why is that necessary?
>>>
>>
>> Because request_entropy() function is called while the request is not in
>> the requests queue, so the loop on !QSIMPLEQ_EMPTY(&s->parent.requests)
>> doens't process it. The request is added just after the call.
> 
> In rng_backend_request_entropy().  I see.  Any particular reason for
> this order?  "I don't know" is an acceptable answer :)
> 

Yes...

and there is a reason:

in rng_random_request_entropy(), QSIMPLEQ_EMPTY() is used to know if we
have to register an fd handler with qemu_set_fd_handler().

For me, it seemed easier to use QEMUBH rather than to change the
existing algorithm, as the backend has been thought to be asynchronous.

Thanks,
Laurent




