Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BBDC35642
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C80207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DorupPEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C80207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j558p-0007Ux-Q2
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 05:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j557K-0006K9-J3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j557I-0001FN-Rp
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:01:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44264
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j557I-0001AN-Jg
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582279263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYNYk/ZBzFhuET+UFCiRZYMcZx/AnwFOJuiQ8SK+V4Q=;
 b=DorupPElVpNT/7LNNg8zxF9AtycCt4QPehFWJVH+aZ/9Vi0QhxExafuuqOugPc5NjJa/RJ
 BcqCH/FdQlq93j7jrvXXsqdh7CUWHJ7hFho0I2cpowka3lDkEJlfyfgBDUBlxwGuP6ZJI9
 gUpnPWhjJHLH1B/9sZ0nNMDEvp6FzFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-OKncACr1MHaD8GBYTwfGzQ-1; Fri, 21 Feb 2020 05:01:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FAE2801E53;
 Fri, 21 Feb 2020 10:01:01 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 562BB9182C;
 Fri, 21 Feb 2020 10:00:57 +0000 (UTC)
Date: Fri, 21 Feb 2020 11:00:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v4 16/16] docs: Add protvirt docs
Message-ID: <20200221110054.322d8206.cohuck@redhat.com>
In-Reply-To: <20200220125638.7241-17-frankja@linux.ibm.com>
References: <20200220125638.7241-1-frankja@linux.ibm.com>
 <20200220125638.7241-17-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: OKncACr1MHaD8GBYTwfGzQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 07:56:38 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Lets add some documentation for the Protected VM functionality.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  docs/protvirt.rst | 53 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 docs/protvirt.rst

You'll probably want to add that file to an index as well, so that it
gets built properly.

> 
> diff --git a/docs/protvirt.rst b/docs/protvirt.rst
> new file mode 100644
> index 0000000000..8bfa72be01
> --- /dev/null
> +++ b/docs/protvirt.rst
> @@ -0,1 +1,53 @@
> +Protected Virtualization on s390x
> +========================

Please lengthen the underlining :)

Also, it might improve readability of the text doc if you added an
empty line beneath the headers.

> +The memory and most of the register contents of Protected Virtual
> +Machines (PVMs) are inaccessible to the hypervisor, effectively
> +prohibiting VM introspection when the VM is running. At rest, PVMs are
> +encrypted and can only be decrypted by the firmware of specific IBM Z
> +machines.
> +
> +
> +Prerequisites
> +-------------
> +To run PVMs, you need to have a machine with the Protected
> +Virtualization feature, which is indicated by the Ultravisor Call
> +facility (stfle bit 158). This is a KVM only feature, therefore you
> +need a KVM which is able to support PVMs and activate the Ultravisor
> +initialization by setting "prot_virt=1" on the kernel command line.

`prot_virt=1`, so that it gets rendered as a literal in html?

> +
> +If those requirements are met, the capability "KVM_CAP_S390_PROTECTED"

`KVM_CAP_S390_PROTECTED`

> +will indicate that KVM can support PVMs on that LPAR.
> +
> +
> +QEMU Settings
> +-------------
> +To indicate to the VM that it can move into protected mode, the
> +"Unpack facility" (stfle bit 161) needs to be part of the cpu model of
> +the VM.

Add an example invocation here?

> +
> +All I/O devices need to use the IOMMU.
> +Passthrough devices are currently not supported.

s/Passthrough devices/Passthrough (vfio) devices/ ?

> +
> +Host huge page backings are not supported. The guest however can use
> +huge pages as indicated by its facilities.
> +
> +
> +Boot Process
> +-----------------

Underlining too long :)

> +A secure guest image can be booted from disk and using the QEMU

"can be both booted from..." ?

> +command line. Booting from disk is done by the unmodified s390-ccw
> +BIOS. I.e., the bootmap is interpreted and a number of components is
> +read into memory and control is transferred to one of the components
> +(zipl stage3), which does some fixups and then transfers control to
> +some program residing in guest memory, which is normally the OS
> +kernel. The secure image has another component prepended (stage3a)
> +which uses the new diag308 subcodes 8 and 10 to trigger the transition
> +into secure mode.
> +
> +Booting from the command line requires that the file passed
> +via -kernel has the same memory layout as would result from the disk
> +boot. This memory layout includes the encrypted components (kernel,
> +initrd, cmdline), the stage3a loader and metadata. In case this boot
> +method is used, the command line options -initrd and -cmdline are
> +ineffective.  The preparation of secure guest image is done by a
> +program (name tbd) of the s390-tools package.

Hm... do you have an ETA for that tbd program?


