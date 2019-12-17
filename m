Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C460C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B34D2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7j3VoaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B34D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihEnN-00072S-9e
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihEmO-00068Q-Qi
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihEmL-0001E8-GL
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:28:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53991
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihEmL-0001Dx-1Q
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576596532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=CXeMealuP7hjG2ThTWAelozFjETM1TZVh0hXRm7nnmM=;
 b=L7j3VoaFb2r8M4zvCS+SAo+JSaswwsldM0itXpn+wWe3CUN8toxYfP9GGirNYOGUElDAf6
 dcr7ret/kPpUTFZbl42LoMyoBxkrX/ClTxTCgQdeQzLaO+fol/VYzVSPj2rVCjeKQ7JR9E
 vt1qArPFhO90S5rQkXiIPS8j/K5EH1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-2TTKQu0FMuyZk0YtbHfyOA-1; Tue, 17 Dec 2019 10:28:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E6C0107ACC9;
 Tue, 17 Dec 2019 15:28:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-149.ams2.redhat.com [10.36.116.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B86168872;
 Tue, 17 Dec 2019 15:28:46 +0000 (UTC)
Subject: Re: Vote against removing the bluetooth subsystem from Quemu.
To: Andreas Scheucher <andreas.scheucher@otaya.cc>
References: <mail.3cd9c49a-989a-40c1-b627-b2197ff912ce@storage.wm.amazon.com>
 <0102016f14331e64-fc1b813a-187a-4ece-9c9e-8f78ea832fe9-000000@eu-west-1.amazonses.com>
 <CAFEAcA8hXW7YhfsF60-wdzOHHf5e5yO9-bNSTWti9Z5kvJn4+g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8eca441b-5939-24ec-03b0-ee64a8fc84c0@redhat.com>
Date: Tue, 17 Dec 2019 16:28:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8hXW7YhfsF60-wdzOHHf5e5yO9-bNSTWti9Z5kvJn4+g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 2TTKQu0FMuyZk0YtbHfyOA-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/2019 15.17, Peter Maydell wrote:
> On Tue, 17 Dec 2019 at 14:13, Andreas Scheucher
> <andreas.scheucher@otaya.cc> wrote:
>> I found following note in the Qemu documentation: This option and the wh=
ole bluetooth subsystem is considered as deprecated. If you still use it, p=
lease send a mail to qemu-devel@nongnu.org where you describe your usecase.
>=20
>> As GPU passthrough is becoming more and more common (to run Linux / Wind=
ows / Mac OS X simultaneously on the same host to prevent multiboot) on des=
ktop systems, support for the use of the host Bluetooth device in Quemu VMs=
 for sure will be a common use case: https://www.reddit.com/r/VFIO/
>=20
>> For me personally I just want to set up a setup supporting Windows & Lin=
ux to use the first strong nVidia GPU for occasional gaming on Windows and =
video editing with DaVinci Resolve under CentOs.
>=20
> Hi; thanks for your response. It's not clear from your email:
> do you mean that you *currently, today* have a setup which uses
> QEMU's bluetooth support; or do you just mean that you have
> an idea for how you would like to use it in future ? The request
> for users was really aimed mostly at finding if we had
> any current users, because as far as we could tell the
> code we have at the moment is just broken and doesn't
> work at all.

Right, if you have the QEMU bluetooth code in use somehow, please
provide more details how you're using it (i.e. the QEMU command line
etc.). Otherwise, be assured that the current bluetooth code won't be of
any help for your topic, since it is likely completely broken. You then
better pass-through a dedicated USB bluetooth adapter from your host to
your instead, or simply use emulated USB mouse and keyboard with your
macOS guest.

 Thomas


