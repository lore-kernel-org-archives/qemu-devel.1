Received: from eggs.gnu.org ([2001:4830:134:3::10]:44708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gUA3T-0004ki-Qe
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gUA3P-0000Zp-Bf
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:43:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gUA3P-0000ZM-5t
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:43:55 -0500
Date: Tue, 4 Dec 2018 13:43:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181204134351.41ba0197@redhat.com>
In-Reply-To: <154343310809.15899.18151397339030117558.malone@gac.canonical.com>
References: <154309137717.32238.5287661827417174062.malonedeb@wampee.canonical.com>
	<154343310809.15899.18151397339030117558.malone@gac.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1804961] Re: qemu-system-aarch64: Windows 10
 ARM64 BSoD on boot while using virt-3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: GH Cao <1804961@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

On Wed, 28 Nov 2018 19:25:07 -0000
GH Cao <1804961@bugs.launchpad.net> wrote:

> @imammedo:
> I am new to kernel debugging, but I managed to get some traces, hope that will help you. 
> 
> https://pastebin.com/shWUC1Pk
> https://pastebin.com/n0gnSaVx
> 

try it with following amli options set: errbrkon traceon spewon
hopefully errbrkon will stop at the error and the rest of options should provide context
