Received: from eggs.gnu.org ([2001:4830:134:3::10]:46320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNEX7-0000aG-RX
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNEX4-0002DN-Jq
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:05:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gNEX4-0001hG-6h
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:05:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id e3-v6so20538840wrs.5
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 02:05:35 -0800 (PST)
References: <20181115085808.GH27915@xz-x1>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <162b1a37-79d7-8133-22ee-688748fe62b1@redhat.com>
Date: Thu, 15 Nov 2018 11:05:33 +0100
MIME-Version: 1.0
In-Reply-To: <20181115085808.GH27915@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Are FreeBSD guest images working?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

On 15/11/18 9:58, Peter Xu wrote:
> Hi, the list,
> 
> I am trying to boot a FreeBSD guest but failed.  It hangs at the
> kernel booting phase:
> 
> /boot/ker]el/kernel text=0x14ed860 data=0x132538+0x4baa68 syms=[0x8+0x159ee8+0x8
> Booting...
> (nothing more)
> 
> It's just as simple as downloading the image and boot so I can't think
> of anything strange within my procedures so far:
> 
> https://wiki.qemu.org/Hosts/BSD#FreeBSD
> 
> I also tried the latest image here:
> 
> https://download.freebsd.org/ftp/releases/VM-IMAGES/11.2-RELEASE/amd64/Latest/FreeBSD-11.2-RELEASE-amd64.qcow2.xz
> 
> but it's having the same problem as 11.0.
> 
> Am downloading an fresh ISO, but before I continue I'm just curious on
> whether anyone is using these images and whether there's quick answers
> to what I have encountered.
> 
> Thanks in advance,

I use 'make vm-build-freebsd' which works, but the image comes 
pre-installed.
