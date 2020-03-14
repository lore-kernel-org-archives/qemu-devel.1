Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140EBC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 18:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0B420784
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 18:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPA69H4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0B420784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDBTy-0001XN-1y
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 14:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDBTB-0000rD-NS
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 14:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDBTA-0007kA-Mn
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 14:25:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31854
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDBTA-0007ip-IV
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 14:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584210308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHxABOPYrTd5jeH4kQ73qkR1EKA7pAk8OhssJ55BfO0=;
 b=VPA69H4+6PiJ8kcZ8qNdxnzik3ZWv0vR4DtCQVhhKZWAfWzp3rrhI3Vcw5LtAk8Rur9eLi
 cfnJ+ETKEKfIxOxYKoobhu9p7mPwYxV5jyxYNRxcumtjcUjY4gT2BVLWv2dMCM8+5K9A3j
 axNojTRyokSh3kCRcvWU9tRS6QxVV+g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-TLrcpO8PMNmYOtzw39Wn6w-1; Sat, 14 Mar 2020 14:25:06 -0400
X-MC-Unique: TLrcpO8PMNmYOtzw39Wn6w-1
Received: by mail-wr1-f72.google.com with SMTP id c6so6219211wrm.18
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 11:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Acr2+zOvPR3PR1E65IrotLByvZr1MWpy53iUxFf29n4=;
 b=b//Y7uFjROu/tqAJlrZn0f2XJIGBnuoztpjptB3P+AZ3KnzuLHPueNAw2lqJ63mWVH
 DdbIUNtKyBgvtkuc1APuC9ChfbBwTnZtAxINFsyxMDS9FYE/61ZQimz6lLNoSAAuj6+i
 YQ7NTFkf6wTIPBwl+5xe8gFpTqyh5Whw86pBUd1jmVIYshNJUnTZS3MQ7sNm+urq5r6G
 j0DOesHfIrzQDCc/idymqVW8TScNnbp24J0a/JYOPP692AngSAS+zri7cLNfgLNvDFtj
 d5f7tDTaDviISqQv0sSH15aZlhALTDPHseYTNXbzUjhI+wc43EuDQkoOPv86Mctxn3Ih
 WRoA==
X-Gm-Message-State: ANhLgQ1RrORQ4ds/krvKupNqZHU7YIpDhNGlowupGsIzyqaIF2/5JerS
 oo9PNdEHD0GofF1dSWA0aOsfZLw5XaeM5gTU3THJ76BvrJs6TtOxlacn4U0FtsoCUIGsVY4kZrk
 62E0trF3mQkZCJac=
X-Received: by 2002:adf:9d8f:: with SMTP id p15mr24652321wre.160.1584210305273; 
 Sat, 14 Mar 2020 11:25:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvlUh91wmcMMIKTh+kVxgbWGDCjrilei4ihGgfdPGR/g1JuXFerJUkbiE2iICP3G1MmPGLEDA==
X-Received: by 2002:adf:9d8f:: with SMTP id p15mr24652305wre.160.1584210305090; 
 Sat, 14 Mar 2020 11:25:05 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 w1sm20743305wmc.11.2020.03.14.11.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2020 11:25:04 -0700 (PDT)
Date: Sat, 14 Mar 2020 14:25:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 07/16] hw/i386/vmport: Introduce vmport.h
Message-ID: <20200314142319-mutt-send-email-mst@kernel.org>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-8-liran.alon@oracle.com>
 <13b98a16-6465-e1c9-5f52-0f338c60fbd5@redhat.com>
 <d81dc7a5-2b20-1792-c1df-ecdb8a964fa7@oracle.com>
 <2f168ddb-34e3-a286-080c-261dcb8ee6bb@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2f168ddb-34e3-a286-080c-261dcb8ee6bb@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: pbonzini@redhat.com, rth@twiddle.net, Liran Alon <liran.alon@oracle.com>,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 14, 2020 at 09:31:31AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 3/13/20 11:38 PM, Liran Alon wrote:
> > On 13/03/2020 21:57, Philippe Mathieu-Daud=E9 wrote:
> > > On 3/12/20 5:54 PM, Liran Alon wrote:
> > > > No functional change. This is mere refactoring.
> > > >=20
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > > ---
> > > > =A0 hw/i386/pc.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> > > > =A0 hw/i386/vmmouse.c=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> > > > =A0 hw/i386/vmport.c=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> > > > =A0 include/hw/i386/pc.h=A0=A0=A0=A0 | 13 -------------
> > > > =A0 include/hw/i386/vmport.h | 16 ++++++++++++++++
> > >=20
> > > What about moving it to hw/i386/vmport.h (no under include/)?
> > >=20
> > > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > >=20
> > >=20
> > Can you explain the logic that separates between hw/i386/*.h to
> > include/hw/i386/*.h?
>=20
> Headers in the include/hw/ namespace can be consumed by all machine targe=
ts.
> If this is a target-specific device, having it local to the target
> (hw/i386/) protect generic code (and other targets) of using it. This hel=
ps
> detecting wrong dependencies between components.

I think it's true. However when headers were moved to include we
weren't always able to do this correctly. So some i386
specific headers are under include.


> > If it makes sense, sure I will move it. I just don't know what is the
> > convention here.
>=20
> Michael/Paolo/Eduardo what do you recommend?




