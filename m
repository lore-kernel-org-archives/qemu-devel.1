Received: from eggs.gnu.org ([2001:4830:134:3::10]:59519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAbvo-0005MG-2J
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAbvk-0003li-UR
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:22:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAbvk-0003kE-Nl
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:22:40 -0400
Message-ID: <1509715357.5662.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Nov 2017 14:22:37 +0100
In-Reply-To: <CAFEAcA8LWHP-yWZxSQmnL_U2f_RAk-_ZfSERF8U48zqRE+bq0Q@mail.gmail.com>
References: <1509697171.31823.9.camel@redhat.com>
	<CAFEAcA8LWHP-yWZxSQmnL_U2f_RAk-_ZfSERF8U48zqRE+bq0Q@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

  Hi,

> Works for me for the crossbuild I do with mingw64, so I wonder
> what's different about your setup?

It's RHEL-7, with the mingw packages from epel.

For some reason just using x86_64-w64-mingw32-ar seems to not be
enough.  When running "x86_64-w64-mingw32-ranlib capstone/capstone.lib"
(as suggested by the error msg) manually, then kick "make" again the
build finishes successfully.

"x86_64-w64-mingw32-ar --version" says "GNU ar (GNU Binutils) 2.25"

cheers,
  Gerd
