Received: from eggs.gnu.org ([2001:4830:134:3::10]:55456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fx1h0-0001dU-DL
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 23:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fx1gv-0006AP-D8
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 23:07:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50002 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fx1gv-00068b-5Q
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 23:07:45 -0400
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-7-sameeh@daynix.com>
	<20180903115406.GA14377@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ee81457c-5df4-974f-29fa-7fdcc6649ea7@redhat.com>
Date: Tue, 4 Sep 2018 11:07:38 +0800
MIME-Version: 1.0
In-Reply-To: <20180903115406.GA14377@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 6/6] virtio-net: rss: Add bpf filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Sameeh Jubran <sameeh@daynix.com>
Cc: Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org



On 2018=E5=B9=B409=E6=9C=8803=E6=97=A5 19:54, Daniel P. Berrang=C3=A9 wro=
te:
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include <linux/bpf.h>
>> +
>> +#ifndef BPF_RSS_INSNS
>> +#define BPF_RSS_INSNS
>> +
>> +/* bpf_insn array matching l3_l4 section. see tap_bpf_program.c file =
*/
>> +struct bpf_insn l3_l4_hash_insns[] =3D {
>> +{0xbf , 0x6 , 0x1 , 0x0000 , 0x00000000},
>> +{0x28 , 0x0 , 0x0 , 0x0000 , 0x0000000c},
>> +{0xbf , 0x8 , 0x0 , 0x0000 , 0x00000000},
> [snip]
>
>> +};
> This massive array is presumably an auto-generated content.
>
> We shouldn't be storing this in GIT. We need to store the
> original preferred source format, and providing makefile
> rules to generate it.
>
>

This is possible. But it depends on eBPF toolchain (e.g recent version=20
of LLVM) to work which is inflexible or impossible to make it work on=20
some distributions. Providing compiled bytecode does not have such=20
limitation.

Thanks
