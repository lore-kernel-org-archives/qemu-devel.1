Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D403C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B0B2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWDJgGAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B0B2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWqO-0003Ci-CB
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEWpk-0002mf-A1
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEWpi-0005G8-UF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:26:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48731)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEWpi-0005FD-RT
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584530758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NICLnaI+grW+6GHiDimf3zsv2HKfTrtvMFGSssU6Oro=;
 b=IWDJgGAykX6Hh3vjdhdeNkmTK+722ins0qPCiO5ORvqOE7Aj0FX1MCqWUbJlxkYRhu40LV
 GlvOAphUoKBXMyB+VxUq+W3ti783RRnntCB4C/XLBkC2LKOeFTQUeMY0Wp2q9v0ysWZb2i
 Jfz/gidUIKYXwzx2WY8yEaM65VZiLn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-wPeEsWYHNyO1zA7Wl0GVog-1; Wed, 18 Mar 2020 07:25:55 -0400
X-MC-Unique: wPeEsWYHNyO1zA7Wl0GVog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDE56800D53;
 Wed, 18 Mar 2020 11:25:53 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC6DD94956;
 Wed, 18 Mar 2020 11:25:49 +0000 (UTC)
Date: Wed, 18 Mar 2020 12:25:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 14/15] docs: Add protvirt docs
Message-ID: <20200318122546.4285aec0.cohuck@redhat.com>
In-Reply-To: <20200311132151.172389-15-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-15-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 09:21:50 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Lets add some documentation for the Protected VM functionality.

s/Lets/Let's/ :)

> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  docs/system/index.rst    |  1 +
>  docs/system/protvirt.rst | 56 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>  create mode 100644 docs/system/protvirt.rst
> 
(...)
> diff --git a/docs/system/protvirt.rst b/docs/system/protvirt.rst
> new file mode 100644
> index 0000000000000000..6c8cf0f7910eae86
> --- /dev/null
> +++ b/docs/system/protvirt.rst
> @@ -0,0 +1,56 @@
> +Protected Virtualization on s390x
> +=================================
> +
> +The memory and most of the registers of Protected Virtual Machines
> +(PVMs) are encrypted or inaccessible to the hypervisor, effectively
> +prohibiting VM introspection when the VM is running. At rest, PVMs are
> +encrypted and can only be decrypted by the firmware, represented by an
> +entity called Ultravisor, of specific IBM Z machines.

Is that specific _generations_ or specific _machines_ (i.e. those with
an appropriate key)? If the latter, maybe add a note that a specific
image is bound to (a) specific machine(s)?


> +
> +
> +Prerequisites
> +-------------

Also, maybe add

"Running PVMs requires using the KVM hypervisor."

?

> +
> +To run PVMs a machine with the Protected Virtualization feature
> +which is indicated by the Ultravisor Call facility (stfle bit

maybe s/which is/as/ ?

> +158) is required. The Ultravisor needs to be initialized at boot by
> +setting `prot_virt=1` on the kernel command line.
> +
> +If those requirements are met, the capability `KVM_CAP_S390_PROTECTED`
> +will indicate that KVM can support PVMs on that LPAR.
> +
> +
> +QEMU Settings
> +-------------
> +
> +To indicate to the VM that it can transition into protected mode, the
> +`Unpack facility` (stfle bit 161 represented by the feature
> +`S390_FEAT_UNPACK`) needs to be part of the cpu model of the VM.
> +
> +All I/O devices need to use the IOMMU.
> +Passthrough (vfio) devices are currently not supported.
> +
> +Host huge page backings are not supported. However guests can use huge
> +pages as indicated by its facilities.
> +
> +
> +Boot Process
> +------------
> +
> +A secure guest image can either be loaded from disk or supplied on the
> +QEMU command line. Booting from disk is done by the unmodified
> +s390-ccw BIOS. I.e., the bootmap is interpreted, multiple components
> +are read into memory and control is transferred to one of the
> +components (zipl stage3). Stag3 does some fixups and then transfers

s/Stag3/Stage3/

> +control to some program residing in guest memory, which is normally
> +the OS kernel. The secure image has another component prepended
> +(stage3a) that uses the new diag308 subcodes 8 and 10 to trigger the
> +transition into secure mode.
> +
> +Booting from the image supplied via the QEMU command line requires
> +that the file passed via -kernel has the same memory layout as would
> +result from the disk boot. This memory layout includes the encrypted
> +components (kernel, initrd, cmdline), the stage3a loader and
> +metadata. In case this boot method is used, the command line
> +options -initrd and -cmdline are ineffective. The preparation of a PVM
> +image is done by genprotimg of the s390-tools package.

"is done via the `genprotimg` tool from the s390-tools collection"

?


