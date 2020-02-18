Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E02C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760D12176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHKM6f53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760D12176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46TA-0004My-Ka
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1j46SZ-0003vM-2a
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1j46SX-0008F5-P7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:14:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53084
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1j46SX-0008Ee-Lf
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkVbNs8TOZWp5znj9cx1QycbgR9ZFpQTeVCjv6uotl0=;
 b=iHKM6f53+GS+5R9FCNNv2tqt96dVvImp9IbnrUX7T71HVxtaj5uRhs+hH8W7zqp3oZaPCi
 qtSbKcc3sjfVGwump6ZJvNSvrgPqEo8VUR8ap09UObUqXnsfs9QEP2lLatDW0n/EBv9A5S
 jlPuv/npqWvm0Dw/JyVgYy7eziBX+Y8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-jQkRR2nuMXaHm2Iw45K1XQ-1; Tue, 18 Feb 2020 12:14:50 -0500
Received: by mail-wr1-f71.google.com with SMTP id o6so11109641wrp.8
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=JfsHq8FXaZ0WyNMC2vdaaoGHFKHETrOhlNj0vSeLcqM=;
 b=P55K+W5FthxYCBwS1RNs4dmvKS6eWXiiDj7TImHxQoPyOcO43yuyqwl3wacAnqPS7q
 B/oStIR3HsPIYdy4Mu76hbrtYwgpA6cNvr5Rt19PUU+EgeMABaEpoKUiiSs1qClo2jcl
 dFJsrGzrtACCAof6qO4GGlPsFcdMmBX1XN57vCyBqcUxztLg9wXAJYfj5VN1SzrRO8r3
 vxT4WvjBs+9A/Ot/QUpG8m6dnlakpAdy2VZdgdw4K4zzGnmEe8Su9QKMwDUlMkVVBlm/
 MnLO5JTm/DJPNqUth6IZ4VBCrJJI8LAXldtzobZkib4RtEx3nmKguXnk91c9UwZtKWr/
 9fOg==
X-Gm-Message-State: APjAAAVeV6mOAGjq85eq66VmpmPhSj1gxb9q7SDHTkumZsyelmUpamHt
 QWpQn9eyEt7/b8dW8KRLNerMy880UKnMHNZnyUoivtgGD4b0UO1ZJG+B4SyAhzhvKCseAY8SXar
 f90U+MfGxFxBB7Sk=
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr29230335wrq.43.1582046089272; 
 Tue, 18 Feb 2020 09:14:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqxi6b63+py5Mn2YyRuY6BikZi2vFKPXvOnPfJFaH2rpDMGfHkl4Qga0oQk8ioy8nYBgUIrURQ==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr29230318wrq.43.1582046089043; 
 Tue, 18 Feb 2020 09:14:49 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id k10sm7013588wrd.68.2020.02.18.09.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 09:14:48 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] target/i386: filter out VMX_PIN_BASED_POSTED_INTR
 when enabling SynIC
In-Reply-To: <158204497899.18888.4612758973157728331@a1bbccc8075a>
References: <158204497899.18888.4612758973157728331@a1bbccc8075a>
Date: Tue, 18 Feb 2020 18:14:47 +0100
Message-ID: <87h7zn95rs.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: jQkRR2nuMXaHm2Iw45K1XQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com,
 liran.alon@oracle.com, rkagan@virtuozzo.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

no-reply@patchew.org writes:

> Patchew URL: https://patchew.org/QEMU/20200218144415.94722-1-vkuznets@red=
hat.com/
>
>
>
> Hi,
>
> This series failed the docker-quick@centos7 build test. Please find the t=
esting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.

Hm, honestly I don't see how this can be related to my patch:

--- /tmp/qemu-test/src/tests/qemu-iotests/041.out=092020-02-18 14:42:30.000=
000000 +0000
+++ /tmp/qemu-test/build/tests/qemu-iotests/041.out.bad=092020-02-18 16:50:=
07.383069241 +0000
@@ -1,5 +1,29 @@
-..........................................................................=
.................
+..................................E.......................................=
.................
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ERROR: test_pause (__main__.TestSingleBlockdev)
+----------------------------------------------------------------------
...
+Exception: Timeout waiting for job to pause
+

something else is broken?

--=20
Vitaly


