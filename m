Received: from eggs.gnu.org ([2001:4830:134:3::10]:54665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjaggi.oss@gmail.com>) id 1fs0KN-0008CY-Ai
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjaggi.oss@gmail.com>) id 1fs0KM-0008FU-Jr
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:39:43 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:44113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjaggi.oss@gmail.com>)
	id 1fs0KM-0008Ez-ED
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:39:42 -0400
Received: by mail-oi0-x236.google.com with SMTP id s198-v6so30225847oih.11
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 23:39:42 -0700 (PDT)
MIME-Version: 1.0
From: Mjaggi Oss <mjaggi.oss@gmail.com>
Date: Tue, 21 Aug 2018 12:09:28 +0530
Message-ID: <CABgNM92-PHWg3X41tCVfErmV9-Hnu5GYpz_pa9-iXfbScFUCZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Live Migration between machines with different
 processor ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: manish.jaggi@cavium.com

Live Migration between machines with different processorIds

VM Migration between machines with different processorId values throws an e=
rror
in qemu/kvm. Though this check is appropriate but is overkill in cases wher=
e the
two machines are of same SoC/arch family and have exactly similar core/gic =
but
delta could be in other parts of Soc which have no effect on VM operation.

There could be two ways to address this issue by ignoring the
comparison of processorIDs
 and so need feedback from the
community on this.

a) Maintain a whitelist in qemu:

This will be a set of all processorIds which are compatible and migration c=
an
happen between any of the machines with the Ids from this set. This set can=
 be
statically built within qemu binary.

b) Provide an extra option with migrate command

    migrate tcp:<ip>:<port>:<dest_processor_id>

This is to fake the src_processor_id as dest_processor_id, so the qemu runn=
ing
on destination machine will not complain. The overhead with this approach i=
s
that the destination machines Id need to be known beforehand.

If there is some better way=E2=80=A6 please suggest.

Thanks,
Manish
