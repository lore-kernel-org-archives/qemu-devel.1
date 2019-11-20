Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C26C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF7F20714
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9vecum7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF7F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRpB-00052K-Sx
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iXRoM-0004cM-9l
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iXRoJ-0000EX-ID
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:22:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20302
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iXRoJ-0000EB-7d
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YHiDLUu5+lStGUZXDjS30jcyMBxjv8JcddTW6vIpTq8=;
 b=g9vecum7JBqPP4fGu0B9bxcT3fD+h8r2wShksvfRR4a1a+26GF04ojwy7phfxEjvFnfybx
 2b35AegIKwkv43RbTG8is2eSBpxU1CiXuMOLfY/dtgN7p8VzdaMz9JZ0fCCJ8lcZuBj8Vd
 NatRphgKcTSkZ+cEtA7nLE5cow9sxE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-8Hz9b5ljMN6x7vUeaa3Ufg-1; Wed, 20 Nov 2019 10:22:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 173C6801E6A;
 Wed, 20 Nov 2019 15:22:24 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B46C62AA92;
 Wed, 20 Nov 2019 15:22:20 +0000 (UTC)
Date: Wed, 20 Nov 2019 16:22:19 +0100
From: Jens Freimann <jfreimann@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 3/4] net/virtio: avoid passing NULL to
 qdev_set_parent_bus
Message-ID: <20191120152219.aba3fumhchyav4fz@jenstp.localdomain>
References: <20191120143859.24584-1-jfreimann@redhat.com>
 <20191120143859.24584-4-jfreimann@redhat.com>
 <20191120100034-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191120100034-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8Hz9b5ljMN6x7vUeaa3Ufg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 10:04:01AM -0500, Michael S. Tsirkin wrote:
>On Wed, Nov 20, 2019 at 03:38:58PM +0100, Jens Freimann wrote:
>> Make sure we don't pass NULL to qdev_set_parent_bus(). Also simplify
>> code a bit and fix a typo.
>> This fixes CID 1407224.
>>
>> Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>
>patch itself is ok I think
>
>Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
>but some questions on the commit log
>
>> ---
>>  hw/net/virtio-net.c | 42 +++++++++++++++++++++++++-----------------
>>  1 file changed, 25 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index ac4d19109e..78f1e4e87c 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -2805,25 +2805,33 @@ static bool failover_replug_primary(VirtIONet *n=
, Error **errp)
>>          n->primary_device_opts =3D qemu_opts_from_qdict(
>>                  qemu_find_opts("device"),
>>                  n->primary_device_dict, errp);
>> -    }
>> -    if (n->primary_device_opts) {
>> -        if (n->primary_dev) {
>> -            n->primary_bus =3D n->primary_dev->parent_bus;
>> -        }
>> -        qdev_set_parent_bus(n->primary_dev, n->primary_bus);
>> -        n->primary_should_be_hidden =3D false;
>> -        qemu_opt_set_bool(n->primary_device_opts,
>> -                "partially_hotplugged", true, errp);
>> -        hotplug_ctrl =3D qdev_get_hotplug_handler(n->primary_dev);
>> -        if (hotplug_ctrl) {
>> -            hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, errp=
);
>> -            hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
>> +        if (!n->primary_device_opts) {
>> +            error_setg(errp, "virtio_net: couldn't find primary device =
opts");
>> +            goto out;
>>          }
>> -        if (!n->primary_dev) {
>> +    }
>> +    if (!n->primary_dev) {
>>              error_setg(errp, "virtio_net: couldn't find primary device"=
);
>> -        }
>> +            goto out;
>>      }
>> -    return *errp !=3D NULL;
>> +
>> +    n->primary_bus =3D n->primary_dev->parent_bus;
>> +    if (!n->primary_bus) {
>> +        error_setg(errp, "virtio_net: couldn't find primary bus");
>> +        goto out;
>> +    }
>> +    qdev_set_parent_bus(n->primary_dev, n->primary_bus);
>> +    n->primary_should_be_hidden =3D false;
>> +    qemu_opt_set_bool(n->primary_device_opts,
>> +                      "partially_hotplugged", true, errp);
>> +    hotplug_ctrl =3D qdev_get_hotplug_handler(n->primary_dev);
>> +    if (hotplug_ctrl) {
>> +        hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, errp);
>> +        hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
>> +    }
>> +
>> +out:
>> +    return *errp =3D=3D NULL;
>>  }
>>
>>  static void virtio_net_handle_migration_primary(VirtIONet *n,
>
>So the logic actually was inverted here? Then ... how did this work?
>and how was it tested?

It did not work and I missed the error in my test output. I tested it
now manually by migrating and then cancelling. Device was added back
to source VM successfully.

Will sent new version with better patch description.

Thanks!

regards
Jens


