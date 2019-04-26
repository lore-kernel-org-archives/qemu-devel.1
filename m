Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9487C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE212206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE212206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49629 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK47O-0005Zv-UL
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 12:54:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hK46b-0005ED-Ff
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hK46a-000377-9y
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:53:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hK46Y-00033L-TF
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:53:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AEBBC085524;
	Fri, 26 Apr 2019 16:53:41 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-104.rdu2.redhat.com
	[10.10.121.104])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0CCA160E3D;
	Fri, 26 Apr 2019 16:53:34 +0000 (UTC)
To: Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liq3ea@gmail.com>
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-4-liq3ea@163.com>
	<a27cd912-4f58-55ac-1aae-e4999fa3d84d@redhat.com>
	<CAKXe6SJZWs7HtXutX6W3saDhaNDtVPMQEh2+s+9XiM3TtZqLdQ@mail.gmail.com>
	<20190425081519.n4leez6sz2wlvpla@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e5087d25-fc45-84e9-db61-5a4c38f69c74@redhat.com>
Date: Fri, 26 Apr 2019 18:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190425081519.n4leez6sz2wlvpla@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 26 Apr 2019 16:53:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] tests: fw_cfg: add reboot_timeout test
 case
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
	Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426165333.oQHZloC9CQUn1FbM1WaJ593wFgO5mxTKzfmgjuJMpdc@z>

On 04/25/19 10:15, Gerd Hoffmann wrote:
> On Wed, Apr 24, 2019 at 09:16:56AM +0800, Li Qiang wrote:
>> Thomas Huth <thuth@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:29=E5=86=99=E9=81=93=EF=BC=9A
>>
>>> Is this endianess-safe? Or do you need to byteswap reboot_timeout if =
the
>>> host and guest endianess does not match?
>>
>> Good question!
>>
>> IIUC, the qemu fw_cfg store the 'file' entry data just in byte stream.
>=20
> No.  Integers are defined to be little endian.  See fw_cfg_add_i64() fo=
r
> example, there is an explicit cpu_to_le64() call for that.

Endianness may be defined on a case-by-case basis (i.e. if you introduce
a new named fw_cfg file, you can make its contents whatever you like);
however, the integer-adding/modifying helper functions do express a
preference for endianness. Search "include/hw/nvram/fw_cfg.h" for "endian=
".

Thanks
Laszlo

