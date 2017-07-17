Received: from eggs.gnu.org ([2001:4830:134:3::10]:43701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renorobert@gmail.com>) id 1dXA07-0005r8-1r
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renorobert@gmail.com>) id 1dXA06-0004BC-4W
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:40:07 -0400
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:36043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <renorobert@gmail.com>)
	id 1dXA05-0004A2-TP
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:40:06 -0400
Received: by mail-lf0-x22a.google.com with SMTP id h22so89630211lfk.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 10:40:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717144811.emvnjxsuulj6e3hw@var.youpi.perso.aquilenet.fr>
References: <20170717120326.27967-1-ppandit@redhat.com>
	<20170717144811.emvnjxsuulj6e3hw@var.youpi.perso.aquilenet.fr>
From: Reno Robert <renorobert@gmail.com>
Date: Mon, 17 Jul 2017 23:10:02 +0530
Message-ID: <CAH4rwTL3H3_LJL3rmy+qkUJo6vKB+tx-ULp66CX+vhV9R7a=Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] slirp: check len against dhcp options
 array end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>, Samuel Thibault <samuel.thibault@gnu.org>

+            if (p + len > p_end) {

Shouldn't this be (p + len >= p_end) ?

On Mon, Jul 17, 2017 at 8:18 PM, Samuel Thibault
<samuel.thibault@gnu.org> wrote:
> P J P, on lun. 17 juil. 2017 17:33:26 +0530, wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While parsing dhcp options string in 'dhcp_decode', if an options'
>> length 'len' appeared towards the end of 'bp_vend' array, ensuing
>> read could lead to an OOB memory access issue. Add check to avoid it.
>>
>> Reported-by: Reno Robert <renorobert@gmail.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>
> Oops, sure, applied to my tree, thanks!
>
> Samuel



-- 
Regards,
Reno Robert
http://v0ids3curity.blogspot.in/
