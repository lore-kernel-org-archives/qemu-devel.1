Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA40C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76D42168B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76D42168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLOr-0003pl-Gj
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iFKqx-0000bF-95
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iFKqw-0005G2-0l
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:18:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iFKqq-00058z-4M; Tue, 01 Oct 2019 12:18:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B72F3082231;
 Tue,  1 Oct 2019 16:18:10 +0000 (UTC)
Received: from [10.3.116.201] (ovpn-116-201.phx2.redhat.com [10.3.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F19FF614CD;
 Tue,  1 Oct 2019 16:17:50 +0000 (UTC)
Subject: Re: [PATCH v4 04/31] error: auto propagated local_err
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b797bece-495e-b254-ba18-a5e444168491@redhat.com>
Date: Tue, 1 Oct 2019 11:17:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001155319.8066-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 01 Oct 2019 16:18:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, pburton@wavecomp.com, peter.maydell@linaro.org,
 codyprime@gmail.com, jasowang@redhat.com, mark.cave-ayland@ilande.co.uk,
 mdroth@linux.vnet.ibm.com, kraxel@redhat.com, sundeep.lkml@gmail.com,
 qemu-block@nongnu.org, quintela@redhat.com, arikalo@wavecomp.com,
 mst@redhat.com, armbru@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 joel@jms.id.au, marcandre.lureau@redhat.com, rth@twiddle.net,
 farman@linux.ibm.com, ehabkost@redhat.com, sw@weilnetz.de, groug@kaod.org,
 yuval.shaia@oracle.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, clg@kaod.org, stefanha@redhat.com, david@redhat.com,
 jsnow@redhat.com, david@gibson.dropbear.id.au, kwolf@redhat.com,
 integration@gluster.org, berrange@redhat.com, andrew@aj.id.au,
 cohuck@redhat.com, qemu-s390x@nongnu.org, mreitz@redhat.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 10:52 AM, Vladimir Sementsov-Ogievskiy wrote:
> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
> functions with errp OUT parameter.
> 
> It has three goals:
> 
> 1. Fix issue with error_fatal & error_prepend/error_append_hint: user
> can't see this additional information, because exit() happens in
> error_setg earlier than information is added. [Reported by Greg Kurz]
> 
> 2. Fix issue with error_abort & error_propagate: when we wrap
> error_abort by local_err+error_propagate, resulting coredump will
> refer to error_propagate and not to the place where error happened.
> (the macro itself doesn't fix the issue, but it allows to [3.] drop all
> local_err+error_propagate pattern, which will definitely fix the issue)
> [Reported by Kevin Wolf]
> 
> 3. Drop local_err+error_propagate pattern, which is used to workaround
> void functions with errp parameter, when caller wants to know resulting
> status. (Note: actually these functions could be merely updated to
> return int error code).
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

I'm still hoping Markus gets some review time for this series with a 
chance to speak up (and that we haven't been causing you a lot of work 
which would all have to change if Markus has a different viewpoint).

Reviewed-by: Eric Blake <eblake@redhat.com>

> +/*
> + * ERRP_AUTO_PROPAGATE
> + *
> + * This macro is created to be the first line of a function with Error **errp
> + * OUT parameter. It's needed only in cases where we want to use error_prepend,
> + * error_append_hint or dereference *errp. It's still safe (but useless) in
> + * other cases.
> + *
> + * If errp is NULL or points to error_fatal, it is rewritten to point to a
> + * local Error object, which will be automatically propagated to the original
> + * errp on function exit (see error_propagator_cleanup).
> + *
> + * After invocation of this macro it is always safe to dereference errp
> + * (as it's not NULL anymore) and to append hints (by error_append_hint)

Maybe: 'to append information (by error_prepend or error_append_hint)'

> + * (as, if it was error_fatal, we swapped it with a local_error to be
> + * propagated on cleanup).
> + *
> + * Note: we don't wrap the error_abort case, as we want resulting coredump
> + * to point to the place where the error happened, not to error_propagate.
> + */
> +#define ERRP_AUTO_PROPAGATE() \
> +g_auto(ErrorPropagator) __auto_errp_prop = {.errp = errp}; \
> +errp = ((errp == NULL || *errp == error_fatal) ? \
> +    &__auto_errp_prop.local_err : errp)
> +
>   /*
>    * Special error destination to abort on error.
>    * See error_setg() and error_propagate() for details.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

