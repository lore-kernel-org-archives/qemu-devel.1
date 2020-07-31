Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E40C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDD122B40
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlKqfIhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDD122B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ZEN-0003kY-PK
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k1ZDf-0003F4-Ee
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:53:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22306
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k1ZDd-000292-7b
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596218000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LePW5BTTYlb1aZMgKbSFSEN2h/6rqCfYTrKDonhsSSQ=;
 b=TlKqfIhfr6hbv7r8218DI0bS/y9w02guBG/c6IO0Bk8W4nLZHcuxgSs9hvbQKUT/O0Wqtu
 YxoR/Mt3Bb4A+4QtqPE5Q7p2gh0AAhfDlD+5kli4NRfHuakBe9wWIy308dOz9XdKNWaMsb
 8PmGKxI6gGnpZTLQXewG4fdhGK1UC9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-rrjwoFnHM8GDhaj44DrzDA-1; Fri, 31 Jul 2020 13:53:18 -0400
X-MC-Unique: rrjwoFnHM8GDhaj44DrzDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C335018C63CC;
 Fri, 31 Jul 2020 17:53:16 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4952C5D992;
 Fri, 31 Jul 2020 17:53:05 +0000 (UTC)
Subject: Re: [PATCH] schemas: Add vim modeline
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
 <6ceef1ab-5078-d77e-6e6c-4e1bfc01418a@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bb0f4298-414c-6b89-c9c2-7c9d86541daf@redhat.com>
Date: Fri, 31 Jul 2020 13:53:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6ceef1ab-5078-d77e-6e6c-4e1bfc01418a@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:39:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/20 12:35 PM, Paolo Bonzini wrote:
> On 31/07/20 17:26, John Snow wrote:
>> I saw the critique that we still use JSON-ish for the runtime QMP
>> protocol, and moving the QAPI IDL to a standard wouldn't remove all
>> instances of a custom format from our tree.
> 
> Sorry, but "still using JSON" is not a critique that makes any sense.
> 
> 99% of the websites you use daily use JSON as their RPC
> frontend-to-backend language; OpenAPI is essentially JSON over HTTP.
> There must be something good in JSON.
> 
> Whenever you hear a complaint about "using JSON", it's actually a
> complaint about bindings for your language, which can be a sensible
> critique: gRPC is essentially {protobuf,FlatBuffers} over HTTP/2 plus a
> boatload of language mappings.  Unfortunately C is not one of those
> mappings.
> 
> Paolo
> 

You have misunderstood me.

The critique I am relaying, but not raising, is that we already use a 
custom JSON parser in two or more places, and so replacing one instance 
of this with a new format actually complicates QEMU instead of 
simplifies it.

I disagree with this concern on the premise that moving one non-standard 
JSON usage to a standard usage is a win because it reduces the total 
number of instances of proprietary formats.

Further, if we remove ALL instances of proprietary JSON, then we're back 
to the same level of complexity internally, but with a reduced level of 
complexity for outside observers.

This is why I said "JSON-ish", not "JSON".

--js


