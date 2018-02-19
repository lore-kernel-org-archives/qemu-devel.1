Received: from eggs.gnu.org ([2001:4830:134:3::10]:55940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ennTV-0001do-BJ
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ennTS-0002HU-6X
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:35:29 -0500
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:37990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1ennTR-0002Fx-SQ
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:35:26 -0500
Received: by mail-io0-x22b.google.com with SMTP id g21so1385883ioj.5
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 07:35:24 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180219084853.zqds7ikihawpb57i@sirius.home.kraxel.org>
Date: Mon, 19 Feb 2018 10:35:15 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <A50C6DCC-F219-453A-8F21-0E4FE1BE165D@gmail.com>
References: <20180203171743.13612-1-programmingkidx@gmail.com>
	<20180216131540.ioudb6rwf4y6qnxq@sirius.home.kraxel.org>
	<55E5910F-47CB-49BD-83F2-E867750F9BEA@gmail.com>
	<20180219084853.zqds7ikihawpb57i@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v6] ui/cocoa.m: Add ability for user to
 specify mouse ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org


> On Feb 19, 2018, at 3:48 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>  Hi,
>=20
>>> (b) Restrict allowed hotkeys to modifier key(s) plus one
>>>   non-modifier key.  Forwarding modifier keydown+keyup
>>>   to the guest has typically effects inside the guest,
>>>   so we only have to hold back that single non-modifier
>>>   key.  That is alot easier to implement.
>>=20
>> Sorry but I was using this patch to make my ungrab key F15.
>> This key is not used by anything and makes things so simple
>> for me. Requiring a modifier key in the sequence seems unnecessary.=20=

>=20
> Just a plain F15 without any modifier should be find too.
>=20
> Allowing *two* (or more) non-modifier keys (i.e. F14+F15) is where it
> becomes tricky ...

I'm not sure I follow. The code does handle two or three non-modifier =
keys just fine.

A quick test shows this does work:
./ppc-softmmu/qemu-system-ppc -display cocoa,hotkey-grab=3Dkp_4-kp_5-kp_6
