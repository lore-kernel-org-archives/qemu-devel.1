Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558AFC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 15:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4B020409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7Bwg/KW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4B020409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijPHP-0002SO-8g
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 10:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1ijPGe-0001ya-KQ
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 10:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1ijPGY-0005rJ-Qx
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 10:05:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27583
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1ijPGY-0005qy-Iv
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 10:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577113501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pULnbLhVX3winYpXFET7CS5edoBmcPCOBHE5gwt4b6Y=;
 b=E7Bwg/KWS4pI2ijVluoQxBap5t6iGRLiKTfoflhxcfarKWXI7NFuKocY6+0cxjXFm0sOaE
 RpkgQXm3hhVHJjxbKL50lCC7ww1L01gRYzSSyMhBbNzMrMpDUEKq0Fg7gEL/OJDhKXafVT
 iWbqPYJMcE2oOHO1WXm9IodUanX85HY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-jVett3H4OPSvJYkuS-pxsw-1; Mon, 23 Dec 2019 10:04:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38C021856A60;
 Mon, 23 Dec 2019 15:04:58 +0000 (UTC)
Received: from [10.40.204.64] (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEF2F60BA0;
 Mon, 23 Dec 2019 15:04:47 +0000 (UTC)
Subject: Re: Making QEMU easier for management tools and applications
To: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Message-ID: <c445ecbe-1559-462a-31c2-f44f60e60a8b@redhat.com>
Date: Mon, 23 Dec 2019 16:04:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <87h81unja8.fsf@dusky.pond.sub.org>
Content-Language: sk-SK
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jVett3H4OPSvJYkuS-pxsw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/21/19 10:02 AM, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
> 


>> 4. Go and Rust bindings would also be useful.  There is
>> https://github.com/intel/govmm but I think it makes sense to keep it
>> in qemu.git and provide an interface similar to our Python modules.
> 
> Mapping QAPI/QMP commands and events to function signatures isn't hard
> (the QAPI code generator does).  Two problems (at least):
> 
> 1. Leads to some pretty ridiculous functions.  Here's one:
> 
>     void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
>                              const char *device,
>                              const char *target,
>                              bool has_replaces, const char *replaces,
>                              MirrorSyncMode sync,
>                              bool has_speed, int64_t speed,
>                              bool has_granularity, uint32_t granularity,
>                              bool has_buf_size, int64_t buf_size,
>                              bool has_on_source_error,
>                              BlockdevOnError on_source_error,
>                              bool has_on_target_error, BlockdevOnError on_target_error,
>                              bool has_filter_node_name, const char *filter_node_name,
>                              bool has_copy_mode, MirrorCopyMode copy_mode, 
>                              bool has_auto_finalize, bool auto_finalize,
>                              bool has_auto_dismiss, bool auto_dismiss,
>                              Error **errp);
> 
>   We commonly use 'boxed': true for such beasts, which results in
>   functions like this one:
> 
>     void qmp_blockdev_add(BlockdevOptions *arg, Error **errp);
> 
> 2. Many schema changes that are nicely backward compatible in QMP are
>    anything but in such an "obvious" C API.  Adding optional arguments,
>    for instance, or changing integer type width.  The former is less of
>    an issue with 'boxed': true.
> 
> Perhaps less of an issue with dynamic languages.
> 
> I figure a static language would need much more expressive oomph than C
> to be a good target.  No idea how well Go or Rust bindings can work.

This is something that bothered me for a while now. Even though it's not
as bad as it used to be because we are not adding so much wrappers for
monitor commands as we used to. I mean, in libvirt the wrapper for a
monitor command has to be written by hand. Worse, whenever I'm adding a
wrapper I look at the QMP schema of it and let my muscle memory write
the wrapper.

However, it's not only what Markus already mentioned. Even if we
generated wrappers by a script, we need to be able to generate wrappers
for every single supported version of qemu.

For instance, if qemu version X has a command that accepts some set of
arguments and this set changes in version X+1 then libvirt needs both
wrappers and decides at runtime (depending on what version it is talking
to) what wrapper to use.

Unfortunately, I don't see any easy way out.

Michal


