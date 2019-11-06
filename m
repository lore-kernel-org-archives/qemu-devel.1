Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C2AC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A163217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ix+fP6vC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A163217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSRwx-0005SR-HD
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 15:30:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iSRvu-0004uS-LK
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iSRvs-000597-11
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:29:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38258
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iSRvr-00056Z-Rp
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573072174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QmM7TkR3DUXrg9IrLjurtmXF2fQShIBFAEVNK6iE6IM=;
 b=Ix+fP6vCdOkFFYT1s4brk4Pp0Oq4pyJxQtOwVFEp1RckMVaqpB4yd2hNzZ2U4XKuYD5WMO
 bu/RhHddYKvb0xr7YY2ZRdm2fz3LgJpf2SGyY/bUjg0sDZwDpD3TNEPfCqiWbEny5YnVhW
 TYZzoqGOpwi7357RKZ2JuR2dtdj3YPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-Yhd2DsZMPO2l3PjXQNzjAg-1; Wed, 06 Nov 2019 15:29:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D195B800054;
 Wed,  6 Nov 2019 20:29:29 +0000 (UTC)
Received: from [10.3.117.38] (ovpn-117-38.phx2.redhat.com [10.3.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDAA45C1BB;
 Wed,  6 Nov 2019 20:29:25 +0000 (UTC)
Subject: Re: [PATCH v14 04/11] numa: Extend CLI to provide initiator
 information for numa nodes
To: Tao Xu <tao3.xu@intel.com>, mst@redhat.com, imammedo@redhat.com,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com
References: <20191028075220.25673-1-tao3.xu@intel.com>
 <20191028075220.25673-5-tao3.xu@intel.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3c0b4ebc-3d0e-87b0-b290-cab4f833cfcf@redhat.com>
Date: Wed, 6 Nov 2019 14:29:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028075220.25673-5-tao3.xu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Yhd2DsZMPO2l3PjXQNzjAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: jingqi.liu@intel.com, Dan Williams <dan.j.williams@intel.com>,
 fan.du@intel.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/19 2:52 AM, Tao Xu wrote:
> In ACPI 6.3 chapter 5.2.27 Heterogeneous Memory Attribute Table (HMAT),
> The initiator represents processor which access to memory. And in 5.2.27.=
3
> Memory Proximity Domain Attributes Structure, the attached initiator is
> defined as where the memory controller responsible for a memory proximity
> domain. With attached initiator information, the topology of heterogeneou=
s
> memory can be described.
>=20
> Extend CLI of "-numa node" option to indicate the initiator numa node-id.
> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and repo=
rt
> the platform's HMAT tables.
>=20
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Jingqi Liu <jingqi.liu@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20

> +++ b/qapi/machine.json
> @@ -463,6 +463,13 @@
>   # @memdev: memory backend object.  If specified for one node,
>   #          it must be specified for all nodes.
>   #
> +# @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145,
> +#             points to the nodeid which has the memory controller
> +#             responsible for this NUMA node. This field provides
> +#             additional information as to the initiator node that
> +#             is closest (as in directly attached) to this node, and
> +#             therefore has the best performance (since 4.2)
> +#

I'm sad to say, but we've now missed soft freeze for 4.2.  This feels=20
like enough of a feature that we'll probably have to defer the series to=20
the 5.0 release, which will have ripple effects to your patches.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


