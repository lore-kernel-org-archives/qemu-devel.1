Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EB1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 09:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5E320809
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 09:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cI1Nz0LH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5E320809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k14Yo-0006ug-OC
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 05:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k14XV-00067L-Uo
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 05:07:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43851
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k14XU-00034g-Er
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 05:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596100067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OMTuFgsY2OasRX+DUOMcWFsDbZdeMqNSMeezDupj+/k=;
 b=cI1Nz0LHJre0+tP9GtxqGL3KRZ9ws3AQTNkLLDd2uOyc+gyveH9bejgbkz5EwfhRJ04V9s
 yDgnGDdJ88Ieu07rIUB8m+mvnWlMWukU/skWxhKLh9koubxyPubjtZUTZjMbXrO2nKgA4F
 qKOaETez1lNe4icrROLqoXiNL5UflPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-pk-bvGAON7CSdNS3yPy7xw-1; Thu, 30 Jul 2020 05:07:43 -0400
X-MC-Unique: pk-bvGAON7CSdNS3yPy7xw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09E2C101C8D5;
 Thu, 30 Jul 2020 09:07:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FFEA26553;
 Thu, 30 Jul 2020 09:07:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE21C1132FD2; Thu, 30 Jul 2020 11:07:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
References: <20200729185024.121766-1-abologna@redhat.com>
Date: Thu, 30 Jul 2020 11:07:26 +0200
In-Reply-To: <20200729185024.121766-1-abologna@redhat.com> (Andrea Bolognani's
 message of "Wed, 29 Jul 2020 20:50:24 +0200")
Message-ID: <87ime52wxd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Mar?= =?utf-8?Q?c-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Andrea Bolognani <abologna@redhat.com> writes:

> The various schemas included in QEMU use a JSON-based format which
> is, however, strictly speaking not valid JSON.
>
> As a consequence, when vim tries to apply syntax highlight rules
> for JSON (as guessed from the file name), the result is an unreadable
> mess which mostly consist of red markers pointing out supposed errors
> in, well, pretty much everything.
>
> Using Python syntax highlighting produces much better results, and
> in fact these files already start with specially-formatted comments
> that instruct Emacs to process them as if they were Python files.
>
> This commit adds the equivalent special comments for vim.
>
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>

Naming QAPI schema files .json even though their contents isn't was a
mistake.  Correcting it would be a pain.  If we correct it, then the
sooner the better.

Renaming them to .py gives decent editor support out of the box.  Their
contents isn't quite Python, though: true vs. True, false vs. False.  Do
we care?  Only a few dozen occurences; they could be adjusted.

Renaming them to .qapi would perhaps be less confusing, for the price of
"out of the box".

Thoughts?


