Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B01EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 05:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C7420774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 05:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTOt24vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C7420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiX2b-0002Au-Gc
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 01:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiX1d-0001gb-Tu
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 01:42:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60234
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiX1d-0005sb-76
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 01:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591681336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Na/SkwCo3XM2xC7Vl83zN+edbmeSDFesXvotOybheNk=;
 b=hTOt24vslHLIYLGsxa7op0bwrH29IYfmh3/IJVhyAe/yl+/nO3CsB4kQ8EA41AUXuw52ex
 P2iVmHXkCjM3Xs30yXdu7YDKT87G4z4iTjiZqTd5wRYIoLaWFo/DtctJ/Jm1hVfz6N0lEv
 5sWFc2MwLQEP2SnQJylxd5s4DDg3Aq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-7yX2MEV4OwGJzUOd82nH4w-1; Tue, 09 Jun 2020 01:42:12 -0400
X-MC-Unique: 7yX2MEV4OwGJzUOd82nH4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA27E801504;
 Tue,  9 Jun 2020 05:42:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55A1260BF3;
 Tue,  9 Jun 2020 05:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8317211386A6; Tue,  9 Jun 2020 07:42:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 10/24] macio: Delete unused "macio-gpio" devices
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-11-armbru@redhat.com>
 <2ff77017-755e-70fe-5112-680c98b1efcf@ilande.co.uk>
Date: Tue, 09 Jun 2020 07:42:09 +0200
In-Reply-To: <2ff77017-755e-70fe-5112-680c98b1efcf@ilande.co.uk> (Mark
 Cave-Ayland's message of "Mon, 8 Jun 2020 12:54:15 +0100")
Message-ID: <87pna8sslq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 28/05/2020 12:04, Markus Armbruster wrote:
>
>> These devices go with the "via-pmu" device, which is controlled by
>> property "has-pmu".  macio_newworld_init() creates it unconditionally,
>> because the property has not been set then.  macio_newworld_realize()
>> realizes it only when the property is true.  Works, although it can
>> leave an unrealized device hanging around in the QOM composition tree.
>> Affects machine mac99 with via=cuda (default).
>> 
>> Delete the unused device by making macio_newworld_realize() unparent
>> it.  Visible in "info qom-tree":
>> 
>>      /machine (mac99-machine)
>>        [...]
>>        /unattached (container)
>>          /device[9] (macio-newworld)
>>            [...]
>>            /escc-legacy-port[8] (qemu:memory-region)
>>            /escc-legacy-port[9] (qemu:memory-region)
>>            /escc-legacy[0] (qemu:memory-region)
>>     -      /gpio (macio-gpio)
>>     -        /gpio[0] (qemu:memory-region)
>>            /ide[0] (macio-ide)
>>              /ide.0 (IDE)
>>              /pmac-ide[0] (qemu:memory-region)
>> 
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: qemu-ppc@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/misc/macio/macio.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
>> index 3779865ab2..b3dddf8be7 100644
>> --- a/hw/misc/macio/macio.c
>> +++ b/hw/misc/macio/macio.c
>> @@ -368,6 +368,8 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
>>          memory_region_add_subregion(&s->bar, 0x16000,
>>                                      sysbus_mmio_get_region(sysbus_dev, 0));
>>      } else {
>> +        object_unparent(OBJECT(&ns->gpio));
>> +
>>          /* CUDA */
>>          object_initialize_child(OBJECT(s), "cuda", &s->cuda, sizeof(s->cuda),
>>                                  TYPE_CUDA, &error_abort, NULL);
>
> This looks correct to me. Re-reading over the 3 different patch series you've posted,
> I think it makes sense to merge them soon since even though there may be some debate
> over init/realize in places, the benefits would far outweigh the drawbacks IMO.

We can always improve on top.

Rebasing this stuff is quite time-consuming.

> Anyhow for this patch:
>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks!


