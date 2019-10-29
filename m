Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12775CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 13:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3C720862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 13:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFZKysYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3C720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPRrG-00086v-Q6
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 09:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iPRps-0006lj-Pl
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 09:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iPRpq-0006za-PS
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 09:46:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52029
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iPRpq-0006zU-LX
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 09:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572356818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tWpu6MOpbqy1hpeXL5+rTrgNsw+Z/DBh3l/Mf4A5KX4=;
 b=HFZKysYnfB58jIA91a1wu4npCfXM7ISav1y2PK7Rt2e0NJXO42ZecHX9KRV2fhMYPULLlD
 QJ2UJTZUTjObR52dzwEInEVM3+SC//pzEwail0XJgAdH7H9e6BeCIXBK2oEnDsgtk9xHdq
 d4Xgr/JY0W7h28vH7lGSyJ4O0ik6B/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-C5yykiybP9mjz16BRyYKIw-1; Tue, 29 Oct 2019 09:46:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD566801E64;
 Tue, 29 Oct 2019 13:46:53 +0000 (UTC)
Received: from localhost (unknown [10.36.118.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4F385D6C3;
 Tue, 29 Oct 2019 13:46:45 +0000 (UTC)
Date: Tue, 29 Oct 2019 14:46:37 +0100
From: Jens Freimann <jfreimann@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 05/11] qapi: add unplug primary event
Message-ID: <20191029134637.nvdbj3dn7rna2olq@jenstp.localdomain>
References: <20191029114905.6856-1-jfreimann@redhat.com>
 <20191029114905.6856-6-jfreimann@redhat.com>
 <87mudjpvgl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87mudjpvgl.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: C5yykiybP9mjz16BRyYKIw-1
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
Cc: berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 jasowang@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 pbonzini@redhat.com, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 29, 2019 at 01:50:02PM +0100, Markus Armbruster wrote:
>Jens Freimann <jfreimann@redhat.com> writes:
>
>> This event is emitted when we sent a request to unplug a
>
>Uh, "we sent a requestion [...] from the Guest OS"...  do you mean "we
>received"?

No, we sent a pci hotplug event to the guest by "pushing" the pcie attentio=
n
button. So, it's QEMU requesting the unplug.

>> +##
>> +# @UNPLUG_PRIMARY:
>> +#
>> +# Emitted from source side of a migration when migration state is
>> +# WAIT_UNPLUG. Device was unplugged by guest operating system.
>> +# Device resources in QEMU are kept on standby to be able to re-plug it=
 in case
>> +# of migration failure.
>> +#
>> +# @device-id: QEMU device id of the unplugged device
>> +#
>> +# Since: 4.2
>> +#
>> +# Example:
>> +#   {"event": "UNPLUG_PRIMARY", "data": {"device-id": "hostdev0"} }
>> +#
>> +##
>> +{ 'event': 'UNPLUG_PRIMARY',
>> +  'data': { 'device-id': 'str' } }
>
>Commit message might need a touch-up.  Regardless:
>Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks for the review!

regards,
Jens=20


