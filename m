Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F9CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893EF22465
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwVPnThF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893EF22465
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOmM-0005CF-GS
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXOj8-0001SQ-Rt
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXOj7-0007fV-Tn
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:04:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40354
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXOj7-0007ds-PU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574251493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hw3rTZmHTAHteLau9OtA2AaQFDqDxsFdbymAF/juzCQ=;
 b=MwVPnThFC3YXFmwVowzxr7OkwOBoVGaSKWHt6bFaxR5hiIO/6krUURQ53fvzrcyKH0TSHT
 6plDR/i8TJdLQs3fdsQ8JMSYKiNiby5Aa2fGay6AmyRBp9Q0Hu5cFv7RmO5aqT18l5TB+W
 hrKyr4aUZR1D7EtQBu7xtz/rjWDIoVg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-j6nvRr21M6unDTswi_02pA-1; Wed, 20 Nov 2019 07:04:51 -0500
Received: by mail-qv1-f70.google.com with SMTP id i11so17026451qvh.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 04:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3XvT4eEtfNxBj0788bLF77PwD3/7LsINo1MZwR+aojo=;
 b=QAL39xAiscSR1uNygjqHeiWX4P/PT1X/S6lleLCV7lIdtBkqkzk7mE93hyqxpk0yjg
 Z7Ym+leGyxKRMA3SmY45A54rnwdXRwRhQXi8VKO5exFtytnsPS+e9kHOgsHR2jeazgqQ
 Z4IZpV+JruuJxgLYDvj1ULYgi44vgfQC/42Zph+OvvylRZwtLRyneSsYLWSQAJM3QYGJ
 79508G/Qqu5vJl2nR3IU9NeAES2nep7lUzIvApxWevagGN2JR00lQnLS0swHOBo93l9Y
 dDuJ/TnPokgHxjd4gEkVVr5+qPlDyaSlaDSiG1tVmKCSQO2GFDDzoVM/zZeqQnxmkQIS
 4eSg==
X-Gm-Message-State: APjAAAUlp6LGAiRMIoD0B7oS6sny53jTWZutVx7T/AYcWLKk9vdFqmVl
 BFPA69Qtqoszz5F3xmyGTllwVBzKseHRJ8GDDsQsc7C51mhVykkPriZCCjEWXX2HP/Y7vrrH0JV
 ydCUeVNpPwSI07Ec=
X-Received: by 2002:a05:6214:13e4:: with SMTP id
 ch4mr2121651qvb.242.1574251489886; 
 Wed, 20 Nov 2019 04:04:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6Q70zR6c+6wpa+ed9o6H5do/UCpP52R9m1UhYTMzzpaIg3sGb239hJJvkrgHlaoZDN5IcqQ==
X-Received: by 2002:a05:6214:13e4:: with SMTP id
 ch4mr2121634qvb.242.1574251489651; 
 Wed, 20 Nov 2019 04:04:49 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id t11sm14202019qtj.15.2019.11.20.04.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 04:04:47 -0800 (PST)
Date: Wed, 20 Nov 2019 07:04:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] vhost-user-input: use free(elem) instead of g_free(elem)
Message-ID: <20191120070222-mutt-send-email-mst@kernel.org>
References: <20191119111626.112206-1-stefanha@redhat.com>
 <6b45458f-386f-3be0-c3d8-20c88ca37a2b@redhat.com>
 <20191120114132.GD242924@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191120114132.GD242924@stefanha-x1.localdomain>
X-MC-Unique: j6nvRr21M6unDTswi_02pA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 11:41:32AM +0000, Stefan Hajnoczi wrote:
> On Wed, Nov 20, 2019 at 10:37:35AM +0100, Philippe Mathieu-Daud=E9 wrote:
> > On 11/19/19 12:16 PM, Stefan Hajnoczi wrote:
> > > The virtqueue element returned by vu_queue_pop() is allocated using
> > > malloc(3) by virtqueue_alloc_element().  Use the matching free(3)
> > > function instead of glib's g_free().
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > Fixes: 06914c97d3a ?
>=20
> Good idea, I should have included that.
>=20
> Stefan

I'd prefer keeping the Fixes tag to bugfixes as opposed to cleanups.
I.e. it should be a reasonable heuristic for people asking "do I need
this patch" to be able to answer based on whether they have the
linked patch.

--=20
MST


