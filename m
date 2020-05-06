Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0747C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95045214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMiGTQpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95045214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWMQs-0000aE-Mr
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 11:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWMPy-0007vH-J6
 for qemu-devel@nongnu.org; Wed, 06 May 2020 11:57:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49722
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWMPw-0004DH-F4
 for qemu-devel@nongnu.org; Wed, 06 May 2020 11:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588780623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+TMGCDYFMQDQHhAHC4nM0k55f8ZpjUDsqA39MHbiTUM=;
 b=BMiGTQpYW7fkxUQsyFuTJnt2KfoHlr8HVp0hUYkvx7Z/viV8KbGZR5UUGtHxW5/x58vtUm
 qgiMt0KtbyLRgqYvLel9KeBysvbfvUUPOZJTDjYdW+7Zm/9mhaZNvrzHx2NGQp+Dm3/3RT
 mCtLi87FGTS3UlUkFYi14tT0W0Tx3gw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-ZO3F7TG1NX6oVYT84oO3QA-1; Wed, 06 May 2020 11:57:01 -0400
X-MC-Unique: ZO3F7TG1NX6oVYT84oO3QA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82A7F460;
 Wed,  6 May 2020 15:57:00 +0000 (UTC)
Received: from gondolin (ovpn-112-211.ams2.redhat.com [10.36.112.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE1C860619;
 Wed,  6 May 2020 15:56:58 +0000 (UTC)
Date: Wed, 6 May 2020 17:56:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v4 3/6] vfio-ccw: Add support for the schib region
Message-ID: <20200506175656.53f60dc1.cohuck@redhat.com>
In-Reply-To: <20200505125757.98209-4-farman@linux.ibm.com>
References: <20200505125757.98209-1-farman@linux.ibm.com>
 <20200505125757.98209-4-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 14:57:54 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
> 
> The schib region can be used to obtain the latest SCHIB from the host
> passthrough subchannel. Since the guest SCHIB is virtualized,
> we currently only update the path related information so that the
> guest is aware of any path related changes when it issues the
> 'stsch' instruction.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v1->v2:
>      - Remove silly variable intialization, and add a block comment,
>        to css_do_stsch() [CH]
>      - Add a TODO statement to s390_ccw_store(), for myself to sort
>        out while we go over kernel code more closely [CH/EF]
>      - In vfio_ccw_handle_store(),
>         - Set schib pointer once region is determined to be non-NULL [CH]
>         - Return cc=0 if pread() fails, and log an error [CH]
>     
>     v0->v1: [EF]
>      - Change various incarnations of "update chp status" to
>        "handle_store", to reflect the STSCH instruction that will
>        drive this code
>      - Remove temporary variable for casting/testing purposes in
>        s390_ccw_store(), and add a block comment of WHY its there.
>      - Add a few comments to vfio_ccw_handle_store()
> 
>  hw/s390x/css.c              | 13 ++++++--
>  hw/s390x/s390-ccw.c         | 21 +++++++++++++
>  hw/vfio/ccw.c               | 63 +++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/css.h      |  3 +-
>  include/hw/s390x/s390-ccw.h |  1 +
>  target/s390x/ioinst.c       |  3 +-
>  6 files changed, 99 insertions(+), 5 deletions(-)
> 
(...)
>  
> +static IOInstEnding vfio_ccw_handle_store(SubchDev *sch)
> +{
> +    S390CCWDevice *cdev = sch->driver_data;
> +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> +    SCHIB *schib = &sch->curr_status;
> +    struct ccw_schib_region *region = vcdev->schib_region;
> +    SCHIB *s;
> +    int ret;
> +
> +    /* schib region not available so nothing else to do */
> +    if (!region) {
> +        return IOINST_CC_EXPECTED;
> +    }
> +
> +    memset(region, 0, sizeof(*region));
> +    ret = pread(vcdev->vdev.fd, region, vcdev->schib_region_size,
> +                vcdev->schib_region_offset);
> +
> +    if (ret == -1) {
> +        /*
> +         * Device is probably damaged, but store subchannel does not
> +         * have a nonzero cc defined for this scenario.  Log an error,
> +         * and presume things are otherwise fine.

One thing we might do is set the device number valid bit to 0 in our
local copy and inject a (subchannel) crw. Maybe as a patch on top later.

> +         */
> +        error_report("vfio-ccw: store region read failed with errno=%d", errno);
> +        return IOINST_CC_EXPECTED;
> +    }
> +
> +    /*
> +     * Selectively copy path-related bits of the SCHIB,
> +     * rather than copying the entire struct.
> +     */
> +    s = (SCHIB *)region->schib_area;
> +    schib->pmcw.pnom = s->pmcw.pnom;
> +    schib->pmcw.lpum = s->pmcw.lpum;
> +    schib->pmcw.pam = s->pmcw.pam;
> +    schib->pmcw.pom = s->pmcw.pom;
> +
> +    if (s->scsw.flags & SCSW_FLAGS_MASK_PNO) {
> +        schib->scsw.flags |= SCSW_FLAGS_MASK_PNO;
> +    }
> +
> +    return IOINST_CC_EXPECTED;
> +}
> +

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


