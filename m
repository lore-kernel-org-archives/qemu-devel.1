Received: from eggs.gnu.org ([2001:4830:134:3::10]:37854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1dlqAM-0006jh-KX
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 01:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1dlqAJ-0005LR-FT
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 01:31:22 -0400
Received: from mail.univention.de ([82.198.197.8]:19839)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hahn@univention.de>) id 1dlqAJ-0005KF-9T
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 01:31:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by solig.knut.univention.de (Postfix) with ESMTP id D6AC518001D8
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 07:31:15 +0200 (CEST)
Received: from mail.univention.de ([127.0.0.1])
	by localhost (solig.knut.univention.de [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id K4ifI4xKLwqd for <qemu-devel@nongnu.org>;
	Sun, 27 Aug 2017 07:31:15 +0200 (CEST)
Received: from [192.168.178.42] (p5B2F5897.dip0.t-ipconnect.de [91.47.88.151])
	by solig.knut.univention.de (Postfix) with ESMTPSA id 3683018001C3
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 07:31:15 +0200 (CEST)
References: <CAOE=1Z0trKFwm__wTKHSTAUSt+r9SBjCwft3tA=i5vJaixuX8w@mail.gmail.com>
From: Philipp Hahn <hahn@univention.de>
Message-ID: <a0c1d574-3d20-2b90-290f-d09c4078175e@univention.de>
Date: Sun, 27 Aug 2017 07:31:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z0trKFwm__wTKHSTAUSt+r9SBjCwft3tA=i5vJaixuX8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Why got no response of vnc?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

Am 25.08.2017 um 08:31 schrieb Sam:
> I'm starting vm using:
>=20
> kvm]$ sudo /usr/local/bin/qemu-system-x86_64 -m 256 -hda test.qcow2 -cd=
rom
>> CentOS-7-x86_64-DVD-1503-01.iso -boot d
>> VNC server running on '127.0.0.1:5900'
                          ^^^^^^^^^
This a a *local* host socket,

> then I start vnc client in another PC to connect 10.253.23.24:11800 and
> 10.253.23.24:5900, I got time out, why?

to which you can't connect from any *other* host

$ man qemu-system-x86_64
...
> -vnc display[,option[,option[,...]]]

So try to add '-vnc 10.253.23.24:5900' to your command line to make Qemu
to listen on that IP address of your host you're running the VM on.

Philipp
