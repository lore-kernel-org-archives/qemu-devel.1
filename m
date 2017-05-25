Received: from eggs.gnu.org ([2001:4830:134:3::10]:59602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dDsh6-0007O3-VX
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dDsh3-0000eR-QT
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:20:48 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:35403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dDsh3-0000eG-J8
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:20:45 -0400
Received: by mail-pf0-x22c.google.com with SMTP id n23so167295013pfb.2
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 06:20:45 -0700 (PDT)
References: <CAGKXQyd8y6xu77XpV-BS1ZGFKBi3Yh=AAnw98nOWFoPkrmNLrw@mail.gmail.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <d65ddaed-14c0-98be-28e0-d61d0bf351b9@gmail.com>
Date: Thu, 25 May 2017 21:20:52 +0800
MIME-Version: 1.0
In-Reply-To: <CAGKXQyd8y6xu77XpV-BS1ZGFKBi3Yh=AAnw98nOWFoPkrmNLrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Memory dirty event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>, qemu-devel@nongnu.org


No API directly supports your case, but you can do it in KVM by using
page-track mechanism.


On 05/25/2017 08:26 PM, ali saeedi wrote:
> Hello
> How can i receive an event when a page or block is dirtied in qemu code?
> thanks a lot
> 
