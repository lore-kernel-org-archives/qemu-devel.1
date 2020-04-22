Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F835C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A03C2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ginuSkIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A03C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRDhb-0006at-Gv
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 07:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jRDgK-0005bv-QB
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jRDgJ-0001Xj-LB
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:36:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32125
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jRDgJ-0001TH-2i
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587555401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/WPtODJnwBrvrCU+KBjAcDgYGsADC/9mSI3pg8Wnc4=;
 b=ginuSkIXxw1emuUstLbUf38/+8roofWv47KMlhAtGL182ObKwDBowJtvJI2EipqlYAKJJ4
 WvvOEcBCK2HjUv6JJoCJkwYoLDs+DZYezDCeR/qeTFPNtg9pckSTCNqXhM4kA8hrbQIFMp
 1m5UlrE71YIN2Szet89z7D6jYEzXDz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-tZgbxgPQOBGbIFK7ogvM6w-1; Wed, 22 Apr 2020 07:36:39 -0400
X-MC-Unique: tZgbxgPQOBGbIFK7ogvM6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46C2A107ACC4;
 Wed, 22 Apr 2020 11:36:38 +0000 (UTC)
Received: from gondolin (ovpn-112-195.ams2.redhat.com [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CE985C1B2;
 Wed, 22 Apr 2020 11:36:36 +0000 (UTC)
Date: Wed, 22 Apr 2020 13:36:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v3 3/7] vfio-ccw: Add support for the schib region
Message-ID: <20200422133600.6fa4d6ac.cohuck@redhat.com>
In-Reply-To: <20200417023440.70514-4-farman@linux.ibm.com>
References: <20200417023440.70514-1-farman@linux.ibm.com>
 <20200417023440.70514-4-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Fri, 17 Apr 2020 04:34:36 +0200
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
>  hw/s390x/s390-ccw.c         | 28 +++++++++++++++++
>  hw/vfio/ccw.c               | 63 +++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/css.h      |  3 +-
>  include/hw/s390x/s390-ccw.h |  1 +
>  target/s390x/ioinst.c       |  3 +-
>  6 files changed, 106 insertions(+), 5 deletions(-)
> 

> +IOInstEnding s390_ccw_store(SubchDev *sch)
> +{
> +    S390CCWDeviceClass *cdc = NULL;
> +    int ret = IOINST_CC_EXPECTED;
> +
> +    /*
> +     * This only applies to passthrough devices, so we can't unconditionally
> +     * set this variable like we would for halt/clear.
> +     *
> +     * TODO from Conny on v1:
> +     *   "We have a generic ccw_cb in the subchannel structure for ccw
> +     *    interpretation; would it make sense to add a generic callback
> +     *    for stsch there as well?
> +     *
> +     *   "(This works fine, though. Might want to add the check for
> +     *    halt/clear as well, but that might be a bit overkill.)"

Do you plan to look into that for the next version? If not, don't feel
pressured.

> +     */
> +    if (object_dynamic_cast(OBJECT(sch->driver_data), TYPE_S390_CCW)) {
> +        cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
> +    }
> +
> +    if (cdc && cdc->handle_store) {
> +        ret = cdc->handle_store(sch);
> +    }
> +
> +    return ret;
> +}
> +
>  static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
>                                    char *sysfsdev,
>                                    Error **errp)

Generally, looks sane.


