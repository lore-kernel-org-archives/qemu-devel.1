Received: from eggs.gnu.org ([2001:4830:134:3::10]:39002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cVJvr-0001Rd-Vn
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 10:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cVJvo-0006yh-KA
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 10:19:51 -0500
Received: from mail.weilnetz.de ([37.221.199.173]:39244)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cVJvo-0006yG-Db
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 10:19:48 -0500
References: <54F1DEE8.3010903@weilnetz.de>
	<20150302221228.GC4114@stefanha-thinkpad.redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <3763fa56-5bba-b060-6ee8-120c9cc50dbb@weilnetz.de>
Date: Sun, 22 Jan 2017 16:19:43 +0100
MIME-Version: 1.0
In-Reply-To: <20150302221228.GC4114@stefanha-thinkpad.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU website (wiki) improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On 03/02/15 23:12, Stefan Hajnoczi wrote:
> On Sat, Feb 28, 2015 at 04:29:44PM +0100, Stefan Weil wrote:
>> * It does not support secure access (https), so each login is insecure.
>>   Can we get a free server certificate?
>
> This is on my todo list.  I'm travelling right now but will work on it
> over the coming weeks.
>
> There are some gotchas:
>
> 1. qemu.org vs qemu-project.org.  Unless we get a SNI certificate, the
>    certificate will only be valid for one or the other.  Users will get
>    an untrusted certificate message if they go to the other domain name.
>
> 2. We use subdomains, so a wildcard certificate is necessary.  That's
>    not always offered for free so I need to compare the certificate
>    vendors.
>
> Stefan


Although this discussion thread is rather old, its subject
still applies.

In the meantime there are free certificates available.
We could add https support with a certificate from
https://letsencrypt.org/. As long as there is only a
small number of host names (*), I'd simply add them all
to the primary certificate. In addition, SNI certificates
for the different names can be installed.

I can help with the installation if that is needed.

Stefan

(*)

qemu.org
qemu.osuosl.org
qemu-project.org
wiki.qemu.org
wiki.qemu-project.org
www.qemu.org
www.qemu-project.org

Are there more host names used?
