Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BF5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32DB0206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPB9deDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DB0206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2VBE-0003wY-44
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 03:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2VAb-0003Rd-0N
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 03:46:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26384
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2VAZ-0007z8-9w
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 03:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596440761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m8/EtZVdTdC6zzqrIgNu+9xiwRHKuOMGJNfySNRwI+g=;
 b=BPB9deDJdS/E8bNZ1rzrKl2/mYZ+Ce2HlGtZiLbQ/DnGkdxz1gODyZS1F6lsAT9g9lcvuz
 CcUPtT0Ir9aff8ga87oFjuvfht8hbw8aSbDB5/7L/mVGeavpU5AANrmCsRZ/hdKvBSo9Gs
 gxsEwBUPhwZGsq3u53yaBjaMUUGvq18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-aW9_7Cc-Mm-6Ai6GslKlpw-1; Mon, 03 Aug 2020 03:45:59 -0400
X-MC-Unique: aW9_7Cc-Mm-6Ai6GslKlpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FF3318C63C1;
 Mon,  3 Aug 2020 07:45:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 387A871904;
 Mon,  3 Aug 2020 07:45:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C1FFB1132FD2; Mon,  3 Aug 2020 09:45:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
 <6ceef1ab-5078-d77e-6e6c-4e1bfc01418a@redhat.com>
 <bb0f4298-414c-6b89-c9c2-7c9d86541daf@redhat.com>
 <a304b5ed-8dba-5ac0-a264-fa8ca1487cb5@redhat.com>
Date: Mon, 03 Aug 2020 09:45:47 +0200
In-Reply-To: <a304b5ed-8dba-5ac0-a264-fa8ca1487cb5@redhat.com> (Paolo
 Bonzini's message of "Fri, 31 Jul 2020 20:01:09 +0200")
Message-ID: <87mu3ci34k.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 01:24:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 31/07/20 19:53, John Snow wrote:
>> You have misunderstood me.
>> 
>> The critique I am relaying, but not raising, is that we already use a
>> custom JSON parser in two or more places, and so replacing one instance
>> of this with a new format actually complicates QEMU instead of
>> simplifies it.
>> 
>> I disagree with this concern on the premise that moving one non-standard
>> JSON usage to a standard usage is a win because it reduces the total
>> number of instances of proprietary formats.
>> 
>> Further, if we remove ALL instances of proprietary JSON, then we're back
>> to the same level of complexity internally, but with a reduced level of
>> complexity for outside observers.
>
> I think we should first build a consensus on using "real" JSON (plus
> Javascript comments) for the schema, which is easy, and then somebody
> can try his hands at removing the custom JSON parser.
>
> I wouldn't conflate the QMP and schema parsers.  For example, QMP does
> not need comments and schemas don't need either bigints or printf-style
> % interpolation.

Seconded.

QAPI schema syntax and the QMP syntax are totally separate.  Heck, the
whole *languages* are.  They happen to use vaguely similar concrete
syntax, a bit like C, Java and JavaScript do.  That's all.

Let's keep this thread focused on the QAPI schema language.


