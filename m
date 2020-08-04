Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B6AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76EB12076C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqsdNEi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EB12076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2rNc-0001Sm-Bt
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 03:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2rN0-0000yP-Vd
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:28:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32906
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2rMz-00013p-DW
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596526100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ow4VH19rEM/c4wKs38/mNj/M8X4WzbCziyRhH0Z3lDw=;
 b=PqsdNEi6gfr9O4bjax6dLKueSmE9SHxeilhrFUrnSrOQG6EUM4ZJ2XaYiNxIXEjtopi1J/
 2STcce94YcD/5nwXzEASiI63wGO3S8W1BZgkiEgYWk/QfpnFOC6Tj1NSzZP8k1rIbKVnJn
 UPURGi/29xGztxmXloglvnj7iJ+wS+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-LAvjBgfgPoOrSHXJvRptkg-1; Tue, 04 Aug 2020 03:28:16 -0400
X-MC-Unique: LAvjBgfgPoOrSHXJvRptkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9543758;
 Tue,  4 Aug 2020 07:28:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62DEA90E83;
 Tue,  4 Aug 2020 07:28:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB7591132FD2; Tue,  4 Aug 2020 09:28:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
References: <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <87d048i1m2.fsf@dusky.pond.sub.org>
 <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
 <87ft94klyl.fsf@dusky.pond.sub.org>
 <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com>
 <87y2mvhg3k.fsf@dusky.pond.sub.org>
 <20200803163629.GA4187@linux.fritz.box>
Date: Tue, 04 Aug 2020 09:28:04 +0200
In-Reply-To: <20200803163629.GA4187@linux.fritz.box> (Kevin Wolf's message of
 "Mon, 3 Aug 2020 18:36:29 +0200")
Message-ID: <87sgd2g9a3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 03.08.2020 um 18:03 hat Markus Armbruster geschrieben:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> > This means the two parts might be considered separately:
>> >
>> > - replacing single-quote with double-quote strings
>> >
>> > - replacing # comments with //
>> 
>> If all we want is decent editor support out of the box, then rename to
>> .py, and drop the modelines.  No merge conflicts, no git-blame
>> pollution.
>> 
>> To make the .py files actual Python, additionally rename the bool
>> literals.  Much, much less churn than massaging all strings or all
>> comments.
>
> I guess I could get behind this one. File renames still have a cost, but
> it feels like it wouldn't be absurdly high at least.
>
> And that you actually occasionally paste schema parts into real Python
> code suggests that there would be even a small benefit in addition to
> the good syntax highlighting out of the box.
>
> I fully expect that we'd keep our existing parser instead of using an
> actual Python parser, because the existing code (a) exists and (b) is
> probably simpler than the resulting code.

Replacing the part of parser.py that deals with JSON by off-the-shelf
code is a non-goal for me.  I got better things to do than replacing[*]
a tiny parser that works by glue for another parser, moving QAPI
sideways instead of forward.

Any messing with the lower syntax layer in non-trivial ways needs to
bring benefits that make it worth our while.


[*] Includes reviewing patches.


