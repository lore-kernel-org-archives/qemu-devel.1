Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9782EC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 17:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E8E2148D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 17:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E8E2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44649 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJLJs-0001cx-PJ
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 13:04:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJLCi-0004RJ-5g
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJL0y-0008Bq-32
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJL0x-0008Ah-TQ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:44:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 993A330A819D;
	Wed, 24 Apr 2019 16:44:53 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE1455D9C8;
	Wed, 24 Apr 2019 16:44:48 +0000 (UTC)
Date: Wed, 24 Apr 2019 13:44:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190424164447.GB18406@habkost.net>
References: <20190424152401.28304-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190424152401.28304-1-stefanha@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 24 Apr 2019 16:44:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] virtio: clarify VirtioPCIDeviceTypeInfo
 usage
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
Cc: sebastien.boeuf@intel.com, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424164447.1Tx9bRhi0FWLkLpmJOZJGNqRjyoBuXpTZe3aYXqjHpA@z>

On Wed, Apr 24, 2019 at 04:24:01PM +0100, Stefan Hajnoczi wrote:
> How to use .base_name, .generic_name, .transitional_name, and
> .non_transitional_name can be confusing.
> 
> Existing devices have .generic_name but its behavior is somewhat magic.
> 
> Devices added to new versions of the VIRTIO specification should forego
> transitional mode completely and always operate in non-transitional mode
> because there are no existing drivers for them that require backwards
> compatibility.
> 
> This patch adds comments that hopefully make it easier for developers to
> decide how to fill out VirtioPCIDeviceTypeInfo.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/virtio/virtio-pci.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 18581854ca..debdee28b3 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -209,7 +209,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
>       * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONAL_PCI_DEVICE,
>       * but PCI Express is supported only in non-transitional mode.
>       *
> -     * The only type implemented by QEMU 3.1 and older.
> +     * The only type implemented by QEMU 3.1 and older.  This type is less
> +     * explicit than the transitional and non-transitional device types.  Its
> +     * behavior can be affected by machine type compat properties.

I'm not sure what you mean here.  All types can be affected by
machine type compat properties when necessary, don't they?

>       */
>      const char *generic_name;
>      /*
> @@ -222,6 +224,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
>       * The non-transitional device type.  Optional.
>       *
>       * Implements INTERFACE_CONVENTIONAL_PCI_DEVICE only.
> +     *
> +     * New virtio device types should only define this and base_name, thereby
> +     * allowing only non-transitional mode.
>       */
>      const char *non_transitional_name;
>  
> -- 
> 2.20.1
> 

-- 
Eduardo

