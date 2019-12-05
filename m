Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B545C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0F321823
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2TFleL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0F321823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvle-00017z-Pn
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icvhd-00068U-4G
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icvhb-0002HJ-0c
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:18:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24896
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icvhY-0002Dt-FS
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575569886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZiPYqCromAEfyVyDGcyCWBqr3Sgc2+S2D72yE6cgQD8=;
 b=T2TFleL7p04loyQmuyNOeTLKy65c4EE7rMxN4ZaIgAfURY1sBo5Dk5XfW7TWzWodm/uTmZ
 1JrRMNrMONNnJeVfRgE+E35XBi5lEK607CyoGkwPnvT9M3yWrpfWeKd8Z9rcw7tlAHvsmc
 1N9P5KEjPtFfudk998yRdOE00U0Y3yo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-HxkeLqBYPUC9mkn9VYdSDA-1; Thu, 05 Dec 2019 13:18:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88F918024C8;
 Thu,  5 Dec 2019 18:18:04 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D5D210013D9;
 Thu,  5 Dec 2019 18:18:03 +0000 (UTC)
Subject: Re: [PATCH v8 06/21] qdev-monitor: well form error hint helpers
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-7-vsementsov@virtuozzo.com>
 <0991f52e-853a-5f34-99d5-6c047593f8af@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <48dc3783-b012-17e3-03db-5d1680ea1c2e@redhat.com>
Date: Thu, 5 Dec 2019 12:18:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0991f52e-853a-5f34-99d5-6c047593f8af@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: HxkeLqBYPUC9mkn9VYdSDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, armbru@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 12:17 PM, Eric Blake wrote:
> On 12/5/19 11:46 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Make qbus_list_bus and qbus_list_dev hint append helpers well formed:
>> switch errp paramter to Error *const * type, as it has uncommon
>> behavior: not change the pointer to return error, but operate on
>> already existent error object.
>> Rename functions to be error_append_*_hint.
>=20
> qbus_error_append_*_hint
>=20
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 qdev-monitor.c | 12 +++++++-----
>> =A0 1 file changed, 7 insertions(+), 5 deletions(-)
>>
>=20
>> -static void qbus_list_dev(BusState *bus, Error **errp)
>> +static void qbus_error_append_dev_list_hint(BusState *bus,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Error *const *=
errp)
>=20
> Or, since you copy-and-paste this commit message in v9, you could use=20

Sorry, I meant it was copied in v8 7/21.

> *_error_append_*_hint between the commits for less one-off fixing per=20
> message.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


