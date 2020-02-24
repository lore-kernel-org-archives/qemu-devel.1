Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65907C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319522072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKEPCpcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319522072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6CoU-0005w1-Dz
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 07:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Cng-0005Tb-LQ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Cnf-0002zt-P0
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:25:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27614
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Cnf-0002yq-LA
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582547123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7j5YB3cjgtWFhF34JmImPBo6iweGoNLc+6Oswu8+o+Y=;
 b=TKEPCpcDy8RGqydwCNFCwmsqIVfGPioZxTwYon6LT9jEdzX4ckCyPPRDTCQqFLq6PEOzB+
 W0UCxMWY6/FOEk/lpaPZp55Ug0vLLgWr23dTKhN5WhpvzDYdxIFeRzHyxLzhLqhJek4GB4
 ywOaEFO5DD6mq9DrqwKuk4JXCn19Us0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-VDyFAHEHPiqdhyM3uIInaA-1; Mon, 24 Feb 2020 07:25:21 -0500
X-MC-Unique: VDyFAHEHPiqdhyM3uIInaA-1
Received: by mail-wr1-f69.google.com with SMTP id u8so5523526wrp.10
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 04:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LxO5kts/rlyEGT54W4K4mwD/UZNhQPCjOqsxL67KsvM=;
 b=gcgykYGMqLbBCGikw1+GXyPGSt5cAnaQhFiRbW1zsh/n7/CypkweGuzkpMShQaIETz
 qLyNdzGV6e3adpf/1WXvDE4obdnGG4bXnJpoztHan39U8KYv+yxXrwVbU/U4d2N6rOQz
 XG+6jf5Od2uND01vy9PogW+x/miEU0Vxson02d6NXvlfQVo7LENsOduGQut/VbNLG1ZA
 GuKT1F+U9MlLQwUdzGCgJCbbCD2sO6daJDe4MXdwbAnNDtTxYSgH5pWuODKQhbgXwVJ0
 Gtip4PzuPx6cXFe+wfeb5hDtvS6J2gH+W828ykMfc8ELNNmwpBD3xhULBJzgQQje32iY
 rhQw==
X-Gm-Message-State: APjAAAVWGIDABFR6C7OfjbACOaZdDT9eyylv9a05P7CgIzTYXbOdIk9o
 iLA9yR+Of39FnsoRQk9LKB7stDPoLK7RTDL7LtaeW+eFwy/sQULy3I8QshbHuglRywRuBXscTh7
 5uoTnOlMAjN5hg8o=
X-Received: by 2002:a1c:a9c7:: with SMTP id s190mr21177586wme.97.1582547120005; 
 Mon, 24 Feb 2020 04:25:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLQ/5UwPUgsL58gD7VxydZdt7mEQR4MHMEmUJe8TNw6MXtyzqfiOkE9IRAVqdLNw3x4nK43g==
X-Received: by 2002:a1c:a9c7:: with SMTP id s190mr21177563wme.97.1582547119831; 
 Mon, 24 Feb 2020 04:25:19 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id u14sm18594398wrm.51.2020.02.24.04.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 04:25:19 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Reactivate MIPS KVM CPUs
To: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>
References: <4bee-5e53bf80-17-5b657e80@176142454>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c812aa14-5203-7174-c08b-9dd1b81d96b5@redhat.com>
Date: Mon, 24 Feb 2020 13:25:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4bee-5e53bf80-17-5b657e80@176142454>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: James Hogan <jhogan@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 1:20 PM, Aleksandar Markovic wrote:
>=20
>  > Philippe Mathieu-Daud=C3=A9 wrote:
>  > > Aleksandar Markovic wrote:
>  > >> From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>  > >>
>  > >> Reactivate MIPS KVM maintainership with a modest goal of keeping
>  > >> the support alive, checking common KVM code changes against MIPS
>  > >> functionality, etc. (hence the status "Odd Fixes"), with hope that
>  > >> this component will be fully maintained at some further, but not
>  > >> distant point in future.
>  >
>  > My only worry here is, do you have hardware to run tests?
>=20
> Yes, I do have access to the appropriate MIPS hardware.

Great news :)

This is something to consider when we add more GitLab CI runners (for=20
automated testing).


