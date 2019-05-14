Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E100C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A9C208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A9C208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQVdy-0004aX-LZ
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 07:30:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQVZF-0000ih-Jn
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQVZE-0004qd-G2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:25:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQVZE-0004pe-9q
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:25:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06948356FF
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 11:25:55 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 07940608A6;
	Tue, 14 May 2019 11:25:51 +0000 (UTC)
Date: Tue, 14 May 2019 12:25:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190514112548.GB8632@work-vm>
References: <20190329095713.14177-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329095713.14177-1-peterx@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 14 May 2019 11:25:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: comment VMSTATE_UNUSED*()
 properly
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> It is error prone to use VMSTATE_UNUSED*() sometimes especially when
> the size of the migration stream of the field is not the same as the
> size of the structure (boolean is one example).  Comment it well so
> people will be aware of this when people want to use it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Queued

> ---
>  include/migration/vmstate.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index a668ec75b8..9224370ed5 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1035,6 +1035,20 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_BUFFER_UNSAFE(_field, _state, _version, _size)        \
>      VMSTATE_BUFFER_UNSAFE_INFO(_field, _state, _version, vmstate_info_buffer, _size)
>  
> +/*
> + * These VMSTATE_UNUSED*() macros can be used to fill in the holes
> + * when some of the vmstate fields are obsolete to be compatible with
> + * migrations between new/old binaries.
> + *
> + * CAUTION: when using any of the VMSTATE_UNUSED*() macros please be
> + * sure that the size passed in is the size that was actually *sent*
> + * rather than the size of the *structure*.  One example is the
> + * boolean type - the size of the structure can vary depending on the
> + * definition of boolean, however the size we actually sent is always
> + * 1 byte (please refer to implementation of VMSTATE_BOOL_V and
> + * vmstate_info_bool).  So here we should always pass in size==1
> + * rather than size==sizeof(bool).
> + */
>  #define VMSTATE_UNUSED_V(_v, _size)                                   \
>      VMSTATE_UNUSED_BUFFER(NULL, _v, _size)
>  
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

