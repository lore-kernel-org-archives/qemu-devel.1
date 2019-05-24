Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602BAC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3716220851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3716220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57173 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCwc-0003gv-BR
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:21:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hUCsh-0000xo-Lx
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hUCsf-0007Tr-M7
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:17:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hUCsc-0007QY-A5; Fri, 24 May 2019 12:17:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 777A53004159;
	Fri, 24 May 2019 16:17:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1809084F7;
	Fri, 24 May 2019 16:17:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id A003F1138648; Fri, 24 May 2019 18:17:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
	<20190524140337.13415-2-mehta.aaru20@gmail.com>
	<20190524151228.GA31070@stefanha-x1.localdomain>
Date: Fri, 24 May 2019 18:17:03 +0200
In-Reply-To: <20190524151228.GA31070@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Fri, 24 May 2019 16:12:28 +0100")
Message-ID: <87o93r6d4w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 24 May 2019 16:17:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/9] qapi/block-core: add option for
 io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Fri, May 24, 2019 at 07:33:29PM +0530, Aarushi Mehta wrote:
>> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
>> ---
>>  qapi/block-core.json | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 7ccbfff9d0..0e927b247d 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2776,11 +2776,13 @@
>>  #
>>  # @threads:     Use qemu's thread pool
>>  # @native:      Use native AIO backend (only Linux and Windows)
>> +# @io_uring:    Use linux io_uring (only Linux)
>>  #
>> -# Since: 2.9
>> +# Since: 4.1
>
> Please leave "Since: 2.9" unchanged and mark only @io_uring "Since:
> 4.1".  This way users can see that this specific option was added in
> 4.1 and the rest has been available since 2.9.
>
>>  ##
>>  { 'enum': 'BlockdevAioOptions',
>> -  'data': [ 'threads', 'native' ] }
>> +  'data': [ 'threads', 'native',
>> +            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX)' } ] }
>
> What about CONFIG_LINUX_IO_URING?  That way the feature wouldn't be
> advertized on Linux systems that don't offer io_uring.

Yes, please.

Also, drop (only Linux) from the doc comment.  As is, qemu-qmp-ref.txt
looks like this:

     'io_uring'
          Use linux io_uring (only Linux)
          If: 'defined(CONFIG_LINUX)'

> Note that in order to do this you'll need to move the ./configure
> patches before this patch (or squash them into this patch).

