Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEBAC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175942465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LooRiTLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175942465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiEwh-0000rW-7T
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 04:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iiEw3-0000SJ-Iy
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iiEw1-0001Xa-5V
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:51:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45793
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iiEw0-0001PR-P2
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576835459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zIxTk0slJfUnk07+ZV/fe/msT2krwtpPsCbvM8+O0Y=;
 b=LooRiTLNH5ztsgw+wm5zX+5KVwzAN6ALjP9z+ptL7F6Grj/NUOEb0TSmlyZEHkJ7pJptf7
 rV4Je0Agw6nppGKVndeQX1BFy7yw3o2CaIGJn+9ogjMz3bxikW0Nvz5Ync3roBV81ArSc1
 u9XCttNMgdp1Ox060KGsI0Gr0DxqCOU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-sbHB-6jgOC-hjQ2GOCMFSQ-1; Fri, 20 Dec 2019 04:50:55 -0500
Received: by mail-wm1-f71.google.com with SMTP id f25so2334602wmb.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 01:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z9D8jA2JMJXEn3XVDO8OVymfGlzwydcWfuDID65Adgs=;
 b=qK8u+We7Lw785f0c4JBqC10I5J82lX3N0H6RwRvDgbJz817pB9xPFrCiQdiZiTQOQz
 TnewHrtMr3FQAKgh+CV70oeFem904s/AIFykETvjfnTxA9e6M4f9ugaWvQW7lmMg0sKZ
 Fqr9XxNIJTinotKPwPFk8fC4VAsxuaOc7+ChBvvQisQY+aSjxd5AUtdxf+pWOoAMX3Ml
 yk+u/r+AxFj1NrDhT98J2g2MtnMP+L/VS23ipyjg974hONmiogJnEBFTm9Wu7XXjITW3
 yehPnsEz5f9pEYvwnxXVYoztr2wmtbcZV7RZwd/8YZIAYasEfy/jtmzK74Zh0CPkAZiT
 CI0w==
X-Gm-Message-State: APjAAAXgswffxfO2mCn8SmmjUW1BNHb3SEzS3f8qg9P8bHc2bXtm92EO
 xhbvlSgjbzzSWRdkp4DIb6pYmpbP33PWeCfMsS63n6M4B0q84Ug9AWJs2fc6Jdq/FYlB5TtlxH2
 mDMzMjXCxuhhLxCI=
X-Received: by 2002:adf:fc08:: with SMTP id i8mr15007075wrr.82.1576835454287; 
 Fri, 20 Dec 2019 01:50:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2wj0dTn5bPj70ytRjonVB3xVEhOij1uBwfsnyfQpwB3QHyEpMzTMSJjXlsyX9Q9Lb0Iu+Xg==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr15007032wrr.82.1576835454032; 
 Fri, 20 Dec 2019 01:50:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:7009:9cf0:6204:f570?
 ([2001:b07:6468:f312:7009:9cf0:6204:f570])
 by smtp.gmail.com with ESMTPSA id u18sm9565548wrt.26.2019.12.20.01.50.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2019 01:50:53 -0800 (PST)
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
To: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
 <20191219125504.GI1190276@redhat.com>
 <20191220094712.GA1635864@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bfaf0b42-513c-08f2-2d4f-d99437b7041d@redhat.com>
Date: Fri, 20 Dec 2019 10:50:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191220094712.GA1635864@stefanha-x1.localdomain>
Content-Language: en-US
X-MC-Unique: sbHB-6jgOC-hjQ2GOCMFSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/12/19 10:47, Stefan Hajnoczi wrote:
>> If it doesn't create too large of a burden to support both, then I think
>> it is very desirable. IIUC, this is saying a kernel based solution as th=
e
>> optimized/optimal solution, and userspace UNIX socket based option as th=
e
>> generic "works everywhere" fallback solution.
> I'm slightly in favor of the kernel implementation because it keeps us
> better aligned with VFIO.  That means solving problems in one place only
> and less reinventing the wheel.

I think there are anyway going to be some differences with VFIO.

For example, currently VFIO requires pinning user memory.  Is that a
limitation for muser too?  If so, that would be a big disadvantage; if
not, however, management tools need to learn that muser devices unlike
other VFIO devices do not prevent overcommit.

Paolo


