Received: from eggs.gnu.org ([2001:4830:134:3::10]:53509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ewM4q-0002oC-QJ
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 02:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ewM4n-0006vG-Kt
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 02:09:24 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33804)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ewM4n-0006tj-CS
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 02:09:21 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <CAMo8BfLuAdsdRScY+CgTzd0EBn3_kAFc=ysEwgp3MrM_+42viQ@mail.gmail.com>
	<000301d3bb73$e997a8e0$bcc6faa0$@ru>
	<CAMo8Bf+seSrT9HBFL1tspoDQ-9s9nGrXueYRt6v2nF4XzZbdfA@mail.gmail.com>
	<000401d3bb7a$418b9fb0$c4a2df10$@ru>
	<CAMo8Bf+Mqjer86N0LnCf0pofo9hyBZtRUXz4CiYo6Vr9d2V0jw@mail.gmail.com>
In-Reply-To: <CAMo8Bf+Mqjer86N0LnCf0pofo9hyBZtRUXz4CiYo6Vr9d2V0jw@mail.gmail.com>
Date: Thu, 15 Mar 2018 09:09:11 +0300
Message-ID: <000301d3bc24$236c48e0$6a44daa0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] regression in timer code?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Max Filippov' <jcmvbkbc@gmail.com>
Cc: 'Pavel Dovgaluk' <Pavel.Dovgaluk@ispras.ru>, 'qemu-devel' <qemu-devel@nongnu.org>

> From: Max Filippov [mailto:jcmvbkbc@gmail.com]
> On Wed, Mar 14, 2018 at 2:53 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> > icount is adjusted by icount_warp_rt when CPU sleeps.
> > These adjustments may be different in different runs.
> > And the first adjustment is performed at the start of the machine.
> > Therefore "now" value includes non-deterministic component from the beginning,
> > but its increments caused by instruction executions are deterministic.
> 
> Ok, so the CPU reset is non-deterministic. Thanks.

BTW, your link to website in MAINTAINERS does not work.

W: http://wiki.osll.spb.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa


Pavel Dovgalyuk
