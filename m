Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B7BC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92AFA21774
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adxezOzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AFA21774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaclU-0005IF-Fv
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iacey-0000pq-2C
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iaceq-0005Wv-Pj
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:33:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iacep-0005P3-S5
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575020023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3qp03P3CCkaNPpSFfnRZDlsJdXjRmnti1042vHc0s1s=;
 b=adxezOzL4Q20SkU5sYB5VAH64pEURJFZvlh5UYvrb/0uJsdB+RPxr41iwua/Vtdb2VpeaD
 CPSNTd/R3gEA2LgjxEJCY6VigxegnkgeoyJKa1iAmBWfg5y2h2DlHbr18tPKq28F45+YlY
 mNIehHdJ5bev9urYNo2up0ur43aRd8w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-kGCwj-GQOGq9adFbcsEFrw-1; Fri, 29 Nov 2019 04:33:42 -0500
Received: by mail-wr1-f70.google.com with SMTP id h30so1718196wrh.5
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 01:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dke7NLkmdO8ceMJ8pQ8q9FeM5rNXBmV8jAUI3+iEJIY=;
 b=A5nydah5pbEGXPL78E+/ut9+VLGXBZwNaZpfneO0fqH39iT0fiUOm69Nx84iXPAedO
 5yv70L3bI64V23WYb3W0c+LIhfdXYJxJ17wdYfaXh7QW8DwFnbOnnvKf42CdwzuoXr9v
 4oylwAPr4bnqNp6jWJe9n3rvyIhofFboIzIjD5WA4ljxfu4B993wKSQLd+QXvYBqIOtF
 VxsO7Qt2RcD+QC/kO5MrhyATXaqVhoCRJ3XLCTA6Lx/ZdHa/I5LDEmgn9IfgCh7eranD
 MAxXnFVfwmM5Il41nA1UDYHP1NTeNF76SVZA2GLTEtDBzrxamHOUm5TEOzCltrFTNgsu
 LQxA==
X-Gm-Message-State: APjAAAXH0zIRtyIhqCSDy7XduQ+/yacKQXtyLNgpqerMBtA4QCbKsYkj
 XR++2FoYSeMNRyBwfEfL3u4I5H2WC9oCd6qV5pdd/GKrhHY3HP38WG/N5eQZ+cy2uMMzDLKvrGa
 a4Jfklt+KOTm/5I8=
X-Received: by 2002:adf:c50a:: with SMTP id q10mr13389728wrf.374.1575020021191; 
 Fri, 29 Nov 2019 01:33:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqsTrSM1CMo34niefpDp2+yx6rOvL3laSZdsDfaw3gcInRpvq3L5nLx2IcByRNm/zkY8/IOQ==
X-Received: by 2002:adf:c50a:: with SMTP id q10mr13389709wrf.374.1575020020932; 
 Fri, 29 Nov 2019 01:33:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:459f:99a9:39f1:65ba?
 ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
 by smtp.gmail.com with ESMTPSA id u18sm6545537wrn.19.2019.11.29.01.33.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2019 01:33:40 -0800 (PST)
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
 <CAMxuvawieN7JQZkRku19v5X-o6q664Wz1Rtx3+Wz3d33m-7Tug@mail.gmail.com>
 <20191129092713.GA2260471@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b441014-1852-3257-2bc5-897cc51d08dc@redhat.com>
Date: Fri, 29 Nov 2019 10:33:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129092713.GA2260471@redhat.com>
Content-Language: en-US
X-MC-Unique: kGCwj-GQOGq9adFbcsEFrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/19 10:27, Daniel P. Berrang=C3=A9 wrote:
>> Yes, with a fallback path currently using a temporary file under /tmp
>> (we may want to use shm_open() instead, or a different location such
>> as XDG_RUNTIME_DIR? - and use O_TMPFILE)
> We can't assume either /tmp or XDG_RUNTIME_DIR is on tmpfs as that is no
> where near standard across all OS distros, and even if on tmpfs these
> dirs can be size limited to a significant subset of available RAM. IOW
> we can't safely use them unless explicitly told to.

Agreed, mkstemp+shm_open seems better.  Perhaps this could be done in
hostmem-memfd.c though, basically as a fallback option?  In principle
one could even use getmntent to search for a hugetlbfs mount.

Paolo


