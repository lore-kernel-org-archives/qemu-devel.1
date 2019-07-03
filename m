Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9D8C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 06:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37162187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 06:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37162187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiYjv-0002h5-GR
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 02:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49125)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiYii-0002Be-9W
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 02:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiYih-0006R2-4s
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 02:26:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hiYie-0006PG-Qc; Wed, 03 Jul 2019 02:26:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 78F2786677;
 Wed,  3 Jul 2019 06:26:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 445FC608A7;
 Wed,  3 Jul 2019 06:26:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C18BA1132ABF; Wed,  3 Jul 2019 08:26:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-3-mehta.aaru20@gmail.com>
 <20190611073653.bfp22e6s4jed2qdx@debian>
 <20190611093250.GO14257@stefanha-x1.localdomain>
Date: Wed, 03 Jul 2019 08:26:05 +0200
In-Reply-To: <20190611093250.GO14257@stefanha-x1.localdomain> (Stefan
 Hajnoczi's message of "Tue, 11 Jun 2019 10:32:50 +0100")
Message-ID: <87pnmry6pu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 03 Jul 2019 06:26:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 02/12] qapi/block-core: add option for
 io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I apologize for replying so late.

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Tue, Jun 11, 2019 at 03:36:53PM +0800, Fam Zheng wrote:
>> On Mon, 06/10 19:18, Aarushi Mehta wrote:
>> > Option only enumerates for hosts that support it.
>> > 
>> > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
>> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > ---
>> >  qapi/block-core.json | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index 1defcde048..db7eedd058 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -2792,11 +2792,13 @@
>> >  #
>> >  # @threads:     Use qemu's thread pool
>> >  # @native:      Use native AIO backend (only Linux and Windows)
>> > +# @io_uring:    Use linux io_uring (since 4.1)
>> >  #
>> >  # Since: 2.9
>> >  ##
>> >  { 'enum': 'BlockdevAioOptions',
>> > -  'data': [ 'threads', 'native' ] }
>> > +  'data': [ 'threads', 'native',
>> > +            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' } ] }
>> 
>> Question: 'native' has a dependency on libaio but it doesn't have the
>> condition.  Is the inconsistency intended?
>
> 'native' could be conditional too but I guess it's a historical thing.
> Either QAPI 'if' didn't exit when BlockdevAioOptions was defined or we
> simply forgot to use it :).

The former.  QAPI supports 'if' in partially since 3.0, and fully since
4.0.

> It doesn't need to be changed in this patch series.

Making the QAPI schema reflect the underlying C code's ifdeffery can
help QMP clients.  Compare:

* query-qmp-schema reports member "native" even when attempting to use
  it will always fail.

* It reports member "io_uring" only when it can work.

This is particularly useful when a QMP client has logic like "do it this
way if X is available, else do it that way".  With accurate
introspection, you can check whether X is available safely and easily.
Without introspection, you'll likely have to try "this way", and if it
fails, figure out why, so you can decide whether to try "that way".
Worse when a multi-step "this way" fails half way through, and you get
to revert its initial steps.

