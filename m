Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6E8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191B42065F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUSopnT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191B42065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklcG-00053m-D5
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jklbT-0004dY-Tk
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:40:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60823
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jklbS-0005h6-4G
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592214028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IrGxI/Vws4TqW+XV/Y5VpwXDu7VSvK0WHjDL8oqKeSQ=;
 b=iUSopnT4HxFzDCCRGJ2Cg4GRXBRk0lbL9x7CTsk96FtXJi9EKm0M5PoPz0iRjqtTOJjAj+
 O7ck2Lny2PfFOB6T3NQTx5I+vA15/zDVrnn3gTrcpkbIA6CwVdhG7Tz8Nu3nZiKS6dimIN
 5rTXiBcUGsN6dlZdNGz+bs1VHrTXupo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-c2bw3L-7PdydkZVD-693JQ-1; Mon, 15 Jun 2020 05:40:24 -0400
X-MC-Unique: c2bw3L-7PdydkZVD-693JQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A896819057A4
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 09:40:23 +0000 (UTC)
Received: from work-vm (ovpn-114-201.ams2.redhat.com [10.36.114.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69C465C1B0;
 Mon, 15 Jun 2020 09:40:19 +0000 (UTC)
Date: Mon, 15 Jun 2020 10:40:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2] hmp: Make json format optional for qom-set
Message-ID: <20200615094016.GC2883@work-vm>
References: <20200610075153.33892-1-david@redhat.com>
 <87pna0c0pr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87pna0c0pr.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
> > Commit 7d2ef6dcc1cf ("hmp: Simplify qom-set") switched to the json
> > parser, making it possible to specify complex types. However, with this
> > change it is no longer possible to specify proper sizes (e.g., 2G, 128M),
> > turning the interface harder to use for properties that consume sizes.
> >
> > Let's switch back to the previous handling and allow to specify passing
> > json via the "-j" parameter.
> 
> Two issues:
> 
> 1. Makes qom-get and qom-set inconsistent
> 
>    qom-get formats as JSON, always.
> 
>    qom-set parses the string visitor's undocumented ad hoc language by
>    default.  You can make it parse JSON by passing -j.
> 
>    Not a show stopper, but sure ugly.  I feel documentation should point
>    it out.

I can imagine one way around this owuld be to remove the flag and make
it happen in the failure case; i.e.:

    obj = qobject_from_json(value, &err);
    if (err == NULL) {
        qmp_qom_set(path, property, obj, &err);
    } else {
        somehow check if it parses with the integer parser and if it
        does use object_property_parse
    }

unfortunately that else path is a bit messy, because you need to pick a
parser in this case and then if that fails probably present the json
error message not it's error.

> 2. Rearms the string visitor death trap
> 
>    If you try to qom-set a property whose ->set() uses something the
>    string input visitor doesn't support, QEMU crashes.  I'm not aware of
>    such a ->set(), but this is a death trap all the same.  Mind, I
>    didn't actually *look* for such a ->set().  Details:
> 
>     Subject: Re: [RFC PATCH] qom: Implement qom-get HMP command
>     Date: Sat, 02 May 2020 08:02:43 +0200 (6 weeks, 2 days, 4 minutes ago)
>     Message-ID: <87a72q6fi4.fsf@dusky.pond.sub.org>
>     https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg00178.html
> 
>    Since we've had this death trap in the code for a number of years, I
>    can't call its restoration a show stopper.  It does feel like an
>    unadvisable risk, though.

That just needs fixing in qom somewhere; it shouldn't assert - people
are too free with asserts.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


