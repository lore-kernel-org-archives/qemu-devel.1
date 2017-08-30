Received: from eggs.gnu.org ([2001:4830:134:3::10]:53354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dn4So-0003ps-1y
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dn4Sn-0003sD-D3
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:59:30 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:38366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dn4Sn-0003rZ-5s
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:59:29 -0400
Received: by mail-wr0-x236.google.com with SMTP id 40so18729777wrv.5
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 07:59:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b98a4c56-f386-f827-5aa7-9a00e6fdf790@amsat.org>
References: <1504100343-26607-1-git-send-email-thuth@redhat.com>
	<b98a4c56-f386-f827-5aa7-9a00e6fdf790@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Aug 2017 15:59:07 +0100
Message-ID: <CAFEAcA8O5T5cX8XqBVZqXLt5MPvF7qEcJK8Az2GBei07P0dZGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/misc/ivshmem: Fix
 ivshmem_recv_msg() to also work on big endian systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 30 August 2017 at 15:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> On 08/30/2017 10:39 AM, Thomas Huth wrote:
>> The problem is that the server side code in ivshmem_server_send_one_msg(=
)
>> correctly translates all messages IDs into little endian 64-bit values,
>> but the client side code in the ivshmem_recv_msg() function does not swa=
p
>> the byte order back. Fix it by passing the value through le64_to_cpu().
>
>
> Yes, we lack BE testing :(

My pre-pull-request test set includes s390 and ppc64 bigendian.
This one was just missed because the 'slow' tests aren't in
'make check'.

thanks
-- PMM
