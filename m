Received: from eggs.gnu.org ([2001:4830:134:3::10]:55060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cMdby-0004jO-ET
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cMdbx-0000tj-Q5
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:31:26 -0500
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAHjZ2x5+xeFyF549scdNu0UqetCkwaOHDU9ZnhwzOze+SUUSHw@mail.gmail.com>
Date: Thu, 29 Dec 2016 11:31:18 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C22C8B9-FC91-40EE-896B-77368525D778@gmail.com>
References: <A7AC9346-B5B0-44F1-9E24-54D14C6A5A55@gmail.com>
	<CAHjZ2x5+xeFyF549scdNu0UqetCkwaOHDU9ZnhwzOze+SUUSHw@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-discuss] Reducing guest cpu usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincenzo Romano <vincenzo.romano@notorand.it>
Cc: qemu-discuss <qemu-discuss@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

Thank you very much for helping, but I found out what to do. There is a =
function called cpu_throttle_set() that does exactly what I needed.=20

Happy Holidays.=20

On Dec 29, 2016, at 3:30 AM, Vincenzo Romano wrote:

> I think you have to provide much more details:
> Qemu version
> Host CPU and OS=20
> Guest CPU and OS=20
> Application details
>=20
>=20
> Il 29 dic 2016 07:27, "Programmingkid" <programmingkidx@gmail.com> ha =
scritto:
> There is a program that I run inside of QEMU that doesn't use the =
virtual CPU very efficiently. It causes QEMU to use 100% of the guest's =
CPU time. I was wondering if there were a way to reduce the amount of =
host CPU time that a guest CPU can use? This feature would help prevent =
laptops from heating up when running QEMU.
