Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078F7C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C411A2071C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZRYpUt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C411A2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXibX-0005La-Tf
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 04:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iXiZw-0004Qi-3B
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iXiZt-0003Pt-Cy
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:16:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44431
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iXiZt-0003PX-1P
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574327800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=ZaaaXO30YPU5Tglk5XRk2qkrncuy0xtt35P8QhBuIIs=;
 b=BZRYpUt3xiZo2IrHHpkXP7KOLXS9e8PqHLEBR/zQ4MuKUPs9nomkWsVJpkMUpH55lESom3
 IXVQsGm8MNSCPfoByKbWyeejsxwhLCjhcIx8VtrX0cNRM6OJreK4XCGGY+AWTkx7bZTFg9
 /XnwSmRts+89x5aJMrhSrUTI5UgOHh0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179--He0ZUtlPgWy6tjrRjETfg-1; Thu, 21 Nov 2019 04:16:39 -0500
Received: by mail-wr1-f72.google.com with SMTP id q6so1734801wrv.11
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 01:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4Y2VUG1uFgQimWXBBaeYjvmWC5l14iP10LtnwHQU6MY=;
 b=J22zbzz2Ged8xUhCk59DxZyctM6u9l+5I2bJ5Fjqn8lgsHVl0xzOFRw/6SO06LNhmy
 ModfBWDIu8BKYTf1XhET/8rb3sbdW65Go03j2yIddhJPsSPrVU5C7JVajPD0gmGusZaU
 nEmk8K08y27CU+YvHt9KQ1WKci4k5fxFXKgAH6ti8ZwR1ptMY2F93+hWolNarIn9Ag6i
 oixZ3Xw3TvZwjpKbqrDCt6ve6J3frQ75PPbE3WdDicpRgRZw90ktCXBPPj1STsq5h+j8
 K/s4L5eqiUM6aiGNMngiXQC36wFw9foJQxHvZS6b3iYLHkx1SQvQo2usnOljLGJzQa+L
 KeLQ==
X-Gm-Message-State: APjAAAVpqogDPZqn+4R2JSKiRyjAkX5KjrrU6F/EabFZSbxWKWrpyhB9
 TmGHwELOiAlr3ChypuWS7+iKCAl1ofJx23QX6jQHedqoIAl8t55Ap7xqpyykzESLpzAH4Iofd07
 rFwKbpwau/Uqmkfg=
X-Received: by 2002:adf:e2cd:: with SMTP id d13mr9285791wrj.221.1574327797846; 
 Thu, 21 Nov 2019 01:16:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQP9C6XUnqkHbLzf/xdgOrtwYAjm2CunKt+YzO77emFnBNoy/B9UzG2+hytVgmyfIN+uVl8A==
X-Received: by 2002:adf:e2cd:: with SMTP id d13mr9285772wrj.221.1574327797583; 
 Thu, 21 Nov 2019 01:16:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744?
 ([2001:b07:6468:f312:71a5:6e:f854:d744])
 by smtp.gmail.com with ESMTPSA id m15sm2662407wrj.52.2019.11.21.01.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2019 01:16:36 -0800 (PST)
Subject: Re: [PATCH for-4.2 1/2] i386: Add new versions of
 Skylake/Cascadelake/Icelake without TSX
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20191120164912.32384-1-ehabkost@redhat.com>
 <20191120164912.32384-2-ehabkost@redhat.com>
 <b1d8c3ef-646a-85c7-176b-c4429f36d384@redhat.com>
 <20191120184258.GS3812@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <afd960e8-103e-b166-34c3-f6db1df45277@redhat.com>
Date: Thu, 21 Nov 2019 10:16:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191120184258.GS3812@habkost.net>
Content-Language: en-US
X-MC-Unique: -He0ZUtlPgWy6tjrRjETfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Jiri Denemark <jdenemar@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/19 19:42, Eduardo Habkost wrote:
> The plan is to set default_cpu_version=3DCPU_VERSION_LATEST on
> pc-*-5.0 (or, more likely, 5.1).  But this will happen only after
> libvirt starts resolving CPU model versions.  See the
> "Runnability guarantee of CPU models" section at
> qemu-deprecated.texi.

Thanks!

Then the patches do not interact negatively with my VMX series.  I have
queued both of them so that we can get the pull request out with all the
TAA bits.

Paolo


