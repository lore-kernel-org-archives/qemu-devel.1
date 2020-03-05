Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED547C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC44F2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqlKMrmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC44F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9nyg-0002Hg-UY
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1j9nx6-0000LH-8b
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:42:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1j9nx5-0005Uz-60
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:42:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52676
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1j9nx4-0005Ti-AB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583404921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZzhPs4lKOub7hqjBkp9uPQ2s+BWc0jPInjvGy7kMvU=;
 b=XqlKMrmfAvhyFHktMPrcAR+7/hfqNJiz9luqWZPBOcV0ar2vZhwhMqqStIzyYCkQL2lCbI
 fdEhf8o2ODgL6WC/qlR6Y8vEoGuk06WgayqqXmPc8X/HlLjwER6hgz0G3OLVLNlbI/vprD
 q2NGskf0cCuEH+fFN7ksf5F2iDeWtgo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-8KAL7BEnOjuju7KrWsbg0w-1; Thu, 05 Mar 2020 05:41:59 -0500
X-MC-Unique: 8KAL7BEnOjuju7KrWsbg0w-1
Received: by mail-wr1-f70.google.com with SMTP id n12so2120814wrp.19
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 02:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=urP5OrHUBAsubdAZ/Xc/6u78BkkUpUvVqF1sL38Vk2Y=;
 b=lyb0P0Cu7c5Z397XUe8j2PwcAOf3zYLTvCDKESmVTUcVDagMYqsCQ7eRo41vLYMHII
 L4XAPp/PUXVMS1XkIJyvn+ykapT8dt0tDUXgu/CfW4Rf0+x7S5G+TkjxYfyiIMWjlVw+
 3kWFhU+jWHXKKHxVKuE7vo4PXB0tEAbbGw/mBNjExJAtpU9ouoIVvYea5NIhXcbkypxx
 gSKPsdUawR8WSukYVdI0SUc+qtU3mni/0lWPXX30g1q+fhdb/sXFnveDPP1r4FTBTN2Y
 Ej64YOZ+Pl46XJPg/TvBrB1FmySMo0FC4tuJ5vXt7hO8rqZYUc2LGYMHOJ225agKQSHu
 jEFw==
X-Gm-Message-State: ANhLgQ1Dj+gVXa7p7IF9SZZyAP3zpWqb0S2AbKzOIrOCO+GIQFkxzn8p
 Aq3HiYQrGBLiV+bbb2f1UfsvNYffMvnkiiCc9Na3Occ02/wm8LJTT8N7atp2wkwXM2e4j4rtClt
 WAPqVnhHnBe0wZco=
X-Received: by 2002:adf:a505:: with SMTP id i5mr8798139wrb.33.1583404917972;
 Thu, 05 Mar 2020 02:41:57 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv/KpEUkOs/jPTy1SwcyYCkwoXHZuXGXCqUvPRjV0Qx1ZizHcz2X36XN+K34JYiTil1YZw/sA==
X-Received: by 2002:adf:a505:: with SMTP id i5mr8798111wrb.33.1583404917763;
 Thu, 05 Mar 2020 02:41:57 -0800 (PST)
Received: from steredhat (host34-204-dynamic.43-79-r.retail.telecomitalia.it.
 [79.43.204.34])
 by smtp.gmail.com with ESMTPSA id p16sm43870161wrw.15.2020.03.05.02.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 02:41:57 -0800 (PST)
Date: Thu, 5 Mar 2020 11:41:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/3] hw/net,virtfs-proxy-helper: Reduce .data footprint
Message-ID: <20200305104142.t4f2jf32y2lms3sd@steredhat>
References: <20200305010446.17029-1-philmd@redhat.com>
 <20200305095357.nvhjz7q7tuquys4k@steredhat>
 <8488759c-022a-1c74-c9a1-ad223959494b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8488759c-022a-1c74-c9a1-ad223959494b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 11:37:22AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 3/5/20 10:53 AM, Stefano Garzarella wrote:
> > On Thu, Mar 05, 2020 at 02:04:43AM +0100, Philippe Mathieu-Daud=E9 wrot=
e:
> > > More memory footprint reduction, similar to:
> > > https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00984.html
> > >=20
> > > The elf-dissector tool [1] [2] helped to notice the big array.
> > >=20
> > > [1] https://phabricator.kde.org/source/elf-dissector/
> > > [2] https://www.volkerkrause.eu/2019/06/22/elf-dissector-aarch64-supp=
ort.html
> > >=20
> >=20
> > Thanks to share these links!
>=20
> FYI the heap equivalent (besides that more powerful) is:
> https://github.com/KDE/heaptrack

Cool, thanks!

Previously I used valgrind's massif tool to track the heap, but I'll try
heaptrack.

Cheers,
Stefano


