Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C33C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B447206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pcq74WUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B447206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMcJt-0005Ae-6l
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jMcJB-0004Ld-1A
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jMcJ9-0003EG-C5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:53:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37444
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jMcJ9-0003E2-4X
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586458426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aYV4uTplYMAq8KuYDV68hAEaDjLoqvdKwWRFKBvfSsI=;
 b=Pcq74WUIxI8ZyxmgzK/msKZPqhzFgPJdjaVzK160AlNZeu8M7KxBXKf+RGcXNpSe9Vr68q
 i3OMAlipF4+EWBC+WjvLwAZdv7QeeqJA6D1Zwfp9Po5AuPx7esmFzv2dZRK7F/LL8qQ0Zl
 zG3jgN1utfdJ/v8eJa0tacMIGk/F8fk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-ZVoxWenSN529kwrAMgJTbw-1; Thu, 09 Apr 2020 14:53:44 -0400
X-MC-Unique: ZVoxWenSN529kwrAMgJTbw-1
Received: by mail-wr1-f70.google.com with SMTP id o10so7048052wrj.7
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 11:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=62KN7G64tPZWKHEdlakQ9hbfUlW8qTH35Q5STcBfFZ4=;
 b=PgANu+ALsKLAlrjol57sAWzQyb11/XBzsHKahyKV6sE6HSn2NXJya3qZdVitKVU669
 p9j7QI4FewLqjihZcqN8T0AP6JaDd5l4mIs2zxCzUmsq5MEbTPdXQn+4dHEaJ//eefF9
 v9IMAV5h5ehJDK3XAILZkuxQ9tvgFsurvkyg1jvAqgrk9ci2NUIghI8Cv1vuN4eH2hPU
 L5ylW5Mw1CasITdK4dK7ag++cAnxLE4P/GAJZRWUMnuvRi39oeUbn0bRA/cFU7H/MXB0
 wPDVdGejSk5QOOhEKsskK+ZbFmrnamWGkl8anrC8lxx8mdtHCiuT8AoZaYNzS8bsjW0S
 IFwA==
X-Gm-Message-State: AGi0PubL5Vnimm2N52SAklv/hrovH0PzM6i7Zoif/UFtlgF22K+Jo+pA
 FWwiaP64qG+X63cpGzOl6b0g5THcd9UCFgYVhsQODyJAbrltxYujMchnu9YfAPYjPCDOepccSn6
 T5OhjjuyWGe2LkhE=
X-Received: by 2002:adf:eed1:: with SMTP id a17mr525527wrp.287.1586458423707; 
 Thu, 09 Apr 2020 11:53:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypLms8/SxvUhF4AAHQlacvPXscWOESP//mkOhGlSyFQkDSkXeUqcxzvqEDah1C4yOb1XIb78uA==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr525516wrp.287.1586458423536; 
 Thu, 09 Apr 2020 11:53:43 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id c190sm4814039wme.10.2020.04.09.11.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 11:53:43 -0700 (PDT)
Date: Thu, 9 Apr 2020 14:53:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH-for-5.0] target/m68k/helper: Fix m68k_fpu_gdb_get_reg()
 use of GByteArray
Message-ID: <20200409185339.GB40299@xz-x1>
References: <20200409172509.4078-1-philmd@redhat.com>
 <20200409182215.GA40299@xz-x1>
 <92ba02b2-1bad-9f97-a931-2270b9c3508d@vivier.eu>
MIME-Version: 1.0
In-Reply-To: <92ba02b2-1bad-9f97-a931-2270b9c3508d@vivier.eu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 09, 2020 at 08:36:22PM +0200, Laurent Vivier wrote:
> Le 09/04/2020 =C3=A0 20:22, Peter Xu a =C3=A9crit=C2=A0:
> > On Thu, Apr 09, 2020 at 07:25:08PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> Since a010bdbe719 the gdbstub API takes a GByteArray*.
> >> Unfortunately we forgot to update the gdb_get_reg*()
> >> calls.  Do it now.
> >>
> >> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> >=20
> > Should this be instead 462474d760 ("target/m68k: use gdb_get_reg
> > helpers", 2020-03-17)?
>=20
> No, this one is correct because it uses an "uint8_t *", then a010bdbe719
> changed this to a GByteArray and didn't remove the "+ len".

Ah right...

--=20
Peter Xu


