Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B838FC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 23:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8132B2196E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 23:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fncMyYgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8132B2196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUIyt-0007dr-Ob
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 18:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iUIyF-0007AO-8M
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 18:19:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iUIyE-0006JF-CT
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 18:19:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56107
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iUIyE-0006J7-9P
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 18:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573514381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=3d5s3anxcRC3Fa2hhM3VsGdVkK3iGSZnDfkaUdO2Ztg=;
 b=fncMyYgX46dIyFnBEVAGZKB4QKluJDf2w0hOIrndit5Wyj1ip0EBzSrDVu4TVlkvFLv9mE
 WuiJKy/Ugf/Dqsu6SPFMfKpCX2lHF5Zzn+NgxmY9su+Ymb0OZuuJ16SZ5aSYD17bBqtMCc
 /MMQLrVlmC1Jkd6OpBZ4TPOjc7WCWWs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-ik7gMga4MHGltmsbZgv3yg-1; Mon, 11 Nov 2019 18:19:40 -0500
Received: by mail-wr1-f72.google.com with SMTP id j17so10902831wru.13
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 15:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GpD93F+W3OE3fnxYmx82ds9warJfRt1oP9t9nkePiaQ=;
 b=oMMTHtGxCQz+fyxuefihFQFlIfCb+xEMmI0/FS2NXuVfwNQIrv0M2Yt3PRGihxQHrR
 OYt8EFQt0UdmaMc0pYxR9Qug8E6CrPQ5eKMjZu+8/AqRthtWN98D0sEn5UQOpSM5VYBD
 emeJD7a/+W1+Oy9a14qO+YFRjv8keSwSrC5OclTkljjIZtHeAGH2F4vNXiCan4GNya+1
 1rZn2aGTT/KAD7ryAr05ZwR69wRKUdH5R+ezBlu6jCsHoOikSAdRacUAJ/N1Jh1uqArd
 rCQoUTJA6/W55cgHoOGOzFmuEF0vyO5DPBkkD46oaWKaL0cHZSASOgXgNKjPiUNOPIvJ
 cY5g==
X-Gm-Message-State: APjAAAUwsSrYmMh2eKRR0O0OiTs9UDbP5SCNZgOp/WjGdg108G1W5zD6
 3xCHWMDqI6y3SzLb48E0MiNggjO3abUAPcgi3PSwzOoiFAxkOrlobxPjf1VpqpRqspX4f3r5dV2
 o7EKKrw9LBCLi2PE=
X-Received: by 2002:a1c:560b:: with SMTP id k11mr1268993wmb.153.1573514379197; 
 Mon, 11 Nov 2019 15:19:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfZq1TGgKxyJ7vvHyk4/MXfLmZe47y08Yj0f6Aa0kyoCVOe9RKOnK7spVjN38n7+DQ8XLn4Q==
X-Received: by 2002:a1c:560b:: with SMTP id k11mr1268984wmb.153.1573514378962; 
 Mon, 11 Nov 2019 15:19:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8c9d:1a6f:4730:367c?
 ([2001:b07:6468:f312:8c9d:1a6f:4730:367c])
 by smtp.gmail.com with ESMTPSA id j63sm1650367wmj.46.2019.11.11.15.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2019 15:19:38 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] migration: check length directly to make
 sure the range is aligned
To: Wei Yang <richardw.yang@linux.intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190712032704.7826-1-richardw.yang@linux.intel.com>
 <20190719175400.GJ3000@work-vm>
 <0fd200f7-ad92-d753-23ca-8c89a27fd346@redhat.com>
 <20190719180651.GM3000@work-vm> <20191028011015.GA3893@richard>
 <20191029070419.GA16329@work-vm> <20191029082112.GA3021@richard>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f2e640c9-8ae4-ce3e-1299-2083a5cdd145@redhat.com>
Date: Tue, 12 Nov 2019 00:19:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191029082112.GA3021@richard>
Content-Language: en-US
X-MC-Unique: ik7gMga4MHGltmsbZgv3yg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: rth@twiddle.net, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/19 09:21, Wei Yang wrote:
> Thanks Dave
>=20
> Paolo
>=20
> Do you feel comfortable with this?
>=20

Queued now, thanks.

Paolo


