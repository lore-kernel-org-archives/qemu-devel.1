Received: from eggs.gnu.org ([2001:4830:134:3::10]:39717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g9Pfi-0003fO-Pi
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g9PfU-0000xf-5y
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:09:34 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57948)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g9PfT-0000wY-DM
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:09:27 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180820150903.1224-4-pbonzini@redhat.com>
	<000001d43ea0$02146ed0$063d4c70$@ru>
	<5b9a85eb-cefd-925c-b24b-95b93bbbfce8@redhat.com>
	<000a01d448c8$4a55c0e0$df0142a0$@ru>
	<ea5f162e-bd8a-001c-b78c-25378e3b2919@redhat.com>
	<001e01d44994$d02acb80$70806280$@ru>
	<f8014c4f-f581-bdf9-c853-9ea1b8855726@redhat.com>
In-Reply-To: <f8014c4f-f581-bdf9-c853-9ea1b8855726@redhat.com>
Date: Mon, 8 Oct 2018 10:09:24 +0300
Message-ID: <003b01d45ed5$d7fec4f0$87fc4ed0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [3/4] cpus: protect TimerState writes with a
 spinlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "'Emilio G . Cota'" <cota@braap.org>

Paolo,

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 11/09/2018 08:00, Pavel Dovgalyuk wrote:
> > Thanks, that works. Here is the updated diff (stubs were added).
> > Will you apply it?
> 
> Yes, thanks for the quick test!

Thanks for applying RR patches, but I think you forgot about this one.

Pavel Dovgalyuk
