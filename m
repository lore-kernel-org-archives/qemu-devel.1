Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0B8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBD62068F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiaoTe8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBD62068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2cwv-0007iS-5h
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 12:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2cvz-0006I7-Gu
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:03:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58918
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2cvx-0002Rr-52
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596470607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MrWj/vtfsnftHu+s+Pcc6mZfxGL2LqGC3Wod97zh/vI=;
 b=XiaoTe8GCA2PXguPDJ0aUntEgUaDKObN7D6q8dVGeU7B7uSf2tzr4/fo0+cxZxzPI3tjUJ
 UZMwsXsFji9mLbbYe4a1pSIkIwc5oUWmhGkCCeRyOXBs0RPxnKP9P0XuSI/I8ebXIFglxT
 ouLrEwcTg++NdST4FeFm7XkrMGoT0bM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-DRJzL5M8MlOBPmrQfkiINw-1; Mon, 03 Aug 2020 12:03:24 -0400
X-MC-Unique: DRJzL5M8MlOBPmrQfkiINw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C90918C63C7;
 Mon,  3 Aug 2020 16:03:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 495156115F;
 Mon,  3 Aug 2020 16:03:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D2A581132FD2; Mon,  3 Aug 2020 18:03:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <87d048i1m2.fsf@dusky.pond.sub.org>
 <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
 <87ft94klyl.fsf@dusky.pond.sub.org>
 <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com>
Date: Mon, 03 Aug 2020 18:03:11 +0200
In-Reply-To: <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com> (Paolo
 Bonzini's message of "Mon, 3 Aug 2020 14:01:57 +0200")
Message-ID: <87y2mvhg3k.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
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

> On 03/08/20 13:28, Markus Armbruster wrote:
>>>> We could remove them from the QAPI schema language.  Flag day, and
>>>> git-blame becomes pretty much useless for a couple of years.
>>> Is that a nack or a "whatever"?
>> It's "is this really worth the trouble?"  I guess that's halfway between
>> NAK and whatever, ready to be moved in either direction by arguments :)
>
> In general it seems like a good idea to use a standard file format and
> not "a standard file format except for two characters". :)  We also
> wouldn't be having discussions on editors.

No argument.  But towards which standard file format should the schema
evolve?

* Standard JSON: no comments, no go

* JSON with # comments: need to change strings from ' to "

* JavaScript: need to change comments from # to //

* Python: may want to switch bool literals from true, false to True,
  False

> That said, after a bit more research I'm skeptical about the possibility
> of using an off-the-shelf parser because most of them either don't
> support comments, or are based on YAJL which simply discards comments.
>
> Since '//' comments are harder to parse than "#" comments, this would
> actually _add_ code instead of removing it.  Also since our doc comment
> syntax uses "##" as a delimiter, we'd have to bikeshed what the doc
> comments would look like ("//!", "///", etc.).

Doc comments don't have to be comments in the schema language.  They
could be doc strings.  Requires decent support for long strings, which
JSON does not provide.

> This means the two parts might be considered separately:
>
> - replacing single-quote with double-quote strings
>
> - replacing # comments with //

If all we want is decent editor support out of the box, then rename to
.py, and drop the modelines.  No merge conflicts, no git-blame
pollution.

To make the .py files actual Python, additionally rename the bool
literals.  Much, much less churn than massaging all strings or all
comments.


