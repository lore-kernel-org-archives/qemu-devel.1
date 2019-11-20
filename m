Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771BBC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41331223D1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKdRnW2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41331223D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOkf-0002Qp-A5
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iXOiO-0000pg-0j
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iXOiM-0006T3-Qc
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:04:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23016
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iXOiM-0006S3-MC
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574251446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9zmvzwRbDjyAFd9stb3TVwb59AjHG9Pu0IqGyZG9iQ=;
 b=JKdRnW2tVYLs/WT7CpIJhW8vSxWxKZSmXRvAoKTrUU7VU/DZS1SaE8OuCHEpdpnefUi8bo
 AhJ1s7V47vwFtpUqNd8b66krJ1MSw7VkqMriv8MGWgNtdPSBkNxZRUo6HE9LiFWQN8W2eR
 7T673bU/ScbqBKW+YzKdqLt4JnSrxMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-fI5qdvqTNymR6SfOBWqRmw-1; Wed, 20 Nov 2019 07:04:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3EB91005514;
 Wed, 20 Nov 2019 12:04:03 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C7A11037ACE;
 Wed, 20 Nov 2019 12:03:58 +0000 (UTC)
Date: Wed, 20 Nov 2019 13:03:57 +0100
From: Jens Freimann <jfreimann@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/4] net/virtio: avoid passing NULL to qdev_set_parent_bus
Message-ID: <20191120120357.brcmoseo46lbc4js@jenstp.localdomain>
References: <20191114141613.15804-1-jfreimann@redhat.com>
 <20191114141613.15804-3-jfreimann@redhat.com>
 <20191120054036-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191120054036-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: fI5qdvqTNymR6SfOBWqRmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 05:46:36AM -0500, Michael S. Tsirkin wrote:
>On Thu, Nov 14, 2019 at 03:16:12PM +0100, Jens Freimann wrote:
>> Make sure no arguments for qdev_set_parent_bus are NULL.
>> This fixes CID 1407224.
>>
>> Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> ---
>>  hw/net/virtio-net.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index ac4d19109e..81650d4dc0 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -2809,8 +2809,16 @@ static bool failover_replug_primary(VirtIONet *n,=
 Error **errp)
>>      if (n->primary_device_opts) {
>>          if (n->primary_dev) {
>>              n->primary_bus =3D n->primary_dev->parent_bus;
>> +            if (n->primary_bus) {
>> +                qdev_set_parent_bus(n->primary_dev, n->primary_bus);
>> +            } else  {
>> +                error_setg(errp, "virtio_net: couldn't set bus for prim=
ary");
>> +                goto out;
>> +            }
>> +        } else {
>> +            error_setg(errp, "virtio_net: couldn't find primary device"=
);
>> +            goto out;
>>          }
>
>
>A bit less messy:
>
>if (!n->primary_dev) {
>            error_setg(errp, "virtio_net: couldn't find primary device");
>            goto err;
>}
>
>n->primary_bus =3D n->primary_dev->parent_bus;
>if (!n->primary_bus) {
>      error_setg(errp, "virtio_net: couldn't find primary device");
>          goto err;
>}
>
>qdev_set_parent_bus(n->primary_dev, n->primary_bus);
>
>err:
>=09return false;
>
>also is it valid for primary_device_opts to not be present at all?
>Maybe we should check that too.
>
>
>
>> -        qdev_set_parent_bus(n->primary_dev, n->primary_bus);
>>          n->primary_should_be_hidden =3D false;
>>          qemu_opt_set_bool(n->primary_device_opts,
>>                  "partially_hotplugged", true, errp);
>> @@ -2819,10 +2827,8 @@ static bool failover_replug_primary(VirtIONet *n,=
 Error **errp)
>>              hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, errp=
);
>>              hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
>>          }
>> -        if (!n->primary_dev) {
>> -            error_setg(errp, "virtio_net: couldn't find primary device"=
);
>> -        }
>>      }
>> +out:
>>      return *errp !=3D NULL;
>>  }
>
>I'd handle errors separately from good path.
>BTW I don't understand something here:
>*errp !=3D NULL is true on error, no?
>Why are we returning success?
>Confused.
>Just return true would be cleaner imho.

I'll fix this and sent a new version as a single patch. As you said
this is not really a series, just individual patches.=20

Thanks!

regards
Jens


