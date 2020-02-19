Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C41C5ACC5
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7923620656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KY8tGyQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7923620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4YAe-0002Nh-Lp
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 17:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4Y9s-0001yg-66
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4Y9r-0001hZ-7u
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:49:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4Y9r-0001h8-46
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582152570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ipfwf/kGnFo4qpG+AAAf8AZUghrnQaaq6PHQukcn2BA=;
 b=KY8tGyQuGBL+LjH1U0qM5wV48qVDN8slUa2XF8LFGxKwltGf7ubBfZhZ/p5Xh5JOrygoqo
 ckGBblcNe1d3gYAGRRWIHyVouRGbd+dLLBbrwBdDLFBsxw3E7v62G+I2rAXIp6ABeJIyp9
 9ShWWlDv4yaYpQAlZGcK7S7A+DPdEuw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-8Tv9YEvgNUKXSJj2kaqR3w-1; Wed, 19 Feb 2020 17:49:28 -0500
Received: by mail-qt1-f200.google.com with SMTP id l1so1257223qtp.21
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 14:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hPrvS54JhlYCs5426eYJmbFnhkPF+WepPCQeKMkd6Rs=;
 b=osxpOTFif/nNSIbjUfCXUOP4PMqR7Kvp9MPPF1zJf1qnQZlWO9wd4Dh2qy2R+Vz+Jp
 f7ShOMbMQpnYhj0XuUetltlgiWZl+ssH/OuNkeSV1xfj+j8LYbiJT9MtfM9AecYguGNn
 nWC/BolGvMHlidoYXVQBemXiX7cOS3k5Lgi2MCZ26RtNfr2DaHG2yH6bJgu9Ygsrlut/
 6QhalkXUzxIKepWqP3s4JB2o5+fGFa8xaKWDDweVTiUmGm79XjDtuil0KfMZb7Z6i60g
 qV+dkda7Z9bf1vT2DgNhNr9NkwySCtJeEMuTWU0hxIn/t6JPQ837N7tGBWj28ni55Mka
 gdpg==
X-Gm-Message-State: APjAAAVDKA+JDHlswPglI1jTpr4cFsJp7J7+QM5emx9ickXZFn8khDCn
 O9CfJSAUvqZppTupiEkHbobPoDxwXcVv3/vBcvjwkfsox996SBFIE/auMiIm77FKcHuWBHjM+iF
 8o9c84FlYCShiOks=
X-Received: by 2002:ac8:4a02:: with SMTP id x2mr24230154qtq.388.1582152567988; 
 Wed, 19 Feb 2020 14:49:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMhsVOOI/Eb+lFlDg/QDDFPWtaoEh4GEuEc7thjFW2ZLkwFQ4O/zqrGzkYnpHmLqhiaJKRpg==
X-Received: by 2002:ac8:4a02:: with SMTP id x2mr24230138qtq.388.1582152567777; 
 Wed, 19 Feb 2020 14:49:27 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id m95sm763317qte.41.2020.02.19.14.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 14:49:27 -0800 (PST)
Date: Wed, 19 Feb 2020 17:49:25 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 10/16] util/mmap-alloc: Factor out populating of
 memory to mmap_populate()
Message-ID: <20200219224925.GC42076@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-11-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212134254.11073-11-david@redhat.com>
X-MC-Unique: 8Tv9YEvgNUKXSJj2kaqR3w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 02:42:48PM +0100, David Hildenbrand wrote:
> We want to populate memory within a reserved memory region. Let's factor
> that out.
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

The naming could be a bit misleading IMO, because we didn't populate
the memory and it's still serviced on demand.  However I don't have a
quick and better name of that either...

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


