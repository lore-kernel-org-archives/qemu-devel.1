Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D26C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 777BB20657
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8kvwK6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777BB20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2AA-0006xZ-LM
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jb29a-0006Pe-6R
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:19:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21089
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jb29Y-0006v3-9a
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589894366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=jinL+HnWJAKXdqCuprSyF/QjD1cJgHBFDW9kBWjpKS8=;
 b=O8kvwK6JGKbNllkeJAzbWP4gtA+V4pBGBDg3LMtiqAavhDxutEW6GHYeVXZ0T4UP539XNE
 zhv0H5bIZWpXwPfWVnr7WyBNQQU5nhJW4yEP4hKPm0kwRCXbO5KdtbEjzvAgBCTmUNFo6B
 K/8Vn2xf+Y1VSr8HQs24GmWZBTHi/ho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471--XnGdbHROrSmPQlEqKqFow-1; Tue, 19 May 2020 09:19:25 -0400
X-MC-Unique: -XnGdbHROrSmPQlEqKqFow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EF58100A621;
 Tue, 19 May 2020 13:19:24 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-76.ams2.redhat.com [10.36.114.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 410846109E;
 Tue, 19 May 2020 13:19:22 +0000 (UTC)
Subject: Re: [PATCH v3] docs/s390x: document vfio-ccw
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
References: <20200518075522.97643-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <73ebd9a0-f173-efed-c9b1-1ec30ead90b3@redhat.com>
Date: Tue, 19 May 2020 15:19:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200518075522.97643-1-cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/05/2020 09.55, Cornelia Huck wrote:
> Add a basic example for passing a dasd via vfio-ccw.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> v2->v3: moved uuid generation (Thomas)
> 
> ---
>  docs/system/s390x/vfio-ccw.rst | 77 ++++++++++++++++++++++++++++++++++
>  docs/system/target-s390x.rst   |  1 +
>  2 files changed, 78 insertions(+)
>  create mode 100644 docs/system/s390x/vfio-ccw.rst
> 
> diff --git a/docs/system/s390x/vfio-ccw.rst b/docs/system/s390x/vfio-ccw.rst
> new file mode 100644
> index 000000000000..fff23d9afff7
> --- /dev/null
> +++ b/docs/system/s390x/vfio-ccw.rst
> @@ -0,0 +1,77 @@
> +Subchannel passthrough via vfio-ccw
> +===================================
> +
> +vfio-ccw (based upon the mediated vfio device infrastructure) allows to
> +make certain I/O subchannels and their devices available to a guest. The
> +host will not interact with those subchannels/devices any more.
> +
> +Note that while vfio-ccw should work with most non-QDIO devices, only ECKD
> +DASDs have really been tested.
> +
> +Example configuration
> +---------------------
> +
> +Step 1: configure the host device
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +As every mdev is identified by a uuid, the first step is to obtain one::
> +
> +  [root@host ~]# uuidgen
> +  7e270a25-e163-4922-af60-757fc8ed48c6
> +
> +Note: it is recommended to use the ``mdevctl`` tool for actually configuring
> +the host device.
> +
> +To define the same device as configured below to be started
> +automatically, use
> +
> +::
> +
> +   [root@host ~]# driverctl -b css set-override 0.0.0313 vfio_ccw
> +   [root@host ~]# mdevctl define -u 7e270a25-e163-4922-af60-757fc8ed48c6\

Maybe add a space before the backslash?

> +                  -p 0.0.0313 -t vfio-ccw_io -a
> +
> +If using ``mdevctl``  is not possible or wanted, follow the manual procedure
> +below.

Nit: Doubled whitespaces after mdevctl. With that fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


