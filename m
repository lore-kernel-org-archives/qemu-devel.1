Received: from eggs.gnu.org ([2001:4830:134:3::10]:41227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sebastien.fremal@gmail.com>) id 1cgY1F-0006nq-AT
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:35:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sebastien.fremal@gmail.com>) id 1cgY1E-0007Zh-DU
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:35:49 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sebastien.fremal@gmail.com>)
	id 1cgY1E-0007ZO-3g
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:35:48 -0500
Received: by mail-ot0-x241.google.com with SMTP id w44so454649otw.1
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:35:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLmHPAVJhmgEDMOrbUmWCn2FqSWa4aUJNA9csfy_Yu54w@mail.gmail.com>
References: <CAOV6k-Am5hxdjueMMzaOVygtq16L7KJur_jkDi5snjeLJqDU2w@mail.gmail.com>
	<CAJ+F1CLmHPAVJhmgEDMOrbUmWCn2FqSWa4aUJNA9csfy_Yu54w@mail.gmail.com>
From: =?UTF-8?B?U8OpYmFzdGllbiBGcsOpbWFs?= <sebastien.fremal@gmail.com>
Date: Wed, 22 Feb 2017 15:35:25 +0100
Message-ID: <CAOV6k-APzvSWDMR-bY+kxgvYm28ye5L5hyqcboprFr+9cYw1Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] How to access to ivshmem device in VM ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

M. Lureau,

Thank you for your reply ! I had misunderstood some informations indicating
that the device would create an entry in the /dev/shm of virtual machines.
The lspci command assured me that the device is properly accessible in my
virtual machine.

 "Note that ivshmem is not well regarded by the qemu community, what are
you trying to accomplish?"

Ivshmem breaks one of the most important virtualization's principal : the
isolation of virtual machines. I know some people don't like it. I'm
working in the GPGPU context. We are working (again) on sharing available
GPUs of a physical machine between the virtual machines running on that
machine. To do so, we created a direct access shared buffer : data are
written and read directly in a ring buffer without any kind of copy. That
reduces transfer times but it requires memory pages to be shared between
communicating processes. I used to work with Xen but Xen was incompatible
with NVIDIA GPUs when I began working on this project. Therefore I went for
Qemu as it's compatible with GPGPU on NVIDIA ! Ivshmem is a danger for
public clusters, but it could bring speed-up for private infrastructures !

Best regards,

Sebastien Fremal
=E2=80=8B
