Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC23C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AAE20721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIp7KsiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AAE20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHa5-0000Qs-88
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jKHXj-0005zF-Nl
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jKHXh-0003a9-WF
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:19:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50080
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jKHXh-0003ZT-OT
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585901949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNPy9Vvo4Bc8OVMH47Scx7uwUK9/GzPNj/QmDrvBlJE=;
 b=DIp7KsiEce+Mt3DKG/N6NUFQI4q/1F+4VlvtKfJGZ0fA8l2s+T4CJ2avgEF2C6RDmFf3Tr
 JtrwClIUV9/DTcXZVESh6w8Jw2wvQxn18emSdIvVSUJX8tPdsUQ3ywwK91t7A35x0p0nZ2
 d+GA2Gs/8oG3zJ79e4HR7M3jP0CtnTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-f_5pwS6MNNOkCXVrDFSlsw-1; Fri, 03 Apr 2020 04:19:07 -0400
X-MC-Unique: f_5pwS6MNNOkCXVrDFSlsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99ABD107ACC7;
 Fri,  3 Apr 2020 08:19:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C11D99E0D;
 Fri,  3 Apr 2020 08:19:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E320317502; Fri,  3 Apr 2020 10:19:02 +0200 (CEST)
Date: Fri, 3 Apr 2020 10:19:02 +0200
From: kraxel <kraxel@redhat.com>
To: =?utf-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>
Subject: Re: is just a wrong function name of libusb_get_port_number? request
 for a review of the bug fix(Internet mail)
Message-ID: <20200403081902.tvjuv6gel3iucub7@sirius.home.kraxel.org>
References: <02a07a59c3964199b73b1145e4abe0e9@tencent.com>
 <20200403065042.cirj4ih3fl45wlqb@sirius.home.kraxel.org>
 <ffdaa53629a94b20aa7b1023911e41a6@tencent.com>
MIME-Version: 1.0
In-Reply-To: <ffdaa53629a94b20aa7b1023911e41a6@tencent.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: hdegoede <hdegoede@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 03, 2020 at 07:05:13AM +0000, bauerchen(=E9=99=88=E8=92=99=E8=
=92=99) wrote:
> thanks, but my libusbx version is libusbx-1.0.15-4.el7.x86_64 ,
> I can find libusb_get_port_numbers function in libusb-1.0.so.0 but find l=
ibusb_get_port_number
>=20
> [root@t]# strings /lib64/libusb-1.0.so.0 |grep libusb_get_port_number
> libusb_get_port_number
> [root@t]#

kraxel@sirius ~# grep libusb_get_port_number /usr/include/libusb-1.0/libusb=
.h=20
uint8_t LIBUSB_CALL libusb_get_port_number(libusb_device *dev);
int LIBUSB_CALL libusb_get_port_numbers(libusb_device *dev, uint8_t* port_n=
umbers, int port_numbers_len);
LIBUSB_DEPRECATED_FOR(libusb_get_port_numbers)

So libusb_get_port_numbers replaces libusb_get_port_number, seems you have =
an
old version which hasn't yet libusb_get_port_numbers.

On old version qemu should fallback to libusb_get_port_path, but maybe the
version #ifdef is wrong so this doesn't work properly for some versions ...

According to my /usr/include/libusb-1.0/libusb.h libusb >=3D 1.0.16 declare=
s
LIBUSB_API_VERSION >=3D 0x01000102, so that looks ok.  Hmm, not sure what i=
s
going on here.  In any case the libusb_get_port_path fallback code path
should work.

cheers,
  Gerd


