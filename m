Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157F4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D5620725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkP8iNYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D5620725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpP9-00034C-5v
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jtpOQ-0001pX-2O
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:32:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jtpOO-0004jJ-03
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594373547;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h56/Z80cp6ePDIbE40i4wd8+2ct+5+WWqno5cc67Ckc=;
 b=BkP8iNYgtJawvpD8UBYoZZW0KUrg5xNGopfHF3gaYSlI6HPdagUhFR60UGQyiN5Qi5hDub
 8pSpKC7lBkamlBz+PTJCL+y82iSaTC5l3oET5de7VoebHBFIUP3IkkvSWm85PFRm6kNzBq
 5q+hGCkRTIlwMPR4DmgPiDX05ax6c2I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-j5vJsK1_MnqUk_DZYxq2DQ-1; Fri, 10 Jul 2020 05:32:25 -0400
X-MC-Unique: j5vJsK1_MnqUk_DZYxq2DQ-1
Received: by mail-wr1-f72.google.com with SMTP id i10so5391589wrn.21
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 02:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h56/Z80cp6ePDIbE40i4wd8+2ct+5+WWqno5cc67Ckc=;
 b=np48+Sec2wNgL2i3EuX2fnBpQ/yM9ZGH/dOWzxA5aTlrdvK6CNYXU5YLKiCqq3AsdB
 tpB2jVohL2SRAPNstXvxEt6tUjhhOkZzdDiFXnTt96bg4bFbOdBwW7DSH1ghVjG40tNA
 edpzNIc3tQlqrVYLy5dflaKOd2QJ3lrV7ubNv5rcUKLEv77EI6Rg/KfcIwvETk3RgVNi
 /x3Rdhgsss5P+Tcixx9U+0+xXPpqasHrTC0cRvmAalobMgQiueM2c2FXMSRz1wf2FXQR
 0QQAUb5V8VW5qmA8kQiYtDZDT5nM6CoSZzp6E6ukgcuaOOZKX2Sy75um1iLCyoZSKo1h
 vqsw==
X-Gm-Message-State: AOAM53266SDdEAQFVYsC3KwWXNIwWxpe1d2/RtA8kD/UGWW3tuF0jmJM
 onZUlGHNuT33I6s4ZgYMGhe0paf4tL+H6ZGU/RdV5FEpy1BnIr21bmwzQsTPFFb0tT7xuLnH6K3
 CQx07Qo+onvzbpiI=
X-Received: by 2002:a7b:c406:: with SMTP id k6mr4156598wmi.130.1594373544309; 
 Fri, 10 Jul 2020 02:32:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqArFcKKrpfTzoOBLKfR3/kQPzHYOIcW3pmzjVxlG6nzHxAzkfhuJsQH4xVtgGL56Zp53eTw==
X-Received: by 2002:a7b:c406:: with SMTP id k6mr4156583wmi.130.1594373544075; 
 Fri, 10 Jul 2020 02:32:24 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id c25sm8169788wml.18.2020.07.10.02.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 02:32:23 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 2/2] hw/char/serial: Allow migration of the I/O serial
 device
In-Reply-To: <20200703185809.5896-3-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 3 Jul 2020 20:58:09
 +0200")
References: <20200703185809.5896-1-f4bug@amsat.org>
 <20200703185809.5896-3-f4bug@amsat.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 10 Jul 2020 11:32:22 +0200
Message-ID: <87a707zpeh.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: quintela@redhat.com
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> The serial device mapped on the I/O bus hold a migratable
> SerialState. Keep the same version range from SerialState:
>
>  837 const VMStateDescription vmstate_serial =3D {
>  838     .name =3D "serial",
>  839     .version_id =3D 3,
>  840     .minimum_version_id =3D 2,
>
> Fixes: 10315a7089 ("serial: make SerialIO a sysbus device")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

In the sense that the vmstate stuff is correct.

Reviewed-by: Juan Quintela <quintela@redhat.com>

But as Peter says, it appears that it is better to just drop the whole
serial_io infrastructure if we can switch the mips simulator
implementation to use mm, no?

Later, Juan.


