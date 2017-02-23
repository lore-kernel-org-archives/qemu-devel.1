Received: from eggs.gnu.org ([2001:4830:134:3::10]:37610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgsU8-0004tO-Ny
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgsU7-000515-VM
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:27:00 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgsU7-00050m-Mz
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:26:59 -0500
Received: by mail-wm0-x22b.google.com with SMTP id r141so9720141wmg.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 04:26:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3d5e7b5e-4501-86b7-093d-47fb09af585e@redhat.com>
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
	<fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
	<CAFEAcA--bSo7PJH0Px9ytQspaYuS55CSsM_EN6zt0djhkqKNPw@mail.gmail.com>
	<5a0773de-6bc7-474a-82ab-2edd37ce8a93@redhat.com>
	<CAFEAcA99xi4k57h2XGw2deGO24E95AS5jyGL+4GzjqNgMb9wcg@mail.gmail.com>
	<92580ca9-47fe-a943-7720-d3cb1fc6d2eb@redhat.com>
	<CAFEAcA8769a_8xwk57FS6Ko+Lioud20+70JRSafeEic6GB_RAw@mail.gmail.com>
	<3d5e7b5e-4501-86b7-093d-47fb09af585e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 12:26:36 +0000
Message-ID: <CAFEAcA9gcArSqhbRi6-YdR=5eE9dtq66C7N0qTbCuBiY_Zr+tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, zhong@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>

On 23 February 2017 at 11:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 23/02/2017 12:34, Peter Maydell wrote:
>> We should probably update the doc comment to note that the
>> pointer is to host-endianness memory (and that this is not
>> like normal RAM which is target-endian)...
>
> I wouldn't call it host-endianness memory, and I disagree that normal
> RAM is target-endian---in both cases it's just a bunch of bytes.
>
> However, the access done by the MemoryRegionOps callbacks needs to match
> the endianness declared by the MemoryRegionOps themselves.

Well, if the guest stores a bunch of integers to the memory, which
way round do you see them when you look at the bunch of bytes? The
answer is different for the two things, so something is different
about their endianness...

thanks
-- PMM
