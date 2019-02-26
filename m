Received: from eggs.gnu.org ([209.51.188.92]:58108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyZVA-0003WN-0K
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyZV9-0000ZJ-CF
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:58:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gyZV9-0000Yk-2a
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:58:15 -0500
References: <201902230335.59138.randrianasulu@gmail.com>
	<201902261158.09086.randrianasulu@gmail.com>
	<e9d2cf10-0c52-a1b6-2be9-e396bd76cf2f@redhat.com>
	<201902261246.41653.randrianasulu@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bf084052-f1d5-457a-d640-016ab3661217@redhat.com>
Date: Tue, 26 Feb 2019 10:58:11 +0100
MIME-Version: 1.0
In-Reply-To: <201902261246.41653.randrianasulu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Build error with git commit
 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116 on x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: qemu-devel@nongnu.org

On 26/02/2019 10.46, Andrew Randrianasulu wrote:
[...]
> also, -g 1186x864x32 resulted in funnuy diagonal corruption even at firmware 
> screen level, and probably same happening with x86-64/kvm guest if I select 
> some less comon, but exposed via xrandr mode. (this bit for -vga std, default)

1186 is not dividable by 16 ... you likely meant 1184 instead?

 Thomas
