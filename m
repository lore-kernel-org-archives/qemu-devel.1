Received: from eggs.gnu.org ([2001:4830:134:3::10]:39838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dqClJ-0008My-T8
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dqClF-0000GL-1C
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:27:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dqClE-0000Fy-S2
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:27:28 -0400
Message-ID: <1504852044.13941.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 08 Sep 2017 08:27:24 +0200
In-Reply-To: <b2d705c1-d86c-ba64-3af2-56aabe08c32b@amsat.org>
References: <20170901125742.4249-1-kraxel@redhat.com>
	<ff830cfa-a8fa-0852-596f-4fc535512b1c@amsat.org>
	<1504772696.15653.5.camel@redhat.com>
	<b2d705c1-d86c-ba64-3af2-56aabe08c32b@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/5] Vga 20170901 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

  Hi,

> Do you notice performance degradations since patch 2?

Didn't benchmark it but it has no effect on the vast majority of video
modes in use today.  Basically only the classic vga video modes with
256 colors (or less) will go through the vga render code.

> Your series is OK, 

Good.  Peter, can you pull?

cheers,
  Gerd
