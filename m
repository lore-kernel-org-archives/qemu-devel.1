Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D44C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8C020851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8C020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34179 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTm7M-0008Uh-Ah
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:42:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hTm30-0004um-FT
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hTlwE-00033u-Sl
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:31:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hTlwE-00033K-O5
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:31:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9761F74B5;
	Thu, 23 May 2019 11:31:06 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-6.rdu2.redhat.com
	[10.10.120.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AE892620D2;
	Thu, 23 May 2019 11:30:58 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190520231008.20140-1-mst@redhat.com>
	<CAFEAcA80Q8zWxM4TBVMZHLuOzo0HSpT=4C76uAwdMjLn2Xye=w@mail.gmail.com>
	<20190521092553-mutt-send-email-mst@kernel.org>
	<20190522150642.3da34e6b@redhat.com>
	<4b230fb0-ae2c-5221-39cb-1bed7b6df8d0@redhat.com>
	<CAFEAcA8rxpMEQcdeHk9s3Cs8f+LMzM2Y=RE_hW9Y7UKRkZhqpg@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c867d061-f2f4-54f2-a80d-e14bec419e30@redhat.com>
Date: Thu, 23 May 2019 13:30:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8rxpMEQcdeHk9s3Cs8f+LMzM2Y=RE_hW9Y7UKRkZhqpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 23 May 2019 11:31:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v2 00/36] pci, pc, virtio: features, fixes
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
Cc: Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 05/22/19 23:15, Peter Maydell wrote:
> On Wed, 22 May 2019 at 15:22, Laszlo Ersek <lersek@redhat.com> wrote:
>> This is very interesting. I had obviously tested booting
>> "bios-tables-test.aarch64.iso.qcow2" against "edk2-aarch64-code.fd",
>> using TCG, on my x86_64 laptop. (And, I've run the above exact command
>> just now, at commit a4f667b67149 -- it works 100% fine.)
>>
>> However, I've never been *near* a 32-bit ARM host. Therefore my
>> suspicion is that the AARCH64 UEFI guest code tickles something in the
>> 32-bit ARM code generator. It could be a bug in 32-bit ARM TCG, or it
>> could be a bug in edk2 that is exposed by 32-bit ARM TCG.
> 
> Does it repro in a 32-bit-chroot in an aarch64 host ?
> I don't know if that might be easier for you to set up than
> getting access to real 32-bit hardware.

If this test is still necessary (e.g. for repeated testing), I might be
able to run qemu-system-aarch64/TCG in a 32-bit QEMU/KVM guest on my
Mustang. I was preparing to set up this kind of nesting, when Igor gave
me access to a real aarch32 host.

Thanks
Laszlo

