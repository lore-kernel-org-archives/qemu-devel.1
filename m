Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54039C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD5320717
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="She9XcTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD5320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy9o8-0003rp-DK
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jy9lT-0008BW-J6
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:06:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jy9lR-00049v-TC
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595405169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/CnFhBDif41UJrSyiNdoTESte73ASXLi3Ld8KOo7YE=;
 b=She9XcTsORS3+S97GdYkY/ZIHy7NSJcm5NmVhSH2P2Hbkd4aVHEvw8b7xDUVQwUnhBlNgn
 /VYeX+PbOENhtHWynh6Zzf28n7nwLJbj5LihnZCbLNvtFqqfI5eMfDk38VoS7K/H8wyuAx
 rOh5RuMd6RZOC6uY1pKivsV+1Ag+ZXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-FwVIPN-AN5yMs6kIoR5pIQ-1; Wed, 22 Jul 2020 04:06:07 -0400
X-MC-Unique: FwVIPN-AN5yMs6kIoR5pIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBF429F598
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 08:05:54 +0000 (UTC)
Received: from titinator (ovpn-113-160.ams2.redhat.com [10.36.113.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 359538BEC5;
 Wed, 22 Jul 2020 08:05:53 +0000 (UTC)
References: <20200624131045.14512-1-kraxel@redhat.com>
 <20200624131045.14512-4-kraxel@redhat.com>
 <7hft9mmfg6.fsf@turbo.dinechin.lan>
 <20200721142753.v2be4d2mdh435gtv@sirius.home.kraxel.org>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 03/10] qdev: device module support
In-reply-to: <20200721142753.v2be4d2mdh435gtv@sirius.home.kraxel.org>
Date: Wed, 22 Jul 2020 10:05:51 +0200
Message-ID: <ly365kht40.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr?= =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-07-21 at 16:27 CEST, Gerd Hoffmann wrote...
>   Hi,
>
>> >  DeviceState *qdev_new(const char *name)
>> >  {
>> > +    if (!object_class_by_name(name)) {
>> > +        module_load_qom_one(name);
>> > +    }
>>
>> Curious why you don't you call module_object_class_by_name here?
>
> Because object_new() wants a name not an ObjectClass ...

I'm talking about the two lines above.

    if (!object_class_by_name(name)) {
        module_load_qom_one(name);
    }

Thi9s code looks very similar to the code below:

    ObjectClass *module_object_class_by_name(const char *typename)
    {
        ObjectClass *oc;

        oc = object_class_by_name(typename);
    #ifdef CONFIG_MODULES
        if (!oc) {
            module_load_qom_one(typename);
            oc = object_class_by_name(typename);
        }
    #endif
        return oc;
    }

Both call module_load_qom_one and object_class_by_name using the name as
input, so I don't see the difference (except for the order).

Am I reading this wrong?

>
>> >      return DEVICE(object_new(name));
>> >  }
>
> take care,
>   Gerd


--
Cheers,
Christophe de Dinechin (IRC c3d)


