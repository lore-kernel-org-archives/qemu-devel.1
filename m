Received: from eggs.gnu.org ([2001:4830:134:3::10]:50101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ew3d1-0000hw-1P
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 06:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ew3d0-0004fB-8t
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 06:27:27 -0400
Received: from mail-yw0-x229.google.com ([2607:f8b0:4002:c05::229]:39715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ew3d0-0004ex-35
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 06:27:26 -0400
Received: by mail-yw0-x229.google.com with SMTP id l24so1765339ywk.6
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 03:27:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000401d3bb7a$418b9fb0$c4a2df10$@ru>
References: <CAMo8BfLuAdsdRScY+CgTzd0EBn3_kAFc=ysEwgp3MrM_+42viQ@mail.gmail.com>
	<000301d3bb73$e997a8e0$bcc6faa0$@ru>
	<CAMo8Bf+seSrT9HBFL1tspoDQ-9s9nGrXueYRt6v2nF4XzZbdfA@mail.gmail.com>
	<000401d3bb7a$418b9fb0$c4a2df10$@ru>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 14 Mar 2018 03:27:25 -0700
Message-ID: <CAMo8Bf+Mqjer86N0LnCf0pofo9hyBZtRUXz4CiYo6Vr9d2V0jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] regression in timer code?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>, qemu-devel <qemu-devel@nongnu.org>

On Wed, Mar 14, 2018 at 2:53 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> icount is adjusted by icount_warp_rt when CPU sleeps.
> These adjustments may be different in different runs.
> And the first adjustment is performed at the start of the machine.
> Therefore "now" value includes non-deterministic component from the beginning,
> but its increments caused by instruction executions are deterministic.

Ok, so the CPU reset is non-deterministic. Thanks.

-- Max
