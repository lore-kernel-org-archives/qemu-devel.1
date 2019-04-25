Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550EAC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 17:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67F720717
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 17:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67F720717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJi0M-00041H-2M
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 13:17:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJhyr-0002uB-EW
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJhwt-0002tD-Mg
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:14:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJhwt-0002sl-HA
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:14:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 041E6307D85A;
	Thu, 25 Apr 2019 17:14:13 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8405D705;
	Thu, 25 Apr 2019 17:14:07 +0000 (UTC)
Date: Thu, 25 Apr 2019 14:14:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190425171406.GN18406@habkost.net>
References: <20190425130939.29674-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190425130939.29674-1-stefanha@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 25 Apr 2019 17:14:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] virtio: clarify VirtioPCIDeviceTypeInfo
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
Message-ID: <20190425171406.IwA3dyxqznzYroQ-oBrOsehEC8PQlRcVfOWQvhnlRfo@z>

On Thu, Apr 25, 2019 at 02:09:39PM +0100, Stefan Hajnoczi wrote:
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

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo

