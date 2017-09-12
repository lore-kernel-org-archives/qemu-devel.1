Received: from eggs.gnu.org ([2001:4830:134:3::10]:51513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1drlbU-0008Me-JS
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1drlbR-0004tl-IA
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:51:52 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:33256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1drlbR-0004qS-5a
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:51:49 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <59B7E305.6080302@huawei.com>
References: <59B7C252.1070004@huawei.com> <59B7E305.6080302@huawei.com>
Date: Tue, 12 Sep 2017 15:51:36 +0200
Message-ID: <w51efrcm3dj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?q?question=EF=BC=9A_I_found_a_bug_which_wil?=
 =?utf-8?q?l_lead_to_qemu_crash?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "WangJie (Captain)" <wangjie88@huawei.com>, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com
Cc: stefanha@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue 12 Sep 2017 03:37:09 PM CEST, WangJie (Captain) wrote:
> the patch which fixed the bug is=EF=BC=9A https://github.com/qemu/qemu/co=
mmit/1606e4cf8a976513ecac70ad6642a7ec45744cf5#diff-7cb66df56045598b75a219ee=
bc27efb6

Oh, now I remember. Here's the bug report:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1428810

> But the condition which I made to causes crash is differ in the
> condition you described in patch info, is it the same reason?

How is it different? Doesn't the script that you posted do exactly that?
(hot-unplug)

>> *3=E3=80=81run below script for a while=EF=BC=8Cthe qemu process of  VM =
will crash*
>> ret=3D1
>> while [ $ret -ne 0 ]; do
>>         virsh attach-device i-clone203_rhel_7.3_64_guestosdev add-1.xml
>>         sleep 2
>>         virsh detach-device i-clone203_rhel_7.3_64_guestosdev add-1.xml
>> done

It makes total sense that that patch fixes the problem. Without it, a
deleted BlockBackend remains in a throttling group, which explains your
backtrace.

Berto
