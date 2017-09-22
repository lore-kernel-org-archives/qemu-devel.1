Received: from eggs.gnu.org ([2001:4830:134:3::10]:38207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dvUX8-00082E-MN
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dvUX4-0005KJ-NR
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:26:46 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:34978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dvUX4-0005Jp-J0
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:26:42 -0400
Received: by mail-it0-x242.google.com with SMTP id u2so1315836itb.2
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 13:26:42 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170922131819.GP12725@redhat.com>
Date: Fri, 22 Sep 2017 16:26:40 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <BA02424C-0C79-4FAE-B191-18A9D0CDBAC8@gmail.com>
References: <mailman.3351.1506066493.14747.qemu-devel@nongnu.org>
	<726A2123-0371-407B-9270-6672DF66D511@gmail.com>
	<20170922124405.GB32000@lemon> <20170922131819.GP12725@redhat.com>
Subject: Re: [Qemu-devel] [PULL 28/36] tests: Add ubuntu.i386 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Sep 22, 2017, at 9:18 AM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> On Fri, Sep 22, 2017 at 08:44:05PM +0800, Fam Zheng wrote:
>> On Fri, 09/22 08:10, Programmingkid wrote:
>>> Could a Darwin test be added? Both x86 and PowerPC versions would be =
great.
>>=20
>> It's nice to cover macOS in our test, but to be honest I don't know =
how to do
>> it. If there isn't any copyright problem, and if there are =
instructions
>> available in wiki.qemu.org descirbing how to create such a guest step =
by step
>> like [1], we can add one.
>=20
> AFAICT we can not just provide or host OS-X images and let individual
> devs run the without it being a license violation, so best avoided.

Actually Darwin and Mac OS X are not the same. Darwin is this =
minimalistic environment and Mac OS X is built on top of that =
environment. There would be no license problems when using Darwin only.

> IMHO it easier to just rely on Travis' OS-X builders for testing OS-X
> platform builds, so that licensing compliance is their responsibility.

That might work for the x86 version of Mac OS X, but there doesn't =
appear to be any support for the PowerPC version of Mac OS X.
