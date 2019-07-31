Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F87CC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B24620449
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Myy55KeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B24620449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hskw0-00016h-NV
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 05:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33880)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hskvZ-0000Ph-H8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hskvY-00043E-Fc
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:29:45 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:58424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hskvT-0003zb-Kh; Wed, 31 Jul 2019 05:29:40 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 96A5696F50;
 Wed, 31 Jul 2019 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564565377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSQAjbqA5TXg43q0JVmvSZNd+foS5vyVzOrBfp+PDgs=;
 b=Myy55KeFleX9wJmVFLeMeoIzKsXzJj/DPAYVBQth4Fq+a6c0J0bVNvuttjX4lIRpngEeQ6
 WFI9zuNMXB8QaVdzTXerix2fcRT6Zyypc59ywVY1Th4VRv/KRueMpR9wcUYmhMQM9Tsp8M
 Z5zWFCikxLJ5Y9eqfhoeotkEApKtl1Q=
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-6-damien.hedde@greensocs.com>
 <20190731060533.GD2032@umbus.fritz.box>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <51aa7e6d-3568-8485-4b67-a598a24a1f3d@greensocs.com>
Date: Wed, 31 Jul 2019 11:29:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190731060533.GD2032@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564565377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSQAjbqA5TXg43q0JVmvSZNd+foS5vyVzOrBfp+PDgs=;
 b=BYat8WSK2wwrLuymKzxmOuaU+48VQnKbhqFhKd3D/0TFwZdrov0AenLwwDsQ3U+NSzxkru
 6fb2qQ9yVDrQM1NvojjnMfptnKFcOQDlZoafG9DQZD/HYPqQr7F6TbdCG2ZggBkGuFEnsx
 1fFW9BfBcMip0CADm+eg3DhcGyDNigg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564565377; a=rsa-sha256; cv=none;
 b=OogKBj3OvtXeELBZNrnS4sXNv/RJpmueV4tXZIjIi1x3UaW9bhCXUNCIdDvhTm2CKrvfd4
 EnI2+tW0jMQcWF9OoeuyiiFZoO0IZ6TGhdSl7YhOjX4DnCov/6k3FiNWR68RygszaTla2F
 ztSPsjqT0I6fzfyles/6XQVIeLacrOU=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v3 05/33] Switch to new api in qdev/bus
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, edgar.iglesias@xilinx.com,
 hare@suse.com, qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, thuth@redhat.com,
 ehabkost@redhat.com, alistair@alistair23.me, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com, rth@twiddle.net,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/31/19 8:05 AM, David Gibson wrote:
> On Mon, Jul 29, 2019 at 04:56:26PM +0200, Damien Hedde wrote:
>> Deprecate old reset apis and make them use the new one while they
>> are still used somewhere.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>  hw/core/qdev.c         | 22 +++-------------------
>>  include/hw/qdev-core.h | 28 ++++++++++++++++++++++------
>>  2 files changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 559ced070d..e9e5f2d5f9 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -312,25 +312,9 @@ static void device_foreach_reset_child(Object *obj, void (*func)(Object *))
>>      }
>>  }
>>  
>> -static int qdev_reset_one(DeviceState *dev, void *opaque)
>> -{
>> -    device_legacy_reset(dev);
>> -
>> -    return 0;
>> -}
>> -
>> -static int qbus_reset_one(BusState *bus, void *opaque)
>> -{
>> -    BusClass *bc = BUS_GET_CLASS(bus);
>> -    if (bc->reset) {
>> -        bc->reset(bus);
>> -    }
>> -    return 0;
>> -}
>> -
>>  void qdev_reset_all(DeviceState *dev)
>>  {
>> -    qdev_walk_children(dev, NULL, NULL, qdev_reset_one, qbus_reset_one, NULL);
>> +    device_reset(dev, false);
>>  }
>>  
>>  void qdev_reset_all_fn(void *opaque)
>> @@ -340,7 +324,7 @@ void qdev_reset_all_fn(void *opaque)
>>  
>>  void qbus_reset_all(BusState *bus)
>>  {
>> -    qbus_walk_children(bus, NULL, NULL, qdev_reset_one, qbus_reset_one, NULL);
>> +    bus_reset(bus, false);
>>  }
>>  
>>  void qbus_reset_all_fn(void *opaque)
>> @@ -922,7 +906,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>>              }
>>          }
>>          if (dev->hotplugged) {
>> -            device_legacy_reset(dev);
>> +            device_reset(dev, true);
> 
> So.. is this change in the device_reset() signature really necessary?
> Even if there are compelling reasons to handle warm reset in the new
> API, that doesn't been you need to change device_reset() itself from
> its established meaning of a cold (i.e. as per power cycle) reset.
> Warm resets are generally called in rather more specific circumstances
> (often under guest software direction) so it seems likely that users
> would want to engage with the new reset API directly.  Or we could
> just create a device_warm_reset() wrapper.  That would also avoid the
> bare boolean parameter, which is not great for readability (you have
> to look up the signature to have any idea what it means).

I've added device_reset_cold/warm wrapper functions to avoid having to
pass the boolean parameter. it seems I forgot to use them in qdev.c
I suppose, like you said, we could live with
+ no function with the boolean parameter
+ device_reset doing cold reset
+ device_reset_warm (or device_warm_reset) for the warm version

Damien

