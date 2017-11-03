Received: from eggs.gnu.org ([2001:4830:134:3::10]:36285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAcCj-0000us-J9
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAcCe-0001Qv-KL
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:40:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAcCe-0001Q7-DQ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:40:08 -0400
Message-ID: <1509716406.5662.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Nov 2017 14:40:06 +0100
In-Reply-To: <CAFEAcA-0d1hEz-O1Q9cCGYAJfcc-rFAg2hNA3Wwq5LzBx1PD9Q@mail.gmail.com>
References: <1509697171.31823.9.camel@redhat.com>
	<CAFEAcA8LWHP-yWZxSQmnL_U2f_RAk-_ZfSERF8U48zqRE+bq0Q@mail.gmail.com>
	<1509715357.5662.1.camel@redhat.com>
	<CAFEAcA-0d1hEz-O1Q9cCGYAJfcc-rFAg2hNA3Wwq5LzBx1PD9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] capstone broke mingw cross build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

  Hi,

> > "x86_64-w64-mingw32-ar --version" says "GNU ar (GNU Binutils) 2.25"
> 
> Hmm, I guess this 'ar' isn't capable of avoiding the requirement for
> ranlib. The capstone makefiles look like they have support for
> running ranlib, though...

Ah, the recursive call in the qemu Makefile doesn't set RANLIB.
So it probably works if that happens to be set correctly in the
environment.  I'm using 'configure --cross-prefix=x86_64-w64-mingw32-'
for cross builds though.

cheers,
  Gerd
