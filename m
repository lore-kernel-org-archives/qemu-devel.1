Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11A0C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386A120652
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWxG9rO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386A120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieg8k-0004st-9L
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 09:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ieg5Z-0002oN-J6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 09:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ieg5S-0004k7-Ar
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 09:02:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ieg5O-0004iV-NS
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 09:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575986518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K82ZiSjL4mKlDlw2aY+UZqQVPLiDSmYOFzfv2vBLUVs=;
 b=OWxG9rO/dTPbZ/Ofk1B3hwp7Tt9molzC8CZLXiYCECnAGsgytcEkcjykb956uKIUaIDMia
 SU9JSdyfNOUrYTcq/KTMUmlMP1I3leKQUaEji1eYlpkcaZeU26B8BXk5or1Q3f2+zZ6xoL
 ThMtseNm3pWcAeCLWuZb8v2Wp9FumKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-n7sBLUT0OKuVLRPAyHERbA-1; Tue, 10 Dec 2019 09:01:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 037891858E72;
 Tue, 10 Dec 2019 14:01:54 +0000 (UTC)
Received: from work-vm (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5495B66FE3;
 Tue, 10 Dec 2019 14:01:53 +0000 (UTC)
Date: Tue, 10 Dec 2019 14:01:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lin Ma <LMa@suse.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOetlA==?=
 =?utf-8?B?5aSNOiBbUWVtdS1kZXZlbF0gbWlncmF0ZV9zZXRfc3BlZQ==?= =?utf-8?Q?d?=
 has no effect if the guest is using hugepages.
Message-ID: <20191210140150.GA3542@work-vm>
References: <BY5PR18MB3313E1E22A22D236D4C2680DC5F30@BY5PR18MB3313.namprd18.prod.outlook.com>
 <20190711102410.GH3971@work-vm>
 <BY5PR18MB331347C441DA068E32BFDE53C5F20@BY5PR18MB3313.namprd18.prod.outlook.com>
 <20190712123400.GJ2730@work-vm>
 <BY5PR18MB3313850D2845C27026891170C5CF0@BY5PR18MB3313.namprd18.prod.outlook.com>
 <20191205103159.GC2824@work-vm>
 <BY5PR18MB331333470C356200DDF0A8DAC55B0@BY5PR18MB3313.namprd18.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BY5PR18MB331333470C356200DDF0A8DAC55B0@BY5PR18MB3313.namprd18.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: n7sBLUT0OKuVLRPAyHERbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lin Ma (LMa@suse.com) wrote:
> Hi Dave,
>=20
> The patch fixed the issue, The rate limit with hugepages works well.
> Thanks for your help!

No problem; thank you for reporting and testing it.

Dave

> Lin
>=20
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Dr. David Alan Gilbert <dgilbert@redhat.co=
m>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2019=E5=B9=B412=E6=9C=885=E6=97=
=A5 18:32
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Lin Ma <LMa@suse.com>
> > =E6=8A=84=E9=80=81: qemu-devel@nongnu.org
> > =E4=B8=BB=E9=A2=98: Re: =E5=9B=9E=E5=A4=8D: =E7=AD=94=E5=A4=8D: [Qemu-d=
evel] migrate_set_speed has no effect if the
> > guest is using hugepages.
> >=20
> > Hi Lin,
> >   I've just posted 'migration: Rate limit inside host pages'; please le=
t me know if
> > it helps for you.
> >=20
> > Dave
> >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


