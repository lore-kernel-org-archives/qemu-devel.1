Received: from eggs.gnu.org ([209.51.188.92]:57234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHE9G-0004H2-3W
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 17:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHE9E-0003Bt-9I
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 17:00:46 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:47098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hHE9C-0003AO-Me
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 17:00:44 -0400
Received: by mail-io1-xd42.google.com with SMTP id p23so2964589iol.13
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:00:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <0437475a-10ff-b8e0-3914-536a78f99b6e@redhat.com>
Date: Thu, 18 Apr 2019 17:00:40 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <59245359-ECA9-430C-A634-50ED8E9C6875@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<6cf20899-f643-950b-37b9-dcc47df0d72e@redhat.com>
	<5C484463-F00B-4EC0-9272-DC23CEE8F376@oberlin.edu>
	<0437475a-10ff-b8e0-3914-536a78f99b6e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/10] block/pflash_cfi02: Implement
 missing AMD pflash functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>



On Apr 9, 2019, at 12:15, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:

> Since you did changes in the CFI table, I think we should add a tests
> verifying the table is correctly generated for all you FlashConfig =
entries.

In v3 of the patch, I added tests for the CFI table values
- device length
- sector length and number of sectors
- erase suspend supported

--=20
Stephen Checkoway
