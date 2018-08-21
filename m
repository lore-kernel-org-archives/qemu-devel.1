Received: from eggs.gnu.org ([2001:4830:134:3::10]:58002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fs5Xs-0007Aq-Kk
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fs5NK-0006MJ-Gj
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:03:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fs5NK-0006L5-9Z
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:03:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id 20-v6so9660515wrb.12
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 05:03:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1534796770-10295-1-git-send-email-minyard@acm.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <266404d6-f23f-c60f-29b9-6cdd68cac8d9@redhat.com>
Date: Tue, 21 Aug 2018 14:02:53 +0200
MIME-Version: 1.0
In-Reply-To: <1534796770-10295-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/8] Make the pm_smbus code more correct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>

On 20/08/2018 22:26, minyard@acm.org wrote:
> These changes make the pm_smbus device work more like the real thing,
> adding block transfers, I2C block transfers, and interrupts.
> 
> It also adds vmstate transfer for the smbus device in patch 5.
> That patch could probably be left out if that is not desirable.
> 
> Patch 7 works around a change made to work around an AMIBIOS bug and
> is necessary for interrupts to work.
> 
> Patches 9 and 10 add vmstate transfer for SMBus EEPROMs, and obviously
> requires patch 5 to work properly.  These could also be left out.


I have applied 1-6/7/8 for now.  Thanks!

Paolo
