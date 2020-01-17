Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4750C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7091D20661
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gph0RNIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7091D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRtS-0004As-5b
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1isRs1-0002p9-NX
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1isRry-00051c-0q
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:41:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1isRrx-00051L-TP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579268461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfK+5UsI1XzrRmyhiIqogqJFQSMaUDwoo1QQgqCaVKU=;
 b=Gph0RNIR9/ruKPQqXXTPdx1f/o6VzoOkc+SECnHd7D93GsMZZEXc41x9On5kP+Ai8lG+dZ
 Fhz0a4mUfObv1pJTKqIc9OoV5UvlarcP76DjI33fvpqKj+8iBuwh/DmieFLwd0I4IHfpW9
 3BLBb+8bgdZCAWzCPMxrevgWaiBE5ZE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-DpBdpYJoOc2XhOduCvBPhg-1; Fri, 17 Jan 2020 08:41:00 -0500
Received: by mail-qv1-f72.google.com with SMTP id p3so15582060qvt.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=A7YsayGL418VOgr2Aq2bbQ/jzdkPnq8xukX11wBwqLY=;
 b=kIy3HI+qhddx6gprLFWc2dSiDbAIrIXkgcNlL7yDzVY7OZ6aFtMHJHdzW7tWMk/vCL
 tyJhkf4O9bfLFsDIChhVJfcmWWw2mx25K6crJk11mVAV7tJWQxk4VaPYfGj4COPSGqSZ
 sezjkLv4yDTxpX8eLM0a/4ZaYpB0QWDMiY7B7cK0iyyFoMeIgZFYjOTdEe2qDzSAus1O
 kS/bkVdqbKMh40OfInvKY26Uho7QHso0evC46+Gx6l9mrDh4fHLHUlMqW7Xap8cWbzrf
 SWkP9EM1Fg0DSm0VFDurJKmkDUsgk4Vt/Z4gy0t66ngW0YB1Tw7/tYsqWV3uJAw76TyK
 MGrw==
X-Gm-Message-State: APjAAAUv20a/EGByvh8rQl7xElKD2vJh1OYljDno4j1Z6TsHVh1hWkhn
 QNigWp8siV7ZnQJIIhpT3bhD3HQlsrJPle8Z5glMPjyubS9Cf62Lwg1bVPHPdbbk9dRM4jiVg/z
 8pUljPjxn/oFV0qM=
X-Received: by 2002:ac8:6910:: with SMTP id e16mr3359593qtr.273.1579268459843; 
 Fri, 17 Jan 2020 05:40:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqycP8cEuCbWArrjXH7OWS58XqV1iSamg5M9lt9VRPQX91aMd7io5/nlTMGRe4081nbRxfEerA==
X-Received: by 2002:ac8:6910:: with SMTP id e16mr3359575qtr.273.1579268459588; 
 Fri, 17 Jan 2020 05:40:59 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
 by smtp.gmail.com with ESMTPSA id i16sm11740846qkh.120.2020.01.17.05.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 05:40:58 -0800 (PST)
Date: Fri, 17 Jan 2020 08:40:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/2] vhost: Only align sections for vhost-user
Message-ID: <20200117083232-mutt-send-email-mst@kernel.org>
References: <20200116202414.157959-1-dgilbert@redhat.com>
 <20200116202414.157959-3-dgilbert@redhat.com>
 <4bf72509-3e60-0d78-c2ba-665a71a978e1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4bf72509-3e60-0d78-c2ba-665a71a978e1@redhat.com>
X-MC-Unique: DpBdpYJoOc2XhOduCvBPhg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: jasowang@redhat.com, vkuznets@redhat.com,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 17, 2020 at 01:52:44PM +0100, Paolo Bonzini wrote:
> On 16/01/20 21:24, Dr. David Alan Gilbert (git) wrote:
> > +    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER) {=
  =20
> > +        /* Round the section to it's page size */
> > +        /* First align the start down to a page boundary */
> > +        size_t mrs_page =3D qemu_ram_pagesize(mrs_rb);
> > +        uint64_t alignage =3D mrs_host & (mrs_page - 1);
> > +        if (alignage) {
> > +            mrs_host -=3D alignage;
> > +            mrs_size +=3D alignage;
> > +            mrs_gpa  -=3D alignage;
> > +        }
> > +        /* Now align the size up to a page boundary */
> > +        alignage =3D mrs_size & (mrs_page - 1);
> > +        if (alignage) {
> > +            mrs_size +=3D mrs_page - alignage;
> > +        }
> > +        trace_vhost_region_add_section_aligned(section->mr->name, mrs_=
gpa, mrs_size,
> > +                                               mrs_host);
> > +    }
>=20
> Ok, now I understand!
>=20
> So it seems to me that the vhost-user protocol is deficient, it should
> have had two different fields for the region size and the region
> alignment (so that mmap does not fail).  But I guess that's just yet
> another thing to remember for vhost-user v2.

We don't really need v2 just to add a field. Compatibility is maintained
using feature bits. Adding that is a subject for another patch.
But I'm not sure I understand why does remote need to know about alignment.
This patch seems to handle it locally ...

> I would add a comment to explain why the alignment is needed in the
> first place, but this fix is certainly much more pleasant.  Thanks very
> much.
>=20
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Paolo


