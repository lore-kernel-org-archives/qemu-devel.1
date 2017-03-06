Received: from eggs.gnu.org ([2001:4830:134:3::10]:58711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ckx9H-0004e8-4t
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ckx9D-0004eK-Up
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:14:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ckx9D-0004eA-OV
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:14:15 -0500
References: <1486623844-13140-1-git-send-email-liqiang6-s@360.cn>
	<1486623844-13140-2-git-send-email-liqiang6-s@360.cn>
	<eadb7db6-dded-77ce-ac46-7dee688be954@redhat.com>
	<CAKXe6SJyeHEeRujwKTd=TUAXjJ1Btv4K9jX6rjyJ4wtsutQ1fQ@mail.gmail.com>
	<8a406a12-5145-bfbe-af18-290e6342f668@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d183120f-c439-246a-5591-73a1cd2536dd@redhat.com>
Date: Mon, 6 Mar 2017 19:14:10 +0100
MIME-Version: 1.0
In-Reply-To: <8a406a12-5145-bfbe-af18-290e6342f668@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] ide: core: add cleanup function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Li Qiang <liq3ea@gmail.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <liqiang6-s@360.cn>, Markus Armbruster <armbru@redhat.com>



On 01/03/2017 21:20, John Snow wrote:
> we have an idebus unrealize function, but it was being registered as the
> unrealize function for the IDE Device, so it was not getting invoked on
> device teardown because nothing is "unrealizing" the IDE devices
> themselves, AFAIK.

I agree.  Thanks for looking at it!

Paolo
