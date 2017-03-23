Received: from eggs.gnu.org ([2001:4830:134:3::10]:59396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cqzOz-0007WT-E7
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cqzOu-0007wd-I0
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:51:29 -0400
Message-ID: <1490262680.463.27.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 23 Mar 2017 10:51:20 +0100
In-Reply-To: <CAJ+F1CJNy+e83EHR_8uzAHURxDk6idnNTTL_FoD-krWPue7Lww@mail.gmail.com>
References: <20170322204844.446-1-f4bug@amsat.org>
	<20170322204844.446-2-f4bug@amsat.org>
	<87y3vw1o94.fsf@dusky.pond.sub.org>
	<1490255007.463.11.camel@redhat.com>
	<CAJ+F1CJNy+e83EHR_8uzAHURxDk6idnNTTL_FoD-krWPue7Lww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RESEND 1/3] usb-ccid: make
 ccid_write_data_block() cope with null buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

  Hi,

>  oops, there are hard-coded calls with NULL/0. I suppose to fix clang
> warning, it would need to check if data !=3D null for memcpy.

I'd check for len > 0, and in that if branch we can also assert on data
=3D=3D NULL and thereby check that len and data are consistent.

cheers,
  Gerd
